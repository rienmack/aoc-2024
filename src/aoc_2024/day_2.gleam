import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

fn parse(data: String) {
  data
  |> string.split("\n")
  |> list.filter_map(fn(x) {
    x
    |> string.split(" ")
    |> list.map(int.parse)
    |> result.all
  })
}

fn is_safe(nums: List(Int)) {
  nums
  |> list.window_by_2
  |> list.map(fn(pair) { pair.0 - pair.1 })
  |> fn(row) {
    list.all(row, fn(value) { value >= 1 && value <= 3 })
    || list.all(row, fn(value) { value <= -1 && value >= -3 })
  }
}

pub fn pt_1(input: String) {
  input
  |> parse
  |> list.count(is_safe)
}

pub fn pt_2(input: String) {
  todo as "part 2 not implemented"
}
