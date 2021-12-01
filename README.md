# Eric's Advent of Code 2021 Solutions

## Project Structure

This year, I plan on tackling AoC with Julia. I've dabbled a bit with Julia off and on
over the past year, and this seemed like a golden opportunity to really put the langauge
through it's paces. Because I know myself, I'm leaving room in the top level of this 
project to accommodate other languages as I have time/it strikes my fancy. For now,
though, there's just `JuliaAdventOfCode`.

### Julia Project

The Julia project structure looks like this:

```
--JuliaAdvventOfCode
 |-- inputs
   |-- DayXX
     |-- Input01.txt
     |-- Input02.txt
 |-- src
   |-- DayXX
     |-- DayXX.jl
     |-- Part01.jl
     |-- Part02.jl
   |-- JuliaAdventOfCode.jl
 |-- bench
   |-- Benchmark.jl
```

With the `JuliaAdventOfCode` package activated (see below):

- Get the results for all days with `julia src/JuliaAdventOfCode.jl`
- Get the benchmarks for all days with `julia bench/Benchmark.jl`

For Day 1, that looks like:

```
❯ julia src/JuliaAdventOfCode.jl 

Advent of Code 2021 Results:

- Day 01
|-- Part 01: 1583
|-- Part 02: 1671
```

```
❯ julia bench/Benchmark.jl

Julia Advent of Code 2021 Benchmarks:

- Day 01:
|-- Part 01:  2.897 μs (5 allocations: 20.31 KiB)
|-- Part 02:  28.081 μs (8 allocations: 114.20 KiB)
```

**Note on Julia project activation**

To conveniently use the commands listed above, add the following to your `/.julia/config/startup.jl`:

```julia
using Pkg
if isfile("Project.toml") && isfile("Manifest.toml")
    Pkg.activate(".")
end
```
