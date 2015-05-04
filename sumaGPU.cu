/*
    @autor José Arcos Aneas
    Codigo de suma de dos vectores contenidos en archivos donde la 
    primera linea sea el numero de elemento a leer.
    Los archivos son pasados como argumento a la hora de ejecutar.
*/

#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <sys/time.h>
using namespace std;

// Funcion de "nucleo" que calcula la suma dando a cada hebra
// la funcion de calcular la suma de los elemento de una posicion
__global__ void VecAdd(double* A,double* B,double* C)
{
    // extern __shared__ float sdata[];
	int i=threadIdx.x;
	C[i]=A[i]+B[i];

}

int main(int argc,char* argv[])
{
  // Leemos el fichero datos que cargamos desde entrada
  /*
  Esto es una actualizacion para no tener que compilar 
  con cada archivo que se quiera leer, no la he probado en 
  paralelo pero es identica a la secuencial y no ha dado 
  problemas.  
  */
  // leo el fichero 
  const char *fichero1 = argv[1];
  const char *fichero2 = argv[2];
  ifstream archivo1(fichero1);
  ifstream archivo2(fichero2);
  // varibles para calcular el tiempo
  struct timeval stop, start; 
  // leemos el numero de filas
  int filas,residuo;
  archivo2 >> residuo;
  archivo1 >> filas;
  cout << filas << "\n";
  //Leemos el contenido del fichero 
  float aux1,aux2=0.0;
  int i = 0;
  float lista1 [filas];
  float lista2 [filas];
  // todas la filas   
  for(i=0 ; i < filas; i++){
      archivo1 >> aux1;
      archivo2 >> aux2;      
      lista1[i]=aux1;
      lista2[i]=aux2;
  }   
	size_t size=filas*sizeof(double); 
	double* h_A=(double *)malloc(size);
	double* h_B=(double *)malloc(size);
	double* h_C=(double *)malloc(size);
	for(i=0;i<filas;i++)
	{
		h_A[i]=lista1[i];
		h_B[i]=lista2[i];
	}
    // Reservamos memoria y movemos las entradas a la memoria
    // del device
	double *d_A;
	cudaMalloc((void**)&d_A,size);
	cudaMemcpy(d_A,h_A,size,cudaMemcpyHostToDevice);
	double *d_B;
	cudaMalloc((void**)&d_B,size);
	cudaMemcpy(d_B,h_B,size,cudaMemcpyHostToDevice);
	double *d_C;
	cudaMalloc((void**)&d_C,size);
	dim3 dimblock(filas);// si el numero es muy grande podriamos tener problemas ya que podria sobrepasar el maximo.
	// Inicia el nucleo para calcular la suma
    gettimeofday(&start, NULL);
	VecAdd<<<1,dimblock>>>(d_A,d_B,d_C);
    gettimeofday(&stop, NULL);
    // Copiamos el resultado del host
	cudaMemcpy(h_C,d_C,size,cudaMemcpyDeviceToHost);
    // mostramos el resultado de la suma
	for(i=0;i<filas;i++)
	{
		printf("%lf ",h_C[i]);
	}
    // Liberamos memoria
	cudaFree(d_A); 
	cudaFree(d_B); 
	cudaFree(d_C); 
	
	free(h_A); 
	free(h_B); 
	free(h_C);
    cout << "\nCodigo ejecutado en (ms) " << stop.tv_usec - start.tv_usec;
	// mostramos el tiempo empleado en ms
	//printf("\nCodigo Ejecutado en  %d(ms)\n",int(stop.tv_usec - start.tv_usec));
    return 0;
}
