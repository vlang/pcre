module pcre

// TODO: windows support

#flag linux  -lpcre
#flag darwin -lpcre

#flag darwin -I /opt/homebrew/include/

#include <pcre.h>

struct C.pcre {}

struct C.pcre_extra {}

fn C.pcre_compile(byteptr, int, &byteptr, &int, voidptr) &C.pcre
fn C.pcre_compile2(byteptr, int, &int, &byteptr, &int, byteptr) &C.pcre
fn C.pcre_copy_named_substring(&C.pcre, byteptr, &int, int, byteptr, byteptr, int) int
fn C.pcre_copy_substring(byteptr, &int, int, int, byteptr, int) int
fn C.pcre_dfa_exec(&C.pcre, &C.pcre_extra, byteptr, int, int, int, &int, int, &int, int) int
fn C.pcre_study(&C.pcre, int, &byteptr) &C.pcre_extra
fn C.pcre_exec(&C.pcre, &C.pcre_extra, byteptr, int, int, int, &int, int) int
fn C.pcre_fullinfo(&C.pcre, &C.pcre_extra, int, voidptr) int
fn C.pcre_get_stringnumber(&C.pcre, byteptr) int
fn C.pcre_get_stringtable_entries(&C.pcre, byteptr, &byteptr, &byteptr) int
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
