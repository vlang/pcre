module pcre

struct MatchData {
pub:
	re         &C.pcre // A pointer to pcre structure
	ovector    []int
	str        string
	pos        int
	group_size int
}

// valid_group checks if group index is valid
pub fn (m MatchData) valid_group(index int) bool {
	return -m.group_size <= index && index < m.group_size
}

// get returns a matched group based on index
// * (.+) hello (.+) -> 'This is a simple hello world'
// * get(0) -> This is a simple hello world
// * get(1) -> This is a simple
// * get(2) -> world
// * get(3) -> Error!
pub fn (m MatchData) get(index_ int) ?string {
	mut index := index_
	if !m.valid_group(index) {
		return error('Index out of bounds')
	}
	if index < 0 {
		index += m.group_size
	}
	start := m.ovector[index * 2]
	end := m.ovector[index * 2 + 1]
	if start < 0 || end > m.str.len {
		return error('Match group is invalid')
	}
	substr := m.str.substr(start, end)
	return substr
}

// get_all returns all matched groups
pub fn (m MatchData) get_all() []string {
	mut res := []string{}
	for i := 1; true; i++ {
		substr := m.get(i) or { break }
		res << substr
	}
	return res
}
