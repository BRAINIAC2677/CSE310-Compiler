int a, b[4];

int main()
{
	int c, d[4];
	b[0] = 1;
	b[1] = 2;
	b[2] = 3;
	b[3] = 4;
	d[0] = b[3];
	d[1] = b[2];
	d[2] = b[1];
	d[3] = b[0];
	a = d[0] * b[1] + b[3];
	c = !b[1];
	println(a);
	println(c);
	return 0;
}