#include "malloc.h"

typedef struct elt {
    size_t size;
    size_t alloc_bytes;
    struct elt * prev;
    struct elt * next;
} elt;

#define HEADER (sizeof(elt))
void remove_list (elt * node, int free);

elt * free_head = NULL;
elt * free_tail = NULL;
elt * alloc_head = NULL;
elt * alloc_tail = NULL;
int free_list_size = 0;
int alloc_list_size = 0;

void append_list (elt * node, size_t size, int free) {
    node->size = size;
    node->next = NULL;
    if(free) {
        if(free_head == NULL) {
            free_head = node;
            free_tail = node;
            node->prev = NULL;
        } else {
            free_tail->next = node;
            node->prev = free_tail;
            free_tail = node;
        }
        free_list_size++;
    } else {
        if(alloc_head == NULL) {
            alloc_head = node;
            alloc_tail = node;
            node->prev = NULL;
        } else {
            alloc_tail->next = node;
            node->prev = alloc_tail;
            alloc_tail = node;
        }
        alloc_list_size++;
    }
}

void append_list_ordered (elt * node, size_t size, size_t alloc_bytes, int free) {
    node->size = size;
    if(free) {
        uintptr_t node_addr = (uintptr_t) node;
        free_list_size++;
        if(free_head == NULL) { // list is empty
            free_head = node;
            free_tail = node;
            node->prev = NULL;
            node->next = NULL;
            return;
        } else if (node_addr < (uintptr_t) free_head) { // insert at list head
            node->prev = NULL;
            node->next = free_head;
            free_head->prev = node;
            free_head = node;
            return;
        } else { // insert in ascending order of address
            elt * p1 = free_head;
            elt * p2 = p1->next;
            while(p2 != NULL) {
                if((node_addr >= ((uintptr_t) p1)) && (node_addr < ((uintptr_t) p2))) {
                    node->prev = p1;
                    node->next = p2;
                    p1->next = node;
                    p2->prev = node;
                    return;
                }
                p1 = p2;
                p2 = p2->next;
            }
            // last elt in list
            p1->next = node;
            node->prev = p1;
            node->next = NULL;
            free_tail = node;
            return;
        }
    } else {
        alloc_list_size++;
        node->alloc_bytes = alloc_bytes;
        if(alloc_head == NULL) {
            alloc_head = node;
            alloc_tail = node;
            node->prev = NULL;
            node->next = NULL;
            return;
        } else if(alloc_bytes > alloc_head->alloc_bytes) {
            node->prev = NULL;
            node->next = alloc_head;
            alloc_head->prev = node;
            alloc_head = node;
            return;
        } else {
            elt * a1 = alloc_head;
            elt * a2 = a1->next;
            while(a2 != NULL) {
                if(alloc_bytes <= a1->alloc_bytes && alloc_bytes > a2->alloc_bytes) {
                    node->prev = a1;
                    node->next = a2;
                    a1->next = node;
                    a2->prev = node;
                    return;
                }
                a1 = a2;
                a2 = a2->next;
            }
            a1->next = node;
            node->prev = a1;
            node->next = NULL;
            alloc_tail = node;
            return;
        }
        return;
    }
}

void remove_list (elt * node, int free) {
    elt * prev = node->prev;
    elt * next = node->next;
    if(free) {
        if(node == free_head) {
            free_head = node->next;
        }
        if(node == free_tail) {
            free_tail = prev;
        }
        if(prev) {
            prev->next = next;
        }
        if(next) {
            next->prev = prev;
        }
        free_list_size--;
        return;
    } else {
        if(node == alloc_head) {
            alloc_head = node->next;
        }
        if(node == alloc_tail) {
            alloc_tail = prev;
        }
        if(prev) {
            prev->next = next;
        }
        if(next) {
            next->prev = prev;
        }
        alloc_list_size--;
        return;
    }
}

elt * search_free (size_t size) {
    elt * p = free_head;
    while(p != NULL) {
        // is free node big enough?
        if(p->size >= size) {
            return p;
        }
        p = p->next;
    }
    return NULL;
}

void free(void *firstbyte) {
    if(firstbyte == NULL) {
        return;
    }
    elt* entire_block = (elt *) ((uintptr_t) firstbyte - HEADER);
    remove_list(entire_block, 0);
    append_list_ordered(entire_block, entire_block->size, 0, 1);
    return;
}

void *malloc(uint64_t numbytes) {
    if (numbytes == 0) {
        return NULL;
    }
    // required bytes: sizeof(header) + numbytes, then ROUNDUP(8)
    size_t required_size = ROUNDUP(HEADER + numbytes, 8);
    // search free list, grow heap if needed
    elt * p = search_free(required_size);
    if(p == NULL) { // grow heap, search again
        size_t chunk_size = ROUNDUP(required_size, PAGESIZE * 4);
        void * chunk_ret = sbrk(chunk_size);
        if(chunk_ret == (void *) -1) {
            return NULL;
        }
        elt * chunk = (elt *) chunk_ret;
        append_list_ordered(chunk, chunk_size, 0, 1);
        p = search_free(required_size);
    }
    size_t initial_free_block_size = p->size; // size of free block
    uintptr_t alloc_start = (uintptr_t) p; // start of to-be-allocated block
    remove_list(p, 1); // remove the free block from free list, since we are allocating it
    if(initial_free_block_size - required_size >= HEADER) { // free block split into alloc and free
        elt * free_part = (elt *) (alloc_start + required_size);
        append_list_ordered(free_part, initial_free_block_size - required_size, 0, 1);
        append_list_ordered(p, required_size, numbytes, 0);
    } else { // add to alloc list w/ initial size, since we didn't split
        append_list_ordered(p, initial_free_block_size, numbytes, 0);
    }
    // return address of payload
    void * payload = (void *) (alloc_start + HEADER);
    return payload;
}


void * calloc(uint64_t num, uint64_t sz) {
    if(num == 0 || sz == 0) {
        return NULL;
    }
    if(sz > ((uint64_t) -1) / num) {
        return NULL;
    }
    void * malloc_ret = malloc(num*sz);
    if(malloc_ret == NULL) {
        return NULL;
    }
    memset(malloc_ret, 0, num*sz);
    return malloc_ret;
}

void * realloc(void * ptr, uint64_t sz) {
    if(ptr == NULL) {
        return malloc(sz);
    }
    if(sz == 0) {
        free(ptr);
        return NULL;
    }
    void * new_payload = malloc(sz);
    if(new_payload == NULL) {
        return NULL;
    }
    elt * original_header = (elt *) ((uintptr_t) ptr - HEADER);
    size_t newsize;
    if(original_header->size < sz) {
        newsize = original_header->size;
    } else {
        newsize = sz;
    }
    memcpy(new_payload, ptr, newsize);
    free(ptr);
    return new_payload;
}

void defrag() {
    // change append function to insert free blocks by ascending order of address
    if(free_head == NULL) {
        return;
    }
    elt * p1 = free_head;
    elt * p2 = p1->next;
    while(p2 != NULL) {
        uintptr_t p1_addr = (uintptr_t) p1;
        uintptr_t p2_addr = (uintptr_t) p2;
        if(p2_addr - p1_addr == p1->size) { // coalesce
            p1->size += p2->size;
            remove_list(p2, 1);
            p2 = p1->next;
        } else {
            p1 = p2;
            p2 = p2->next;
        }
    }
    return;
}

int heap_info(heap_info_struct * info) {
    // change append function to insert alloc'd blocks by descending order of size
    info->num_allocs = alloc_list_size;

    elt * f1 = free_head;
    info->free_space = 0;
    info->largest_free_chunk = 0;
    while (f1 != NULL) {
        info->free_space += f1->size;
        if((int) f1->size >= info->largest_free_chunk) {
            info->largest_free_chunk = (int) f1->size;
        }
        f1 = f1->next;
    }

    if(info->num_allocs == 0) {
        info->size_array = NULL;
        info->ptr_array = NULL;
        return 0;
    }

    long * size_array = malloc(info->num_allocs * sizeof(long));
    if(size_array == NULL) {
        return -1;
    }
    uintptr_t size_array_addr = (uintptr_t) size_array - HEADER;

    void ** ptr_array = malloc(info->num_allocs * sizeof(void *));
    if(ptr_array == NULL) {
        return -1;
    }
    uintptr_t ptr_array_addr = (uintptr_t) ptr_array - HEADER;

    elt * x1 = alloc_head;
    int i = 0;
    while (x1 != NULL) {
        if(((uintptr_t) x1 != size_array_addr) && ((uintptr_t) x1 != ptr_array_addr)) {
            size_array[i] = (long) x1->alloc_bytes;
            ptr_array[i] = (void *) ((uintptr_t) x1 + HEADER);
            i++;
        }
        x1 = x1->next;
    }
    info->size_array = size_array;
    info->ptr_array = ptr_array;
    return 0;
}
