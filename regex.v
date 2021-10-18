module pcre

struct Regex {
pub:
	re       &C.pcre       // A pointer to pcre structure
	extra    &C.pcre_extra // A pointer to pcre_extra structure
	captures int // The number of capture groups
}

pub fn (r &Regex) free() {
	if !isnil(r.re) {
		C.pcre_free(r.re)
	}
	if !isnil(r.extra) {
		C.pcre_free_study(r.extra)
	}
}

// match_str returns a MatchData structure containing matched strings and:
// str: the string to test
// pos: the position of the beginning of the string (default: 0)
// options: the options as mentioned in the PCRE documentation
pub fn (r Regex) match_str(str string, pos int, options int) ?MatchData {
	if pos < 0 || pos >= str.len {
		return error('Invalid position')
	}
	ovector_size := (r.captures + 1) * 3
	ovector := []int{len: ovector_size}
	ret := C.pcre_exec(r.re, r.extra, str.str, str.len, pos, options, ovector.data, ovector_size)
	if ret <= 0 {
		return error('No match!')
	}
	return MatchData{
		re: r.re
		str: str
		ovector: ovector
		pos: pos
		group_size: r.captures + 1
	}
}

// new_regex create a new regex
// * source: the string representing the regex
// * options: the options as mentioned in the PCRE documentation
pub fn new_regex(source string, options int) ?Regex {
	err := ''
	studyerr := ''
	erroffset := 0
	captures := 0
	re := C.pcre_compile(source.str, options, &err, &erroffset, 0)
	if isnil(re) {
		return error('Failed to compile regex')
	}
	extra := C.pcre_study(re, 0, &studyerr)
	if studyerr.len != 0 {
		return error('Failed to study regex	')
	}
	C.pcre_fullinfo(re, 0, C.PCRE_INFO_CAPTURECOUNT, &captures)
	return Regex{re, extra, captures}
}
