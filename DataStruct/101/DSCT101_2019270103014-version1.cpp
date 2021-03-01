// compile command:
// g++ -O3 -Wall DSCT101_stuid.cpp -o DSCT101_stuid.exe


#include <iostream>
  
using namespace std;
int f[20000005];
  
int solve(int sum){
	// TODO: implements your code here
	int i,j,fl=1,kind=0; //kind means how many kinds of coins are avaliable,fl as face value
    f[0]=1;
    for (j = 1; j <= sum;j++)
        f[j] = 0;
    for (i = 1; fl<=sum; i++) //ut circle loop though kind
    {
		kind++;
        for (j = sum; j >= 1; j--) //inside circle loop though sum
        {
            if (j - fl >= 0)
                f[j] += f[j - fl];
            if (j - 2 * fl >= 0)
                f[j] += f[j - 2 * fl];
        }
        fl *= 2;
    }

	return f[sum];
}

int main(int argc, char *argv[]) {
	
    if(argc != 2){
		cout << "Usage: " << argv[0] << " " << "<number>" << endl;
		return -1;
	}

	int sum = atol(argv[1]);
	
	int resulut = solve(sum);
	
	cout << resulut << endl;
	
	return 0;
}
