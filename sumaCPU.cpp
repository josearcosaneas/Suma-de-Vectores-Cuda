/*
    @autor José Arcos Aneas
    Codigo que calcula la suma de dos vectores.
    El contenido de los vectores estara contenido fichero cuyo contenido sera en la primera linea el numero de elementos que de cada vector, seguido de los elementos.
    El nombre de los archivos se pasa como argumento al ejecutar.

*/
#include <iostream>
#include <fstream>
#include <sys/time.h>
using namespace std;

int main(int argc, char* argv[]){
  struct timeval stop, start;
  
  const char *fichero1 = argv[1];
  const char *fichero2 = argv[2];
  ifstream archivo1(fichero1);
  ifstream archivo2(fichero2);
  
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
  float listaSuma[filas];
  // todas la filas   
  for(i=0 ; i < filas; i++){
      archivo1 >> aux1;
      archivo2 >> aux2;
      
      lista1[i]=aux1;
      lista2[i]=aux2;
        
  }  

  gettimeofday(&start, NULL);
  for( i = 0;i < filas ; i++){
      listaSuma[i]= lista1[i] + lista2[i];
  }
  gettimeofday(&stop, NULL);
  
  for (i =0; i< filas ; i++){ 
      cout<< lista1[i] << "+" << lista2[i] << "=" << listaSuma[i] <<  "\n";}
   cout << "\nLa suma se ha calculado en un tiempo de " << stop.tv_usec - start.tv_usec <<"\n";
  }   
