#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <stdio.h>
#include <stdlib.h>

void callFactorial(PyObject *module) {
    int n;
    printf("Dla jakiego n program ma policzyć silnię?\n");
    scanf("%d", &n);
    PyObject *args, *kwargs;
    PyObject *result = 0; 
    PyGILState_STATE state = PyGILState_Ensure(); 
    PyObject* func = PyObject_GetAttrString(module, (char*)"calc_factorial");
    if(!func || !PyCallable_Check(func)) {
        fprintf(stderr, "Nie można znaleźć funkcji 'calc_factorial'\n");
        return;
    }
    args = Py_BuildValue("(i)", n); 
    kwargs = NULL; 
    result = PyObject_Call(func, args, kwargs);
    long factorial = PyLong_AsLong(result);
    printf("Factorial of %d is %d\n", n, factorial);
    Py_DECREF(args); 
    Py_DECREF(func); 
    Py_DECREF(result); 
    Py_XDECREF(kwargs); 
    Py_DECREF(module);
    PyGILState_Release(state); 
}

void callGcd(PyObject *module) {
    int a, b;
    printf("Podaj 2 liczby w celu obliczenia ich nwd.\n");
    scanf("%d", &a);
    scanf("%d", &b);
    PyObject *args, *kwargs;
    PyObject *result = 0; 
    PyGILState_STATE state = PyGILState_Ensure(); 
    PyObject* func = PyObject_GetAttrString(module, (char*)"calc_gcd");
    if(!func || !PyCallable_Check(func)) {
        fprintf(stderr, "Nie można znaleźć funkcji 'calc_gcd'\n");
        return;
    }
    args = Py_BuildValue("(i,i)", a, b);
    kwargs = NULL;
    result = PyObject_Call(func, args, kwargs);
    long gcd = PyLong_AsLong(result);
    printf("GCD of %d and %d is %d\n", a, b, gcd);
    Py_DECREF(args); 
    Py_DECREF(func); 
    Py_DECREF(result); 
    Py_XDECREF(kwargs); 
    Py_DECREF(module);
    PyGILState_Release(state); 
}

void callSolveDiofantic(PyObject *module) {
    int a, b, c;
    printf("Podaj wspolczynniki a, b, c równania diofantycznego\n");
    scanf("%d", &a);
    scanf("%d", &b);
    scanf("%d", &c);
    PyObject *args, *kwargs;
    PyGILState_STATE state = PyGILState_Ensure(); 
    PyObject* func = PyObject_GetAttrString(module, (char*)"solve_diofantic");
    if(!func || !PyCallable_Check(func)) { 
        fprintf(stderr, "Nie można znaleźć funkcji 'solve_diofantic'\n"); 
        return;
    } 
    args = Py_BuildValue("(iii)", a, b, c); 
    kwargs = NULL; 
    PyObject* result = PyObject_CallObject(func, args);
    if(result == NULL) {
        fprintf(stderr, "Error trying to call function\n");
        return;
    }
    if(PyTuple_Check(result) && PyTuple_Size(result) == 2) {
        PyObject *first = PyTuple_GetItem(result, 0);
        PyObject *second = PyTuple_GetItem(result, 1);
        if(PyTuple_Check(second) && PyTuple_Size(second) == 2) {
            PyObject *x_val = PyTuple_GetItem(second, 0);
            PyObject *y_val = PyTuple_GetItem(second, 1);
            if(PyLong_Check(x_val) && PyLong_Check(y_val)) {
                long x = PyLong_AsLong(x_val);
                long y = PyLong_AsLong(y_val);
                printf("Solution to equation %dx + %dy = %d are x = %d and y = %d\n", a, b, c, x, y);
            }
        } else if(PyUnicode_Check(first)) {
            const char *message = PyUnicode_AsUTF8(first);
            printf("%s\n", message);
        }
    }
    Py_DECREF(func);
    Py_DECREF(result);
    Py_DECREF(module);
}
