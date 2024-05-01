#pragma once
#include <iostream>
#include <random>
#include <cmath>
using namespace std;

template <typename T>
class DHSetup {
    private:
        T field;
        int P;
        T generator;

        std::vector<int> findPrimesDividingP(int n) {
            std::vector<int> result; 
            bool *marked = new bool[n + 1];
            for(int i = 0; i <= n; i++) {
                marked[i] = true;
            }
            for(int i = 2; i <= sqrt(n); i++) {
                if(marked[i] == true) {
                    int j = i * i;
                    while(j <= n) {
                        marked[j] = false;
                        j = j + i;
                    }
                }
            }
            for(int q = 2; q <= n; q++) {
                if(marked[q] == true) { // if q is prime number
                    if(n % q == 0) { // check if q divides p
                        result.push_back(q);
                    }
                }
            }
            delete[] marked;
            return result;
        }

        bool isGenerator(uint64_t a, std::vector<int> &primes) {
            for(int prime : primes) {
                uint64_t factor = (this->P - 1) / prime;
                uint64_t elem = a * factor;
                if(elem == 1) {
                    return false;
                }
            }
            return true;
        }

        int generateRandom(std::mt19937 &gen, int min, int max) {
            uniform_int_distribution<> distrib(min, max);
            return distrib(gen);
        }

        std::vector<int> decomposeIntoPowersOfTwo(int num) {
            std::vector<int> powers;
            int bitPosition = 0;
            while(num > 0) {
                if(num & 1) { // least significant bit
                    powers.push_back(1 << bitPosition); // 1 * 2^bitPos
                }
                num >>= 1;  // shift bits to right
                bitPosition++;  // przechodzimy do kolejnej pozycji bitu
            }
            return powers;
        }

    public:
        DHSetup() = default;
        DHSetup(T &field) {
            this->field = field;
            this->P = T::order; // order is static field of class T
            std::random_device rd;
            mt19937 gen(rd());
            T gener;
            std::vector<int> primes = this->findPrimesDividingP(this->P - 1);
            for(int elem : primes) {
                cout << elem << ", ";
            }
            cout << endl;
            while(gener == T()) {
                int element = this->generateRandom(gen, 1, this->P - 1);
                if(this->isGenerator(element, primes)) {
                    cout << "Gen is " << element << std::endl;
                    gener = T(element);
                    break;
                }
            }
            this->generator = gener;
        }

        T getGenerator() {
            return this->generator;
        }

        T power(T a, unsigned long b) { // method for a.power(b) (mod P)
            int a_val = a.getCharacteristics();
            std::vector<int> powers = decomposeIntoPowersOfTwo(b);
            std::vector<unsigned long> modulus;
            std::vector<unsigned long> values;
            int j = 0;
            for(int i = 1; i <= powers[powers.size() - 1]; i *= 2) { // log(b) multiplication because number of operations is determined by the number of bits in b so it is O(log(b))
                unsigned long modulo;
                if(i == 1) {
                    modulo = a_val % this->P;
                    modulus.push_back(modulo);
                } else {
                    modulo = (modulus[modulus.size() - 1] * modulus[modulus.size() - 1]) % this->P;
                    modulus.push_back(modulo);
                } 
                if(powers[j] == i) {
                    j++;
                    values.push_back(modulo);
                }
            }
            unsigned long multiply = 1;
            for(unsigned long value : values) {
                multiply = (multiply * value) % this->P;
            }
            cout << "Wynik: " << multiply % this->P << endl;
            return T(multiply % this->P);
        }
};