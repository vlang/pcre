module pcre

@[heap]
struct Regex {
pub:
	re       &C.pcre       // A pointer to pcre structure
	extra    &C.pcre_extra // A pointer to pcre_extra structure
	captures int           // The number of capture groups
	options  int           // Regex options
}

pub fn (r &Regex) free() {
	if !isnil(r.re) {
		// C.pcre_free is a function pointer, call a stub that calls it.
		C.pcre_free_stub(r.re)
	}
	if !isnil(r.extra) {
		C.pcre_free_study(r.extra)
	}
}

// match_str returns a MatchData structure containing matched strings and:
// str: the string to test
// pos: the position of the beginning of the string (default: 0)
// options: the options as mentioned in the PCRE documentation
pub fn (r &Regex) match_str(str string, pos int, options int) !MatchData {
	if pos < 0 || pos >= str.len {
		return error('Invalid position')
	}
	ovector_size := (r.captures + 1) * 3
	ovector := []int{len: ovector_size}
	ret := C.pcre_exec(r.re, r.extra, &char(str.str), str.len, pos, options, ovector.data,
		ovector_size)
	if ret <= 0 {
		return error('No match!')
	}
	return MatchData{
		re:         r.re
		regex:      r
		str:        str
		ovector:    ovector
		pos:        pos
		group_size: r.captures + 1
	}
}



// like match_str, match_str_many returns an array of MatchData structure containing all matched strings
// useful for regex with multiple capture groups
pub fn (r &Regex) match_str_many(str string, pos int, options int) ![]MatchData {
	if pos < 0 || pos >= str.len {
		return error('Invalid position')
	}
	ovector_size := (r.captures + 1) * 3
	ovector := []int{len: ovector_size}
	mut ret := C.pcre_exec(r.re, r.extra, &char(str.str), str.len, pos, options, ovector.data,
		ovector_size)
	if ret <= 0 {
		return error('No match!')
	}
	mut match_datas := []MatchData{}
	for {
		mut new_pos := ovector[1]
		if ret <= 0 {
			break
		}
		match_data := MatchData{
			re:         r.re
			regex:      r
			str:        str
			ovector:    ovector.clone()
			pos:        new_pos
			group_size: r.captures + 1
		}
		match_datas << match_data
		ret = C.pcre_exec(r.re, r.extra, &char(str.str), str.len, new_pos, options, ovector.data,
			ovector_size)
	}
	return match_datas
}


// new_regex create a new regex
// * source: the string representing the regex
// * options: the options as mentioned in the PCRE documentation
pub fn new_regex(source string, options int) !Regex {
	mut perrbuf := &char(0)
	mut pstudyerr := &char(0)
	erroffset := 0
	captures := 0
	re := C.pcre_compile(&char(source.str), options, voidptr(&perrbuf), &erroffset, 0)
	if isnil(re) {
		err := unsafe { cstring_to_vstring(perrbuf) }
		return error('Failed to compile regex: ${err}')
	}
	extra := C.pcre_study(re, 0, voidptr(&pstudyerr))
	if extra == 0 {
		if pstudyerr == 0 {
			return error('no additional information')
		}
		err := unsafe { cstring_to_vstring(pstudyerr) }
		return error('Failed to study regex: ${err}')
	}
	C.pcre_fullinfo(re, 0, C.PCRE_INFO_CAPTURECOUNT, &captures)
	return Regex{re, extra, captures, options}
}
