#include <stdio.h>
#include <stdint.h>

long int circle();

int main() {
	long int result_code = -999;
	printf("Welcome to your friendly circle circumference calculator.\n");
	printf("The main program will now call the circle function.\n");

	result_code = circle();
	
	printf("%s%ld\n","The main recieved this integer: ",result_code);
	printf("Have a nice day. Main will now return 0 to the operating system.\n");

	return 0;
} // main