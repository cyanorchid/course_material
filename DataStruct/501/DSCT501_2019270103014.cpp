#include <iostream>
#include <stdio.h>
#include <string.h>
#include <algorithm>
#include <math.h>

using namespace std;

int main(int argc, char *argv[]) {
	long long  input = atof(argv[1]);
	long part[10];
	int order = 0;
	for(long long  i = 2;input != 1;i++)
	{
		while(input%i == 0){
			input /= i;
			part[order] = i; 
			order++;                           
			}
		}
		
	for(int i = 0;i <= order-2;i++)
	{
		printf("%d*",part[i]);
	}
	printf("%d",part[order-1]);
	return 0;

	return 0;
}

