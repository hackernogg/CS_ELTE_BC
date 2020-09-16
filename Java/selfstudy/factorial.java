class factorial {

public static void main (String args[]){
    int i,fact=1;
    int number=5;
    for (i=1;i<=number;i++) {
        fact=fact*i;
    }
    System.out.println("factorial of "+number+" is: "+fact);
}


    }
------------------------------------------------------------
/*way 2*/
static int factor(int n){
    if (n==0)
    return 1;
    else return(n*factor(n-1));
}
public static void main(String args[]){
    int i,fact=1;
    int number=4;
    fact=factor(number);
    System.out.println("factorial of "+number+" is: "+fact);
}
}
