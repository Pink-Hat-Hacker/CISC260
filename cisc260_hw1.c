/*
* CISC260
* HW1
* Zoe Valladares
*/
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void main() {
    int a, b, c;
    printf("Enter an integer:\n");
    scanf("%d", &a);
    printf("Enter an integer:\n");

    scanf("%d", &b);
    c = 0; // product, initialized as 0.
    // the code of your subroutine multBooth is called below
    
    //im getting here test
//  printf("IM GETTING HERE");
    c = multBooth(a, b);
    printf("the product = %d\n", c);
}

int multBooth(int a, int b){
    int m = a;
    int x = b;
    int c = 0;
    
    if(a < 0){
        m *= -1;
        if(b<0){
            x *= -1;
        }
    }else if(b < 0){
        x *= -1;
    }
    
    while(x!=0){
        if((x & 0x01) == 1){
            c = c + m;
        }
        m = m << 1;
        x = x >> 1;
    }
    
    if(a < 0 && b < 0){
        return c;
    }else if((a < 0) || (b < 0)){
        return c * -1;
    }
    return c;
}