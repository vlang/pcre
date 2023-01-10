#include "config.h"
#include "pcre_internal.h"

PCRE_EXP_DEFN void PCRE_CALL_CONVENTION pcre_free_stub(void *re) {
  (PUBL(free))(re);
}
