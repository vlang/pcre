module pcre

fn test_match_after() {
	r := new_regex('Match everything after this: (.+)', 0) or { panic('An error occured!') }

	m := r.match_str('Match everything after this: "I <3 VLang!"', 0, 0) or { panic('No match!') }

	// m.get(0) -> Match everything after this: "I <3 VLang!"
	// m.get(1) -> "I <3 VLang!"
	// m.get(2) -> Error!
	whole_match := m.get(0) or { panic('We matched nothing...') }

	matched_str := m.get(1) or { panic('We matched nothing...') }

	assert whole_match == 'Match everything after this: "I <3 VLang!"'
	assert matched_str == '"I <3 VLang!"'

	r.free()
}

fn test_match_all() {
	body := 'abcdef'
	pattern := r'(.)'

	mut re := new_regex(pattern, 0) or {
		println('An error occured')
		return
	}

	matches := re.match_str(body, 0, 0) or { return }

	mut out := ''
	for m in matches {
		assert m.get_all().len == 1
		out += m.get(0) or { 'error' }
	}

	assert out.str() == body.str()
}
