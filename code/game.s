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
    @    Programa que permite jugar al juego de adivina el número
    */

/*---------------------------------------------------------------*/
/*                      Solucion en C                           */
/*--------------------------------------------------------------*/

/*
#include <stdio.h>  // Including the standard input-output header file for functions like printf.
#include <stdlib.h> // Including the standard library header for functions like malloc and exit.
#include <time.h>   // Including the time header for generating random numbers.
*/
 
/**
 * Generates a random number between a specified minimum and maximum value.
 *
 * @param min: The minimum value for the random number.
 * @param max: The maximum value for the random number.
 * @return: The generated random number.
 */
/*
int generateRandomNumber(int min, int max) {
    // Generating a random number using the current time as the seed.
    srand(time(NULL));
    return (rand() % (max - min + 1)) + min;
}*/
 
/**
 * Generates a game.
 *
 * This function generates a game by performing the following steps:
 * 1. Generates a random number between 1 and 100.
 * 2. Prompts the user to guess the generated number.
 * 3. Compares the user's guess with the generated number and provides feedback.
 * 4. Repeats steps 2 and 3 until the user guesses the correct number.
 *
 * @return: The number of attempts it took the user to guess the correct number.
 */
/*
int generateGame() {
    int randomNumber = generateRandomNumber(1, 100);
    int guess;
    int attempts = 0;
 
    printf("Welcome to the Number Guessing Game!\n");
    printf("I have generated a random number between 1 and 100.\n");
 
    do {
        printf("Please enter your guess: ");
        scanf("%d", &guess);
        attempts++;
 
        if (guess < randomNumber) {
            printf("Too low! Try again.\n");
        } else if (guess > randomNumber) {
            printf("Too high! Try again.\n");
        } else {
            printf("Congratulations! You guessed the correct number.\n");
        }
    } while (guess != randomNumber);
 
    return attempts;
}
 
int main() {
    int attempts = generateGame();
    printf("It took you %d attempts to guess the correct number.\n", attempts);
 
    return 0;
}
*/



/*--------------------------------------------------------------*/
/*          Seccion  de datos           */
/*--------------------------------------------------------------*/

.section .data
min_value:  .word 1            @ Valor mínimo
max_value:  .word 100          @ Valor máximo

welcomeMessage:     .asciz "Welcome to the Number Guessing Game!\nI have generated a random number between 1 and 100.\n"
promptMessage:      .asciz "Please enter your guess: "
guessFormat:        .asciz "%d"
tooLowMessage:      .asciz "Too low! Try again.\n"
tooHighMessage:     .asciz "Too high! Try again.\n"
congratsMessage:    .asciz "Congratulations! You guessed the correct number.\n"
timeSeed:           .word 0



/*--------------------------------------------------------------*/
/*                     Seccion de codigo            */
/*--------------------------------------------------------------*/


.section .text
.global _start

_start:
    // Llama a la función para generar el juego
    bl generateGame

    // Llama a la función de salida
    bl exit

generateRandomNumber:
    // Establece el puntero a la semilla aleatoria usando el tiempo actual
    ldr r0, =timeSeed
    bl srand

    // Carga los valores mínimos y máximos
    ldr r1, =min_value
    ldr r2, =max_value

    // Llama a rand para generar un número aleatorio
    bl rand

    // Calcula el número aleatorio dentro del rango
    mov r3, r2, lsr #16
    sub r2, r2, r3, lsl #16
    add r3, r3, #1
    sub r0, r0, r2
    add r0, r0, r3

    // Retorna el número aleatorio en r0
    bx lr

generateGame:
    // Llama a generateRandomNumber para obtener un número aleatorio
    ldr r0, =min_value
    ldr r1, =max_value
    bl generateRandomNumber

    // Inicializa las variables locales
    mov r4, r0          // randomNumber
    mov r5, #0          // guess
    mov r6, #0          // attempts

    // Imprime el mensaje de bienvenida
    ldr r0, =welcomeMessage
    bl printf

gameLoop:
    // Imprime el mensaje de ingreso de la suposición
    ldr r0, =promptMessage
    bl printf

    // Lee la suposición del usuario
    ldr r0, =guessFormat
    ldr r1, =r5
    bl scanf

    // Incrementa el contador de intentos
    add r6, r6, #1

    // Compara la suposición con el número aleatorio
    cmp r5, r4
    beq gameEnd         // Salta a gameEnd si son iguales
    blt tooLowMessage   // Salta a tooLowMessage si la suposición es menor
    bgt tooHighMessage  // Salta a tooHighMessage si la suposición es mayor
    b gameLoop          // Vuelve a gameLoop si no es igual, menor o mayor

tooLowMessage:
    // Imprime mensaje de "demasiado bajo"
    ldr r0, =tooLowMessage
    bl printf
    b gameLoop

tooHighMessage:
    // Imprime mensaje de "demasiado alto"
    ldr r0, =tooHighMessage
    bl printf
    b gameLoop

gameEnd:
    // Imprime mensaje de "adivinaste el número"
    ldr r0, =congratsMessage
    bl printf

    // Retorna la cantidad de intentos en r6
    mov r0, r6
    bx lr

exit:
    // Llama a la función de salida
    mov r7, #1          // syscall para salir
    swi 0

