#!/usr/bin/env julia

function parse_num(v::Vector{Bool})
  lb = 0
  ub = 2^length(v) - 1

  for b in v
    mid = (lb + ub) ÷ 2
    if b
      lb = mid + 1
    else
      ub = mid
    end
  end

  return lb
end

function str_to_bool_vec(str::String, falsy::Char, truthy::Char)
  map(collect(str)) do c
    if c == falsy
      return false
    end
    if c == truthy
      return true
    end

    throw("Unknown type of char")
  end
end

function parse_seat(str::String)
  row = str_to_bool_vec(str[1:7], 'F', 'B')
  col = str_to_bool_vec(str[8:10], 'L', 'R')

  parse_num(row), parse_num(col)
end

function find_max_id()
  max_idx = -1
  for line in eachline("./input")
    row, col = parse_seat(line)

    max_idx = max(max_idx, row * 8 + col)
  end
  println(max_idx)
end

function find_missing_id()
  row_col_seats = [parse_seat(l) for l in eachline("./input")]
  seats = Set([x[1] * 8 + x[2] for x in row_col_seats])
  for res in minimum(seats):maximum(seats)
    if res ∉ seats
      println(res)
    end
  end
end

find_missing_id()
