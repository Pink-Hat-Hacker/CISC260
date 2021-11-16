
int tFib(int n){ 
  if (n == 0 || n == 1 || n==2){
    return n; 
  }else{
    return tFib(n-1) + tFib(n-2) + tFib(n-3); 
  }
} 

int main() {
    tFib(5);

    return 0;
}
