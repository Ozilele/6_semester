package Lista3.zad2;
import java.security.SecureRandom;
import java.util.ArrayList;
import Lista2.zad2.GaloisField;

class DHSetup<T> {
    private T field;
    private int P;
    private T generator;
    public int getP() {
        return this.P;
    }
    private ArrayList<Integer> findPrimesDividingP(int n) {
        ArrayList<Integer> result = new ArrayList<>();
        boolean marked[] = new boolean[n + 1];
        for(int i = 0; i < marked.length; i++) {
            marked[i] = true;
        }
        for(int i = 2; i <= Math.sqrt(n); i++) {
            if(marked[i]) {
                int j = i * i;
                while(j <= n) {
                    marked[j] = false;
                    j = j + i;
                }
            }
        }
        for(int q = 2; q <= n; q++) {
            if(marked[q]) {
                if(n % q == 0) {
                    result.add(q);
                }
            }
        }
        return result;
    }
    private boolean isGenerator(long a, ArrayList<Integer> primes) {
        for(int prime : primes) {
            long factor = (this.P - 1) / prime;
            long elem = a * factor;
            if(elem == 1) {
                return false;
            }
        }
        return true;
    }
    private long generateRandom(SecureRandom rand, int min, int max) {
        return rand.nextLong(min, max + 1);
    }

    private ArrayList<Integer> decomposeIntoPowersOfTwo(long num) {
        ArrayList<Integer> powers = new ArrayList<>();
        int bitPosition = 0;
        while(num > 0) {
            if((num & 1) == 1) {
                powers.add(1 << bitPosition);
            }
            num >>= 1; // shift bits to right
            bitPosition++; // next bit position
        }
        return powers;
    }
    @SuppressWarnings("unchecked")
    public DHSetup(T field, SecureRandom rand) {
        this.field = field;
        GaloisField myField = null;
        try {
            myField = (GaloisField)field;
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        }
        this.P = myField.getOrder();
        ArrayList<Integer> primes = this.findPrimesDividingP(this.P - 1);
        T generator = null;
        while(generator == null) {
            long element = this.generateRandom(rand, 1, this.P - 1);
            if(this.isGenerator(element, primes)) {
                System.out.println("Gen is " + element);
                try {
                    generator = (T)new GaloisField(element, this.P);
                } catch(Exception ex) {
                    System.out.println(ex.getMessage());
                }
            }
        }
        this.generator = generator;
    }   

    public T getGenerator() {
        return this.generator;
    }

    @SuppressWarnings("unchecked")
    public T power(T a, long b) {
        GaloisField field = null;
        try {
            field = (GaloisField) a;
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        }
        long a_val = field.getCharacteristics();
        ArrayList<Integer> powers = this.decomposeIntoPowersOfTwo(b);
        ArrayList<Long> modulus = new ArrayList<>();
        ArrayList<Long> values = new ArrayList<>();
        int j = 0;
        for(int i = 1; i <= powers.get(powers.size() - 1); i *= 2) {
            long modulo;
            if(i == 1) {
                modulo = a_val % this.P;
            } else {
                modulo = (modulus.get(modulus.size() - 1) * modulus.get(modulus.size() - 1)) % this.P;
            }
            modulus.add(modulo);
            if(powers.get(j) == i) {
                j++;
                values.add(modulo);
            }
        }
        long multiply = 1;
        for(long value : values) {
            multiply = (multiply * value) % this.P;
        }
        int value = (int)multiply;
        System.out.println("Val " + value);
        GaloisField gField = null;
        T result = null;
        try {
            gField = new GaloisField(value, this.P);
            result = (T)gField;
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
        }
        return result;
    }
}
