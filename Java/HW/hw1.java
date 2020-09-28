public class hw1{
    public static void main (String args[]){
    int max = Integer.parseInt(args[0]);
    for(int i=1;i < args.length;i++){
        int nums = Integer.parseInt(args[i]);
      if(nums > max){
        max = nums;
      }
    }
    System.out.println(max);
  }
}
// find the max num from command line (take arguments from command line)
