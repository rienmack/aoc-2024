import gleam/int
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
  input
  |> parse
  |> list.count(fn(row) {
    row
    |> list.index_map(fn(_, idx) {
      list.append(list.take(row, idx), list.drop(row, idx + 1))
    })
    |> list.any(is_safe)
  })
}
