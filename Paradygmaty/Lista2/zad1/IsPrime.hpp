#pragma once
#include <iostream>
#include <cstdint>
using namespace std;

namespace impl {
    constexpr bool isPrime(const int order) {
        if(order <= 1)
            return false;

        for(int i = 2; i * i <= order; i++)
            if(order % i == 0) 
                return false;
        return true;
    }
};

template<int64_t N>
struct is_prime {
    inline static constexpr bool value = impl::isPrime(N);
};

template<int64_t N>
constexpr bool is_prime_v = is_prime<N>::value;
