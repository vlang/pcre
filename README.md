## pcre

A simple regex library for [V](https://github.com/vlang/v).
It use bindings from the [PCRE](https://www.pcre.org/) library.

## Example

```go
# examples/match_after.v

import regex

fn main() {
  r := regex.new_regex('Match everything after this: (.+)', 0) or {
    println('An error occured!')
    return
  }

  m := r.match_str('Match everything after this: "I <3 VLang!"', 0, 0) or {
    println('No match!')
    return
  }

  // m.get(0) -> Match everything after this: "I <3 VLang!"
  // m.get(1) -> "I <3 VLang!"'
  // m.get(2) -> Error!
  whole_match := m.get(0) or {
    println('We matched nothing...')
    return
  }

  matched_str := m.get(1) or {
    println('We matched nothing...')
    return
  }

  println(whole_match) // Match everything after this: "I <3 VLang!"
  println(matched_str) // "I <3 VLang!"

  r.free()
}
```

```bash
> v -o example examples/match_after.v
> ./example
Match everything after this: "I <3 VLang!"
"I <3 VLang!"
```

## Usage

Some examples are available in the [examples](examples/) directory.

## Built With

* [PCRE](https://www.pcre.org/) - Perl Compatible Regular Expressions
* [Vlang](https://github.com/vlang/v) - Simple, fast, safe, compiled language

## License

[MIT](LICENSE)

## Contributors

* [Shellbear](https://github.com/shellbear) - creator and maintainer
