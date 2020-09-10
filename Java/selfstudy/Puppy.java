public class Puppy{
	int puppyAge;
  public Puppy(String name){
System.out.println("Dog's name is :" + name );
}
public void setAge( int age ) {
	puppyAge = age;
}
public int getAge(){
	System.out.println("Dog's age is : " + puppyAge);
return puppyAge;
}
public static void main (String[] args){
Puppy yourPuppy = new Puppy("tommy");
yourPuppy.setAge( 2 + 3 );
yourPuppy.getAge();

}


}
