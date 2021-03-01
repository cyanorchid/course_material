// compile command:
// g++ -O3 -Wall DSCT101_stuid.cpp -o DSCT101_stuid.exe


#include <iostream>
  
using namespace std;


int main(int argc, char *argv[]) {
	int num ,i ,maxindex ,n ; 
	int yes[32] , no[32] ,only[32] ;
	unsigned int  maxvalue,j; 
	
	num = atol(argv[1]);
	
	
	for(i = 0 ,j = 1 ;j <= num ; i++ , j*=2 )   //i--index,j--value,找到小于目标的最大指数与值 
	{
	}
	maxvalue = j / 2 ;
	maxindex = i - 1 ;

	
	for( n = 0  ; num != 0 ;maxvalue /= 2, maxindex -= 1 )		//每个元素仅使用一次，找到唯一分解 
	{
		if(num >= maxvalue )
		{
			num -= maxvalue ;
			only[n] = maxindex ;
			n++ ;		//n为分解出的元素个数 
		}
	}
	
	
	
	yes[n-1] = only[n-1] ;		 //最后一元素分解的情况数量 
	no[n-1] = 1 ;		//最后一个元素不分解的情况数
	if(n>=2)
	{

	for(i = n-2 ; i>=0; i -- )
		{
			yes[i] = (only[i] - only[i+1]) * yes[i+1]   +  (only[i] - only[i+1] - 1) * no[i+1] ;
			no[i] = yes[i+1] + no[i+1] ;
		}
	}
	
	
	cout << yes[0]+ no[0] << endl;
	
	return 0;

}
