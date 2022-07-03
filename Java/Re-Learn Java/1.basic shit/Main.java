
public class Main {

	public static void main(String[] args) {
		// basic shit
		System.out.print("hey");
		System.out.println("hello");
		System.out.println("I love \n pizza");
		// this is a comment :)
		for (int i = 0; i<5;i++) {
			System.out.println(i);
		}
		
		int x = 123;
		float y = 3.14f;
		double z = 3.14;
		boolean s = true;
		char symbol = '@';
		String name = "Jerry";
		
		System.out.println("My shit is : " + name);
		
		// swap two variables
		String str1 = "water";
		String str2 = "Juice";
		String temp;
		
		temp = str1;
		str1 = str2;
		str2 = temp;
		
		System.out.println(str1);
		System.out.println(str2);
}
}
