#include <iostream>
#include "lib/example_template.cpp"
#include "printing/printer.hpp"

int main() {
    ExampleTemplate<int> temp;
    temp.PrintData();

    Printer printer;
    printer.print_hello_world();

    return 0;
}