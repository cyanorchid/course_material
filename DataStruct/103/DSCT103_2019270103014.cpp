// compile command:
// g++ -O3 -Wall DSCT103_2019270103014.cpp -o DSCT101_stuid.exe


#include <iostream>
  
using namespace std;



int main(int argc, char *argv[]) {    
      //argc为参数个数，argv存储输入的参数，argv[0]为程序名，argv[1]为输入的第一个参数，argv[2]...类推


	int better = 1 ,n = 1;
    double sumx2 = 0 , sumx1 = 0 , sumx1squ = 0, sumx2squ = 0;
    double sumy1 = 0 , sumx1y1 = 0 , k1 = 0 , b1 = 0 ,  s1fit = 0, s1ori = 0 , loss1 ;
    double sumy2 = 0 , sumx2y2 = 0,  k2 = 0 , b2 = 0 ,  s2fit = 0, s2ori = 0 , loss2 ;
	double x1[4] , x2[4] , y1[4] , y2[4] ,subx1[3] ,subx2[3] ;
	double result ;

	for(int i = 0  ; n<=16 ; i++)
	{
        if(n <= 8)
        {
		    x1[i] = atof(argv[n]);//argv[]默认存储char类型，atof将char转化为浮点数
		    n++ ; 
		    y1[i] = atof(argv[n]);
		    n++ ; 
            if(n == 9)i = -1 ;
        }
        else
        {
            x2[i] = atof(argv[n]  );
            n++ ; 
            y2[i] = atof(argv[n]);
            n++ ; 
        }

	}

	n = 4;
    // for(int i=0;i<=3;i++)
    // {
	//     printf("%2.2lf %2.2lf %2.2lf %2.2lf \n ",x1[i],y1[i],x2[i],y2[i]);
    // }


    for(int i = 0 ; i <= 3 ;i ++ )
    {
        sumx1 += x1[i];
        sumx2 += x2[i];
        
        sumx1squ += x1[i] * x1[i];
        sumx2squ += x2[i] * x2[i];

        sumy1 += y1[i] ;
        sumy2 += y2[i] ; 

        sumx1y1 += x1[i] * y1[i];
        sumx2y2 += x2[i] * y2[i];

        if(i<=2)
        {
            subx1[i] = (x1[i] + x1[i+1] )/ 2;
            subx2[i] = (x2[i] + x2[i+1] )/ 2;
        }

    }

    k1 = ( n * sumx1y1 - sumx1 * sumy1 )  /  ( n * sumx1squ - sumx1 * sumx1 );
    k2 = ( n * sumx2y2 - sumx2 * sumy2 )  /  ( n * sumx2squ - sumx2 * sumx2 );
    b1 = ( sumx1squ * sumy1 - sumx1 * sumx1y1  )  /  ( n * sumx1squ - sumx1 * sumx1 );
    b2 = ( sumx2squ * sumy2 - sumx2 * sumx2y2  )  /  ( n * sumx2squ - sumx2 * sumx2 );


 
    s1fit = ( ( k1 * x1[0] + b1) + ( k1 * x1[3] + b1) ) *  (x1[3] - x1[0]) / 2 ;
    s2fit = ( ( k2 * x2[0] + b1) + ( k2 * x2[3] + b2) ) *  (x2[3] - x2[0]) / 2 ;                                                                                                                                     

    s1ori = (subx1[0]-x1[0]) * y1[0] + (subx1[1] - subx1[0]) * y1[1] + (subx1[2] - subx1[1]) * y1[2] + (x1[3] - subx1[2]) * y1[3];
    s2ori = (subx2[0]-x2[0]) * y2[0] + (subx2[1] - subx2[0]) * y2[1] + (subx2[2] - subx2[1]) * y2[2] + (x2[3] - subx2[2]) * y1[3];
    
    loss1 = (s1ori - s1fit) / s1fit ;
    loss2 = (s2ori - s2fit) / s2fit ;

    if(loss1 < 0 )loss1 = -loss1;
    if(loss2 < 0 )loss2 = -loss2;



    if(loss1 > loss2)
    {    
        better = 2 ;
        result = (loss1 - loss2) / loss1 ;
    }
    else
    {
    result = (loss2 - loss1) / loss2 ;
    }
    if(result < 0) result = -result ;
    result  = 100 * result;
    printf("放法%d更优，优%.2lf%%\n",better, result);
	
	return 0;
}
