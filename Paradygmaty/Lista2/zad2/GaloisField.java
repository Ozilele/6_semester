import java.io.*;

public class GaloisField {
    private int value;
    private int order;

    public GaloisField(int value, int order) {
        this.value = value;
        this.order = order;
    }

    // Assignments
    public GaloisField equals(GaloisField l) {
        this.value = l.value;
        return this;
    }

    public GaloisField plusEq(GaloisField l) {
        this.value = (this.value + l.value) % order;
        return this;
    }

    public GaloisField minusEq(GaloisField l) {
        GaloisField l_inverse = l.minus();
        return this.plusEq(l_inverse);
    }

    public GaloisField multplyEq(GaloisField l) {
        this.value = (this.value * l.value) % order;
        return this;
    }

    public GaloisField divideEq(GaloisField l) {
        GaloisField l_inverse = this.inverse(l);
        return this.multplyEq(l_inverse);
    }

    // Arithmetic operations
    public GaloisField add(GaloisField l) {
        return new GaloisField((l.value + this.value) % order, order);
    }

    public GaloisField subtract(GaloisField l) {
        GaloisField r_inverse = l.minus();
        return this.add(r_inverse);
    }

    public GaloisField multiply(GaloisField l) {
        return new GaloisField((l.value * this.value) % order, order);
    }

    public GaloisField divide(GaloisField l) {
        GaloisField r_inverse = this.inverse(l);
        return this.multiply(r_inverse);
    }

    public GaloisField minus() {
        return new GaloisField(order - this.value, order);
    }

    public GaloisField inverse(GaloisField l) {
        return new GaloisField(this.solveDiofantic(l.value, order, 1), order);
    }

    private static int gcdExtended(int a, int b, int[] x, int[] y) {
        if(b == 0) {
            x[0] = 1;
            y[0] = 0;
            return a;
        }
        int[] x1 = new int[1];
        int[] y1 = new int[1];
        int gcd = gcdExtended(b, a%b, x1, y1);
        x[0] = y1[0];
        y[0] = x1[0] - (a / b) * y1[0];
        return gcd;
    }

    private int solveDiofantic(int a, int b, int c) {
        int[] x = new int[1];
        int[] y = new int[1];
        int gcd = GaloisField.gcdExtended(a, b, x, y);
        int solution = x[0];
        if(solution < 0) {
            solution = solution + order;
        }
        return solution;
    }

    // Comparisions operators
    boolean isEqual(GaloisField l) {
        return this.value == l.value;
    }

    boolean notEqual(GaloisField l) {
        return this.value != l.value;
    }
    
    boolean isLessEq(GaloisField l) {
        return this.value <= l.value;
    }

    boolean isLess(GaloisField l) {
        return this.value < l.value;
    }

    boolean isGreater(GaloisField l) {
        return this.value > l.value;
    }

    boolean isGreaterEq(GaloisField l) {
        return this.value >= l.value;
    }

    public void writeToStream(OutputStream out) {
        try {
            final String dataToBeWritten = this.value + " " + this.order;
            byte[] bytes = dataToBeWritten.getBytes();
            out.write(bytes);
            out.close();
        } catch(IOException ex) {
            System.out.println(ex);
        }
    }

    public void readFromStream(InputStream in) {
        try {
            byte[] data = new byte[in.available()];
            in.read(data);
            String stringData = new String(data);
            System.out.println(stringData);
            in.close();
        } catch(IOException ex) {
            System.out.println(ex.getMessage());
        }
    }

}