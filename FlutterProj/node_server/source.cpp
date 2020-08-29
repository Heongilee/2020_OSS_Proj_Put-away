#include <stdio.h>
int main(void) {

	// processor intensive computations
	int x = 1 + 2 + 3;

	// send to node via stdout
	printf("%d", x);

	//terminate the process
	return 0;
}