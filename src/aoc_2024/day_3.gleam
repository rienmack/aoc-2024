import gleam/int
import gleam/option.{Some}
import gleam/regexp.{type Match, Match}

pub fn pt_1(input: String) {
  find_with(input, "mul\\((\\d+),(\\d+)\\)")
}

pub fn pt_2(input: String) {
  find_with(input, "mul\\((\\d+),(\\d+)\\)|don't\\(\\)|do\\(\\)")
}

fn find_with(input: String, pattern: String) {
  let assert Ok(re) = regexp.from_string(pattern)
  regexp.scan(input, with: re) |> evaluate_instructions(0, True)
}

fn parse_int(str: String) -> Int {
  let assert Ok(n) = int.parse(str)
  n
}

fn evaluate_instructions(instructions: List(Match), acc: Int, doing: Bool) {
  case instructions, doing {
    [], _ -> acc
    [Match("don't()", []), ..rest], _ -> evaluate_instructions(rest, acc, False)
    [Match("do()", []), ..rest], _ -> evaluate_instructions(rest, acc, True)
    [Match(_, [Some(a), Some(b)]), ..rest], True ->
      evaluate_instructions(rest, acc + parse_int(a) * parse_int(b), True)
    [_, ..rest], False -> evaluate_instructions(rest, acc, False)
    _, _ -> panic as "unexpected match"
  }
}
