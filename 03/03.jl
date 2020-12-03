#!/usr/bin/env julia

function main2()
  lines_read = 0
  res = zeros(Int, 5)
  for l in eachline("./input")
    function calc_index(right_offset)
      1 + ((lines_read * right_offset) % length(l))
    end

    trees = [
             l[calc_index(1)] == '#',
             l[calc_index(3)] == '#',
             l[calc_index(5)] == '#',
             l[calc_index(7)] == '#',
             lines_read % 2 == 0 ? l[calc_index(1)] == '#' : 0
            ]
    res += trees
    lines_read += 1
  end
  println(reduce(*, res))
end

main2()

# part one
function main()
  lines_read = 0
  res = 0
  for l in eachline("./input")
    if (l[1 + ((lines_read * 3) % length(l))] == '#')
      res += 1
    end
    lines_read += 1
  end

  println(res)
end
