
obj/p-malloc.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	53                   	push   %rbx
  100005:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100009:	cd 31                	int    $0x31
  10000b:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10000d:	b8 47 30 10 00       	mov    $0x103047,%eax
  100012:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100018:	48 89 05 e9 1f 00 00 	mov    %rax,0x1fe9(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10001f:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100022:	48 83 e8 01          	sub    $0x1,%rax
  100026:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10002c:	48 89 05 cd 1f 00 00 	mov    %rax,0x1fcd(%rip)        # 102000 <stack_bottom>
  100033:	eb 02                	jmp    100037 <process_main+0x37>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  100035:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  100037:	e8 b5 08 00 00       	call   1008f1 <rand>
  10003c:	48 63 d0             	movslq %eax,%rdx
  10003f:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100046:	48 c1 fa 25          	sar    $0x25,%rdx
  10004a:	89 c1                	mov    %eax,%ecx
  10004c:	c1 f9 1f             	sar    $0x1f,%ecx
  10004f:	29 ca                	sub    %ecx,%edx
  100051:	6b d2 64             	imul   $0x64,%edx,%edx
  100054:	29 d0                	sub    %edx,%eax
  100056:	39 d8                	cmp    %ebx,%eax
  100058:	7d db                	jge    100035 <process_main+0x35>
	    void * ret = malloc(PAGESIZE);
  10005a:	bf 00 10 00 00       	mov    $0x1000,%edi
  10005f:	e8 c6 02 00 00       	call   10032a <malloc>
	    if(ret == NULL)
  100064:	48 85 c0             	test   %rax,%rax
  100067:	74 04                	je     10006d <process_main+0x6d>
		break;
	    *((int*)ret) = p;       // check we have write access
  100069:	89 18                	mov    %ebx,(%rax)
  10006b:	eb c8                	jmp    100035 <process_main+0x35>
  10006d:	cd 32                	int    $0x32
  10006f:	eb fc                	jmp    10006d <process_main+0x6d>

0000000000100071 <append_list>:
elt * alloc_tail = NULL;
int free_list_size = 0;
int alloc_list_size = 0;

void append_list (elt * node, size_t size, int free) {
    node->size = size;
  100071:	48 89 37             	mov    %rsi,(%rdi)
    node->next = NULL;
  100074:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  10007b:	00 
    if(free) {
  10007c:	85 d2                	test   %edx,%edx
  10007e:	74 40                	je     1000c0 <append_list+0x4f>
        if(free_head == NULL) {
  100080:	48 83 3d a8 1f 00 00 	cmpq   $0x0,0x1fa8(%rip)        # 102030 <free_head>
  100087:	00 
  100088:	74 1e                	je     1000a8 <append_list+0x37>
            free_head = node;
            free_tail = node;
            node->prev = NULL;
        } else {
            free_tail->next = node;
  10008a:	48 8b 05 97 1f 00 00 	mov    0x1f97(%rip),%rax        # 102028 <free_tail>
  100091:	48 89 78 18          	mov    %rdi,0x18(%rax)
            node->prev = free_tail;
  100095:	48 89 47 10          	mov    %rax,0x10(%rdi)
            free_tail = node;
  100099:	48 89 3d 88 1f 00 00 	mov    %rdi,0x1f88(%rip)        # 102028 <free_tail>
        }
        free_list_size++;
  1000a0:	83 05 6d 1f 00 00 01 	addl   $0x1,0x1f6d(%rip)        # 102014 <free_list_size>
  1000a7:	c3                   	ret    
            free_head = node;
  1000a8:	48 89 3d 81 1f 00 00 	mov    %rdi,0x1f81(%rip)        # 102030 <free_head>
            free_tail = node;
  1000af:	48 89 3d 72 1f 00 00 	mov    %rdi,0x1f72(%rip)        # 102028 <free_tail>
            node->prev = NULL;
  1000b6:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  1000bd:	00 
  1000be:	eb e0                	jmp    1000a0 <append_list+0x2f>
    } else {
        if(alloc_head == NULL) {
  1000c0:	48 83 3d 58 1f 00 00 	cmpq   $0x0,0x1f58(%rip)        # 102020 <alloc_head>
  1000c7:	00 
  1000c8:	74 1e                	je     1000e8 <append_list+0x77>
            alloc_head = node;
            alloc_tail = node;
            node->prev = NULL;
        } else {
            alloc_tail->next = node;
  1000ca:	48 8b 05 47 1f 00 00 	mov    0x1f47(%rip),%rax        # 102018 <alloc_tail>
  1000d1:	48 89 78 18          	mov    %rdi,0x18(%rax)
            node->prev = alloc_tail;
  1000d5:	48 89 47 10          	mov    %rax,0x10(%rdi)
            alloc_tail = node;
  1000d9:	48 89 3d 38 1f 00 00 	mov    %rdi,0x1f38(%rip)        # 102018 <alloc_tail>
        }
        alloc_list_size++;
  1000e0:	83 05 29 1f 00 00 01 	addl   $0x1,0x1f29(%rip)        # 102010 <alloc_list_size>
    }
}
  1000e7:	c3                   	ret    
            alloc_head = node;
  1000e8:	48 89 3d 31 1f 00 00 	mov    %rdi,0x1f31(%rip)        # 102020 <alloc_head>
            alloc_tail = node;
  1000ef:	48 89 3d 22 1f 00 00 	mov    %rdi,0x1f22(%rip)        # 102018 <alloc_tail>
            node->prev = NULL;
  1000f6:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  1000fd:	00 
  1000fe:	eb e0                	jmp    1000e0 <append_list+0x6f>

0000000000100100 <append_list_ordered>:

void append_list_ordered (elt * node, size_t size, size_t alloc_bytes, int free) {
    node->size = size;
  100100:	48 89 37             	mov    %rsi,(%rdi)
    if(free) {
  100103:	85 c9                	test   %ecx,%ecx
  100105:	0f 84 9c 00 00 00    	je     1001a7 <append_list_ordered+0xa7>
        uintptr_t node_addr = (uintptr_t) node;
        free_list_size++;
  10010b:	83 05 02 1f 00 00 01 	addl   $0x1,0x1f02(%rip)        # 102014 <free_list_size>
        if(free_head == NULL) { // list is empty
  100112:	48 8b 15 17 1f 00 00 	mov    0x1f17(%rip),%rdx        # 102030 <free_head>
  100119:	48 85 d2             	test   %rdx,%rdx
  10011c:	74 3a                	je     100158 <append_list_ordered+0x58>
            free_head = node;
            free_tail = node;
            node->prev = NULL;
            node->next = NULL;
            return;
        } else if (node_addr < (uintptr_t) free_head) { // insert at list head
  10011e:	48 39 d7             	cmp    %rdx,%rdi
  100121:	72 54                	jb     100177 <append_list_ordered+0x77>
            free_head->prev = node;
            free_head = node;
            return;
        } else { // insert in ascending order of address
            elt * p1 = free_head;
            elt * p2 = p1->next;
  100123:	48 8b 42 18          	mov    0x18(%rdx),%rax
            while(p2 != NULL) {
  100127:	48 85 c0             	test   %rax,%rax
  10012a:	74 63                	je     10018f <append_list_ordered+0x8f>
                if((node_addr >= ((uintptr_t) p1)) && (node_addr < ((uintptr_t) p2))) {
  10012c:	48 39 c7             	cmp    %rax,%rdi
  10012f:	72 16                	jb     100147 <append_list_ordered+0x47>
                    p1->next = node;
                    p2->prev = node;
                    return;
                }
                p1 = p2;
                p2 = p2->next;
  100131:	48 89 c2             	mov    %rax,%rdx
  100134:	48 8b 40 18          	mov    0x18(%rax),%rax
            while(p2 != NULL) {
  100138:	48 85 c0             	test   %rax,%rax
  10013b:	74 52                	je     10018f <append_list_ordered+0x8f>
                if((node_addr >= ((uintptr_t) p1)) && (node_addr < ((uintptr_t) p2))) {
  10013d:	48 39 d7             	cmp    %rdx,%rdi
  100140:	72 ef                	jb     100131 <append_list_ordered+0x31>
  100142:	48 39 c7             	cmp    %rax,%rdi
  100145:	73 ea                	jae    100131 <append_list_ordered+0x31>
                    node->prev = p1;
  100147:	48 89 57 10          	mov    %rdx,0x10(%rdi)
                    node->next = p2;
  10014b:	48 89 47 18          	mov    %rax,0x18(%rdi)
                    p1->next = node;
  10014f:	48 89 7a 18          	mov    %rdi,0x18(%rdx)
                    p2->prev = node;
  100153:	48 89 78 10          	mov    %rdi,0x10(%rax)
                    return;
  100157:	c3                   	ret    
            free_head = node;
  100158:	48 89 3d d1 1e 00 00 	mov    %rdi,0x1ed1(%rip)        # 102030 <free_head>
            free_tail = node;
  10015f:	48 89 3d c2 1e 00 00 	mov    %rdi,0x1ec2(%rip)        # 102028 <free_tail>
            node->prev = NULL;
  100166:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  10016d:	00 
            node->next = NULL;
  10016e:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  100175:	00 
            return;
  100176:	c3                   	ret    
            node->prev = NULL;
  100177:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  10017e:	00 
            node->next = free_head;
  10017f:	48 89 57 18          	mov    %rdx,0x18(%rdi)
            free_head->prev = node;
  100183:	48 89 7a 10          	mov    %rdi,0x10(%rdx)
            free_head = node;
  100187:	48 89 3d a2 1e 00 00 	mov    %rdi,0x1ea2(%rip)        # 102030 <free_head>
            return;
  10018e:	c3                   	ret    
            }
            // last elt in list
            p1->next = node;
  10018f:	48 89 7a 18          	mov    %rdi,0x18(%rdx)
            node->prev = p1;
  100193:	48 89 57 10          	mov    %rdx,0x10(%rdi)
            node->next = NULL;
  100197:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  10019e:	00 
            free_tail = node;
  10019f:	48 89 3d 82 1e 00 00 	mov    %rdi,0x1e82(%rip)        # 102028 <free_tail>
            return;
  1001a6:	c3                   	ret    
        }
    } else {
        alloc_list_size++;
  1001a7:	83 05 62 1e 00 00 01 	addl   $0x1,0x1e62(%rip)        # 102010 <alloc_list_size>
        node->alloc_bytes = alloc_bytes;
  1001ae:	48 89 57 08          	mov    %rdx,0x8(%rdi)
        if(alloc_head == NULL) {
  1001b2:	48 8b 35 67 1e 00 00 	mov    0x1e67(%rip),%rsi        # 102020 <alloc_head>
  1001b9:	48 85 f6             	test   %rsi,%rsi
  1001bc:	74 2a                	je     1001e8 <append_list_ordered+0xe8>
            alloc_head = node;
            alloc_tail = node;
            node->prev = NULL;
            node->next = NULL;
            return;
        } else if(alloc_bytes > alloc_head->alloc_bytes) {
  1001be:	48 39 56 08          	cmp    %rdx,0x8(%rsi)
  1001c2:	72 43                	jb     100207 <append_list_ordered+0x107>
            alloc_head->prev = node;
            alloc_head = node;
            return;
        } else {
            elt * a1 = alloc_head;
            elt * a2 = a1->next;
  1001c4:	48 8b 46 18          	mov    0x18(%rsi),%rax
            while(a2 != NULL) {
  1001c8:	48 85 c0             	test   %rax,%rax
  1001cb:	75 61                	jne    10022e <append_list_ordered+0x12e>
            elt * a1 = alloc_head;
  1001cd:	48 89 f0             	mov    %rsi,%rax
                    return;
                }
                a1 = a2;
                a2 = a2->next;
            }
            a1->next = node;
  1001d0:	48 89 78 18          	mov    %rdi,0x18(%rax)
            node->prev = a1;
  1001d4:	48 89 47 10          	mov    %rax,0x10(%rdi)
            node->next = NULL;
  1001d8:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  1001df:	00 
            alloc_tail = node;
  1001e0:	48 89 3d 31 1e 00 00 	mov    %rdi,0x1e31(%rip)        # 102018 <alloc_tail>
            return;
        }
        return;
    }
}
  1001e7:	c3                   	ret    
            alloc_head = node;
  1001e8:	48 89 3d 31 1e 00 00 	mov    %rdi,0x1e31(%rip)        # 102020 <alloc_head>
            alloc_tail = node;
  1001ef:	48 89 3d 22 1e 00 00 	mov    %rdi,0x1e22(%rip)        # 102018 <alloc_tail>
            node->prev = NULL;
  1001f6:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  1001fd:	00 
            node->next = NULL;
  1001fe:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  100205:	00 
            return;
  100206:	c3                   	ret    
            node->prev = NULL;
  100207:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  10020e:	00 
            node->next = alloc_head;
  10020f:	48 89 77 18          	mov    %rsi,0x18(%rdi)
            alloc_head->prev = node;
  100213:	48 89 7e 10          	mov    %rdi,0x10(%rsi)
            alloc_head = node;
  100217:	48 89 3d 02 1e 00 00 	mov    %rdi,0x1e02(%rip)        # 102020 <alloc_head>
            return;
  10021e:	c3                   	ret    
                a2 = a2->next;
  10021f:	48 8b 48 18          	mov    0x18(%rax),%rcx
            while(a2 != NULL) {
  100223:	48 89 c6             	mov    %rax,%rsi
  100226:	48 85 c9             	test   %rcx,%rcx
  100229:	74 a5                	je     1001d0 <append_list_ordered+0xd0>
                a2 = a2->next;
  10022b:	48 89 c8             	mov    %rcx,%rax
                if(alloc_bytes <= a1->alloc_bytes && alloc_bytes > a2->alloc_bytes) {
  10022e:	48 39 56 08          	cmp    %rdx,0x8(%rsi)
  100232:	72 eb                	jb     10021f <append_list_ordered+0x11f>
  100234:	48 39 50 08          	cmp    %rdx,0x8(%rax)
  100238:	73 e5                	jae    10021f <append_list_ordered+0x11f>
                    node->prev = a1;
  10023a:	48 89 77 10          	mov    %rsi,0x10(%rdi)
                    node->next = a2;
  10023e:	48 89 47 18          	mov    %rax,0x18(%rdi)
                    a1->next = node;
  100242:	48 89 7e 18          	mov    %rdi,0x18(%rsi)
                    a2->prev = node;
  100246:	48 89 78 10          	mov    %rdi,0x10(%rax)
                    return;
  10024a:	c3                   	ret    

000000000010024b <remove_list>:

void remove_list (elt * node, int free) {
    elt * prev = node->prev;
  10024b:	48 8b 57 10          	mov    0x10(%rdi),%rdx
    elt * next = node->next;
  10024f:	48 8b 47 18          	mov    0x18(%rdi),%rax
    if(free) {
  100253:	85 f6                	test   %esi,%esi
  100255:	74 3e                	je     100295 <remove_list+0x4a>
        if(node == free_head) {
  100257:	48 39 3d d2 1d 00 00 	cmp    %rdi,0x1dd2(%rip)        # 102030 <free_head>
  10025e:	74 23                	je     100283 <remove_list+0x38>
            free_head = node->next;
        }
        if(node == free_tail) {
  100260:	48 39 3d c1 1d 00 00 	cmp    %rdi,0x1dc1(%rip)        # 102028 <free_tail>
  100267:	74 23                	je     10028c <remove_list+0x41>
            free_tail = prev;
        }
        if(prev) {
  100269:	48 85 d2             	test   %rdx,%rdx
  10026c:	74 04                	je     100272 <remove_list+0x27>
            prev->next = next;
  10026e:	48 89 42 18          	mov    %rax,0x18(%rdx)
        }
        if(next) {
  100272:	48 85 c0             	test   %rax,%rax
  100275:	74 04                	je     10027b <remove_list+0x30>
            next->prev = prev;
  100277:	48 89 50 10          	mov    %rdx,0x10(%rax)
        }
        free_list_size--;
  10027b:	83 2d 92 1d 00 00 01 	subl   $0x1,0x1d92(%rip)        # 102014 <free_list_size>
        return;
  100282:	c3                   	ret    
            free_head = node->next;
  100283:	48 89 05 a6 1d 00 00 	mov    %rax,0x1da6(%rip)        # 102030 <free_head>
  10028a:	eb d4                	jmp    100260 <remove_list+0x15>
            free_tail = prev;
  10028c:	48 89 15 95 1d 00 00 	mov    %rdx,0x1d95(%rip)        # 102028 <free_tail>
  100293:	eb d4                	jmp    100269 <remove_list+0x1e>
    } else {
        if(node == alloc_head) {
  100295:	48 39 3d 84 1d 00 00 	cmp    %rdi,0x1d84(%rip)        # 102020 <alloc_head>
  10029c:	74 23                	je     1002c1 <remove_list+0x76>
            alloc_head = node->next;
        }
        if(node == alloc_tail) {
  10029e:	48 39 3d 73 1d 00 00 	cmp    %rdi,0x1d73(%rip)        # 102018 <alloc_tail>
  1002a5:	74 23                	je     1002ca <remove_list+0x7f>
            alloc_tail = prev;
        }
        if(prev) {
  1002a7:	48 85 d2             	test   %rdx,%rdx
  1002aa:	74 04                	je     1002b0 <remove_list+0x65>
            prev->next = next;
  1002ac:	48 89 42 18          	mov    %rax,0x18(%rdx)
        }
        if(next) {
  1002b0:	48 85 c0             	test   %rax,%rax
  1002b3:	74 04                	je     1002b9 <remove_list+0x6e>
            next->prev = prev;
  1002b5:	48 89 50 10          	mov    %rdx,0x10(%rax)
        }
        alloc_list_size--;
  1002b9:	83 2d 50 1d 00 00 01 	subl   $0x1,0x1d50(%rip)        # 102010 <alloc_list_size>
        return;
    }
}
  1002c0:	c3                   	ret    
            alloc_head = node->next;
  1002c1:	48 89 05 58 1d 00 00 	mov    %rax,0x1d58(%rip)        # 102020 <alloc_head>
  1002c8:	eb d4                	jmp    10029e <remove_list+0x53>
            alloc_tail = prev;
  1002ca:	48 89 15 47 1d 00 00 	mov    %rdx,0x1d47(%rip)        # 102018 <alloc_tail>
  1002d1:	eb d4                	jmp    1002a7 <remove_list+0x5c>

00000000001002d3 <search_free>:

elt * search_free (size_t size) {
    elt * p = free_head;
  1002d3:	48 8b 05 56 1d 00 00 	mov    0x1d56(%rip),%rax        # 102030 <free_head>
    while(p != NULL) {
  1002da:	48 85 c0             	test   %rax,%rax
  1002dd:	74 0e                	je     1002ed <search_free+0x1a>
        // is free node big enough?
        if(p->size >= size) {
  1002df:	48 39 38             	cmp    %rdi,(%rax)
  1002e2:	73 09                	jae    1002ed <search_free+0x1a>
            return p;
        }
        p = p->next;
  1002e4:	48 8b 40 18          	mov    0x18(%rax),%rax
    while(p != NULL) {
  1002e8:	48 85 c0             	test   %rax,%rax
  1002eb:	75 f2                	jne    1002df <search_free+0xc>
    }
    return NULL;
}
  1002ed:	c3                   	ret    

00000000001002ee <free>:

void free(void *firstbyte) {
    if(firstbyte == NULL) {
  1002ee:	48 85 ff             	test   %rdi,%rdi
  1002f1:	74 36                	je     100329 <free+0x3b>
void free(void *firstbyte) {
  1002f3:	55                   	push   %rbp
  1002f4:	48 89 e5             	mov    %rsp,%rbp
  1002f7:	41 54                	push   %r12
  1002f9:	53                   	push   %rbx
  1002fa:	48 89 fb             	mov    %rdi,%rbx
        return;
    }
    elt* entire_block = (elt *) ((uintptr_t) firstbyte - HEADER);
  1002fd:	4c 8d 67 e0          	lea    -0x20(%rdi),%r12
    remove_list(entire_block, 0);
  100301:	be 00 00 00 00       	mov    $0x0,%esi
  100306:	4c 89 e7             	mov    %r12,%rdi
  100309:	e8 3d ff ff ff       	call   10024b <remove_list>
    append_list_ordered(entire_block, entire_block->size, 0, 1);
  10030e:	48 8b 73 e0          	mov    -0x20(%rbx),%rsi
  100312:	b9 01 00 00 00       	mov    $0x1,%ecx
  100317:	ba 00 00 00 00       	mov    $0x0,%edx
  10031c:	4c 89 e7             	mov    %r12,%rdi
  10031f:	e8 dc fd ff ff       	call   100100 <append_list_ordered>
    return;
}
  100324:	5b                   	pop    %rbx
  100325:	41 5c                	pop    %r12
  100327:	5d                   	pop    %rbp
  100328:	c3                   	ret    
  100329:	c3                   	ret    

000000000010032a <malloc>:

void *malloc(uint64_t numbytes) {
  10032a:	55                   	push   %rbp
  10032b:	48 89 e5             	mov    %rsp,%rbp
  10032e:	41 57                	push   %r15
  100330:	41 56                	push   %r14
  100332:	41 55                	push   %r13
  100334:	41 54                	push   %r12
  100336:	53                   	push   %rbx
  100337:	48 83 ec 08          	sub    $0x8,%rsp
    if (numbytes == 0) {
        return NULL;
  10033b:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (numbytes == 0) {
  100340:	48 85 ff             	test   %rdi,%rdi
  100343:	74 64                	je     1003a9 <malloc+0x7f>
  100345:	49 89 fc             	mov    %rdi,%r12
    }
    // required bytes: sizeof(header) + numbytes, then ROUNDUP(8)
    size_t required_size = ROUNDUP(HEADER + numbytes, 8);
  100348:	4c 8d 6f 27          	lea    0x27(%rdi),%r13
  10034c:	49 83 e5 f8          	and    $0xfffffffffffffff8,%r13
    // search free list, grow heap if needed
    elt * p = search_free(required_size);
  100350:	4c 89 ef             	mov    %r13,%rdi
  100353:	e8 7b ff ff ff       	call   1002d3 <search_free>
  100358:	48 89 c3             	mov    %rax,%rbx
    if(p == NULL) { // grow heap, search again
  10035b:	48 85 c0             	test   %rax,%rax
  10035e:	74 5b                	je     1003bb <malloc+0x91>
        }
        elt * chunk = (elt *) chunk_ret;
        append_list_ordered(chunk, chunk_size, 0, 1);
        p = search_free(required_size);
    }
    size_t initial_free_block_size = p->size; // size of free block
  100360:	4c 8b 33             	mov    (%rbx),%r14
    uintptr_t alloc_start = (uintptr_t) p; // start of to-be-allocated block
  100363:	49 89 df             	mov    %rbx,%r15
    remove_list(p, 1); // remove the free block from free list, since we are allocating it
  100366:	be 01 00 00 00       	mov    $0x1,%esi
  10036b:	48 89 df             	mov    %rbx,%rdi
  10036e:	e8 d8 fe ff ff       	call   10024b <remove_list>
    if(initial_free_block_size - required_size >= HEADER) { // free block split into alloc and free
  100373:	4c 89 f6             	mov    %r14,%rsi
  100376:	4c 29 ee             	sub    %r13,%rsi
  100379:	48 83 fe 1f          	cmp    $0x1f,%rsi
  10037d:	76 7e                	jbe    1003fd <malloc+0xd3>
        elt * free_part = (elt *) (alloc_start + required_size);
  10037f:	4a 8d 3c 2b          	lea    (%rbx,%r13,1),%rdi
        append_list_ordered(free_part, initial_free_block_size - required_size, 0, 1);
  100383:	b9 01 00 00 00       	mov    $0x1,%ecx
  100388:	ba 00 00 00 00       	mov    $0x0,%edx
  10038d:	e8 6e fd ff ff       	call   100100 <append_list_ordered>
        append_list_ordered(p, required_size, numbytes, 0);
  100392:	b9 00 00 00 00       	mov    $0x0,%ecx
  100397:	4c 89 e2             	mov    %r12,%rdx
  10039a:	4c 89 ee             	mov    %r13,%rsi
  10039d:	48 89 df             	mov    %rbx,%rdi
  1003a0:	e8 5b fd ff ff       	call   100100 <append_list_ordered>
    } else { // add to alloc list w/ initial size, since we didn't split
        append_list_ordered(p, initial_free_block_size, numbytes, 0);
    }
    // return address of payload
    void * payload = (void *) (alloc_start + HEADER);
  1003a5:	49 8d 5f 20          	lea    0x20(%r15),%rbx
    return payload;
}
  1003a9:	48 89 d8             	mov    %rbx,%rax
  1003ac:	48 83 c4 08          	add    $0x8,%rsp
  1003b0:	5b                   	pop    %rbx
  1003b1:	41 5c                	pop    %r12
  1003b3:	41 5d                	pop    %r13
  1003b5:	41 5e                	pop    %r14
  1003b7:	41 5f                	pop    %r15
  1003b9:	5d                   	pop    %rbp
  1003ba:	c3                   	ret    
        size_t chunk_size = ROUNDUP(required_size, PAGESIZE * 4);
  1003bb:	49 8d b5 ff 3f 00 00 	lea    0x3fff(%r13),%rsi
  1003c2:	48 81 e6 00 c0 ff ff 	and    $0xffffffffffffc000,%rsi
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  1003c9:	48 89 f7             	mov    %rsi,%rdi
  1003cc:	cd 3a                	int    $0x3a
  1003ce:	48 89 c7             	mov    %rax,%rdi
  1003d1:	48 89 05 60 1c 00 00 	mov    %rax,0x1c60(%rip)        # 102038 <result.0>
        if(chunk_ret == (void *) -1) {
  1003d8:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1003dc:	74 cb                	je     1003a9 <malloc+0x7f>
        append_list_ordered(chunk, chunk_size, 0, 1);
  1003de:	b9 01 00 00 00       	mov    $0x1,%ecx
  1003e3:	ba 00 00 00 00       	mov    $0x0,%edx
  1003e8:	e8 13 fd ff ff       	call   100100 <append_list_ordered>
        p = search_free(required_size);
  1003ed:	4c 89 ef             	mov    %r13,%rdi
  1003f0:	e8 de fe ff ff       	call   1002d3 <search_free>
  1003f5:	48 89 c3             	mov    %rax,%rbx
  1003f8:	e9 63 ff ff ff       	jmp    100360 <malloc+0x36>
        append_list_ordered(p, initial_free_block_size, numbytes, 0);
  1003fd:	b9 00 00 00 00       	mov    $0x0,%ecx
  100402:	4c 89 e2             	mov    %r12,%rdx
  100405:	4c 89 f6             	mov    %r14,%rsi
  100408:	48 89 df             	mov    %rbx,%rdi
  10040b:	e8 f0 fc ff ff       	call   100100 <append_list_ordered>
  100410:	eb 93                	jmp    1003a5 <malloc+0x7b>

0000000000100412 <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
  100412:	55                   	push   %rbp
  100413:	48 89 e5             	mov    %rsp,%rbp
  100416:	41 54                	push   %r12
  100418:	53                   	push   %rbx
    if(num == 0 || sz == 0) {
  100419:	48 85 ff             	test   %rdi,%rdi
  10041c:	74 3e                	je     10045c <calloc+0x4a>
  10041e:	48 85 f6             	test   %rsi,%rsi
  100421:	74 39                	je     10045c <calloc+0x4a>
        return NULL;
    }
    if(sz > ((uint64_t) -1) / num) {
        return NULL;
  100423:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    if(sz > ((uint64_t) -1) / num) {
  100429:	48 89 f8             	mov    %rdi,%rax
  10042c:	48 f7 e6             	mul    %rsi
  10042f:	70 23                	jo     100454 <calloc+0x42>
    }
    void * malloc_ret = malloc(num*sz);
  100431:	48 89 c3             	mov    %rax,%rbx
  100434:	48 89 c7             	mov    %rax,%rdi
  100437:	e8 ee fe ff ff       	call   10032a <malloc>
  10043c:	49 89 c4             	mov    %rax,%r12
    if(malloc_ret == NULL) {
  10043f:	48 85 c0             	test   %rax,%rax
  100442:	74 10                	je     100454 <calloc+0x42>
        return NULL;
    }
    memset(malloc_ret, 0, num*sz);
  100444:	48 89 da             	mov    %rbx,%rdx
  100447:	be 00 00 00 00       	mov    $0x0,%esi
  10044c:	48 89 c7             	mov    %rax,%rdi
  10044f:	e8 e0 02 00 00       	call   100734 <memset>
    return malloc_ret;
}
  100454:	4c 89 e0             	mov    %r12,%rax
  100457:	5b                   	pop    %rbx
  100458:	41 5c                	pop    %r12
  10045a:	5d                   	pop    %rbp
  10045b:	c3                   	ret    
        return NULL;
  10045c:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100462:	eb f0                	jmp    100454 <calloc+0x42>

0000000000100464 <realloc>:

void * realloc(void * ptr, uint64_t sz) {
  100464:	55                   	push   %rbp
  100465:	48 89 e5             	mov    %rsp,%rbp
  100468:	41 55                	push   %r13
  10046a:	41 54                	push   %r12
  10046c:	53                   	push   %rbx
  10046d:	48 83 ec 08          	sub    $0x8,%rsp
  100471:	48 89 f3             	mov    %rsi,%rbx
    if(ptr == NULL) {
  100474:	48 85 ff             	test   %rdi,%rdi
  100477:	74 48                	je     1004c1 <realloc+0x5d>
  100479:	49 89 fc             	mov    %rdi,%r12
        return malloc(sz);
    }
    if(sz == 0) {
  10047c:	48 85 f6             	test   %rsi,%rsi
  10047f:	74 4d                	je     1004ce <realloc+0x6a>
        free(ptr);
        return NULL;
    }
    void * new_payload = malloc(sz);
  100481:	48 89 f7             	mov    %rsi,%rdi
  100484:	e8 a1 fe ff ff       	call   10032a <malloc>
  100489:	49 89 c5             	mov    %rax,%r13
    if(new_payload == NULL) {
  10048c:	48 85 c0             	test   %rax,%rax
  10048f:	74 22                	je     1004b3 <realloc+0x4f>
    if(original_header->size < sz) {
        newsize = original_header->size;
    } else {
        newsize = sz;
    }
    memcpy(new_payload, ptr, newsize);
  100491:	49 8b 44 24 e0       	mov    -0x20(%r12),%rax
  100496:	48 39 c3             	cmp    %rax,%rbx
  100499:	48 0f 46 c3          	cmovbe %rbx,%rax
  10049d:	48 89 c2             	mov    %rax,%rdx
  1004a0:	4c 89 e6             	mov    %r12,%rsi
  1004a3:	4c 89 ef             	mov    %r13,%rdi
  1004a6:	e8 8b 01 00 00       	call   100636 <memcpy>
    free(ptr);
  1004ab:	4c 89 e7             	mov    %r12,%rdi
  1004ae:	e8 3b fe ff ff       	call   1002ee <free>
    return new_payload;
}
  1004b3:	4c 89 e8             	mov    %r13,%rax
  1004b6:	48 83 c4 08          	add    $0x8,%rsp
  1004ba:	5b                   	pop    %rbx
  1004bb:	41 5c                	pop    %r12
  1004bd:	41 5d                	pop    %r13
  1004bf:	5d                   	pop    %rbp
  1004c0:	c3                   	ret    
        return malloc(sz);
  1004c1:	48 89 f7             	mov    %rsi,%rdi
  1004c4:	e8 61 fe ff ff       	call   10032a <malloc>
  1004c9:	49 89 c5             	mov    %rax,%r13
  1004cc:	eb e5                	jmp    1004b3 <realloc+0x4f>
        free(ptr);
  1004ce:	e8 1b fe ff ff       	call   1002ee <free>
        return NULL;
  1004d3:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  1004d9:	eb d8                	jmp    1004b3 <realloc+0x4f>

00000000001004db <defrag>:

void defrag() {
  1004db:	55                   	push   %rbp
  1004dc:	48 89 e5             	mov    %rsp,%rbp
  1004df:	53                   	push   %rbx
  1004e0:	48 83 ec 08          	sub    $0x8,%rsp
    // change append function to insert free blocks by ascending order of address
    if(free_head == NULL) {
  1004e4:	48 8b 1d 45 1b 00 00 	mov    0x1b45(%rip),%rbx        # 102030 <free_head>
  1004eb:	48 85 db             	test   %rbx,%rbx
  1004ee:	74 09                	je     1004f9 <defrag+0x1e>
        return;
    }
    elt * p1 = free_head;
    elt * p2 = p1->next;
  1004f0:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    while(p2 != NULL) {
  1004f4:	48 85 ff             	test   %rdi,%rdi
  1004f7:	75 1f                	jne    100518 <defrag+0x3d>
            p1 = p2;
            p2 = p2->next;
        }
    }
    return;
}
  1004f9:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1004fd:	c9                   	leave  
  1004fe:	c3                   	ret    
            p1->size += p2->size;
  1004ff:	48 03 07             	add    (%rdi),%rax
  100502:	48 89 03             	mov    %rax,(%rbx)
            remove_list(p2, 1);
  100505:	be 01 00 00 00       	mov    $0x1,%esi
  10050a:	e8 3c fd ff ff       	call   10024b <remove_list>
            p2 = p1->next;
  10050f:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    while(p2 != NULL) {
  100513:	48 85 ff             	test   %rdi,%rdi
  100516:	74 e1                	je     1004f9 <defrag+0x1e>
        if(p2_addr - p1_addr == p1->size) { // coalesce
  100518:	48 8b 03             	mov    (%rbx),%rax
  10051b:	48 89 fa             	mov    %rdi,%rdx
  10051e:	48 29 da             	sub    %rbx,%rdx
  100521:	48 39 c2             	cmp    %rax,%rdx
  100524:	74 d9                	je     1004ff <defrag+0x24>
            p2 = p2->next;
  100526:	48 89 fb             	mov    %rdi,%rbx
  100529:	48 8b 7f 18          	mov    0x18(%rdi),%rdi
  10052d:	eb e4                	jmp    100513 <defrag+0x38>

000000000010052f <heap_info>:

int heap_info(heap_info_struct * info) {
  10052f:	55                   	push   %rbp
  100530:	48 89 e5             	mov    %rsp,%rbp
  100533:	41 55                	push   %r13
  100535:	41 54                	push   %r12
  100537:	53                   	push   %rbx
  100538:	48 83 ec 08          	sub    $0x8,%rsp
  10053c:	48 89 fb             	mov    %rdi,%rbx
    // change append function to insert alloc'd blocks by descending order of size
    info->num_allocs = alloc_list_size;
  10053f:	8b 0d cb 1a 00 00    	mov    0x1acb(%rip),%ecx        # 102010 <alloc_list_size>
  100545:	89 0f                	mov    %ecx,(%rdi)

    elt * f1 = free_head;
  100547:	48 8b 05 e2 1a 00 00 	mov    0x1ae2(%rip),%rax        # 102030 <free_head>
    info->free_space = 0;
  10054e:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
    info->largest_free_chunk = 0;
  100555:	c7 47 1c 00 00 00 00 	movl   $0x0,0x1c(%rdi)
    while (f1 != NULL) {
  10055c:	48 85 c0             	test   %rax,%rax
  10055f:	75 2a                	jne    10058b <heap_info+0x5c>
            info->largest_free_chunk = (int) f1->size;
        }
        f1 = f1->next;
    }

    if(info->num_allocs == 0) {
  100561:	85 c9                	test   %ecx,%ecx
  100563:	75 39                	jne    10059e <heap_info+0x6f>
        info->size_array = NULL;
  100565:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  10056c:	00 
        info->ptr_array = NULL;
  10056d:	48 c7 43 10 00 00 00 	movq   $0x0,0x10(%rbx)
  100574:	00 
        x1 = x1->next;
    }
    info->size_array = size_array;
    info->ptr_array = ptr_array;
    return 0;
}
  100575:	89 c8                	mov    %ecx,%eax
  100577:	48 83 c4 08          	add    $0x8,%rsp
  10057b:	5b                   	pop    %rbx
  10057c:	41 5c                	pop    %r12
  10057e:	41 5d                	pop    %r13
  100580:	5d                   	pop    %rbp
  100581:	c3                   	ret    
        f1 = f1->next;
  100582:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (f1 != NULL) {
  100586:	48 85 c0             	test   %rax,%rax
  100589:	74 d6                	je     100561 <heap_info+0x32>
        info->free_space += f1->size;
  10058b:	48 8b 10             	mov    (%rax),%rdx
  10058e:	01 53 18             	add    %edx,0x18(%rbx)
        if((int) f1->size >= info->largest_free_chunk) {
  100591:	48 8b 10             	mov    (%rax),%rdx
  100594:	3b 53 1c             	cmp    0x1c(%rbx),%edx
  100597:	7c e9                	jl     100582 <heap_info+0x53>
            info->largest_free_chunk = (int) f1->size;
  100599:	89 53 1c             	mov    %edx,0x1c(%rbx)
  10059c:	eb e4                	jmp    100582 <heap_info+0x53>
    long * size_array = malloc(info->num_allocs * sizeof(long));
  10059e:	48 63 c9             	movslq %ecx,%rcx
  1005a1:	48 8d 3c cd 00 00 00 	lea    0x0(,%rcx,8),%rdi
  1005a8:	00 
  1005a9:	e8 7c fd ff ff       	call   10032a <malloc>
  1005ae:	49 89 c4             	mov    %rax,%r12
    if(size_array == NULL) {
  1005b1:	48 85 c0             	test   %rax,%rax
  1005b4:	74 6c                	je     100622 <heap_info+0xf3>
    uintptr_t size_array_addr = (uintptr_t) size_array - HEADER;
  1005b6:	4c 8d 68 e0          	lea    -0x20(%rax),%r13
    void ** ptr_array = malloc(info->num_allocs * sizeof(void *));
  1005ba:	48 63 3b             	movslq (%rbx),%rdi
  1005bd:	48 c1 e7 03          	shl    $0x3,%rdi
  1005c1:	e8 64 fd ff ff       	call   10032a <malloc>
    if(ptr_array == NULL) {
  1005c6:	48 85 c0             	test   %rax,%rax
  1005c9:	74 61                	je     10062c <heap_info+0xfd>
    uintptr_t ptr_array_addr = (uintptr_t) ptr_array - HEADER;
  1005cb:	4c 8d 48 e0          	lea    -0x20(%rax),%r9
    elt * x1 = alloc_head;
  1005cf:	48 8b 15 4a 1a 00 00 	mov    0x1a4a(%rip),%rdx        # 102020 <alloc_head>
    while (x1 != NULL) {
  1005d6:	48 85 d2             	test   %rdx,%rdx
  1005d9:	74 35                	je     100610 <heap_info+0xe1>
    int i = 0;
  1005db:	be 00 00 00 00       	mov    $0x0,%esi
  1005e0:	eb 1f                	jmp    100601 <heap_info+0xd2>
            size_array[i] = (long) x1->alloc_bytes;
  1005e2:	48 63 fe             	movslq %esi,%rdi
  1005e5:	4c 8b 42 08          	mov    0x8(%rdx),%r8
  1005e9:	4d 89 04 fc          	mov    %r8,(%r12,%rdi,8)
            ptr_array[i] = (void *) ((uintptr_t) x1 + HEADER);
  1005ed:	48 83 c1 20          	add    $0x20,%rcx
  1005f1:	48 89 0c f8          	mov    %rcx,(%rax,%rdi,8)
            i++;
  1005f5:	83 c6 01             	add    $0x1,%esi
        x1 = x1->next;
  1005f8:	48 8b 52 18          	mov    0x18(%rdx),%rdx
    while (x1 != NULL) {
  1005fc:	48 85 d2             	test   %rdx,%rdx
  1005ff:	74 0f                	je     100610 <heap_info+0xe1>
        if(((uintptr_t) x1 != size_array_addr) && ((uintptr_t) x1 != ptr_array_addr)) {
  100601:	48 89 d1             	mov    %rdx,%rcx
  100604:	4c 39 ea             	cmp    %r13,%rdx
  100607:	74 ef                	je     1005f8 <heap_info+0xc9>
  100609:	4c 39 ca             	cmp    %r9,%rdx
  10060c:	75 d4                	jne    1005e2 <heap_info+0xb3>
  10060e:	eb e8                	jmp    1005f8 <heap_info+0xc9>
    info->size_array = size_array;
  100610:	4c 89 63 08          	mov    %r12,0x8(%rbx)
    info->ptr_array = ptr_array;
  100614:	48 89 43 10          	mov    %rax,0x10(%rbx)
    return 0;
  100618:	b9 00 00 00 00       	mov    $0x0,%ecx
  10061d:	e9 53 ff ff ff       	jmp    100575 <heap_info+0x46>
        return -1;
  100622:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  100627:	e9 49 ff ff ff       	jmp    100575 <heap_info+0x46>
        return -1;
  10062c:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  100631:	e9 3f ff ff ff       	jmp    100575 <heap_info+0x46>

0000000000100636 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100636:	55                   	push   %rbp
  100637:	48 89 e5             	mov    %rsp,%rbp
  10063a:	48 83 ec 28          	sub    $0x28,%rsp
  10063e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100642:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100646:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10064a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10064e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100652:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100656:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  10065a:	eb 1c                	jmp    100678 <memcpy+0x42>
        *d = *s;
  10065c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100660:	0f b6 10             	movzbl (%rax),%edx
  100663:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100667:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100669:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  10066e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100673:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  100678:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10067d:	75 dd                	jne    10065c <memcpy+0x26>
    }
    return dst;
  10067f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100683:	c9                   	leave  
  100684:	c3                   	ret    

0000000000100685 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100685:	55                   	push   %rbp
  100686:	48 89 e5             	mov    %rsp,%rbp
  100689:	48 83 ec 28          	sub    $0x28,%rsp
  10068d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100691:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100695:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  100699:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10069d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1006a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1006a5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1006a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006ad:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1006b1:	73 6a                	jae    10071d <memmove+0x98>
  1006b3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1006b7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006bb:	48 01 d0             	add    %rdx,%rax
  1006be:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1006c2:	73 59                	jae    10071d <memmove+0x98>
        s += n, d += n;
  1006c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006c8:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1006cc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006d0:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1006d4:	eb 17                	jmp    1006ed <memmove+0x68>
            *--d = *--s;
  1006d6:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1006db:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1006e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1006e4:	0f b6 10             	movzbl (%rax),%edx
  1006e7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1006eb:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1006ed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1006f1:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1006f5:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1006f9:	48 85 c0             	test   %rax,%rax
  1006fc:	75 d8                	jne    1006d6 <memmove+0x51>
    if (s < d && s + n > d) {
  1006fe:	eb 2e                	jmp    10072e <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100700:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100704:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100708:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10070c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100710:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100714:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100718:	0f b6 12             	movzbl (%rdx),%edx
  10071b:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  10071d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100721:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100725:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100729:	48 85 c0             	test   %rax,%rax
  10072c:	75 d2                	jne    100700 <memmove+0x7b>
        }
    }
    return dst;
  10072e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100732:	c9                   	leave  
  100733:	c3                   	ret    

0000000000100734 <memset>:

void* memset(void* v, int c, size_t n) {
  100734:	55                   	push   %rbp
  100735:	48 89 e5             	mov    %rsp,%rbp
  100738:	48 83 ec 28          	sub    $0x28,%rsp
  10073c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100740:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100743:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100747:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  10074b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  10074f:	eb 15                	jmp    100766 <memset+0x32>
        *p = c;
  100751:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100754:	89 c2                	mov    %eax,%edx
  100756:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10075a:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10075c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100761:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100766:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10076b:	75 e4                	jne    100751 <memset+0x1d>
    }
    return v;
  10076d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100771:	c9                   	leave  
  100772:	c3                   	ret    

0000000000100773 <strlen>:

size_t strlen(const char* s) {
  100773:	55                   	push   %rbp
  100774:	48 89 e5             	mov    %rsp,%rbp
  100777:	48 83 ec 18          	sub    $0x18,%rsp
  10077b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  10077f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100786:	00 
  100787:	eb 0a                	jmp    100793 <strlen+0x20>
        ++n;
  100789:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  10078e:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100793:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100797:	0f b6 00             	movzbl (%rax),%eax
  10079a:	84 c0                	test   %al,%al
  10079c:	75 eb                	jne    100789 <strlen+0x16>
    }
    return n;
  10079e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1007a2:	c9                   	leave  
  1007a3:	c3                   	ret    

00000000001007a4 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  1007a4:	55                   	push   %rbp
  1007a5:	48 89 e5             	mov    %rsp,%rbp
  1007a8:	48 83 ec 20          	sub    $0x20,%rsp
  1007ac:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1007b0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1007b4:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  1007bb:	00 
  1007bc:	eb 0a                	jmp    1007c8 <strnlen+0x24>
        ++n;
  1007be:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1007c3:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  1007c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1007cc:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  1007d0:	74 0b                	je     1007dd <strnlen+0x39>
  1007d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1007d6:	0f b6 00             	movzbl (%rax),%eax
  1007d9:	84 c0                	test   %al,%al
  1007db:	75 e1                	jne    1007be <strnlen+0x1a>
    }
    return n;
  1007dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  1007e1:	c9                   	leave  
  1007e2:	c3                   	ret    

00000000001007e3 <strcpy>:

char* strcpy(char* dst, const char* src) {
  1007e3:	55                   	push   %rbp
  1007e4:	48 89 e5             	mov    %rsp,%rbp
  1007e7:	48 83 ec 20          	sub    $0x20,%rsp
  1007eb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1007ef:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  1007f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1007f7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  1007fb:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1007ff:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100803:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100807:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10080b:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10080f:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100813:	0f b6 12             	movzbl (%rdx),%edx
  100816:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100818:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10081c:	48 83 e8 01          	sub    $0x1,%rax
  100820:	0f b6 00             	movzbl (%rax),%eax
  100823:	84 c0                	test   %al,%al
  100825:	75 d4                	jne    1007fb <strcpy+0x18>
    return dst;
  100827:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  10082b:	c9                   	leave  
  10082c:	c3                   	ret    

000000000010082d <strcmp>:

int strcmp(const char* a, const char* b) {
  10082d:	55                   	push   %rbp
  10082e:	48 89 e5             	mov    %rsp,%rbp
  100831:	48 83 ec 10          	sub    $0x10,%rsp
  100835:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100839:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  10083d:	eb 0a                	jmp    100849 <strcmp+0x1c>
        ++a, ++b;
  10083f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100844:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100849:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10084d:	0f b6 00             	movzbl (%rax),%eax
  100850:	84 c0                	test   %al,%al
  100852:	74 1d                	je     100871 <strcmp+0x44>
  100854:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100858:	0f b6 00             	movzbl (%rax),%eax
  10085b:	84 c0                	test   %al,%al
  10085d:	74 12                	je     100871 <strcmp+0x44>
  10085f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100863:	0f b6 10             	movzbl (%rax),%edx
  100866:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10086a:	0f b6 00             	movzbl (%rax),%eax
  10086d:	38 c2                	cmp    %al,%dl
  10086f:	74 ce                	je     10083f <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100871:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100875:	0f b6 00             	movzbl (%rax),%eax
  100878:	89 c2                	mov    %eax,%edx
  10087a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  10087e:	0f b6 00             	movzbl (%rax),%eax
  100881:	38 d0                	cmp    %dl,%al
  100883:	0f 92 c0             	setb   %al
  100886:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100889:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10088d:	0f b6 00             	movzbl (%rax),%eax
  100890:	89 c1                	mov    %eax,%ecx
  100892:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100896:	0f b6 00             	movzbl (%rax),%eax
  100899:	38 c1                	cmp    %al,%cl
  10089b:	0f 92 c0             	setb   %al
  10089e:	0f b6 c0             	movzbl %al,%eax
  1008a1:	29 c2                	sub    %eax,%edx
  1008a3:	89 d0                	mov    %edx,%eax
}
  1008a5:	c9                   	leave  
  1008a6:	c3                   	ret    

00000000001008a7 <strchr>:

char* strchr(const char* s, int c) {
  1008a7:	55                   	push   %rbp
  1008a8:	48 89 e5             	mov    %rsp,%rbp
  1008ab:	48 83 ec 10          	sub    $0x10,%rsp
  1008af:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  1008b3:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  1008b6:	eb 05                	jmp    1008bd <strchr+0x16>
        ++s;
  1008b8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  1008bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008c1:	0f b6 00             	movzbl (%rax),%eax
  1008c4:	84 c0                	test   %al,%al
  1008c6:	74 0e                	je     1008d6 <strchr+0x2f>
  1008c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008cc:	0f b6 00             	movzbl (%rax),%eax
  1008cf:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1008d2:	38 d0                	cmp    %dl,%al
  1008d4:	75 e2                	jne    1008b8 <strchr+0x11>
    }
    if (*s == (char) c) {
  1008d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008da:	0f b6 00             	movzbl (%rax),%eax
  1008dd:	8b 55 f4             	mov    -0xc(%rbp),%edx
  1008e0:	38 d0                	cmp    %dl,%al
  1008e2:	75 06                	jne    1008ea <strchr+0x43>
        return (char*) s;
  1008e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1008e8:	eb 05                	jmp    1008ef <strchr+0x48>
    } else {
        return NULL;
  1008ea:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  1008ef:	c9                   	leave  
  1008f0:	c3                   	ret    

00000000001008f1 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  1008f1:	55                   	push   %rbp
  1008f2:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  1008f5:	8b 05 45 17 00 00    	mov    0x1745(%rip),%eax        # 102040 <rand_seed_set>
  1008fb:	85 c0                	test   %eax,%eax
  1008fd:	75 0a                	jne    100909 <rand+0x18>
        srand(819234718U);
  1008ff:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100904:	e8 24 00 00 00       	call   10092d <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100909:	8b 05 35 17 00 00    	mov    0x1735(%rip),%eax        # 102044 <rand_seed>
  10090f:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100915:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  10091a:	89 05 24 17 00 00    	mov    %eax,0x1724(%rip)        # 102044 <rand_seed>
    return rand_seed & RAND_MAX;
  100920:	8b 05 1e 17 00 00    	mov    0x171e(%rip),%eax        # 102044 <rand_seed>
  100926:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  10092b:	5d                   	pop    %rbp
  10092c:	c3                   	ret    

000000000010092d <srand>:

void srand(unsigned seed) {
  10092d:	55                   	push   %rbp
  10092e:	48 89 e5             	mov    %rsp,%rbp
  100931:	48 83 ec 08          	sub    $0x8,%rsp
  100935:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100938:	8b 45 fc             	mov    -0x4(%rbp),%eax
  10093b:	89 05 03 17 00 00    	mov    %eax,0x1703(%rip)        # 102044 <rand_seed>
    rand_seed_set = 1;
  100941:	c7 05 f5 16 00 00 01 	movl   $0x1,0x16f5(%rip)        # 102040 <rand_seed_set>
  100948:	00 00 00 
}
  10094b:	90                   	nop
  10094c:	c9                   	leave  
  10094d:	c3                   	ret    

000000000010094e <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  10094e:	55                   	push   %rbp
  10094f:	48 89 e5             	mov    %rsp,%rbp
  100952:	48 83 ec 28          	sub    $0x28,%rsp
  100956:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10095a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  10095e:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100961:	48 c7 45 f8 70 18 10 	movq   $0x101870,-0x8(%rbp)
  100968:	00 
    if (base < 0) {
  100969:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  10096d:	79 0b                	jns    10097a <fill_numbuf+0x2c>
        digits = lower_digits;
  10096f:	48 c7 45 f8 90 18 10 	movq   $0x101890,-0x8(%rbp)
  100976:	00 
        base = -base;
  100977:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  10097a:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  10097f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100983:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100986:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100989:	48 63 c8             	movslq %eax,%rcx
  10098c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100990:	ba 00 00 00 00       	mov    $0x0,%edx
  100995:	48 f7 f1             	div    %rcx
  100998:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10099c:	48 01 d0             	add    %rdx,%rax
  10099f:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  1009a4:	0f b6 10             	movzbl (%rax),%edx
  1009a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1009ab:	88 10                	mov    %dl,(%rax)
        val /= base;
  1009ad:	8b 45 dc             	mov    -0x24(%rbp),%eax
  1009b0:	48 63 f0             	movslq %eax,%rsi
  1009b3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  1009b7:	ba 00 00 00 00       	mov    $0x0,%edx
  1009bc:	48 f7 f6             	div    %rsi
  1009bf:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  1009c3:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  1009c8:	75 bc                	jne    100986 <fill_numbuf+0x38>
    return numbuf_end;
  1009ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  1009ce:	c9                   	leave  
  1009cf:	c3                   	ret    

00000000001009d0 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  1009d0:	55                   	push   %rbp
  1009d1:	48 89 e5             	mov    %rsp,%rbp
  1009d4:	53                   	push   %rbx
  1009d5:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  1009dc:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  1009e3:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  1009e9:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  1009f0:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  1009f7:	e9 8a 09 00 00       	jmp    101386 <printer_vprintf+0x9b6>
        if (*format != '%') {
  1009fc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a03:	0f b6 00             	movzbl (%rax),%eax
  100a06:	3c 25                	cmp    $0x25,%al
  100a08:	74 31                	je     100a3b <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100a0a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100a11:	4c 8b 00             	mov    (%rax),%r8
  100a14:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a1b:	0f b6 00             	movzbl (%rax),%eax
  100a1e:	0f b6 c8             	movzbl %al,%ecx
  100a21:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100a27:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100a2e:	89 ce                	mov    %ecx,%esi
  100a30:	48 89 c7             	mov    %rax,%rdi
  100a33:	41 ff d0             	call   *%r8
            continue;
  100a36:	e9 43 09 00 00       	jmp    10137e <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100a3b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100a42:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a49:	01 
  100a4a:	eb 44                	jmp    100a90 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100a4c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a53:	0f b6 00             	movzbl (%rax),%eax
  100a56:	0f be c0             	movsbl %al,%eax
  100a59:	89 c6                	mov    %eax,%esi
  100a5b:	bf 90 16 10 00       	mov    $0x101690,%edi
  100a60:	e8 42 fe ff ff       	call   1008a7 <strchr>
  100a65:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100a69:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100a6e:	74 30                	je     100aa0 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100a70:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100a74:	48 2d 90 16 10 00    	sub    $0x101690,%rax
  100a7a:	ba 01 00 00 00       	mov    $0x1,%edx
  100a7f:	89 c1                	mov    %eax,%ecx
  100a81:	d3 e2                	shl    %cl,%edx
  100a83:	89 d0                	mov    %edx,%eax
  100a85:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100a88:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100a8f:	01 
  100a90:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100a97:	0f b6 00             	movzbl (%rax),%eax
  100a9a:	84 c0                	test   %al,%al
  100a9c:	75 ae                	jne    100a4c <printer_vprintf+0x7c>
  100a9e:	eb 01                	jmp    100aa1 <printer_vprintf+0xd1>
            } else {
                break;
  100aa0:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100aa1:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100aa8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100aaf:	0f b6 00             	movzbl (%rax),%eax
  100ab2:	3c 30                	cmp    $0x30,%al
  100ab4:	7e 67                	jle    100b1d <printer_vprintf+0x14d>
  100ab6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100abd:	0f b6 00             	movzbl (%rax),%eax
  100ac0:	3c 39                	cmp    $0x39,%al
  100ac2:	7f 59                	jg     100b1d <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100ac4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100acb:	eb 2e                	jmp    100afb <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100acd:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100ad0:	89 d0                	mov    %edx,%eax
  100ad2:	c1 e0 02             	shl    $0x2,%eax
  100ad5:	01 d0                	add    %edx,%eax
  100ad7:	01 c0                	add    %eax,%eax
  100ad9:	89 c1                	mov    %eax,%ecx
  100adb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ae2:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100ae6:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100aed:	0f b6 00             	movzbl (%rax),%eax
  100af0:	0f be c0             	movsbl %al,%eax
  100af3:	01 c8                	add    %ecx,%eax
  100af5:	83 e8 30             	sub    $0x30,%eax
  100af8:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100afb:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b02:	0f b6 00             	movzbl (%rax),%eax
  100b05:	3c 2f                	cmp    $0x2f,%al
  100b07:	0f 8e 85 00 00 00    	jle    100b92 <printer_vprintf+0x1c2>
  100b0d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b14:	0f b6 00             	movzbl (%rax),%eax
  100b17:	3c 39                	cmp    $0x39,%al
  100b19:	7e b2                	jle    100acd <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100b1b:	eb 75                	jmp    100b92 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100b1d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100b24:	0f b6 00             	movzbl (%rax),%eax
  100b27:	3c 2a                	cmp    $0x2a,%al
  100b29:	75 68                	jne    100b93 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100b2b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b32:	8b 00                	mov    (%rax),%eax
  100b34:	83 f8 2f             	cmp    $0x2f,%eax
  100b37:	77 30                	ja     100b69 <printer_vprintf+0x199>
  100b39:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b40:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100b44:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b4b:	8b 00                	mov    (%rax),%eax
  100b4d:	89 c0                	mov    %eax,%eax
  100b4f:	48 01 d0             	add    %rdx,%rax
  100b52:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b59:	8b 12                	mov    (%rdx),%edx
  100b5b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100b5e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b65:	89 0a                	mov    %ecx,(%rdx)
  100b67:	eb 1a                	jmp    100b83 <printer_vprintf+0x1b3>
  100b69:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100b70:	48 8b 40 08          	mov    0x8(%rax),%rax
  100b74:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100b78:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100b7f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100b83:	8b 00                	mov    (%rax),%eax
  100b85:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100b88:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100b8f:	01 
  100b90:	eb 01                	jmp    100b93 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100b92:	90                   	nop
        }

        // process precision
        int precision = -1;
  100b93:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100b9a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ba1:	0f b6 00             	movzbl (%rax),%eax
  100ba4:	3c 2e                	cmp    $0x2e,%al
  100ba6:	0f 85 00 01 00 00    	jne    100cac <printer_vprintf+0x2dc>
            ++format;
  100bac:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100bb3:	01 
            if (*format >= '0' && *format <= '9') {
  100bb4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bbb:	0f b6 00             	movzbl (%rax),%eax
  100bbe:	3c 2f                	cmp    $0x2f,%al
  100bc0:	7e 67                	jle    100c29 <printer_vprintf+0x259>
  100bc2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bc9:	0f b6 00             	movzbl (%rax),%eax
  100bcc:	3c 39                	cmp    $0x39,%al
  100bce:	7f 59                	jg     100c29 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100bd0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100bd7:	eb 2e                	jmp    100c07 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100bd9:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100bdc:	89 d0                	mov    %edx,%eax
  100bde:	c1 e0 02             	shl    $0x2,%eax
  100be1:	01 d0                	add    %edx,%eax
  100be3:	01 c0                	add    %eax,%eax
  100be5:	89 c1                	mov    %eax,%ecx
  100be7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100bee:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100bf2:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100bf9:	0f b6 00             	movzbl (%rax),%eax
  100bfc:	0f be c0             	movsbl %al,%eax
  100bff:	01 c8                	add    %ecx,%eax
  100c01:	83 e8 30             	sub    $0x30,%eax
  100c04:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100c07:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c0e:	0f b6 00             	movzbl (%rax),%eax
  100c11:	3c 2f                	cmp    $0x2f,%al
  100c13:	0f 8e 85 00 00 00    	jle    100c9e <printer_vprintf+0x2ce>
  100c19:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c20:	0f b6 00             	movzbl (%rax),%eax
  100c23:	3c 39                	cmp    $0x39,%al
  100c25:	7e b2                	jle    100bd9 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100c27:	eb 75                	jmp    100c9e <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100c29:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100c30:	0f b6 00             	movzbl (%rax),%eax
  100c33:	3c 2a                	cmp    $0x2a,%al
  100c35:	75 68                	jne    100c9f <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100c37:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c3e:	8b 00                	mov    (%rax),%eax
  100c40:	83 f8 2f             	cmp    $0x2f,%eax
  100c43:	77 30                	ja     100c75 <printer_vprintf+0x2a5>
  100c45:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c4c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100c50:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c57:	8b 00                	mov    (%rax),%eax
  100c59:	89 c0                	mov    %eax,%eax
  100c5b:	48 01 d0             	add    %rdx,%rax
  100c5e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c65:	8b 12                	mov    (%rdx),%edx
  100c67:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100c6a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c71:	89 0a                	mov    %ecx,(%rdx)
  100c73:	eb 1a                	jmp    100c8f <printer_vprintf+0x2bf>
  100c75:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100c7c:	48 8b 40 08          	mov    0x8(%rax),%rax
  100c80:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100c84:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100c8b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100c8f:	8b 00                	mov    (%rax),%eax
  100c91:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100c94:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100c9b:	01 
  100c9c:	eb 01                	jmp    100c9f <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100c9e:	90                   	nop
            }
            if (precision < 0) {
  100c9f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100ca3:	79 07                	jns    100cac <printer_vprintf+0x2dc>
                precision = 0;
  100ca5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100cac:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100cb3:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100cba:	00 
        int length = 0;
  100cbb:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100cc2:	48 c7 45 c8 96 16 10 	movq   $0x101696,-0x38(%rbp)
  100cc9:	00 
    again:
        switch (*format) {
  100cca:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100cd1:	0f b6 00             	movzbl (%rax),%eax
  100cd4:	0f be c0             	movsbl %al,%eax
  100cd7:	83 e8 43             	sub    $0x43,%eax
  100cda:	83 f8 37             	cmp    $0x37,%eax
  100cdd:	0f 87 9f 03 00 00    	ja     101082 <printer_vprintf+0x6b2>
  100ce3:	89 c0                	mov    %eax,%eax
  100ce5:	48 8b 04 c5 a8 16 10 	mov    0x1016a8(,%rax,8),%rax
  100cec:	00 
  100ced:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100cef:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100cf6:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100cfd:	01 
            goto again;
  100cfe:	eb ca                	jmp    100cca <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100d00:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100d04:	74 5d                	je     100d63 <printer_vprintf+0x393>
  100d06:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d0d:	8b 00                	mov    (%rax),%eax
  100d0f:	83 f8 2f             	cmp    $0x2f,%eax
  100d12:	77 30                	ja     100d44 <printer_vprintf+0x374>
  100d14:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d1b:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d1f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d26:	8b 00                	mov    (%rax),%eax
  100d28:	89 c0                	mov    %eax,%eax
  100d2a:	48 01 d0             	add    %rdx,%rax
  100d2d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d34:	8b 12                	mov    (%rdx),%edx
  100d36:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d39:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d40:	89 0a                	mov    %ecx,(%rdx)
  100d42:	eb 1a                	jmp    100d5e <printer_vprintf+0x38e>
  100d44:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d4b:	48 8b 40 08          	mov    0x8(%rax),%rax
  100d4f:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100d53:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d5a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100d5e:	48 8b 00             	mov    (%rax),%rax
  100d61:	eb 5c                	jmp    100dbf <printer_vprintf+0x3ef>
  100d63:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d6a:	8b 00                	mov    (%rax),%eax
  100d6c:	83 f8 2f             	cmp    $0x2f,%eax
  100d6f:	77 30                	ja     100da1 <printer_vprintf+0x3d1>
  100d71:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d78:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100d7c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100d83:	8b 00                	mov    (%rax),%eax
  100d85:	89 c0                	mov    %eax,%eax
  100d87:	48 01 d0             	add    %rdx,%rax
  100d8a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d91:	8b 12                	mov    (%rdx),%edx
  100d93:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100d96:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100d9d:	89 0a                	mov    %ecx,(%rdx)
  100d9f:	eb 1a                	jmp    100dbb <printer_vprintf+0x3eb>
  100da1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100da8:	48 8b 40 08          	mov    0x8(%rax),%rax
  100dac:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100db0:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100db7:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100dbb:	8b 00                	mov    (%rax),%eax
  100dbd:	48 98                	cltq   
  100dbf:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100dc3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100dc7:	48 c1 f8 38          	sar    $0x38,%rax
  100dcb:	25 80 00 00 00       	and    $0x80,%eax
  100dd0:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  100dd3:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  100dd7:	74 09                	je     100de2 <printer_vprintf+0x412>
  100dd9:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100ddd:	48 f7 d8             	neg    %rax
  100de0:	eb 04                	jmp    100de6 <printer_vprintf+0x416>
  100de2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100de6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100dea:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  100ded:	83 c8 60             	or     $0x60,%eax
  100df0:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  100df3:	e9 cf 02 00 00       	jmp    1010c7 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100df8:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  100dfc:	74 5d                	je     100e5b <printer_vprintf+0x48b>
  100dfe:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e05:	8b 00                	mov    (%rax),%eax
  100e07:	83 f8 2f             	cmp    $0x2f,%eax
  100e0a:	77 30                	ja     100e3c <printer_vprintf+0x46c>
  100e0c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e13:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e17:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e1e:	8b 00                	mov    (%rax),%eax
  100e20:	89 c0                	mov    %eax,%eax
  100e22:	48 01 d0             	add    %rdx,%rax
  100e25:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e2c:	8b 12                	mov    (%rdx),%edx
  100e2e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e31:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e38:	89 0a                	mov    %ecx,(%rdx)
  100e3a:	eb 1a                	jmp    100e56 <printer_vprintf+0x486>
  100e3c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e43:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e47:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e4b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e52:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e56:	48 8b 00             	mov    (%rax),%rax
  100e59:	eb 5c                	jmp    100eb7 <printer_vprintf+0x4e7>
  100e5b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e62:	8b 00                	mov    (%rax),%eax
  100e64:	83 f8 2f             	cmp    $0x2f,%eax
  100e67:	77 30                	ja     100e99 <printer_vprintf+0x4c9>
  100e69:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e70:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e74:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e7b:	8b 00                	mov    (%rax),%eax
  100e7d:	89 c0                	mov    %eax,%eax
  100e7f:	48 01 d0             	add    %rdx,%rax
  100e82:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e89:	8b 12                	mov    (%rdx),%edx
  100e8b:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e8e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e95:	89 0a                	mov    %ecx,(%rdx)
  100e97:	eb 1a                	jmp    100eb3 <printer_vprintf+0x4e3>
  100e99:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ea0:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ea4:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100ea8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100eaf:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100eb3:	8b 00                	mov    (%rax),%eax
  100eb5:	89 c0                	mov    %eax,%eax
  100eb7:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  100ebb:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  100ebf:	e9 03 02 00 00       	jmp    1010c7 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  100ec4:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  100ecb:	e9 28 ff ff ff       	jmp    100df8 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  100ed0:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  100ed7:	e9 1c ff ff ff       	jmp    100df8 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  100edc:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ee3:	8b 00                	mov    (%rax),%eax
  100ee5:	83 f8 2f             	cmp    $0x2f,%eax
  100ee8:	77 30                	ja     100f1a <printer_vprintf+0x54a>
  100eea:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ef1:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100ef5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100efc:	8b 00                	mov    (%rax),%eax
  100efe:	89 c0                	mov    %eax,%eax
  100f00:	48 01 d0             	add    %rdx,%rax
  100f03:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f0a:	8b 12                	mov    (%rdx),%edx
  100f0c:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f0f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f16:	89 0a                	mov    %ecx,(%rdx)
  100f18:	eb 1a                	jmp    100f34 <printer_vprintf+0x564>
  100f1a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f21:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f25:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f29:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f30:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f34:	48 8b 00             	mov    (%rax),%rax
  100f37:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  100f3b:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100f42:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  100f49:	e9 79 01 00 00       	jmp    1010c7 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  100f4e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f55:	8b 00                	mov    (%rax),%eax
  100f57:	83 f8 2f             	cmp    $0x2f,%eax
  100f5a:	77 30                	ja     100f8c <printer_vprintf+0x5bc>
  100f5c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f63:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f67:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f6e:	8b 00                	mov    (%rax),%eax
  100f70:	89 c0                	mov    %eax,%eax
  100f72:	48 01 d0             	add    %rdx,%rax
  100f75:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f7c:	8b 12                	mov    (%rdx),%edx
  100f7e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f81:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f88:	89 0a                	mov    %ecx,(%rdx)
  100f8a:	eb 1a                	jmp    100fa6 <printer_vprintf+0x5d6>
  100f8c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f93:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f97:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f9b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fa2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100fa6:	48 8b 00             	mov    (%rax),%rax
  100fa9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  100fad:	e9 15 01 00 00       	jmp    1010c7 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  100fb2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fb9:	8b 00                	mov    (%rax),%eax
  100fbb:	83 f8 2f             	cmp    $0x2f,%eax
  100fbe:	77 30                	ja     100ff0 <printer_vprintf+0x620>
  100fc0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fc7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100fcb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100fd2:	8b 00                	mov    (%rax),%eax
  100fd4:	89 c0                	mov    %eax,%eax
  100fd6:	48 01 d0             	add    %rdx,%rax
  100fd9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fe0:	8b 12                	mov    (%rdx),%edx
  100fe2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100fe5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100fec:	89 0a                	mov    %ecx,(%rdx)
  100fee:	eb 1a                	jmp    10100a <printer_vprintf+0x63a>
  100ff0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100ff7:	48 8b 40 08          	mov    0x8(%rax),%rax
  100ffb:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100fff:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101006:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10100a:	8b 00                	mov    (%rax),%eax
  10100c:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  101012:	e9 67 03 00 00       	jmp    10137e <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  101017:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  10101b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  10101f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101026:	8b 00                	mov    (%rax),%eax
  101028:	83 f8 2f             	cmp    $0x2f,%eax
  10102b:	77 30                	ja     10105d <printer_vprintf+0x68d>
  10102d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101034:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101038:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10103f:	8b 00                	mov    (%rax),%eax
  101041:	89 c0                	mov    %eax,%eax
  101043:	48 01 d0             	add    %rdx,%rax
  101046:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10104d:	8b 12                	mov    (%rdx),%edx
  10104f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101052:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101059:	89 0a                	mov    %ecx,(%rdx)
  10105b:	eb 1a                	jmp    101077 <printer_vprintf+0x6a7>
  10105d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101064:	48 8b 40 08          	mov    0x8(%rax),%rax
  101068:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10106c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101073:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101077:	8b 00                	mov    (%rax),%eax
  101079:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  10107c:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  101080:	eb 45                	jmp    1010c7 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  101082:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101086:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  10108a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101091:	0f b6 00             	movzbl (%rax),%eax
  101094:	84 c0                	test   %al,%al
  101096:	74 0c                	je     1010a4 <printer_vprintf+0x6d4>
  101098:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10109f:	0f b6 00             	movzbl (%rax),%eax
  1010a2:	eb 05                	jmp    1010a9 <printer_vprintf+0x6d9>
  1010a4:	b8 25 00 00 00       	mov    $0x25,%eax
  1010a9:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1010ac:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  1010b0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1010b7:	0f b6 00             	movzbl (%rax),%eax
  1010ba:	84 c0                	test   %al,%al
  1010bc:	75 08                	jne    1010c6 <printer_vprintf+0x6f6>
                format--;
  1010be:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  1010c5:	01 
            }
            break;
  1010c6:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  1010c7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010ca:	83 e0 20             	and    $0x20,%eax
  1010cd:	85 c0                	test   %eax,%eax
  1010cf:	74 1e                	je     1010ef <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  1010d1:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1010d5:	48 83 c0 18          	add    $0x18,%rax
  1010d9:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1010dc:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1010e0:	48 89 ce             	mov    %rcx,%rsi
  1010e3:	48 89 c7             	mov    %rax,%rdi
  1010e6:	e8 63 f8 ff ff       	call   10094e <fill_numbuf>
  1010eb:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  1010ef:	48 c7 45 c0 96 16 10 	movq   $0x101696,-0x40(%rbp)
  1010f6:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1010f7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1010fa:	83 e0 20             	and    $0x20,%eax
  1010fd:	85 c0                	test   %eax,%eax
  1010ff:	74 48                	je     101149 <printer_vprintf+0x779>
  101101:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101104:	83 e0 40             	and    $0x40,%eax
  101107:	85 c0                	test   %eax,%eax
  101109:	74 3e                	je     101149 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  10110b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10110e:	25 80 00 00 00       	and    $0x80,%eax
  101113:	85 c0                	test   %eax,%eax
  101115:	74 0a                	je     101121 <printer_vprintf+0x751>
                prefix = "-";
  101117:	48 c7 45 c0 97 16 10 	movq   $0x101697,-0x40(%rbp)
  10111e:	00 
            if (flags & FLAG_NEGATIVE) {
  10111f:	eb 73                	jmp    101194 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  101121:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101124:	83 e0 10             	and    $0x10,%eax
  101127:	85 c0                	test   %eax,%eax
  101129:	74 0a                	je     101135 <printer_vprintf+0x765>
                prefix = "+";
  10112b:	48 c7 45 c0 99 16 10 	movq   $0x101699,-0x40(%rbp)
  101132:	00 
            if (flags & FLAG_NEGATIVE) {
  101133:	eb 5f                	jmp    101194 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  101135:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101138:	83 e0 08             	and    $0x8,%eax
  10113b:	85 c0                	test   %eax,%eax
  10113d:	74 55                	je     101194 <printer_vprintf+0x7c4>
                prefix = " ";
  10113f:	48 c7 45 c0 9b 16 10 	movq   $0x10169b,-0x40(%rbp)
  101146:	00 
            if (flags & FLAG_NEGATIVE) {
  101147:	eb 4b                	jmp    101194 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  101149:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10114c:	83 e0 20             	and    $0x20,%eax
  10114f:	85 c0                	test   %eax,%eax
  101151:	74 42                	je     101195 <printer_vprintf+0x7c5>
  101153:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101156:	83 e0 01             	and    $0x1,%eax
  101159:	85 c0                	test   %eax,%eax
  10115b:	74 38                	je     101195 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  10115d:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  101161:	74 06                	je     101169 <printer_vprintf+0x799>
  101163:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101167:	75 2c                	jne    101195 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  101169:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10116e:	75 0c                	jne    10117c <printer_vprintf+0x7ac>
  101170:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101173:	25 00 01 00 00       	and    $0x100,%eax
  101178:	85 c0                	test   %eax,%eax
  10117a:	74 19                	je     101195 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  10117c:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101180:	75 07                	jne    101189 <printer_vprintf+0x7b9>
  101182:	b8 9d 16 10 00       	mov    $0x10169d,%eax
  101187:	eb 05                	jmp    10118e <printer_vprintf+0x7be>
  101189:	b8 a0 16 10 00       	mov    $0x1016a0,%eax
  10118e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101192:	eb 01                	jmp    101195 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  101194:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  101195:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  101199:	78 24                	js     1011bf <printer_vprintf+0x7ef>
  10119b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10119e:	83 e0 20             	and    $0x20,%eax
  1011a1:	85 c0                	test   %eax,%eax
  1011a3:	75 1a                	jne    1011bf <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  1011a5:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1011a8:	48 63 d0             	movslq %eax,%rdx
  1011ab:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1011af:	48 89 d6             	mov    %rdx,%rsi
  1011b2:	48 89 c7             	mov    %rax,%rdi
  1011b5:	e8 ea f5 ff ff       	call   1007a4 <strnlen>
  1011ba:	89 45 bc             	mov    %eax,-0x44(%rbp)
  1011bd:	eb 0f                	jmp    1011ce <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  1011bf:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1011c3:	48 89 c7             	mov    %rax,%rdi
  1011c6:	e8 a8 f5 ff ff       	call   100773 <strlen>
  1011cb:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1011ce:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011d1:	83 e0 20             	and    $0x20,%eax
  1011d4:	85 c0                	test   %eax,%eax
  1011d6:	74 20                	je     1011f8 <printer_vprintf+0x828>
  1011d8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1011dc:	78 1a                	js     1011f8 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  1011de:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1011e1:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  1011e4:	7e 08                	jle    1011ee <printer_vprintf+0x81e>
  1011e6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1011e9:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1011ec:	eb 05                	jmp    1011f3 <printer_vprintf+0x823>
  1011ee:	b8 00 00 00 00       	mov    $0x0,%eax
  1011f3:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1011f6:	eb 5c                	jmp    101254 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1011f8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1011fb:	83 e0 20             	and    $0x20,%eax
  1011fe:	85 c0                	test   %eax,%eax
  101200:	74 4b                	je     10124d <printer_vprintf+0x87d>
  101202:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101205:	83 e0 02             	and    $0x2,%eax
  101208:	85 c0                	test   %eax,%eax
  10120a:	74 41                	je     10124d <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  10120c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10120f:	83 e0 04             	and    $0x4,%eax
  101212:	85 c0                	test   %eax,%eax
  101214:	75 37                	jne    10124d <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  101216:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10121a:	48 89 c7             	mov    %rax,%rdi
  10121d:	e8 51 f5 ff ff       	call   100773 <strlen>
  101222:	89 c2                	mov    %eax,%edx
  101224:	8b 45 bc             	mov    -0x44(%rbp),%eax
  101227:	01 d0                	add    %edx,%eax
  101229:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  10122c:	7e 1f                	jle    10124d <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  10122e:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101231:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101234:	89 c3                	mov    %eax,%ebx
  101236:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10123a:	48 89 c7             	mov    %rax,%rdi
  10123d:	e8 31 f5 ff ff       	call   100773 <strlen>
  101242:	89 c2                	mov    %eax,%edx
  101244:	89 d8                	mov    %ebx,%eax
  101246:	29 d0                	sub    %edx,%eax
  101248:	89 45 b8             	mov    %eax,-0x48(%rbp)
  10124b:	eb 07                	jmp    101254 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  10124d:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101254:	8b 55 bc             	mov    -0x44(%rbp),%edx
  101257:	8b 45 b8             	mov    -0x48(%rbp),%eax
  10125a:	01 d0                	add    %edx,%eax
  10125c:	48 63 d8             	movslq %eax,%rbx
  10125f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101263:	48 89 c7             	mov    %rax,%rdi
  101266:	e8 08 f5 ff ff       	call   100773 <strlen>
  10126b:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  10126f:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101272:	29 d0                	sub    %edx,%eax
  101274:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101277:	eb 25                	jmp    10129e <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  101279:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101280:	48 8b 08             	mov    (%rax),%rcx
  101283:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101289:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101290:	be 20 00 00 00       	mov    $0x20,%esi
  101295:	48 89 c7             	mov    %rax,%rdi
  101298:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10129a:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  10129e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1012a1:	83 e0 04             	and    $0x4,%eax
  1012a4:	85 c0                	test   %eax,%eax
  1012a6:	75 36                	jne    1012de <printer_vprintf+0x90e>
  1012a8:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1012ac:	7f cb                	jg     101279 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  1012ae:	eb 2e                	jmp    1012de <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  1012b0:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012b7:	4c 8b 00             	mov    (%rax),%r8
  1012ba:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1012be:	0f b6 00             	movzbl (%rax),%eax
  1012c1:	0f b6 c8             	movzbl %al,%ecx
  1012c4:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1012ca:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012d1:	89 ce                	mov    %ecx,%esi
  1012d3:	48 89 c7             	mov    %rax,%rdi
  1012d6:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  1012d9:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  1012de:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1012e2:	0f b6 00             	movzbl (%rax),%eax
  1012e5:	84 c0                	test   %al,%al
  1012e7:	75 c7                	jne    1012b0 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  1012e9:	eb 25                	jmp    101310 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  1012eb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1012f2:	48 8b 08             	mov    (%rax),%rcx
  1012f5:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1012fb:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101302:	be 30 00 00 00       	mov    $0x30,%esi
  101307:	48 89 c7             	mov    %rax,%rdi
  10130a:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  10130c:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  101310:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101314:	7f d5                	jg     1012eb <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  101316:	eb 32                	jmp    10134a <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  101318:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10131f:	4c 8b 00             	mov    (%rax),%r8
  101322:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101326:	0f b6 00             	movzbl (%rax),%eax
  101329:	0f b6 c8             	movzbl %al,%ecx
  10132c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101332:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101339:	89 ce                	mov    %ecx,%esi
  10133b:	48 89 c7             	mov    %rax,%rdi
  10133e:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101341:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101346:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  10134a:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  10134e:	7f c8                	jg     101318 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  101350:	eb 25                	jmp    101377 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  101352:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101359:	48 8b 08             	mov    (%rax),%rcx
  10135c:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101362:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101369:	be 20 00 00 00       	mov    $0x20,%esi
  10136e:	48 89 c7             	mov    %rax,%rdi
  101371:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  101373:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101377:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10137b:	7f d5                	jg     101352 <printer_vprintf+0x982>
        }
    done: ;
  10137d:	90                   	nop
    for (; *format; ++format) {
  10137e:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101385:	01 
  101386:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10138d:	0f b6 00             	movzbl (%rax),%eax
  101390:	84 c0                	test   %al,%al
  101392:	0f 85 64 f6 ff ff    	jne    1009fc <printer_vprintf+0x2c>
    }
}
  101398:	90                   	nop
  101399:	90                   	nop
  10139a:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  10139e:	c9                   	leave  
  10139f:	c3                   	ret    

00000000001013a0 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1013a0:	55                   	push   %rbp
  1013a1:	48 89 e5             	mov    %rsp,%rbp
  1013a4:	48 83 ec 20          	sub    $0x20,%rsp
  1013a8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1013ac:	89 f0                	mov    %esi,%eax
  1013ae:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1013b1:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1013b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1013b8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1013bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013c0:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013c4:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  1013c9:	48 39 d0             	cmp    %rdx,%rax
  1013cc:	72 0c                	jb     1013da <console_putc+0x3a>
        cp->cursor = console;
  1013ce:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013d2:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  1013d9:	00 
    }
    if (c == '\n') {
  1013da:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1013de:	75 78                	jne    101458 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  1013e0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1013e4:	48 8b 40 08          	mov    0x8(%rax),%rax
  1013e8:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1013ee:	48 d1 f8             	sar    %rax
  1013f1:	48 89 c1             	mov    %rax,%rcx
  1013f4:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1013fb:	66 66 66 
  1013fe:	48 89 c8             	mov    %rcx,%rax
  101401:	48 f7 ea             	imul   %rdx
  101404:	48 c1 fa 05          	sar    $0x5,%rdx
  101408:	48 89 c8             	mov    %rcx,%rax
  10140b:	48 c1 f8 3f          	sar    $0x3f,%rax
  10140f:	48 29 c2             	sub    %rax,%rdx
  101412:	48 89 d0             	mov    %rdx,%rax
  101415:	48 c1 e0 02          	shl    $0x2,%rax
  101419:	48 01 d0             	add    %rdx,%rax
  10141c:	48 c1 e0 04          	shl    $0x4,%rax
  101420:	48 29 c1             	sub    %rax,%rcx
  101423:	48 89 ca             	mov    %rcx,%rdx
  101426:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  101429:	eb 25                	jmp    101450 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  10142b:	8b 45 e0             	mov    -0x20(%rbp),%eax
  10142e:	83 c8 20             	or     $0x20,%eax
  101431:	89 c6                	mov    %eax,%esi
  101433:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101437:	48 8b 40 08          	mov    0x8(%rax),%rax
  10143b:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10143f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101443:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101447:	89 f2                	mov    %esi,%edx
  101449:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10144c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101450:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101454:	75 d5                	jne    10142b <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101456:	eb 24                	jmp    10147c <console_putc+0xdc>
        *cp->cursor++ = c | color;
  101458:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  10145c:	8b 55 e0             	mov    -0x20(%rbp),%edx
  10145f:	09 d0                	or     %edx,%eax
  101461:	89 c6                	mov    %eax,%esi
  101463:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101467:	48 8b 40 08          	mov    0x8(%rax),%rax
  10146b:	48 8d 48 02          	lea    0x2(%rax),%rcx
  10146f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101473:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101477:	89 f2                	mov    %esi,%edx
  101479:	66 89 10             	mov    %dx,(%rax)
}
  10147c:	90                   	nop
  10147d:	c9                   	leave  
  10147e:	c3                   	ret    

000000000010147f <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  10147f:	55                   	push   %rbp
  101480:	48 89 e5             	mov    %rsp,%rbp
  101483:	48 83 ec 30          	sub    $0x30,%rsp
  101487:	89 7d ec             	mov    %edi,-0x14(%rbp)
  10148a:	89 75 e8             	mov    %esi,-0x18(%rbp)
  10148d:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101491:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101495:	48 c7 45 f0 a0 13 10 	movq   $0x1013a0,-0x10(%rbp)
  10149c:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10149d:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1014a1:	78 09                	js     1014ac <console_vprintf+0x2d>
  1014a3:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1014aa:	7e 07                	jle    1014b3 <console_vprintf+0x34>
        cpos = 0;
  1014ac:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1014b3:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014b6:	48 98                	cltq   
  1014b8:	48 01 c0             	add    %rax,%rax
  1014bb:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  1014c1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1014c5:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1014c9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1014cd:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1014d0:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1014d4:	48 89 c7             	mov    %rax,%rdi
  1014d7:	e8 f4 f4 ff ff       	call   1009d0 <printer_vprintf>
    return cp.cursor - console;
  1014dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1014e0:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1014e6:	48 d1 f8             	sar    %rax
}
  1014e9:	c9                   	leave  
  1014ea:	c3                   	ret    

00000000001014eb <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1014eb:	55                   	push   %rbp
  1014ec:	48 89 e5             	mov    %rsp,%rbp
  1014ef:	48 83 ec 60          	sub    $0x60,%rsp
  1014f3:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1014f6:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1014f9:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1014fd:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101501:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101505:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101509:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101510:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101514:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101518:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10151c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101520:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101524:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  101528:	8b 75 a8             	mov    -0x58(%rbp),%esi
  10152b:	8b 45 ac             	mov    -0x54(%rbp),%eax
  10152e:	89 c7                	mov    %eax,%edi
  101530:	e8 4a ff ff ff       	call   10147f <console_vprintf>
  101535:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  101538:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  10153b:	c9                   	leave  
  10153c:	c3                   	ret    

000000000010153d <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  10153d:	55                   	push   %rbp
  10153e:	48 89 e5             	mov    %rsp,%rbp
  101541:	48 83 ec 20          	sub    $0x20,%rsp
  101545:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  101549:	89 f0                	mov    %esi,%eax
  10154b:	89 55 e0             	mov    %edx,-0x20(%rbp)
  10154e:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101551:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101555:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  101559:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10155d:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101561:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101565:	48 8b 40 10          	mov    0x10(%rax),%rax
  101569:	48 39 c2             	cmp    %rax,%rdx
  10156c:	73 1a                	jae    101588 <string_putc+0x4b>
        *sp->s++ = c;
  10156e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101572:	48 8b 40 08          	mov    0x8(%rax),%rax
  101576:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10157a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  10157e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101582:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101586:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  101588:	90                   	nop
  101589:	c9                   	leave  
  10158a:	c3                   	ret    

000000000010158b <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  10158b:	55                   	push   %rbp
  10158c:	48 89 e5             	mov    %rsp,%rbp
  10158f:	48 83 ec 40          	sub    $0x40,%rsp
  101593:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101597:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  10159b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  10159f:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1015a3:	48 c7 45 e8 3d 15 10 	movq   $0x10153d,-0x18(%rbp)
  1015aa:	00 
    sp.s = s;
  1015ab:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1015af:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1015b3:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1015b8:	74 33                	je     1015ed <vsnprintf+0x62>
        sp.end = s + size - 1;
  1015ba:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1015be:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1015c2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1015c6:	48 01 d0             	add    %rdx,%rax
  1015c9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1015cd:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1015d1:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1015d5:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1015d9:	be 00 00 00 00       	mov    $0x0,%esi
  1015de:	48 89 c7             	mov    %rax,%rdi
  1015e1:	e8 ea f3 ff ff       	call   1009d0 <printer_vprintf>
        *sp.s = 0;
  1015e6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1015ea:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1015ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1015f1:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1015f5:	c9                   	leave  
  1015f6:	c3                   	ret    

00000000001015f7 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1015f7:	55                   	push   %rbp
  1015f8:	48 89 e5             	mov    %rsp,%rbp
  1015fb:	48 83 ec 70          	sub    $0x70,%rsp
  1015ff:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101603:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101607:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  10160b:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10160f:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101613:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101617:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  10161e:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101622:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101626:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10162a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  10162e:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101632:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101636:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  10163a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  10163e:	48 89 c7             	mov    %rax,%rdi
  101641:	e8 45 ff ff ff       	call   10158b <vsnprintf>
  101646:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  101649:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  10164c:	c9                   	leave  
  10164d:	c3                   	ret    

000000000010164e <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  10164e:	55                   	push   %rbp
  10164f:	48 89 e5             	mov    %rsp,%rbp
  101652:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101656:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  10165d:	eb 13                	jmp    101672 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  10165f:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101662:	48 98                	cltq   
  101664:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  10166b:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  10166e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101672:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  101679:	7e e4                	jle    10165f <console_clear+0x11>
    }
    cursorpos = 0;
  10167b:	c7 05 77 79 fb ff 00 	movl   $0x0,-0x48689(%rip)        # b8ffc <cursorpos>
  101682:	00 00 00 
}
  101685:	90                   	nop
  101686:	c9                   	leave  
  101687:	c3                   	ret    
