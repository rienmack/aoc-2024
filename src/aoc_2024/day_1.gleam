import gleam/int
import gleam/list
import gleam/string

pub fn pt_1(input: String) -> Int {
  let pairs =
    input
    |> string.trim()
    |> string.split("\n")
    |> list.map(fn(line) {
      let assert [left, right] = string.split(line, "   ")
      #(int.parse(left), int.parse(right))
    })

  // Extract and handle successful integer parses
  let parsed_pairs =
    list.filter_map(pairs, fn(pair) {
      case pair {
        #(Ok(left), Ok(right)) -> Ok(#(left, right))
        _ -> Error(Nil)
      }
    })

  // Sort the left and right lists separately
  let left_list =
    parsed_pairs
    |> list.map(fn(pair) { pair.0 })
    |> list.sort(int.compare)

  let right_list =
    parsed_pairs
    |> list.map(fn(pair) { pair.1 })
    |> list.sort(int.compare)

  // Calculate the distance between paired elements
  list.zip(left_list, right_list)
  |> list.map(fn(pair) { int.absolute_value(pair.0 - pair.1) })
  |> list.fold(0, fn(acc, distance) { acc + distance })
}

pub fn pt_2(_input: String) {
  todo
}
