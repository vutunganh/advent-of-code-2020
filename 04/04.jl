#!/usr/bin/env julia

using Match

function process_passport(line::String)
  kv_pairs = split(line, " ")

  found_keys = Set{String}()

  for field in kv_pairs
    key, value = split(field, ':')
    push!(found_keys, key)
  end

  all(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]) do k
    k ∈ found_keys
  end
end

function parse_num_range(num, lb, ub)
  if nothing === num
    return false
  end

  lb <= parse(Int, num) <= ub
end

function validate_passport(line::String)
  kv_pairs = split(line, " ")
  d = Dict{String, String}()

  for field in kv_pairs
    key, value = split(field, ':')
    d[key] = value
  end

  validator = Dict([
    ("byr", s -> parse_num_range(s, 1920, 2002)),
    ("iyr", s -> parse_num_range(s, 2010, 2020)),
    ("eyr", s -> parse_num_range(s, 2020, 2030)),
    ("hgt", s -> begin
       m = match(r"(\d+)(cm|in)", s)
       if m === nothing || length(m.captures) < 2
         return false
       end

       hgt, units = m.captures[1], m.captures[2]
       @match units begin
         "cm" => parse_num_range(hgt, 150, 193)
         "in" => parse_num_range(hgt, 59, 76)
         _ => false
       end
     end),
    ("hcl", s -> match(r"^#[0-9a-f]{6}$", s) !== nothing),
    ("ecl", s -> s ∈ ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]),
    ("pid", s -> match(r"^\d{9}$", s) !== nothing)
  ])

  all(k -> haskey(d, k) && (validator[k])(d[k]), keys(validator))
end

function main()
  res = 0
  passport_lines = String[]
  for line in eachline("./input")
    if match(r"^\W*$", line) !== nothing
      res += validate_passport(join(passport_lines, ' '))
      passport_lines = []
      continue
    end

    push!(passport_lines, line)
  end

  # process last passport
  res += validate_passport(join(passport_lines, ' '))
  println(res)
end

main()
