#pragma once
#include <iostream>
#include <fstream>
#include "IsPrime.hpp"

using namespace std;

template <int64_t P>
class GaloisField {
    static_assert(is_prime_v<P>, "P must be a prime number");
    private: 
        int64_t value{};
        static auto gcdExtended(int a, int b, int *x, int *y) {
            if(b == 0) {
                *x = 1;
                *y = 0;
                return a;
            }
            int x1, y1;
            int gcd = gcdExtended(b, a%b, &x1, &y1);
            *x = y1;
            *y = x1 - (a / b) * y1;
            return gcd;
        }

        static constexpr auto solveDiofantic(int a, int b, int c) {
            int x, y;
            int gcd = gcdExtended(a, b, &x, &y);
            if(x < 0) {
                return order + x;
            }
            return x;
        }

    public:
        constexpr static int order = P;
        constexpr GaloisField() = default;
        constexpr GaloisField(int64_t value) : value(value % order) {}
        // main idea is a performance improvement of programs by doing computations at compile time rather than run time
        // Assignments
        constexpr GaloisField& operator=(const GaloisField& other) {
            this->value = other.value;
            return *this;
        }

        constexpr GaloisField& operator+=(const GaloisField& other) {
            this->value = (this->value + other.value) % this->order;
            return *this;
        }
        
        constexpr GaloisField& operator-=(const GaloisField& other) {
            const auto other_inverse = -other;
            this->value = (this->value + other_inverse.value) % this->order;
            return *this;
        }

        constexpr GaloisField& operator*=(const GaloisField& other) {
            this->value = (this->value * other.value) % this->order;
            return *this;
        }

        constexpr GaloisField& operator/=(const GaloisField& other) {
            const auto other_inverse = ~other;
            this->value = (this->value * other_inverse.value) % this->order;
            return *this;
        }
        
        // Arithmetic(friend function has priviliges to access all private and protected members of the class)
        constexpr friend GaloisField operator+(const GaloisField& l, const GaloisField& r) {   
            return GaloisField((l.value + r.value) % order);
        }

        constexpr friend GaloisField operator-(const GaloisField& l, const GaloisField& r) {
            const auto inverse = -r;
            return l + inverse;
        }

        constexpr friend GaloisField operator*(const GaloisField& l, const GaloisField& r) {
            return GaloisField((l.value * r.value) % order);
        }

        constexpr friend GaloisField operator/(const GaloisField& l, const GaloisField& r) {
            const auto r_inverse = ~r;
            return l * r_inverse;
        }

        constexpr friend GaloisField operator-(const GaloisField& gF) {
            return GaloisField(order - gF.value);
        }

        constexpr friend GaloisField operator~(const GaloisField& l) {
            return GaloisField(solveDiofantic(l.value, order, 1));
        }
        
        // Comparison operators
        constexpr bool operator==(const GaloisField& other) const {
            return this->value == other.value;
        }

        constexpr bool operator!=(const GaloisField& other) const {
            return this->value != other.value;
        }

        constexpr bool operator<=(const GaloisField& other) const {
            return this->value <= other.value;
        }

        constexpr bool operator>=(const GaloisField& other) const {
            return this->value >= other.value;
        }

        constexpr bool operator<(const GaloisField& other) const {
            return this->value < other.value;
        }

        constexpr bool operator>(const GaloisField& other) const {
            return this->value > other.value;
        }

        // Obsługa operatorow strumieni
        constexpr friend std::ostream& setStreams(std::ofstream& outStream, const GaloisField& l) {
            return outStream << l.value;
        }

        constexpr int getCharacteristics() {
            return this->value;
        }
};