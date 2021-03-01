// compile command:
// g++ -O3 -Wall DSCT101_stuid.cpp -o DSCT101_stuid.exe


#include <iostream>
  
using namespace std;


int main(int argc, char *argv[]) {
	long long  cost = 0,sum ,temp ;		//storage the target division 

	int  i , j  ;			//sum is the sum  of  the two min value 
	
	long long *l = NULL ;
	l = (long long *)malloc(sizeof(int) * (argc-1));
	if( l != NULL )
	{	for(int i= 1 ; i<=argc ; i++)
		{
			l[i-1] =atof( argv[i]);
		}
	
		for(int time = 0 ; time <= argc-3 ; time ++ )		//each time abandon the two min value used , the sum of them become a new value 
		{	
			for(i = time ; i <= time+1 ;i ++)		// rank datas from min to max
			{
				for(j = i+1 ; j <= argc-2 ; j++)
				{
				if( l[j] < l[i] )
					{
						temp = l[j] ;
						l[j] = l[i] ;
						l[i] = temp ;
					}
					
				}		
			}
			sum   = l[time] + l[time + 1] ;		//the new plank
			l[time+1] = sum ;
			cost += sum ;						//take  it into cost
		}
	free(l);
	l = NULL ;
	
	cout << cost << endl;
	
	return 0;
	}
	else return -1;
}
