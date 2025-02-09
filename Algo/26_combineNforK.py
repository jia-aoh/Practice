class Solution:
    def __init__(self):
        self.ans = []

    def find(self, start, nums, max_length, comb):
        if len(comb) + (len(nums) - start) < max_length:
            return

        # already have k elements in this combination
        if len(comb) == max_length:
            self.ans.append(comb[:])
            return

        if (start >= len(nums)):
            return

        # use this value
        comb.append(nums[start])
        self.find(start + 1, nums, max_length, comb)
        comb.pop()

        # don't use this value
        self.find(start + 1, nums, max_length, comb)

    def combine(self, n: int, k: int) -> List[List[int]]:
        self.ans = []
        self.find(0, [i + 1 for i in range(n)], k, [])
        return self.ans

s = Solution()
n = 4
k = 3
print(s.combine(n, k))