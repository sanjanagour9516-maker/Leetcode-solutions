class Solution {
public:
    bool isAnagram(string s, string t) {
        if(s.length() != t.length()){
            return false;
        }
        int count[26]= {0};
        for(int i=0; i<s.size(); i++){
            int index = s[i]-'a';
            count[index]++;
        }

        for(int i= 0; i<t.size(); i++){
            int index= t[i]-'a';
            if(count[index]==0){
                return false;
            }
            count[index]--;
        }
        return true;
    }
};