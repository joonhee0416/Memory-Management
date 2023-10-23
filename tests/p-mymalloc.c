#include "lib.h"
#include "malloc.h"


void process_main(void) {
    pid_t p = getpid();
    srand(p);

    void * ptr = malloc(10);
    assert(ptr != NULL);
    assert((uintptr_t)ptr % 8 == 0);

    void * ptr2 = malloc(9);
    assert(ptr != NULL);
    assert((uintptr_t)ptr % 8 == 0);

    TEST_PASS();
}
