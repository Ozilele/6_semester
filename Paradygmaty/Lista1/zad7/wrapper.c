#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include "./def.h"

// Compilation: gcc -o program wrapper.c -I/opt/homebrew/Frameworks/Python.framework/Versions/3.12/include/python3.12 -L/opt/homebrew/Frameworks/Python.framework/Versions/3.12/lib -lpython3.12
// -I to specify python.h directory location, -L specifies additional directories where libraries are located, it helps during linking process
int main(int argc, char *argv[]) {
    Py_Initialize(); // initializing python interpreter
    PyObject *sys = PyImport_ImportModule("sys");
    PyObject *path = PyObject_GetAttrString(sys, "path");
    PyList_Append(path, PyUnicode_FromString("../zad3"));

    PyObject *ModuleString = PyUnicode_FromString("framework_loop");
    if(!ModuleString) {
        PyErr_Print();
        printf("Error formatting python script\n");
    }
    PyObject* Module = PyImport_Import(ModuleString);
    if(!Module) {
        PyErr_Print();
        printf("Error importing python script\n");
    }
    // callFactorial(Module);
    // callSolveDiofantic(Module);
    callGcd(Module);
    Py_Finalize(); // shutting the interpreter down
    return 0;
}