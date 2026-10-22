class Solution {
public:
    bool uniqueOccurrences(vector<int>& arr) {
        sort(arr.begin(), arr.end());

        vector<int> freq;

        for (int i = 0; i < arr.size(); i++) {
            int count = 1;

            while (i + 1 < arr.size() && arr[i] == arr[i + 1]) {
                count++;
                i++;
            }

            freq.push_back(count);
        }

        sort(freq.begin(), freq.end());

        for (int i = 1; i < freq.size(); i++) {
            if (freq[i] == freq[i - 1]) {
                return false;
            }
        }

        return true;
    }
};