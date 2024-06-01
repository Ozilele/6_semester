import threading
import time
import random

numPhilosophers = 5
numForks = numPhilosophers
maxDinings = 5 # maksymalna liczba posiłków zjedzonych przez kazdego z filozofów
# forks = [threading.Semaphore(1) for i in range(numForks)]

class DiningTable:
    def __init__(self):
        self.forks = [threading.Semaphore(1) for i in range(numForks)]
        self.mutex = threading.Lock()
        self.eating = [False] * numPhilosophers
        self.mealsEaten = [0] * numPhilosophers

    def pick_up_first_fork(self, phID):
        if phID == numForks - 1: # pick up right fork first
            index = (phID + 1) % numForks
            if self.forks[index].acquire(timeout = 0.01):
                return 1
            return -1
        else: # pick up left fork first
            index = phID
            if self.forks[index].acquire(timeout = 0.01):
                return 1
            return -1
        
    def pick_up_second_fork(self, phID):
        if phID == numForks - 1: # 
            if self.forks[phID].acquire(timeout = 0.01):
                return 1
            return -1
        else:
            index = phID + 1
            if self.forks[index].acquire(timeout = 0.01):
                return 1
            return -1
    
    def release_fork(self, phID):
        if phID == numForks - 1:
            self.forks[(phID + 1) % numForks].release()
        else:
            self.forks[phID].release()

    def put_down_forks(self, phID):
        print(f"Philosopher of id {phID} put down its forks")
        self.mutex.acquire() # Acquire lock on DiningTable obj
        self.eating[phID] = False
        self.update_eating_list()
        self.mutex.release()

        self.forks[phID].release() # left fork signal
        self.forks[(phID + 1) % numForks].release() # right fork signal

    def update_eating_list(self):
        list = "Eating list: [ "
        for i, val in enumerate(self.eating):
            if val is True:
                list += f'Phil {i} with forks ({i}, {(i + 1) % numForks}), '
        list += "]"
        print(list)
    
def philosopherRoutine(id, table):
    print(f"Philosopher {id} is thinking...")

    while table.mealsEaten[id] < maxDinings:
        # Thinking
        # print(f"Philosopher {id} is thinking...")
        time.sleep(random.randint(100, 350) / 1000.0)
        # Picks up forks to eat
        success = table.pick_up_first_fork(id)
        if success == -1:
            continue 
        result = table.pick_up_second_fork(id)
        if result == -1:
            # If not successful in acquiring both forks release semaphore(fork) and return to thinking
            table.release_fork(id)
            continue
        # Eating 
        table.mutex.acquire()
        table.mealsEaten[id] += 1
        print(f"Philosopher {id} is eating meal nr {table.mealsEaten[id]}")
        table.eating[id] = True
        table.update_eating_list()
        table.mutex.release()
        time.sleep(random.randint(100, 500) / 1000.0)
		# Put down forks after eating and output info
        table.put_down_forks(id)

def main():
    table = DiningTable()
    philosopher_threads = []
    for i in range(numPhilosophers):
        # target is the func to be executed by the thread, args are arguments to be passed to target func
        philosopher_threads.append(threading.Thread(target=philosopherRoutine, args=(i,table)))
    # Start running threads
    for thread in philosopher_threads:
        thread.start()
    # Wait for all threads to complete
    for thread in philosopher_threads:
        thread.join()

main()  