package main

import (
	"fmt"
	"math/rand"
	"sync"
	"time"
)

// A philosopher may eat if he can pick up two chopsticks adjacent to him
// One chopstick may be picked up by any one of its adjacent followers but not both.
var numPhilosophers = 8

type MyMutex struct {
	chanel chan struct{}
}
  
// Jezeli mutex jest zajety to gorutyna blokuje się czekajac na mozliwosc wyslania wiadomosci
func (m *MyMutex) Lock() {
	if m.chanel == nil {
		m.chanel = make(chan struct{}, 1) // buffered channel of size 1
	}
	m.chanel <- struct{}{} // sygnał zajęcia mutexa
}
  
func (m *MyMutex) Unlock() {
	if m.chanel != nil {
		<-m.chanel // Odbieranie(zwolnienie mutexu, co pozwala innym gorutynom na dostep do chronionego zasobu)
	}
}

type Semaphore struct {
	value int // 0 - unavailable, 1 - available
	mutex MyMutex // synchronizacja dostępu
}

func (s *Semaphore) init(val int) {
	s.value = val
}

// Gorutyna czeka az semafora(fork) stanie się dostępny, jezeli jest to sygnalizuje zajęcie zasobu
// Returns 1 in case of success, -1 in case of failure to acquire semaphore
func (s *Semaphore) wait() int {
	s.mutex.Lock()
	if s.value <= 0 {
		s.mutex.Unlock()
		return -1
	}
	// for s.value <= 0 { // resources not available
	// 	s.mutex.Unlock() // Aktywne czekanie na wartosc semeafora az będzie > 0(az fork stanie się dostępny)
	// 	s.mutex.Lock()
	// }
	s.value-- // zajęcie zasobu
	s.mutex.Unlock()
	return 1
}

// Gorutyna zwalnia zasób(fork) dzięki czemu fork staje się dostępny dla innych gorutyn
func (s *Semaphore) signal() {
	s.mutex.Lock()
	s.value++ // zwolnienie zasobu(fork jest dostępny)
	s.mutex.Unlock()
}

// Each fork is represented by a semaphore
type DiningTable struct {
	forks []*Semaphore
	mutex sync.Mutex
	eating map[int]bool
	eatingCh chan string
}

func (table *DiningTable) init() {
	table.forks = make([]*Semaphore, numPhilosophers)
	for i := 0; i < numPhilosophers; i++ {
		table.forks[i] = &Semaphore{}
		// Initialize the semaphores for each fork to 1 (indicating that they are available).
		table.forks[i].init(1)
	}
	table.eating = make(map[int]bool)
	table.eatingCh = make(chan string, 1)
}

func (table *DiningTable) getLeftFork(id int) *Semaphore {
	return table.forks[id]
}

func (table *DiningTable) getRightFork(id int) *Semaphore {
	return table.forks[(id + 1) % numPhilosophers]
}

// if every philosopher picks their left chopstick simultaneously, a deadlock results, and no philosopher can eat.
// func (table *DiningTable) pickUpForks(philosopher *Philosopher) {
// 	if(philosopher.id == numPhilosophers - 1) { // last philosopher picks 
// 		philosopher.rightFork.wait(philosopher)
// 		philosopher.leftFork.wait(philosopher)
// 	} else {
// 		l_response := philosopher.leftFork.wait(philosopher)
// 		if l_
// 		philosopher.rightFork.wait(philosopher)
// 	}
// 	table.mutex.Lock()
// 	fmt.Printf("Philosopher %d is eating\n", philosopher.id)
// 	table.eating[philosopher.id] = true
// 	table.updateEatingList()
// 	table.mutex.Unlock()
// }

func (table *DiningTable) pickUpFirstFork(philosopher *Philosopher) int {
	if(philosopher.id == numPhilosophers - 1) { // last philosopher picks right fork first to avoid the situation of deadlock
		return philosopher.rightFork.wait()
	} else {
		return philosopher.leftFork.wait()
	}
}

func (table *DiningTable) pickUpSecondFork(philosopher *Philosopher) int {
	if(philosopher.id == numPhilosophers - 1) {
		return philosopher.leftFork.wait()
	} else {
		return philosopher.rightFork.wait()
	}
}

func (table *DiningTable) releaseFork(philosopher *Philosopher) {
	if(philosopher.id == numPhilosophers - 1) {
		philosopher.rightFork.signal()
	} else {
		philosopher.leftFork.signal()
	}
}

func (table *DiningTable) putDownForks(philo *Philosopher, leftFork, rightFork *Semaphore) {
	fmt.Printf("Philosopher of id %d put down its forks\n", philo.id)
	table.mutex.Lock()
	delete(table.eating, philo.id)
	table.updateEatingList()
	table.mutex.Unlock()

	leftFork.signal() // signal
	rightFork.signal() // signal 
}

func (table *DiningTable) updateEatingList() {
	list := "Eating List: ["
	first := true
	for id := range table.eating {
		if !first {
			list += ", "
		}
		list += fmt.Sprintf("Phil %d with forks (%d, %d)", id, id, (id + 1) % numPhilosophers)
		first = false
	}
	list += "]"
	fmt.Println(list)
}
  
type Philosopher struct {
	id int
	leftFork, rightFork *Semaphore
}

// A philosopher must acquire both the semaphore for the fork to their left and the semaphore for the fork to their right before he can begin eating
func philosopherRoutine(philosopher *Philosopher, table *DiningTable, wg *sync.WaitGroup, printMutex *sync.Mutex) {
	defer wg.Done()
	fmt.Printf("Philosopher %d is thinking\n", philosopher.id)
	for {
		// Thinking
		// fmt.Printf("Philosopher %d is thinking\n", philosopher.id)
		time.Sleep(time.Duration(rand.Intn(300)) * time.Millisecond)
		// Picks up forks to eat
		success := table.pickUpFirstFork(philosopher)
		if success == -1 {
			// Failed to pick up first fork, return to thinking
			continue
		}
		result := table.pickUpSecondFork(philosopher)
		if result == -1 {
			// If not successful in acquiring both forks release semaphore(fork) and return to thinking
			table.releaseFork(philosopher)
			continue
		}
		// Eating 
		table.mutex.Lock()
		fmt.Printf("Philosopher %d is eating\n", philosopher.id)
		table.eating[philosopher.id] = true
		table.updateEatingList()
		table.mutex.Unlock()
		// table.pickUpForks(philosopher)
		time.Sleep(time.Duration(rand.Intn(500)) * time.Millisecond)
		// Put down forks after eating and output info
		table.putDownForks(philosopher, philosopher.leftFork, philosopher.rightFork)
	}
}

func main() {
	rand.Seed(time.Now().Unix())

	var wg sync.WaitGroup
	printMutex := &sync.Mutex{}
	table := &DiningTable{}
	table.init()

	philosophers := make([]*Philosopher, numPhilosophers)
	for i := 0; i < numPhilosophers; i++ {
		philosophers[i] = &Philosopher{
			id: i,
			leftFork: table.getLeftFork(i),
			rightFork: table.getRightFork(i),
		}
	}

	for i := 0; i < numPhilosophers; i++ {
		wg.Add(1)
		go philosopherRoutine(philosophers[i], table, &wg, printMutex) // for each philosopher separate thread 
	}
	time.Sleep(time.Second * 7)
	// wg.Wait()
}