import gleam/dict
import gleam/int
import gleam/list
import gleam/result
import gleam/string

fn parse(data: String) -> #(List(Int), List(Int)) {
  data
  |> string.split("\n")
  |> list.map(fn(x) {
    let assert Ok([a, b]) =
      string.split(x, "   ") |> list.map(int.parse) |> result.all
    #(a, b)
  })
  |> list.unzip
}

pub fn pt_1(input: String) -> Int {
  input
  |> parse
  |> fn(data) {
    list.zip(list.sort(data.0, int.compare), list.sort(data.1, int.compare))
  }
  |> list.map(fn(data) { int.absolute_value(data.0 - data.1) })
  |> int.sum
}

pub fn pt_2(input: String) {
  let #(line1, line2) = parse(input)
  let freq =
    list.fold(line2, dict.new(), fn(acc, x) {
      dict.insert(acc, x, 1 + result.unwrap(dict.get(acc, x), 0))
    })
  list.map(line1, fn(x) { x * result.unwrap(dict.get(freq, x), 0) })
  |> int.sum
}
