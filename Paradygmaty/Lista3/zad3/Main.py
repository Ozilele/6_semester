from DHSetup import DHSetup
from User import User
import sys
sys.path.append('/Users/bartiq/Desktop/Studia/sem6/Paradygmaty/')
from Lista2.zad3.GaloisField import GaloisField

ORDER = 1234577

def create_galois_field(value: int, order: int) -> GaloisField:
    return GaloisField(value, order)

def testDiffieHellman(alice, bob):
    alicePublicKey = alice.getPublicKey()
    bobPublicKey = bob.getPublicKey()
    alice.setKey(bobPublicKey)
    bob.setKey(alicePublicKey)
    msg = GaloisField(12345, ORDER)
    aliceSecret = alice.encrypt(msg)
    bobDecryptedMsg = bob.decrypt(aliceSecret)
    if msg == bobDecryptedMsg:
        print(f'Bob managed to decrypt msg sent by Alice!')
    else:
        print('Decryption was unsuccessful')

def main():
    field = GaloisField(None, ORDER)
    diffieHelman = DHSetup(field, create_galois_field)
    alice = User(diffieHelman)
    bob = User(diffieHelman)
    testDiffieHellman(alice, bob)

main()