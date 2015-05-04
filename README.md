# Suma-de-Vectores-Cuda
Varios programas sobre CUDA

0. Tabla de contenidos

    - Documentación: datos sobre la realizacion de la practica.
    - info.cu : archivo de codigo encargado de mostrar la información
    sobre la tarjeta con la trabajeremos.
    - sumaCPU: archivo de codigo encargado de realizar la suma de dos vectores en la CPU.
    - sumaGPU: archivo de codigo encargado de realizar la suma de dos vectores en la GPU.

1. info.cu

Haciendo uso de la funcion "cudaDevicepropiedades" y "cudaGetDevicepropiedadeserties" obtenemos información sobre la tarjeta grafica que vamos a usar para la relaizacion de la practica. Dicha información será mostrada por pantalla.


2. sumaCPU

Archivo que realiza la lectura de dos archivos le el contenido de ambos una vez hecho esto, realizamos la suma de los dos vectores almacenando el resultado en otro vector, mostraremos por pantalla el resultado. El codigo realiza dos veces la suma, una primera vez que toma el tiempo que se emplea y una segunda vez, cuando muetra el resultado por pantalla. Tomamos el tiempo unicamente la primera vez por que el otro tiempo no reflejaria el tiempo empleado unicamente en la suma.

    compilacion: g++ -o sumaCPU sumaCPU.cpp 
    ejecución: ./sumaCPU datos/input00.raw datos/input01.raw

3. sumaGPU
Al contrario que el codigo anterior este codigo esta mas comentado indicando cada paso que he seguido en su realización.



