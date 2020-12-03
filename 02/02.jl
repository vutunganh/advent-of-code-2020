#!/usr/bin/env julia

import Base.show

struct ParsedLine
  min::Int
  max::Int
  c::Char
  str::String
end

function show(io::IO, parsed_line::ParsedLine)
  print(io, parsed_line.min, " ", parsed_line.max, " ", parsed_line.c, " ", parsed_line.str)
end

function debug_print(parsed_line::ParsedLine)
  println(parsed_line.c, " ", parsed_line.str[parsed_line.min], " ", parsed_line.str[parsed_line.max])
end

function parse_line(line::String)
  m = match(r"(\d+)-(\d+) ([a-z]): (\w+)", line)

  ParsedLine(parse(Int, m.captures[1]), parse(Int, m.captures[2]), m.captures[3][1], m.captures[4])
end

function check_line(parsed_line::ParsedLine)
  parsed_line.min <= count(c -> c == parsed_line.c, parsed_line.str) <= parsed_line.max
end

function check_line2(parsed_line::ParsedLine)
  min_has = parsed_line.str[parsed_line.min] == parsed_line.c
  max_has = parsed_line.str[parsed_line.max] == parsed_line.c

  min_has ⊻ max_has
end

function main()
  res = 0
  for line in eachline("./input")
    parsed_line = parse_line(line)
    res += check_line2(parsed_line) == true
    debug_print(parsed_line)
    println(check_line2(parsed_line))
  end
  println(res)
end

main()
