class Solution:
    def __init__(self):
        self.dp = {} # 暫存set

    def fibonacci(self, x):
        if x == 1 or x == 2:
            return 1
        if x in self.dp: # reuse
            return self.dp[x]

        # record answer for index x
        self.dp[x] = self.fibonacci(x-1) + self.fibonacci(x-2)
        return self.dp[x]

s = Solution()
print(s.fibonacci(100))