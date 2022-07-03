class Solution {
public:
    bool isPalindrome(int x) {
        int temp = x;
        bool ans = false;
        int rem;
        long reversNum = 0;
        
        if (x == 0)
        {
            ans = true;
        }
        if(x > 0)
        {
            while(temp > 0)
            {
                rem = temp % 10;
                reversNum = reversNum * 10 + rem;
                temp = temp / 10;
            }
            
            if(reversNum == x)
            {
                ans = true;
            }
        }
        
        return ans;

    }
};
