#include<stdio.h>
#include<math.h>

int main(){
	int f[7][100]={};
	int ld,rd,lh,rh;
	f[0][0]=1;
	f[1][1]=1;
	f[2][2]=2;
	f[2][3]=1;
	int n,m=6,sum=0;
	scanf("%d",&n);
	for(int j = 3 ;j <= m;j++)
	{
		for(int i = 0;i <= n;i++)
		{
			f[j][i]= 0;
			if ((pow(2,j-2)-1 )<= i)
			{
		
			lh = j-1;
			rh = j-2;
			for(ld = 0;ld <= i-1;ld++)
			{
				rd = i-1-ld; 
				if( (pow(2,lh-2)-1 <= ld) &&(pow(2,lh)-1 >= ld) && (pow(2,rh-2)-1 <= rd) &&(pow(2,rh)-1 >= rd) )
				{
					f[j][i] += 2 * f[lh][ld] * f[rh][rd];
				}
			}
			rh = j-1;
			for(ld = 0;ld<=i-1;ld++)
			{
				rd = i-1-ld; 
				if( (pow(2,lh-2)-1 <= ld) &&(pow(2,lh)-1 >= ld) && (pow(2,rh-2)-1 <= rd) &&(pow(2,rh)-1 >= rd) )
				{
					f[j][i] += f[lh][ld] * f[rh][rd];	
				}
			}
			}
		}
	}
	for(int i = 0;i <= m;i++)
	{
        sum+=f[i][n];
	}
 		printf("\n%d\t",sum);
}
