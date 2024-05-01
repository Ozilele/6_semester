import java.io.*;

public class Test {

    private static int order = 1234577;
    
    private static boolean checkEQ(GaloisField l, GaloisField r) {
        if(l.notEqual(r)) {
            return false;
        }
        return true;
    }

    private static boolean testArithmeticOperators() {
        try {
            GaloisField a = new GaloisField(1, order);
            GaloisField b = new GaloisField(2, order);
            GaloisField c = new GaloisField(3, order);
            GaloisField d = new GaloisField(321, order);
            GaloisField e = new GaloisField(15676, order);
            return checkEQ(a.add(b), c) && checkEQ(b.subtract(a), a) && checkEQ(a.multiply(b), b) && checkEQ(b.multiply(c), new GaloisField(6, order)) && checkEQ(c.divide(b), new GaloisField(617290, order)) && checkEQ(a.minus(), new GaloisField(1234576, order)) && checkEQ(d.multiply(e), new GaloisField(93688, order));
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }   

    private static boolean testComparisonOperators() {
        try {
            GaloisField a = new GaloisField(20, order);
            GaloisField b = new GaloisField(20, order);
            GaloisField c = new GaloisField(25, order);
            GaloisField d = new GaloisField(15, order);
            GaloisField e = new GaloisField(21, order);
            return a.isEqual(b) && a.notEqual(c) && d.isLessEq(c) && e.isGreaterEq(d) && e.isLess(c) && b.isGreater(d);
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    private static boolean testAssignmentOperators() {
        try {
            GaloisField a = new GaloisField(10, order);
            GaloisField b = new GaloisField(2, order);
            GaloisField c = new GaloisField(3, order);
            GaloisField d = new GaloisField(4, order);
            GaloisField e = new GaloisField(5, order);
            a.plusEq(b);
            d.minusEq(b);
            b.multplyEq(c);
            c.divideEq(d);
            e.equals(b);
            return checkEQ(a, new GaloisField(12, order)) && checkEQ(d, new GaloisField(2, order)) && checkEQ(b, new GaloisField(6, order)) && checkEQ(c, new GaloisField(617290, order)) && checkEQ(e, new GaloisField(6, order));
        } catch(Exception ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public static void main(String[] args) {
        boolean test1 = testArithmeticOperators();
        System.out.println("test1 is " + test1);
        boolean test2 = testComparisonOperators();
        System.out.println("test2 is " + test2);
        boolean test3 = testAssignmentOperators();
        System.out.println("test3 is " + test3);
    }    
}
