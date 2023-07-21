int a[10];

// write sorting algorithm to sort a here
void sort()
{
	int i, j, temp;
	for (i = 0; i < 10; i++)
	{
		for (j = i + 1; j < 10; j++)
		{
			if (a[i] > a[j])
			{
				temp = a[i];
				a[i] = a[j];
				a[j] = temp;
			}
		}
	}
}

int main()
{
	a[0] = 5;
	a[1] = 2;
	a[2] = 3;
	a[3] = 1;
	a[4] = -4;
	a[5] = 9;
	a[6] = 8;
	a[7] = 7;
	a[8] = 6;
	a[9] = -1;
	sort();
	int i;
	for (i = 0; i < 10; i++)
	{
		int c;
		c = a[i];
		println(c);
	}
	return 0;
}
