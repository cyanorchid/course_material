// compile command:
// g++ -O3 -Wall DSCT101_stuid.cpp -o DSCT101_stuid.exe


#include <iostream>
  
using namespace std;


int solve(int sum){
	// TODO: implements your code here

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
