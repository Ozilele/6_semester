#pragma once
#include <random>
#include <iostream>
#include "DHSetup.hpp"
using namespace std;

template <typename T>
class User {
    private:
        DHSetup<T> dh;
        unsigned long secret;
        T encryption_key;
        
    public:
        User() = default;
        User(DHSetup<T> &dh) {
            this->dh = dh;
            std::random_device rd;
            mt19937 gen(rd());
            uniform_int_distribution<unsigned long> distr(1, T::order - 1);
            this->secret = distr(gen);
            cout << "Secret key is " << this->secret << endl;
        }

        T getPublicKey() { // G^a, this key is being sent to another user
            T gen = dh.getGenerator();
            // cout << "Gen is " << gen.getCharacteristics() << " secret to " << this->secret << endl;
            return dh.power(gen, this->secret);
        }

        void setKey(T a) { // compute a = G^b, (G^b)^a
            this->encryption_key = dh.power(a, this->secret);
        }

        T encrypt(T m) { // szyfruje m przez pomnozenie jej przez klucz szyfrujący(operacja mnozenia z listy 2)
            return m * this->encryption_key;
        }

        T decrypt(T c) { // deszyfruje c przez podzielenie jej przez klucz szyfrujący(operacja dzielenia z listy 2)
            return c / this->encryption_key;
        }
};