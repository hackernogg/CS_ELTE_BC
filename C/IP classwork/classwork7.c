#include <stdio.h>

/*int main ()
{
	int i = 0, j = 0;
	j = i++; //i++ = do i first and then plus 1 for i
	printf("%d %d", i, j);
}*/
//OP= 1 0
// ---------------------------------------
// i dont know shit about this.
/*int main()
//void hiding()
{
	int n = 0;
	printf("%p\n",&n);
	{
		int n = 1;
		printf("%p\n",&n);
	}
	printf("%p\n",&n);
}*/
//-----------------------------------------
// slow way of do the fib task
/*
int fib(int n)
{
	if (n < 2)
		return 1;
	
	return fib(n - 1) + fib (n - 2);
}
int main()
{
	for (int i = 0; i < 100; ++i)
	printf("%d\n", fib(i));
	
*/
//----------------------------------
//fast way of the fib task
/*
int* f()
{
	//int arr[10];
	int* arr = (int*)malloc(10 * sizeof(int));
	
	for (int i = 0; i < 10; ++i)
		arr[i] = i + 1;
	return arr;
}
int main()
{
	int* arr = f();
	for (int i = 0; i < 10; ++i)
		printf("%d\n", arr[i]);
}
*/
