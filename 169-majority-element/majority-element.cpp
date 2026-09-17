class Solution {
public:
    int majorityElement(vector<int>& nums) {
      sort(nums.begin(), nums.end());
      int count =1;
      int i;
      for(i = 0; i<nums.size()-1; i++){
        if(nums[i] == nums[i+1]){
            count++;
        
        if(count>nums.size()/2){
            break;
        }
        
        }
        else{
            count = 1;
        }
    
      }  
      return nums[i];
    }
};