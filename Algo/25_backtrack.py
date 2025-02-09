from typing import List

class Solution:
    def create(self, depth: int, max_depth: int, password: List[int]):
        if (depth == max_depth):
            print(password) # 印出內容：可做99乘法
            return

        for i in range(3): 
            password.append(i + 1) # 密碼數字
            self.create(depth + 1, max_depth, password)
            password.pop() #back

    def find_all_passwords(self, digits: int):
        self.create(0, digits, [])

s = Solution()
N = 3 # 密碼長度
s.find_all_passwords(N)