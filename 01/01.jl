input = readlines("./input")
nums = sort(parse.(Int, input))
set = Set(nums)

for i in 1:length(nums)
  X = nums[i]
  for j in (i + 1):length(nums)
    Y = nums[j]
    target = 2020 - X - Y
    if target in set
      println(X * Y * target)
      exit(0)
    end
  end
end
