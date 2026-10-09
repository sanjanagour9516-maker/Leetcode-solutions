
class Solution {
public:
    bool isPalindrome(int x) {
        if (x < 0) {
            return false;
        }

        long long sum = 0;
        int check = x;

        while (check != 0) {
            int rem = check % 10;
            sum = sum * 10 + rem;
            check = check / 10;
        }

        return sum == x;
    }
};