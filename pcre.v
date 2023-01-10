module pcre

// TODO: windows support
#flag -I@VMODROOT

#flag linux  -lpcre
#flag darwin -lpcre

#include <./pcre.h>

[typedef]
struct C.pcre {}

[typedef]
struct C.pcre_extra {}

fn C.pcre_compile(pattern byteptr, options int, const_perr &&char, perroroffset &int, ptable voidptr) &C.pcre
fn C.pcre_compile2(pattern byteptr, options int, perrorcode &int, const_perr &&char, perroroffset &int, ptable byteptr) &C.pcre
fn C.pcre_copy_named_substring(&C.pcre, byteptr, &int, int, byteptr, byteptr, int) int
fn C.pcre_copy_substring(byteptr, &int, int, int, byteptr, int) int
fn C.pcre_dfa_exec(const_pcode &C.pcre, const_pextra &C.pcre_extra, const_subject &char, length int, startoffset int, options int, povector &int, ovecsize int, workspace &int, wscount int) int
fn C.pcre_study(const_pcode &C.pcre, options int, const_x &&char) &C.pcre_extra
fn C.pcre_exec(const_pcode &C.pcre, const_pextra &C.pcre_extra, subject byteptr, length int, startoffset int, options int, povector &int, ovecsize int) int
fn C.pcre_fullinfo(const_pcode &C.pcre, const_pextra &C.pcre_extra, what int, where voidptr) int
fn C.pcre_get_stringnumber(const_pcode &C.pcre, const_pname &char) int
fn C.pcre_get_stringtable_entries(const_pcode &C.pcre, const_pname &char, pfirst &&char, plast &&char) int
fn C.pcre_get_substring(byteptr, &int, int, int, &byteptr) int
fn C.pcre_get_substring_list(byteptr, &int, int, &&byteptr) int
fn C.pcre_get_named_substring(&C.pctr, byteptr, &int, int, byteptr, &byteptr) int
fn C.pcre_maketables() byteptr
fn C.pcre_refcount(&C.pcre, int) int
fn C.pcre_version() byteptr
fn C.pcre_free_substring_list(&byteptr)
fn C.pcre_free_substring(byteptr)
fn C.pcre_free_study(&C.pcre_extra)
fn C.pcre_free(voidptr)
