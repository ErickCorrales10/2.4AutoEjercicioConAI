/*@@
    @@ Instituto Tecnológico de Tijuana
    @@ Depto de Sistemas y Computación
    @@ Ing. En Sistemas Computacionales
    @@
    @@ Autor : Corrales Quintero Erick Roberto @ErickCorrales10
    @@ Repositorio: https://github.com/tectijuana/3bldcorrida-ErickCorrales10.git
    @@ Fecha de revisión: 10/10/2023
    @@
    @
    @ Objetivo del programa:
    @    Generar números aleatorios*/

/*---------------------------------------------------------------*/
/*                      Solucion en C                           */
/*--------------------------------------------------------------*/
/*
#include <stdio.h>     
#include <stdlib.h>    // Including the standard library header file for functions like rand and srand.
#include <time.h>      // Including the time header file for generating random seed.
*/
/*
 * Generates and prints random numbers.
 *
 * @param count: The number of random numbers to generate and print.
 */
 /*
 void generateAndPrintRandomNumbers(int count) {
    // Setting the seed for the random number generator using the current time.
    srand(time(NULL));

    printf("Random Numbers:\n");

    for (int i = 0; i < count; i++) {
        // Generating a random number between 0 and RAND_MAX.
        int randomNumber = rand();
        printf("%d\n", randomNumber);
    }
}

// Usage example for generateAndPrintRandomNumbers

int main() {
    // Example: Generate and print 5 random numbers.
    generateAndPrintRandomNumbers(5);

    return 0;
}*/




/*--------------------------------------------------------------*/
/*          Seccion  de datos           */
/*--------------------------------------------------------------*/


.section .data

format:
    .asciz "Random Numbers:\n"
    

/*--------------------------------------------------------------*/
/*                     Seccion de codigo            */
/*--------------------------------------------------------------*/

.section .text

.globl main

main:
    push {lr}                           // Guardar el registro de enlace para la función "generateAndPrintRandomNumbers"
    mov r0, #5                          // Establecer el número de números aleatorios para generar
    bl generateAndPrintRandomNumbers    // Llamar a la función
    pop {lr}                            // Restaurar el registro de enlace
    mov r7, #1                          // Llamada al sistema para salir
    swi 0                               // Realizar la llamada al sistema para salir

generateAndPrintRandomNumbers:
    push {lr}                           // Guardar el registro de enlace
    mov r1, r0                          // Copiar el parámetro (cantidad) a r1
    ldr r0, =timeSeed                   // Cargar la dirección de timeSeed en r0
    bl srand                            // Llamar a srand para establecer la semilla
    ldr r0, =format                     // Cargar la dirección de la cadena de formato en r0
    bl printf                           // Llamar a printf para imprimir la cadena de encabezado
    mov r0, r1                          // Mover la cantidad a generar nuevamente a r0
loop:
    bl rand                             // Llamar a rand para generar un número aleatorio
    mov r2, r0                          // Copiar el número aleatorio a r2
    ldr r0, =numberFormat               // Cargar la dirección de numberFormat en r0
    bl printf                           // Llamar a printf para imprimir el número aleatorio
    subs r1, r1, #1                     // Decrementar la cantidad restante
    bne loop                            // Repetir el bucle hasta que se generen todos los números
    pop {lr}                            // Restaurar el registro de enlace
    bx lr                               // Retornar

.section .data

timeSeed:
    .word 0                             // Variable para almacenar la semilla generada a partir del tiempo

numberFormat:
    .asciz "%d\n"                       // Formato para imprimir números enteros con nueva línea
