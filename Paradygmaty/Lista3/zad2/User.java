package Lista3.zad2;
import Lista2.zad2.GaloisField;
import java.security.SecureRandom;

public class User<T> {
    private DHSetup<T> dh;
    private long secret;
    private T encryption_key;

    public User(DHSetup<T> dh) {
        this.dh = dh;
        SecureRandom rand = new SecureRandom();
        long bound = (long)dh.getP();
        this.secret = rand.nextLong(1L, bound); // bound exclusive
        System.out.println("Secret key is " + this.secret);
    }

    public T getPublicKey() { // G^a, this key is being sent to another user
        T gen = dh.getGenerator();
        return dh.power(gen, this.secret);
    }

    public void setKey(T a) { // compute a = G^b, (G^b)^a
        this.encryption_key = dh.power(a, this.secret);
    }

    @SuppressWarnings("unchecked")
    public T encrypt(T m) {
        GaloisField data = null;
        GaloisField encryption_key;
        try {
            data = (GaloisField)m;
            encryption_key = (GaloisField)this.encryption_key;
            data = data.multiply(encryption_key);
            return (T)data;
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        }
        return (T) null;
    }   

    @SuppressWarnings("unchecked")
    public T decrypt(T c) {
        GaloisField data = null;
        GaloisField encryption_key;
        try {
            data = (GaloisField)c;
            encryption_key = (GaloisField)this.encryption_key;    
            data = data.divide(encryption_key);
            return (T)data;
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        }
        return (T) null;
    }
}
