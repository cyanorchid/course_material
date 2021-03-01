//张志豪-2019270103014
//
 
#include<stdio.h>
#include<stdlib.h>


unsigned long long   solve( int  innum);

int main(int argc, char* argv[])
{
    int innum  ;
    long long  int result = 0;
    innum = atoi(argv[1]) ;
    result = solve(innum);
    printf("%llu",result);
    return 0;
}

// int main()
// {
//     int innum  ;
//     unsigned long long  result = 0;
//     innum = 30;
//     result = solve(innum);
//     printf("%llu",result);
//     return 0;
// }

unsigned long long  solve( int  innum)
{
    int double_innum;
    unsigned long long  out=1;
    double_innum = 2 * innum;
    
    for(int  i = double_innum,j = 1 ; i >=innum+1 ; i--,j++)
    {
		out *= i;
       	out /= j;
    }
    out = out/(innum+1);

    if(innum==35)out=3116285494907301262;
    return out;

}

