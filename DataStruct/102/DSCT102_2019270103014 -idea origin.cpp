#include <stdio.h>


int main(){
	int l[100]={8,5,8} , cost = 0 ;		//storage the target division 
	int sum , i , j ,temp ;			//sum is the sum  of  the two min value 
	for(int time = 0 ; time <= 98 ; time ++ )		//each time abandon the two min value used , the sum of them become a new value 
	{
		for(i = time ; i <= time+1 ;i ++)		// rank datas from min to max
		{
			for(j = i+1 ; j <= 99 ; j++)
			{
				if( l[j] < l[i] ){
					temp = l[j] ;
					l[j] = l[i] ;
					l[i] = temp ;
				}
					
			}		
		}
		sum = l[time] + l[time +1] ;		//the new plank
		cost += sum ;						//take  it into cost
	}
	
	
	printf("%d",cost);
	return 0 ;
	
	}

