#include <iostream>
#include "DHSetup.hpp"
#include "User.hpp"
#include "../../Lista2/zad1/GaloisField.hpp"
using namespace std;

template <typename T>
T myMax(T x, T y) {
    return (x > y) ? x: y;
}

// 1234567891
using GF1234567891 = GaloisField<1234577>;
using GF = GF1234567891;

void testDiffieHellman(DHSetup<GF> &dh, User<GF> &a, User<GF> &b) {
    GF alicePublicKey = a.getPublicKey();
    GF bobPublicKey = b.getPublicKey();
    a.setKey(bobPublicKey); // (g^b)^a
    b.setKey(alicePublicKey); // (g^a)^b
    GF secret = GF(12345);
    GF aliceSecret = a.encrypt(secret);
    GF bobDecryptedMsg = b.decrypt(aliceSecret); // bob receives msg encrypted by Alice and decryptes it by his encryption key
    if(bobDecryptedMsg == secret) {
        cout << " Bob managed to decrypt msg sent by Alice!" << endl;
    } else {
        cout << "Decryption was unsuccessful " << endl;
    }
}

// Diffie–Hellman protocol test class for field of characteristics 1234567891
int main(int argc, char **argv) {
    // cout << myMax<int>(3, 7) << endl;
    GF field;
    DHSetup<GF> diffieHelman(field);
    User a(diffieHelman);
    User b(diffieHelman);
    testDiffieHellman(diffieHelman, a, b);
    return 0;
}