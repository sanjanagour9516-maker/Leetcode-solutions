class Solution {
public:
    vector<int> majorityElement(vector<int>& nums) {
        sort(nums.begin(), nums.end());

        vector<int> ans;
        int count = 1;

        for(int i = 0; i < nums.size(); i++) {

            if(i < nums.size() - 1 && nums[i] == nums[i + 1]) {
                count++;
            }
            else {
                if(count > nums.size() / 3) {
                    ans.push_back(nums[i]);
                }

                count = 1;
            }
        }

        return ans;
    }
};