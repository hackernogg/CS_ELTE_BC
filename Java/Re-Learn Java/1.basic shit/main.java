class Solution {
    public int[] twoSum(int[] nums, int target) {
        int[] ans1 = {0,0};
        for(int i = 0; i < nums.length;i++)
        {
            for(int j = i +1; j<nums.length;j++)
            {
                if(nums[i]+nums[j]== target)
                {
                    int[] ans = {i,j};
                    ans1 = ans;
                }
            }
        }
        return ans1;
    }
}
