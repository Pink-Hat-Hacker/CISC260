#include <stdio.h>
#include <string.h>

void isPalindrome(char str[]){
    int l = 0, h = strlen(str) - 1;
    
    while(h > 1){
        if(str[l++] != str[h--]){
            printf("Not  palindrome");
            return;
        }
    }
    printf("Palindrome");
}

