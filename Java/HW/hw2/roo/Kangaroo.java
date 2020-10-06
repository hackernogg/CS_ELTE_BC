package roo;
public class Kangaroo {
    String name;
    String country;
    int age;
    public Kangaroo(String name,int age){
        this.name = name;
        this.age=age;
    }
    public void display(String country){
        this.country = country;
        System.out.println("Kangaroo name:"+ name + "Kangaroo age:"+( age+1 ) +"Kangaroo country:"+country );
    }
      
}
