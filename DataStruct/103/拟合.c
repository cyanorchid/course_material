#include<stdio.h>



int main(){
    float sumx2 = 0  , n = 8 , sumx = 0 ;
    float sumy1 = 0 , sumxy1 = 0 , k1 = 0 , b1 = 0 ;
    float sumy2 = 0 , sumxy2 = 0,  k2 = 0 , b2 = 0 ;
    int y1[8] = { 8,16,24,32,10,18,88,35} ;
    int y2[8] = { 64,256,576,1024,120,38,940,1470} ;


    for(int i = 1 ; i <= n ;i ++ )
    {
        sumx += i ;
        sumx2 += i * i ;
        
        sumxy1 += i * y1[i-1] ;
        sumy1 += y1[i-1] ;
        
        sumxy2 += i * y2[i-1] ;
        sumy2 += y2[i-1] ;

    }

    k1 = ( n * sumxy1 - sumx * sumy1 )  /  ( n * sumx2 - sumx * sumx );
    k2 = ( n * sumxy2 - sumx * sumy2 )  /  ( n * sumx2 - sumx * sumx );
    b1 = ( sumx2 * sumy1 - sumx * sumxy1  )  /  ( n * sumx2 - sumx * sumx );
    b1 = ( sumx2 * sumy2 - sumx * sumxy2  )  /  ( n * sumx2 - sumx * sumx );
    

    printf("%f %f\n %f %f ", k1, b1, k2, b2);


    return 0 ;
}