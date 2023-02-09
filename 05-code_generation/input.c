
int f(int a, int b)
{
	int c;
	c = a + b;
	return c;
}

int main()
{
	int a;
	a = 1 + 3;
	println(a);
	a = f(5, 6);
	println(a);
	a = f(1, 2) && f(3, 4);
	println(a);
	return 0;
}