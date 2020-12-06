#!/usr/bin/env julia

function process_group(answers::Vector{String})::Int
  h = zeros(Int, 'z' - 'a' + 1)

  for answer in answers
    for c in answer
      h[1 + c - 'a'] += 1
    end
  end

  # task one
  # count(a -> a > 0, h)
  ppl_cnt = length(answers)
  count(a -> a == ppl_cnt, h)
end

function main()
  group = Vector{String}()
  res = 0
  for line in eachline("./input")
    if length(line) == 0
      res += process_group(group)
      group = Vector{String}()
      continue
    end

    push!(group, line)
  end

  res += process_group(group)
  println(res)
end

main()
