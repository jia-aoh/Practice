from typing import List
class Solution:
    def __init__(self):
        self.dp = None # for recording

    def helper(self, coins, start, remain):
        if start == len(coins): # use out all coins
            return 0
        if remain < 0:
            return 0
        if remain == 0:
            return 1

        if self.dp[start][remain] != None: # reuse
            return self.dp[start][remain]
        
        left_count = self.helper(coins, start, remain - coins[start]) # use this coin
        right_count = self.helper(coins, start + 1, remain) # not use this coin
        self.dp[start][remain] = left_count + right_count

        return self.dp[start][remain]

    def change(self, amount: int, coins: List[int]) -> int:
        self.dp = [[None for _ in range(amount+1)] for _ in range(len(coins))] # initialize
        return self.helper(coins, 0, amount)
      
s = Solution()
amount = 5
coins = [1,2,5]
print(s.change(amount, coins))

from functools import cache

@cache
def fibonacci(x): # x >= 0
  if x == 0 or x == 1:
    return 1
  return fibonacci(x-1) + fibonacci(x-2)

斐波那契矩陣快速冪
def fibonacci(n):
  A = [
      [1, 1],
      [1, 0]
  ]
  if n == 0:
      return 0
  result = matrix_exponentiate(A, n - 1)  # 計算 A^(n-1)
  return result[0][0]  # 返回 F(n)