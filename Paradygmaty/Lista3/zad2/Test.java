package Lista3.zad2;
import java.security.SecureRandom;

import Lista2.zad2.GaloisField;

public class Test {

    public static int order = 1234577;

    @SuppressWarnings("unchecked")
    private static <T> void testDiffieHellman(User<T> a, User<T> b) throws Exception {
        T alicePublicKey = a.getPublicKey();
        T bobPublicKey = b.getPublicKey();
        a.setKey(bobPublicKey);
        b.setKey(alicePublicKey);
        GaloisField msg = new GaloisField(12345, order);
        T msgT = null;
        try {
            msgT = (T)msg;
        } catch(ClassCastException ex) {
            System.out.println(ex.getMessage());
        }
        T aliceSecret = a.encrypt(msgT);
        T bobDecryptedMsg = b.decrypt(aliceSecret);        
        GaloisField decryptBob = null;
        try {
            decryptBob = (GaloisField)bobDecryptedMsg;
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        }

        if(msg.isEqual(decryptBob)) { // if msg decrypted by Bob was an original msg which Alice sent and encrypted
            System.out.println("Bob managed to decrypt msg sent by Alice!");
        } else {
            System.out.println("Decryption was unsuccessful");
        }
    }

    public static void main(String[] args) {
        GaloisField field = null;
        try {
            field = new GaloisField(order);    
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        }
        SecureRandom rand = new SecureRandom();
        DHSetup<GaloisField> diffieHellman = new DHSetup<>(field, rand);
        User<GaloisField> alice = new User<>(diffieHellman);
        User<GaloisField> bob = new User<>(diffieHellman);
        try {
            testDiffieHellman(alice, bob);
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        }
    }
}
