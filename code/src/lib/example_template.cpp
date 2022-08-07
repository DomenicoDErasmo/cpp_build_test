#ifndef EXAMPLE_TEMPLATE_TPP
#define EXAMPLE_TEMPLATE_TPP

template <typename T>
class ExampleTemplate {
public:
    ExampleTemplate(): data(T()) {}
    ExampleTemplate(T in_data): data(in_data) {}
    void PrintData() {std::cout << "Data: " << data << ", size:" << sizeof(T) << std::endl;}
private:
    T data;
};

#endif