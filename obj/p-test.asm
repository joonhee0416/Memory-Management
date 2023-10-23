
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
uint8_t *heap_bottom;
uint8_t *stack_bottom;



void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	41 55                	push   %r13
  100006:	41 54                	push   %r12
  100008:	53                   	push   %rbx
  100009:	48 83 ec 28          	sub    $0x28,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  10000d:	cd 31                	int    $0x31
  10000f:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();
    srand(p);
  100011:	89 c7                	mov    %eax,%edi
  100013:	e8 17 0c 00 00       	call   100c2f <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100018:	b8 4f 30 10 00       	mov    $0x10304f,%eax
  10001d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100023:	48 89 05 e6 1f 00 00 	mov    %rax,0x1fe6(%rip)        # 102010 <heap_top>
  10002a:	48 89 05 d7 1f 00 00 	mov    %rax,0x1fd7(%rip)        # 102008 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100031:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100034:	48 83 e8 01          	sub    $0x1,%rax
  100038:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10003e:	48 89 05 bb 1f 00 00 	mov    %rax,0x1fbb(%rip)        # 102000 <stack_bottom>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  100045:	bf 28 00 00 00       	mov    $0x28,%edi
  10004a:	e8 dd 05 00 00       	call   10062c <malloc>

    assert(array != NULL);
  10004f:	48 85 c0             	test   %rax,%rax
  100052:	0f 84 bf 00 00 00    	je     100117 <process_main+0x117>
    assert((uintptr_t)array % 8 == 0);
  100058:	48 89 c2             	mov    %rax,%rdx
  10005b:	83 e2 07             	and    $0x7,%edx
  10005e:	0f 85 c7 00 00 00    	jne    10012b <process_main+0x12b>

    // set array elements
    for(int  i = 0 ; i < 10; i++){
	array[i] = i;
  100064:	89 14 90             	mov    %edx,(%rax,%rdx,4)
    for(int  i = 0 ; i < 10; i++){
  100067:	48 83 c2 01          	add    $0x1,%rdx
  10006b:	48 83 fa 0a          	cmp    $0xa,%rdx
  10006f:	75 f3                	jne    100064 <process_main+0x64>
    }

    // realloc array to size 20
    array = (int*)realloc(array, sizeof(int) * 20);
  100071:	be 50 00 00 00       	mov    $0x50,%esi
  100076:	48 89 c7             	mov    %rax,%rdi
  100079:	e8 e8 06 00 00       	call   100766 <realloc>
  10007e:	49 89 c4             	mov    %rax,%r12

    assert(array != NULL);
  100081:	48 85 c0             	test   %rax,%rax
  100084:	0f 84 b5 00 00 00    	je     10013f <process_main+0x13f>
    assert((uintptr_t)array % 8 == 0);
  10008a:	83 e0 07             	and    $0x7,%eax
  10008d:	0f 85 c0 00 00 00    	jne    100153 <process_main+0x153>

    // check if contents are same
    for(int i = 0 ; i < 10 ; i++){
        assert(array[i] == i);
  100093:	41 39 04 84          	cmp    %eax,(%r12,%rax,4)
  100097:	0f 85 ca 00 00 00    	jne    100167 <process_main+0x167>
    for(int i = 0 ; i < 10 ; i++){
  10009d:	48 83 c0 01          	add    $0x1,%rax
  1000a1:	48 83 f8 0a          	cmp    $0xa,%rax
  1000a5:	75 ec                	jne    100093 <process_main+0x93>
    }

    // alloc int array of size 30 using calloc
    int * array2 = (int *)calloc(30, sizeof(int));
  1000a7:	be 04 00 00 00       	mov    $0x4,%esi
  1000ac:	bf 1e 00 00 00       	mov    $0x1e,%edi
  1000b1:	e8 5e 06 00 00       	call   100714 <calloc>
  1000b6:	49 89 c5             	mov    %rax,%r13

    // assert array[i] == 0
    for(int i = 0 ; i < 30; i++){
  1000b9:	48 8d 50 78          	lea    0x78(%rax),%rdx
        assert(array2[i] == 0);
  1000bd:	83 38 00             	cmpl   $0x0,(%rax)
  1000c0:	0f 85 b5 00 00 00    	jne    10017b <process_main+0x17b>
    for(int i = 0 ; i < 30; i++){
  1000c6:	48 83 c0 04          	add    $0x4,%rax
  1000ca:	48 39 d0             	cmp    %rdx,%rax
  1000cd:	75 ee                	jne    1000bd <process_main+0xbd>
    }

    heap_info_struct info;
    assert(heap_info(&info) == 0);
  1000cf:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
  1000d3:	e8 59 07 00 00       	call   100831 <heap_info>
  1000d8:	85 c0                	test   %eax,%eax
  1000da:	0f 85 af 00 00 00    	jne    10018f <process_main+0x18f>

    // check if allocations are in sorted order
    for(int i = 1 ; i < info.num_allocs; i++){
  1000e0:	8b 75 c0             	mov    -0x40(%rbp),%esi
        assert(info.size_array[i] < info.size_array[i-1]);
  1000e3:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1000e7:	b8 01 00 00 00       	mov    $0x1,%eax
    for(int i = 1 ; i < info.num_allocs; i++){
  1000ec:	39 c6                	cmp    %eax,%esi
  1000ee:	0f 8e af 00 00 00    	jle    1001a3 <process_main+0x1a3>
        assert(info.size_array[i] < info.size_array[i-1]);
  1000f4:	48 8b 0c c2          	mov    (%rdx,%rax,8),%rcx
  1000f8:	48 83 c0 01          	add    $0x1,%rax
  1000fc:	48 3b 4c c2 f0       	cmp    -0x10(%rdx,%rax,8),%rcx
  100101:	7c e9                	jl     1000ec <process_main+0xec>
  100103:	ba 18 1a 10 00       	mov    $0x101a18,%edx
  100108:	be 36 00 00 00       	mov    $0x36,%esi
  10010d:	bf 9e 19 10 00       	mov    $0x10199e,%edi
  100112:	e8 2d 02 00 00       	call   100344 <assert_fail>
    assert(array != NULL);
  100117:	ba 90 19 10 00       	mov    $0x101990,%edx
  10011c:	be 16 00 00 00       	mov    $0x16,%esi
  100121:	bf 9e 19 10 00       	mov    $0x10199e,%edi
  100126:	e8 19 02 00 00       	call   100344 <assert_fail>
    assert((uintptr_t)array % 8 == 0);
  10012b:	ba ae 19 10 00       	mov    $0x1019ae,%edx
  100130:	be 17 00 00 00       	mov    $0x17,%esi
  100135:	bf 9e 19 10 00       	mov    $0x10199e,%edi
  10013a:	e8 05 02 00 00       	call   100344 <assert_fail>
    assert(array != NULL);
  10013f:	ba 90 19 10 00       	mov    $0x101990,%edx
  100144:	be 21 00 00 00       	mov    $0x21,%esi
  100149:	bf 9e 19 10 00       	mov    $0x10199e,%edi
  10014e:	e8 f1 01 00 00       	call   100344 <assert_fail>
    assert((uintptr_t)array % 8 == 0);
  100153:	ba ae 19 10 00       	mov    $0x1019ae,%edx
  100158:	be 22 00 00 00       	mov    $0x22,%esi
  10015d:	bf 9e 19 10 00       	mov    $0x10199e,%edi
  100162:	e8 dd 01 00 00       	call   100344 <assert_fail>
        assert(array[i] == i);
  100167:	ba c8 19 10 00       	mov    $0x1019c8,%edx
  10016c:	be 26 00 00 00       	mov    $0x26,%esi
  100171:	bf 9e 19 10 00       	mov    $0x10199e,%edi
  100176:	e8 c9 01 00 00       	call   100344 <assert_fail>
        assert(array2[i] == 0);
  10017b:	ba d6 19 10 00       	mov    $0x1019d6,%edx
  100180:	be 2e 00 00 00       	mov    $0x2e,%esi
  100185:	bf 9e 19 10 00       	mov    $0x10199e,%edi
  10018a:	e8 b5 01 00 00       	call   100344 <assert_fail>
    assert(heap_info(&info) == 0);
  10018f:	ba e5 19 10 00       	mov    $0x1019e5,%edx
  100194:	be 32 00 00 00       	mov    $0x32,%esi
  100199:	bf 9e 19 10 00       	mov    $0x10199e,%edi
  10019e:	e8 a1 01 00 00       	call   100344 <assert_fail>
    }

    // free array, array2
    free(array);
  1001a3:	4c 89 e7             	mov    %r12,%rdi
  1001a6:	e8 45 04 00 00       	call   1005f0 <free>
    free(array2);
  1001ab:	4c 89 ef             	mov    %r13,%rdi
  1001ae:	e8 3d 04 00 00       	call   1005f0 <free>
  1001b3:	41 bc 00 01 00 00    	mov    $0x100,%r12d
/* rdtscp */
static uint64_t rdtsc(void) {
	uint64_t var;
	uint32_t hi, lo;

	__asm volatile
  1001b9:	0f 31                	rdtsc  
    int total_pages = 0;

    // allocate pages till no more memory
    for(int i = 0; i < 256; ++i) {
        uint64_t time = rdtsc();
        void * ptr = malloc(PAGESIZE);
  1001bb:	bf 00 10 00 00       	mov    $0x1000,%edi
  1001c0:	e8 67 04 00 00       	call   10062c <malloc>
  1001c5:	48 89 c1             	mov    %rax,%rcx
  1001c8:	0f 31                	rdtsc  
        total_time += (rdtsc() - time);

        if(ptr == NULL) break;
  1001ca:	48 85 c9             	test   %rcx,%rcx
  1001cd:	74 08                	je     1001d7 <process_main+0x1d7>

        total_pages++;
        *((int *)ptr) = p; // check write access
  1001cf:	89 19                	mov    %ebx,(%rcx)
    for(int i = 0; i < 256; ++i) {
  1001d1:	41 83 ec 01          	sub    $0x1,%r12d
  1001d5:	75 e2                	jne    1001b9 <process_main+0x1b9>
    }


    TEST_PASS();
  1001d7:	bf fb 19 10 00       	mov    $0x1019fb,%edi
  1001dc:	b8 00 00 00 00       	mov    $0x0,%eax
  1001e1:	e8 90 00 00 00       	call   100276 <kernel_panic>

00000000001001e6 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  1001e6:	55                   	push   %rbp
  1001e7:	48 89 e5             	mov    %rsp,%rbp
  1001ea:	48 83 ec 50          	sub    $0x50,%rsp
  1001ee:	49 89 f2             	mov    %rsi,%r10
  1001f1:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  1001f5:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1001f9:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1001fd:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100201:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100206:	85 ff                	test   %edi,%edi
  100208:	78 2e                	js     100238 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  10020a:	48 63 ff             	movslq %edi,%rdi
  10020d:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100214:	cc cc cc 
  100217:	48 89 f8             	mov    %rdi,%rax
  10021a:	48 f7 e2             	mul    %rdx
  10021d:	48 89 d0             	mov    %rdx,%rax
  100220:	48 c1 e8 02          	shr    $0x2,%rax
  100224:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  100228:	48 01 c2             	add    %rax,%rdx
  10022b:	48 29 d7             	sub    %rdx,%rdi
  10022e:	0f b6 b7 75 1a 10 00 	movzbl 0x101a75(%rdi),%esi
  100235:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  100238:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  10023f:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100243:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100247:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10024b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  10024f:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100253:	4c 89 d2             	mov    %r10,%rdx
  100256:	8b 3d a0 8d fb ff    	mov    -0x47260(%rip),%edi        # b8ffc <cursorpos>
  10025c:	e8 20 15 00 00       	call   101781 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100261:	3d 30 07 00 00       	cmp    $0x730,%eax
  100266:	ba 00 00 00 00       	mov    $0x0,%edx
  10026b:	0f 4d c2             	cmovge %edx,%eax
  10026e:	89 05 88 8d fb ff    	mov    %eax,-0x47278(%rip)        # b8ffc <cursorpos>
    }
}
  100274:	c9                   	leave  
  100275:	c3                   	ret    

0000000000100276 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  100276:	55                   	push   %rbp
  100277:	48 89 e5             	mov    %rsp,%rbp
  10027a:	53                   	push   %rbx
  10027b:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100282:	48 89 fb             	mov    %rdi,%rbx
  100285:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100289:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  10028d:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100291:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100295:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100299:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  1002a0:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1002a4:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  1002a8:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  1002ac:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  1002b0:	ba 07 00 00 00       	mov    $0x7,%edx
  1002b5:	be 42 1a 10 00       	mov    $0x101a42,%esi
  1002ba:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  1002c1:	e8 72 06 00 00       	call   100938 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  1002c6:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  1002ca:	48 89 da             	mov    %rbx,%rdx
  1002cd:	be 99 00 00 00       	mov    $0x99,%esi
  1002d2:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  1002d9:	e8 af 15 00 00       	call   10188d <vsnprintf>
  1002de:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  1002e1:	85 d2                	test   %edx,%edx
  1002e3:	7e 0f                	jle    1002f4 <kernel_panic+0x7e>
  1002e5:	83 c0 06             	add    $0x6,%eax
  1002e8:	48 98                	cltq   
  1002ea:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  1002f1:	0a 
  1002f2:	75 2a                	jne    10031e <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  1002f4:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  1002fb:	48 89 d9             	mov    %rbx,%rcx
  1002fe:	ba 4c 1a 10 00       	mov    $0x101a4c,%edx
  100303:	be 00 c0 00 00       	mov    $0xc000,%esi
  100308:	bf 30 07 00 00       	mov    $0x730,%edi
  10030d:	b8 00 00 00 00       	mov    $0x0,%eax
  100312:	e8 d6 14 00 00       	call   1017ed <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  100317:	48 89 df             	mov    %rbx,%rdi
  10031a:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  10031c:	eb fe                	jmp    10031c <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  10031e:	48 63 c2             	movslq %edx,%rax
  100321:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100327:	0f 94 c2             	sete   %dl
  10032a:	0f b6 d2             	movzbl %dl,%edx
  10032d:	48 29 d0             	sub    %rdx,%rax
  100330:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100337:	ff 
  100338:	be 4a 1a 10 00       	mov    $0x101a4a,%esi
  10033d:	e8 a3 07 00 00       	call   100ae5 <strcpy>
  100342:	eb b0                	jmp    1002f4 <kernel_panic+0x7e>

0000000000100344 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100344:	55                   	push   %rbp
  100345:	48 89 e5             	mov    %rsp,%rbp
  100348:	48 89 f9             	mov    %rdi,%rcx
  10034b:	41 89 f0             	mov    %esi,%r8d
  10034e:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100351:	ba 50 1a 10 00       	mov    $0x101a50,%edx
  100356:	be 00 c0 00 00       	mov    $0xc000,%esi
  10035b:	bf 30 07 00 00       	mov    $0x730,%edi
  100360:	b8 00 00 00 00       	mov    $0x0,%eax
  100365:	e8 83 14 00 00       	call   1017ed <console_printf>
    asm volatile ("int %0" : /* no result */
  10036a:	bf 00 00 00 00       	mov    $0x0,%edi
  10036f:	cd 30                	int    $0x30
 loop: goto loop;
  100371:	eb fe                	jmp    100371 <assert_fail+0x2d>

0000000000100373 <append_list>:
elt * alloc_tail = NULL;
int free_list_size = 0;
int alloc_list_size = 0;

void append_list (elt * node, size_t size, int free) {
    node->size = size;
  100373:	48 89 37             	mov    %rsi,(%rdi)
    node->next = NULL;
  100376:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  10037d:	00 
    if(free) {
  10037e:	85 d2                	test   %edx,%edx
  100380:	74 40                	je     1003c2 <append_list+0x4f>
        if(free_head == NULL) {
  100382:	48 83 3d ae 1c 00 00 	cmpq   $0x0,0x1cae(%rip)        # 102038 <free_head>
  100389:	00 
  10038a:	74 1e                	je     1003aa <append_list+0x37>
            free_head = node;
            free_tail = node;
            node->prev = NULL;
        } else {
            free_tail->next = node;
  10038c:	48 8b 05 9d 1c 00 00 	mov    0x1c9d(%rip),%rax        # 102030 <free_tail>
  100393:	48 89 78 18          	mov    %rdi,0x18(%rax)
            node->prev = free_tail;
  100397:	48 89 47 10          	mov    %rax,0x10(%rdi)
            free_tail = node;
  10039b:	48 89 3d 8e 1c 00 00 	mov    %rdi,0x1c8e(%rip)        # 102030 <free_tail>
        }
        free_list_size++;
  1003a2:	83 05 73 1c 00 00 01 	addl   $0x1,0x1c73(%rip)        # 10201c <free_list_size>
  1003a9:	c3                   	ret    
            free_head = node;
  1003aa:	48 89 3d 87 1c 00 00 	mov    %rdi,0x1c87(%rip)        # 102038 <free_head>
            free_tail = node;
  1003b1:	48 89 3d 78 1c 00 00 	mov    %rdi,0x1c78(%rip)        # 102030 <free_tail>
            node->prev = NULL;
  1003b8:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  1003bf:	00 
  1003c0:	eb e0                	jmp    1003a2 <append_list+0x2f>
    } else {
        if(alloc_head == NULL) {
  1003c2:	48 83 3d 5e 1c 00 00 	cmpq   $0x0,0x1c5e(%rip)        # 102028 <alloc_head>
  1003c9:	00 
  1003ca:	74 1e                	je     1003ea <append_list+0x77>
            alloc_head = node;
            alloc_tail = node;
            node->prev = NULL;
        } else {
            alloc_tail->next = node;
  1003cc:	48 8b 05 4d 1c 00 00 	mov    0x1c4d(%rip),%rax        # 102020 <alloc_tail>
  1003d3:	48 89 78 18          	mov    %rdi,0x18(%rax)
            node->prev = alloc_tail;
  1003d7:	48 89 47 10          	mov    %rax,0x10(%rdi)
            alloc_tail = node;
  1003db:	48 89 3d 3e 1c 00 00 	mov    %rdi,0x1c3e(%rip)        # 102020 <alloc_tail>
        }
        alloc_list_size++;
  1003e2:	83 05 2f 1c 00 00 01 	addl   $0x1,0x1c2f(%rip)        # 102018 <alloc_list_size>
    }
}
  1003e9:	c3                   	ret    
            alloc_head = node;
  1003ea:	48 89 3d 37 1c 00 00 	mov    %rdi,0x1c37(%rip)        # 102028 <alloc_head>
            alloc_tail = node;
  1003f1:	48 89 3d 28 1c 00 00 	mov    %rdi,0x1c28(%rip)        # 102020 <alloc_tail>
            node->prev = NULL;
  1003f8:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  1003ff:	00 
  100400:	eb e0                	jmp    1003e2 <append_list+0x6f>

0000000000100402 <append_list_ordered>:

void append_list_ordered (elt * node, size_t size, size_t alloc_bytes, int free) {
    node->size = size;
  100402:	48 89 37             	mov    %rsi,(%rdi)
    if(free) {
  100405:	85 c9                	test   %ecx,%ecx
  100407:	0f 84 9c 00 00 00    	je     1004a9 <append_list_ordered+0xa7>
        uintptr_t node_addr = (uintptr_t) node;
        free_list_size++;
  10040d:	83 05 08 1c 00 00 01 	addl   $0x1,0x1c08(%rip)        # 10201c <free_list_size>
        if(free_head == NULL) { // list is empty
  100414:	48 8b 15 1d 1c 00 00 	mov    0x1c1d(%rip),%rdx        # 102038 <free_head>
  10041b:	48 85 d2             	test   %rdx,%rdx
  10041e:	74 3a                	je     10045a <append_list_ordered+0x58>
            free_head = node;
            free_tail = node;
            node->prev = NULL;
            node->next = NULL;
            return;
        } else if (node_addr < (uintptr_t) free_head) { // insert at list head
  100420:	48 39 d7             	cmp    %rdx,%rdi
  100423:	72 54                	jb     100479 <append_list_ordered+0x77>
            free_head->prev = node;
            free_head = node;
            return;
        } else { // insert in ascending order of address
            elt * p1 = free_head;
            elt * p2 = p1->next;
  100425:	48 8b 42 18          	mov    0x18(%rdx),%rax
            while(p2 != NULL) {
  100429:	48 85 c0             	test   %rax,%rax
  10042c:	74 63                	je     100491 <append_list_ordered+0x8f>
                if((node_addr >= ((uintptr_t) p1)) && (node_addr < ((uintptr_t) p2))) {
  10042e:	48 39 c7             	cmp    %rax,%rdi
  100431:	72 16                	jb     100449 <append_list_ordered+0x47>
                    p1->next = node;
                    p2->prev = node;
                    return;
                }
                p1 = p2;
                p2 = p2->next;
  100433:	48 89 c2             	mov    %rax,%rdx
  100436:	48 8b 40 18          	mov    0x18(%rax),%rax
            while(p2 != NULL) {
  10043a:	48 85 c0             	test   %rax,%rax
  10043d:	74 52                	je     100491 <append_list_ordered+0x8f>
                if((node_addr >= ((uintptr_t) p1)) && (node_addr < ((uintptr_t) p2))) {
  10043f:	48 39 d7             	cmp    %rdx,%rdi
  100442:	72 ef                	jb     100433 <append_list_ordered+0x31>
  100444:	48 39 c7             	cmp    %rax,%rdi
  100447:	73 ea                	jae    100433 <append_list_ordered+0x31>
                    node->prev = p1;
  100449:	48 89 57 10          	mov    %rdx,0x10(%rdi)
                    node->next = p2;
  10044d:	48 89 47 18          	mov    %rax,0x18(%rdi)
                    p1->next = node;
  100451:	48 89 7a 18          	mov    %rdi,0x18(%rdx)
                    p2->prev = node;
  100455:	48 89 78 10          	mov    %rdi,0x10(%rax)
                    return;
  100459:	c3                   	ret    
            free_head = node;
  10045a:	48 89 3d d7 1b 00 00 	mov    %rdi,0x1bd7(%rip)        # 102038 <free_head>
            free_tail = node;
  100461:	48 89 3d c8 1b 00 00 	mov    %rdi,0x1bc8(%rip)        # 102030 <free_tail>
            node->prev = NULL;
  100468:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  10046f:	00 
            node->next = NULL;
  100470:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  100477:	00 
            return;
  100478:	c3                   	ret    
            node->prev = NULL;
  100479:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  100480:	00 
            node->next = free_head;
  100481:	48 89 57 18          	mov    %rdx,0x18(%rdi)
            free_head->prev = node;
  100485:	48 89 7a 10          	mov    %rdi,0x10(%rdx)
            free_head = node;
  100489:	48 89 3d a8 1b 00 00 	mov    %rdi,0x1ba8(%rip)        # 102038 <free_head>
            return;
  100490:	c3                   	ret    
            }
            // last elt in list
            p1->next = node;
  100491:	48 89 7a 18          	mov    %rdi,0x18(%rdx)
            node->prev = p1;
  100495:	48 89 57 10          	mov    %rdx,0x10(%rdi)
            node->next = NULL;
  100499:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  1004a0:	00 
            free_tail = node;
  1004a1:	48 89 3d 88 1b 00 00 	mov    %rdi,0x1b88(%rip)        # 102030 <free_tail>
            return;
  1004a8:	c3                   	ret    
        }
    } else {
        alloc_list_size++;
  1004a9:	83 05 68 1b 00 00 01 	addl   $0x1,0x1b68(%rip)        # 102018 <alloc_list_size>
        node->alloc_bytes = alloc_bytes;
  1004b0:	48 89 57 08          	mov    %rdx,0x8(%rdi)
        if(alloc_head == NULL) {
  1004b4:	48 8b 35 6d 1b 00 00 	mov    0x1b6d(%rip),%rsi        # 102028 <alloc_head>
  1004bb:	48 85 f6             	test   %rsi,%rsi
  1004be:	74 2a                	je     1004ea <append_list_ordered+0xe8>
            alloc_head = node;
            alloc_tail = node;
            node->prev = NULL;
            node->next = NULL;
            return;
        } else if(alloc_bytes > alloc_head->alloc_bytes) {
  1004c0:	48 39 56 08          	cmp    %rdx,0x8(%rsi)
  1004c4:	72 43                	jb     100509 <append_list_ordered+0x107>
            alloc_head->prev = node;
            alloc_head = node;
            return;
        } else {
            elt * a1 = alloc_head;
            elt * a2 = a1->next;
  1004c6:	48 8b 46 18          	mov    0x18(%rsi),%rax
            while(a2 != NULL) {
  1004ca:	48 85 c0             	test   %rax,%rax
  1004cd:	75 61                	jne    100530 <append_list_ordered+0x12e>
            elt * a1 = alloc_head;
  1004cf:	48 89 f0             	mov    %rsi,%rax
                    return;
                }
                a1 = a2;
                a2 = a2->next;
            }
            a1->next = node;
  1004d2:	48 89 78 18          	mov    %rdi,0x18(%rax)
            node->prev = a1;
  1004d6:	48 89 47 10          	mov    %rax,0x10(%rdi)
            node->next = NULL;
  1004da:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  1004e1:	00 
            alloc_tail = node;
  1004e2:	48 89 3d 37 1b 00 00 	mov    %rdi,0x1b37(%rip)        # 102020 <alloc_tail>
            return;
        }
        return;
    }
}
  1004e9:	c3                   	ret    
            alloc_head = node;
  1004ea:	48 89 3d 37 1b 00 00 	mov    %rdi,0x1b37(%rip)        # 102028 <alloc_head>
            alloc_tail = node;
  1004f1:	48 89 3d 28 1b 00 00 	mov    %rdi,0x1b28(%rip)        # 102020 <alloc_tail>
            node->prev = NULL;
  1004f8:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  1004ff:	00 
            node->next = NULL;
  100500:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  100507:	00 
            return;
  100508:	c3                   	ret    
            node->prev = NULL;
  100509:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  100510:	00 
            node->next = alloc_head;
  100511:	48 89 77 18          	mov    %rsi,0x18(%rdi)
            alloc_head->prev = node;
  100515:	48 89 7e 10          	mov    %rdi,0x10(%rsi)
            alloc_head = node;
  100519:	48 89 3d 08 1b 00 00 	mov    %rdi,0x1b08(%rip)        # 102028 <alloc_head>
            return;
  100520:	c3                   	ret    
                a2 = a2->next;
  100521:	48 8b 48 18          	mov    0x18(%rax),%rcx
            while(a2 != NULL) {
  100525:	48 89 c6             	mov    %rax,%rsi
  100528:	48 85 c9             	test   %rcx,%rcx
  10052b:	74 a5                	je     1004d2 <append_list_ordered+0xd0>
                a2 = a2->next;
  10052d:	48 89 c8             	mov    %rcx,%rax
                if(alloc_bytes <= a1->alloc_bytes && alloc_bytes > a2->alloc_bytes) {
  100530:	48 39 56 08          	cmp    %rdx,0x8(%rsi)
  100534:	72 eb                	jb     100521 <append_list_ordered+0x11f>
  100536:	48 39 50 08          	cmp    %rdx,0x8(%rax)
  10053a:	73 e5                	jae    100521 <append_list_ordered+0x11f>
                    node->prev = a1;
  10053c:	48 89 77 10          	mov    %rsi,0x10(%rdi)
                    node->next = a2;
  100540:	48 89 47 18          	mov    %rax,0x18(%rdi)
                    a1->next = node;
  100544:	48 89 7e 18          	mov    %rdi,0x18(%rsi)
                    a2->prev = node;
  100548:	48 89 78 10          	mov    %rdi,0x10(%rax)
                    return;
  10054c:	c3                   	ret    

000000000010054d <remove_list>:

void remove_list (elt * node, int free) {
    elt * prev = node->prev;
  10054d:	48 8b 57 10          	mov    0x10(%rdi),%rdx
    elt * next = node->next;
  100551:	48 8b 47 18          	mov    0x18(%rdi),%rax
    if(free) {
  100555:	85 f6                	test   %esi,%esi
  100557:	74 3e                	je     100597 <remove_list+0x4a>
        if(node == free_head) {
  100559:	48 39 3d d8 1a 00 00 	cmp    %rdi,0x1ad8(%rip)        # 102038 <free_head>
  100560:	74 23                	je     100585 <remove_list+0x38>
            free_head = node->next;
        }
        if(node == free_tail) {
  100562:	48 39 3d c7 1a 00 00 	cmp    %rdi,0x1ac7(%rip)        # 102030 <free_tail>
  100569:	74 23                	je     10058e <remove_list+0x41>
            free_tail = prev;
        }
        if(prev) {
  10056b:	48 85 d2             	test   %rdx,%rdx
  10056e:	74 04                	je     100574 <remove_list+0x27>
            prev->next = next;
  100570:	48 89 42 18          	mov    %rax,0x18(%rdx)
        }
        if(next) {
  100574:	48 85 c0             	test   %rax,%rax
  100577:	74 04                	je     10057d <remove_list+0x30>
            next->prev = prev;
  100579:	48 89 50 10          	mov    %rdx,0x10(%rax)
        }
        free_list_size--;
  10057d:	83 2d 98 1a 00 00 01 	subl   $0x1,0x1a98(%rip)        # 10201c <free_list_size>
        return;
  100584:	c3                   	ret    
            free_head = node->next;
  100585:	48 89 05 ac 1a 00 00 	mov    %rax,0x1aac(%rip)        # 102038 <free_head>
  10058c:	eb d4                	jmp    100562 <remove_list+0x15>
            free_tail = prev;
  10058e:	48 89 15 9b 1a 00 00 	mov    %rdx,0x1a9b(%rip)        # 102030 <free_tail>
  100595:	eb d4                	jmp    10056b <remove_list+0x1e>
    } else {
        if(node == alloc_head) {
  100597:	48 39 3d 8a 1a 00 00 	cmp    %rdi,0x1a8a(%rip)        # 102028 <alloc_head>
  10059e:	74 23                	je     1005c3 <remove_list+0x76>
            alloc_head = node->next;
        }
        if(node == alloc_tail) {
  1005a0:	48 39 3d 79 1a 00 00 	cmp    %rdi,0x1a79(%rip)        # 102020 <alloc_tail>
  1005a7:	74 23                	je     1005cc <remove_list+0x7f>
            alloc_tail = prev;
        }
        if(prev) {
  1005a9:	48 85 d2             	test   %rdx,%rdx
  1005ac:	74 04                	je     1005b2 <remove_list+0x65>
            prev->next = next;
  1005ae:	48 89 42 18          	mov    %rax,0x18(%rdx)
        }
        if(next) {
  1005b2:	48 85 c0             	test   %rax,%rax
  1005b5:	74 04                	je     1005bb <remove_list+0x6e>
            next->prev = prev;
  1005b7:	48 89 50 10          	mov    %rdx,0x10(%rax)
        }
        alloc_list_size--;
  1005bb:	83 2d 56 1a 00 00 01 	subl   $0x1,0x1a56(%rip)        # 102018 <alloc_list_size>
        return;
    }
}
  1005c2:	c3                   	ret    
            alloc_head = node->next;
  1005c3:	48 89 05 5e 1a 00 00 	mov    %rax,0x1a5e(%rip)        # 102028 <alloc_head>
  1005ca:	eb d4                	jmp    1005a0 <remove_list+0x53>
            alloc_tail = prev;
  1005cc:	48 89 15 4d 1a 00 00 	mov    %rdx,0x1a4d(%rip)        # 102020 <alloc_tail>
  1005d3:	eb d4                	jmp    1005a9 <remove_list+0x5c>

00000000001005d5 <search_free>:

elt * search_free (size_t size) {
    elt * p = free_head;
  1005d5:	48 8b 05 5c 1a 00 00 	mov    0x1a5c(%rip),%rax        # 102038 <free_head>
    while(p != NULL) {
  1005dc:	48 85 c0             	test   %rax,%rax
  1005df:	74 0e                	je     1005ef <search_free+0x1a>
        // is free node big enough?
        if(p->size >= size) {
  1005e1:	48 39 38             	cmp    %rdi,(%rax)
  1005e4:	73 09                	jae    1005ef <search_free+0x1a>
            return p;
        }
        p = p->next;
  1005e6:	48 8b 40 18          	mov    0x18(%rax),%rax
    while(p != NULL) {
  1005ea:	48 85 c0             	test   %rax,%rax
  1005ed:	75 f2                	jne    1005e1 <search_free+0xc>
    }
    return NULL;
}
  1005ef:	c3                   	ret    

00000000001005f0 <free>:

void free(void *firstbyte) {
    if(firstbyte == NULL) {
  1005f0:	48 85 ff             	test   %rdi,%rdi
  1005f3:	74 36                	je     10062b <free+0x3b>
void free(void *firstbyte) {
  1005f5:	55                   	push   %rbp
  1005f6:	48 89 e5             	mov    %rsp,%rbp
  1005f9:	41 54                	push   %r12
  1005fb:	53                   	push   %rbx
  1005fc:	48 89 fb             	mov    %rdi,%rbx
        return;
    }
    elt* entire_block = (elt *) ((uintptr_t) firstbyte - HEADER);
  1005ff:	4c 8d 67 e0          	lea    -0x20(%rdi),%r12
    remove_list(entire_block, 0);
  100603:	be 00 00 00 00       	mov    $0x0,%esi
  100608:	4c 89 e7             	mov    %r12,%rdi
  10060b:	e8 3d ff ff ff       	call   10054d <remove_list>
    append_list_ordered(entire_block, entire_block->size, 0, 1);
  100610:	48 8b 73 e0          	mov    -0x20(%rbx),%rsi
  100614:	b9 01 00 00 00       	mov    $0x1,%ecx
  100619:	ba 00 00 00 00       	mov    $0x0,%edx
  10061e:	4c 89 e7             	mov    %r12,%rdi
  100621:	e8 dc fd ff ff       	call   100402 <append_list_ordered>
    return;
}
  100626:	5b                   	pop    %rbx
  100627:	41 5c                	pop    %r12
  100629:	5d                   	pop    %rbp
  10062a:	c3                   	ret    
  10062b:	c3                   	ret    

000000000010062c <malloc>:

void *malloc(uint64_t numbytes) {
  10062c:	55                   	push   %rbp
  10062d:	48 89 e5             	mov    %rsp,%rbp
  100630:	41 57                	push   %r15
  100632:	41 56                	push   %r14
  100634:	41 55                	push   %r13
  100636:	41 54                	push   %r12
  100638:	53                   	push   %rbx
  100639:	48 83 ec 08          	sub    $0x8,%rsp
    if (numbytes == 0) {
        return NULL;
  10063d:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (numbytes == 0) {
  100642:	48 85 ff             	test   %rdi,%rdi
  100645:	74 64                	je     1006ab <malloc+0x7f>
  100647:	49 89 fc             	mov    %rdi,%r12
    }
    // required bytes: sizeof(header) + numbytes, then ROUNDUP(8)
    size_t required_size = ROUNDUP(HEADER + numbytes, 8);
  10064a:	4c 8d 6f 27          	lea    0x27(%rdi),%r13
  10064e:	49 83 e5 f8          	and    $0xfffffffffffffff8,%r13
    // search free list, grow heap if needed
    elt * p = search_free(required_size);
  100652:	4c 89 ef             	mov    %r13,%rdi
  100655:	e8 7b ff ff ff       	call   1005d5 <search_free>
  10065a:	48 89 c3             	mov    %rax,%rbx
    if(p == NULL) { // grow heap, search again
  10065d:	48 85 c0             	test   %rax,%rax
  100660:	74 5b                	je     1006bd <malloc+0x91>
        }
        elt * chunk = (elt *) chunk_ret;
        append_list_ordered(chunk, chunk_size, 0, 1);
        p = search_free(required_size);
    }
    size_t initial_free_block_size = p->size; // size of free block
  100662:	4c 8b 33             	mov    (%rbx),%r14
    uintptr_t alloc_start = (uintptr_t) p; // start of to-be-allocated block
  100665:	49 89 df             	mov    %rbx,%r15
    remove_list(p, 1); // remove the free block from free list, since we are allocating it
  100668:	be 01 00 00 00       	mov    $0x1,%esi
  10066d:	48 89 df             	mov    %rbx,%rdi
  100670:	e8 d8 fe ff ff       	call   10054d <remove_list>
    if(initial_free_block_size - required_size >= HEADER) { // free block split into alloc and free
  100675:	4c 89 f6             	mov    %r14,%rsi
  100678:	4c 29 ee             	sub    %r13,%rsi
  10067b:	48 83 fe 1f          	cmp    $0x1f,%rsi
  10067f:	76 7e                	jbe    1006ff <malloc+0xd3>
        elt * free_part = (elt *) (alloc_start + required_size);
  100681:	4a 8d 3c 2b          	lea    (%rbx,%r13,1),%rdi
        append_list_ordered(free_part, initial_free_block_size - required_size, 0, 1);
  100685:	b9 01 00 00 00       	mov    $0x1,%ecx
  10068a:	ba 00 00 00 00       	mov    $0x0,%edx
  10068f:	e8 6e fd ff ff       	call   100402 <append_list_ordered>
        append_list_ordered(p, required_size, numbytes, 0);
  100694:	b9 00 00 00 00       	mov    $0x0,%ecx
  100699:	4c 89 e2             	mov    %r12,%rdx
  10069c:	4c 89 ee             	mov    %r13,%rsi
  10069f:	48 89 df             	mov    %rbx,%rdi
  1006a2:	e8 5b fd ff ff       	call   100402 <append_list_ordered>
    } else { // add to alloc list w/ initial size, since we didn't split
        append_list_ordered(p, initial_free_block_size, numbytes, 0);
    }
    // return address of payload
    void * payload = (void *) (alloc_start + HEADER);
  1006a7:	49 8d 5f 20          	lea    0x20(%r15),%rbx
    return payload;
}
  1006ab:	48 89 d8             	mov    %rbx,%rax
  1006ae:	48 83 c4 08          	add    $0x8,%rsp
  1006b2:	5b                   	pop    %rbx
  1006b3:	41 5c                	pop    %r12
  1006b5:	41 5d                	pop    %r13
  1006b7:	41 5e                	pop    %r14
  1006b9:	41 5f                	pop    %r15
  1006bb:	5d                   	pop    %rbp
  1006bc:	c3                   	ret    
        size_t chunk_size = ROUNDUP(required_size, PAGESIZE * 4);
  1006bd:	49 8d b5 ff 3f 00 00 	lea    0x3fff(%r13),%rsi
  1006c4:	48 81 e6 00 c0 ff ff 	and    $0xffffffffffffc000,%rsi
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  1006cb:	48 89 f7             	mov    %rsi,%rdi
  1006ce:	cd 3a                	int    $0x3a
  1006d0:	48 89 c7             	mov    %rax,%rdi
  1006d3:	48 89 05 66 19 00 00 	mov    %rax,0x1966(%rip)        # 102040 <result.0>
        if(chunk_ret == (void *) -1) {
  1006da:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  1006de:	74 cb                	je     1006ab <malloc+0x7f>
        append_list_ordered(chunk, chunk_size, 0, 1);
  1006e0:	b9 01 00 00 00       	mov    $0x1,%ecx
  1006e5:	ba 00 00 00 00       	mov    $0x0,%edx
  1006ea:	e8 13 fd ff ff       	call   100402 <append_list_ordered>
        p = search_free(required_size);
  1006ef:	4c 89 ef             	mov    %r13,%rdi
  1006f2:	e8 de fe ff ff       	call   1005d5 <search_free>
  1006f7:	48 89 c3             	mov    %rax,%rbx
  1006fa:	e9 63 ff ff ff       	jmp    100662 <malloc+0x36>
        append_list_ordered(p, initial_free_block_size, numbytes, 0);
  1006ff:	b9 00 00 00 00       	mov    $0x0,%ecx
  100704:	4c 89 e2             	mov    %r12,%rdx
  100707:	4c 89 f6             	mov    %r14,%rsi
  10070a:	48 89 df             	mov    %rbx,%rdi
  10070d:	e8 f0 fc ff ff       	call   100402 <append_list_ordered>
  100712:	eb 93                	jmp    1006a7 <malloc+0x7b>

0000000000100714 <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
  100714:	55                   	push   %rbp
  100715:	48 89 e5             	mov    %rsp,%rbp
  100718:	41 54                	push   %r12
  10071a:	53                   	push   %rbx
    if(num == 0 || sz == 0) {
  10071b:	48 85 ff             	test   %rdi,%rdi
  10071e:	74 3e                	je     10075e <calloc+0x4a>
  100720:	48 85 f6             	test   %rsi,%rsi
  100723:	74 39                	je     10075e <calloc+0x4a>
        return NULL;
    }
    if(sz > ((uint64_t) -1) / num) {
        return NULL;
  100725:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    if(sz > ((uint64_t) -1) / num) {
  10072b:	48 89 f8             	mov    %rdi,%rax
  10072e:	48 f7 e6             	mul    %rsi
  100731:	70 23                	jo     100756 <calloc+0x42>
    }
    void * malloc_ret = malloc(num*sz);
  100733:	48 89 c3             	mov    %rax,%rbx
  100736:	48 89 c7             	mov    %rax,%rdi
  100739:	e8 ee fe ff ff       	call   10062c <malloc>
  10073e:	49 89 c4             	mov    %rax,%r12
    if(malloc_ret == NULL) {
  100741:	48 85 c0             	test   %rax,%rax
  100744:	74 10                	je     100756 <calloc+0x42>
        return NULL;
    }
    memset(malloc_ret, 0, num*sz);
  100746:	48 89 da             	mov    %rbx,%rdx
  100749:	be 00 00 00 00       	mov    $0x0,%esi
  10074e:	48 89 c7             	mov    %rax,%rdi
  100751:	e8 e0 02 00 00       	call   100a36 <memset>
    return malloc_ret;
}
  100756:	4c 89 e0             	mov    %r12,%rax
  100759:	5b                   	pop    %rbx
  10075a:	41 5c                	pop    %r12
  10075c:	5d                   	pop    %rbp
  10075d:	c3                   	ret    
        return NULL;
  10075e:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100764:	eb f0                	jmp    100756 <calloc+0x42>

0000000000100766 <realloc>:

void * realloc(void * ptr, uint64_t sz) {
  100766:	55                   	push   %rbp
  100767:	48 89 e5             	mov    %rsp,%rbp
  10076a:	41 55                	push   %r13
  10076c:	41 54                	push   %r12
  10076e:	53                   	push   %rbx
  10076f:	48 83 ec 08          	sub    $0x8,%rsp
  100773:	48 89 f3             	mov    %rsi,%rbx
    if(ptr == NULL) {
  100776:	48 85 ff             	test   %rdi,%rdi
  100779:	74 48                	je     1007c3 <realloc+0x5d>
  10077b:	49 89 fc             	mov    %rdi,%r12
        return malloc(sz);
    }
    if(sz == 0) {
  10077e:	48 85 f6             	test   %rsi,%rsi
  100781:	74 4d                	je     1007d0 <realloc+0x6a>
        free(ptr);
        return NULL;
    }
    void * new_payload = malloc(sz);
  100783:	48 89 f7             	mov    %rsi,%rdi
  100786:	e8 a1 fe ff ff       	call   10062c <malloc>
  10078b:	49 89 c5             	mov    %rax,%r13
    if(new_payload == NULL) {
  10078e:	48 85 c0             	test   %rax,%rax
  100791:	74 22                	je     1007b5 <realloc+0x4f>
    if(original_header->size < sz) {
        newsize = original_header->size;
    } else {
        newsize = sz;
    }
    memcpy(new_payload, ptr, newsize);
  100793:	49 8b 44 24 e0       	mov    -0x20(%r12),%rax
  100798:	48 39 c3             	cmp    %rax,%rbx
  10079b:	48 0f 46 c3          	cmovbe %rbx,%rax
  10079f:	48 89 c2             	mov    %rax,%rdx
  1007a2:	4c 89 e6             	mov    %r12,%rsi
  1007a5:	4c 89 ef             	mov    %r13,%rdi
  1007a8:	e8 8b 01 00 00       	call   100938 <memcpy>
    free(ptr);
  1007ad:	4c 89 e7             	mov    %r12,%rdi
  1007b0:	e8 3b fe ff ff       	call   1005f0 <free>
    return new_payload;
}
  1007b5:	4c 89 e8             	mov    %r13,%rax
  1007b8:	48 83 c4 08          	add    $0x8,%rsp
  1007bc:	5b                   	pop    %rbx
  1007bd:	41 5c                	pop    %r12
  1007bf:	41 5d                	pop    %r13
  1007c1:	5d                   	pop    %rbp
  1007c2:	c3                   	ret    
        return malloc(sz);
  1007c3:	48 89 f7             	mov    %rsi,%rdi
  1007c6:	e8 61 fe ff ff       	call   10062c <malloc>
  1007cb:	49 89 c5             	mov    %rax,%r13
  1007ce:	eb e5                	jmp    1007b5 <realloc+0x4f>
        free(ptr);
  1007d0:	e8 1b fe ff ff       	call   1005f0 <free>
        return NULL;
  1007d5:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  1007db:	eb d8                	jmp    1007b5 <realloc+0x4f>

00000000001007dd <defrag>:

void defrag() {
  1007dd:	55                   	push   %rbp
  1007de:	48 89 e5             	mov    %rsp,%rbp
  1007e1:	53                   	push   %rbx
  1007e2:	48 83 ec 08          	sub    $0x8,%rsp
    // change append function to insert free blocks by ascending order of address
    if(free_head == NULL) {
  1007e6:	48 8b 1d 4b 18 00 00 	mov    0x184b(%rip),%rbx        # 102038 <free_head>
  1007ed:	48 85 db             	test   %rbx,%rbx
  1007f0:	74 09                	je     1007fb <defrag+0x1e>
        return;
    }
    elt * p1 = free_head;
    elt * p2 = p1->next;
  1007f2:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    while(p2 != NULL) {
  1007f6:	48 85 ff             	test   %rdi,%rdi
  1007f9:	75 1f                	jne    10081a <defrag+0x3d>
            p1 = p2;
            p2 = p2->next;
        }
    }
    return;
}
  1007fb:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1007ff:	c9                   	leave  
  100800:	c3                   	ret    
            p1->size += p2->size;
  100801:	48 03 07             	add    (%rdi),%rax
  100804:	48 89 03             	mov    %rax,(%rbx)
            remove_list(p2, 1);
  100807:	be 01 00 00 00       	mov    $0x1,%esi
  10080c:	e8 3c fd ff ff       	call   10054d <remove_list>
            p2 = p1->next;
  100811:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    while(p2 != NULL) {
  100815:	48 85 ff             	test   %rdi,%rdi
  100818:	74 e1                	je     1007fb <defrag+0x1e>
        if(p2_addr - p1_addr == p1->size) { // coalesce
  10081a:	48 8b 03             	mov    (%rbx),%rax
  10081d:	48 89 fa             	mov    %rdi,%rdx
  100820:	48 29 da             	sub    %rbx,%rdx
  100823:	48 39 c2             	cmp    %rax,%rdx
  100826:	74 d9                	je     100801 <defrag+0x24>
            p2 = p2->next;
  100828:	48 89 fb             	mov    %rdi,%rbx
  10082b:	48 8b 7f 18          	mov    0x18(%rdi),%rdi
  10082f:	eb e4                	jmp    100815 <defrag+0x38>

0000000000100831 <heap_info>:

int heap_info(heap_info_struct * info) {
  100831:	55                   	push   %rbp
  100832:	48 89 e5             	mov    %rsp,%rbp
  100835:	41 55                	push   %r13
  100837:	41 54                	push   %r12
  100839:	53                   	push   %rbx
  10083a:	48 83 ec 08          	sub    $0x8,%rsp
  10083e:	48 89 fb             	mov    %rdi,%rbx
    // change append function to insert alloc'd blocks by descending order of size
    info->num_allocs = alloc_list_size;
  100841:	8b 0d d1 17 00 00    	mov    0x17d1(%rip),%ecx        # 102018 <alloc_list_size>
  100847:	89 0f                	mov    %ecx,(%rdi)

    elt * f1 = free_head;
  100849:	48 8b 05 e8 17 00 00 	mov    0x17e8(%rip),%rax        # 102038 <free_head>
    info->free_space = 0;
  100850:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
    info->largest_free_chunk = 0;
  100857:	c7 47 1c 00 00 00 00 	movl   $0x0,0x1c(%rdi)
    while (f1 != NULL) {
  10085e:	48 85 c0             	test   %rax,%rax
  100861:	75 2a                	jne    10088d <heap_info+0x5c>
            info->largest_free_chunk = (int) f1->size;
        }
        f1 = f1->next;
    }

    if(info->num_allocs == 0) {
  100863:	85 c9                	test   %ecx,%ecx
  100865:	75 39                	jne    1008a0 <heap_info+0x6f>
        info->size_array = NULL;
  100867:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  10086e:	00 
        info->ptr_array = NULL;
  10086f:	48 c7 43 10 00 00 00 	movq   $0x0,0x10(%rbx)
  100876:	00 
        x1 = x1->next;
    }
    info->size_array = size_array;
    info->ptr_array = ptr_array;
    return 0;
}
  100877:	89 c8                	mov    %ecx,%eax
  100879:	48 83 c4 08          	add    $0x8,%rsp
  10087d:	5b                   	pop    %rbx
  10087e:	41 5c                	pop    %r12
  100880:	41 5d                	pop    %r13
  100882:	5d                   	pop    %rbp
  100883:	c3                   	ret    
        f1 = f1->next;
  100884:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (f1 != NULL) {
  100888:	48 85 c0             	test   %rax,%rax
  10088b:	74 d6                	je     100863 <heap_info+0x32>
        info->free_space += f1->size;
  10088d:	48 8b 10             	mov    (%rax),%rdx
  100890:	01 53 18             	add    %edx,0x18(%rbx)
        if((int) f1->size >= info->largest_free_chunk) {
  100893:	48 8b 10             	mov    (%rax),%rdx
  100896:	3b 53 1c             	cmp    0x1c(%rbx),%edx
  100899:	7c e9                	jl     100884 <heap_info+0x53>
            info->largest_free_chunk = (int) f1->size;
  10089b:	89 53 1c             	mov    %edx,0x1c(%rbx)
  10089e:	eb e4                	jmp    100884 <heap_info+0x53>
    long * size_array = malloc(info->num_allocs * sizeof(long));
  1008a0:	48 63 c9             	movslq %ecx,%rcx
  1008a3:	48 8d 3c cd 00 00 00 	lea    0x0(,%rcx,8),%rdi
  1008aa:	00 
  1008ab:	e8 7c fd ff ff       	call   10062c <malloc>
  1008b0:	49 89 c4             	mov    %rax,%r12
    if(size_array == NULL) {
  1008b3:	48 85 c0             	test   %rax,%rax
  1008b6:	74 6c                	je     100924 <heap_info+0xf3>
    uintptr_t size_array_addr = (uintptr_t) size_array - HEADER;
  1008b8:	4c 8d 68 e0          	lea    -0x20(%rax),%r13
    void ** ptr_array = malloc(info->num_allocs * sizeof(void *));
  1008bc:	48 63 3b             	movslq (%rbx),%rdi
  1008bf:	48 c1 e7 03          	shl    $0x3,%rdi
  1008c3:	e8 64 fd ff ff       	call   10062c <malloc>
    if(ptr_array == NULL) {
  1008c8:	48 85 c0             	test   %rax,%rax
  1008cb:	74 61                	je     10092e <heap_info+0xfd>
    uintptr_t ptr_array_addr = (uintptr_t) ptr_array - HEADER;
  1008cd:	4c 8d 48 e0          	lea    -0x20(%rax),%r9
    elt * x1 = alloc_head;
  1008d1:	48 8b 15 50 17 00 00 	mov    0x1750(%rip),%rdx        # 102028 <alloc_head>
    while (x1 != NULL) {
  1008d8:	48 85 d2             	test   %rdx,%rdx
  1008db:	74 35                	je     100912 <heap_info+0xe1>
    int i = 0;
  1008dd:	be 00 00 00 00       	mov    $0x0,%esi
  1008e2:	eb 1f                	jmp    100903 <heap_info+0xd2>
            size_array[i] = (long) x1->alloc_bytes;
  1008e4:	48 63 fe             	movslq %esi,%rdi
  1008e7:	4c 8b 42 08          	mov    0x8(%rdx),%r8
  1008eb:	4d 89 04 fc          	mov    %r8,(%r12,%rdi,8)
            ptr_array[i] = (void *) ((uintptr_t) x1 + HEADER);
  1008ef:	48 83 c1 20          	add    $0x20,%rcx
  1008f3:	48 89 0c f8          	mov    %rcx,(%rax,%rdi,8)
            i++;
  1008f7:	83 c6 01             	add    $0x1,%esi
        x1 = x1->next;
  1008fa:	48 8b 52 18          	mov    0x18(%rdx),%rdx
    while (x1 != NULL) {
  1008fe:	48 85 d2             	test   %rdx,%rdx
  100901:	74 0f                	je     100912 <heap_info+0xe1>
        if(((uintptr_t) x1 != size_array_addr) && ((uintptr_t) x1 != ptr_array_addr)) {
  100903:	48 89 d1             	mov    %rdx,%rcx
  100906:	4c 39 ea             	cmp    %r13,%rdx
  100909:	74 ef                	je     1008fa <heap_info+0xc9>
  10090b:	4c 39 ca             	cmp    %r9,%rdx
  10090e:	75 d4                	jne    1008e4 <heap_info+0xb3>
  100910:	eb e8                	jmp    1008fa <heap_info+0xc9>
    info->size_array = size_array;
  100912:	4c 89 63 08          	mov    %r12,0x8(%rbx)
    info->ptr_array = ptr_array;
  100916:	48 89 43 10          	mov    %rax,0x10(%rbx)
    return 0;
  10091a:	b9 00 00 00 00       	mov    $0x0,%ecx
  10091f:	e9 53 ff ff ff       	jmp    100877 <heap_info+0x46>
        return -1;
  100924:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  100929:	e9 49 ff ff ff       	jmp    100877 <heap_info+0x46>
        return -1;
  10092e:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  100933:	e9 3f ff ff ff       	jmp    100877 <heap_info+0x46>

0000000000100938 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  100938:	55                   	push   %rbp
  100939:	48 89 e5             	mov    %rsp,%rbp
  10093c:	48 83 ec 28          	sub    $0x28,%rsp
  100940:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100944:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100948:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10094c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100950:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100954:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100958:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  10095c:	eb 1c                	jmp    10097a <memcpy+0x42>
        *d = *s;
  10095e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100962:	0f b6 10             	movzbl (%rax),%edx
  100965:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100969:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  10096b:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100970:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100975:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  10097a:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  10097f:	75 dd                	jne    10095e <memcpy+0x26>
    }
    return dst;
  100981:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100985:	c9                   	leave  
  100986:	c3                   	ret    

0000000000100987 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  100987:	55                   	push   %rbp
  100988:	48 89 e5             	mov    %rsp,%rbp
  10098b:	48 83 ec 28          	sub    $0x28,%rsp
  10098f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100993:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100997:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  10099b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  10099f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  1009a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1009a7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  1009ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009af:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  1009b3:	73 6a                	jae    100a1f <memmove+0x98>
  1009b5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  1009b9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1009bd:	48 01 d0             	add    %rdx,%rax
  1009c0:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  1009c4:	73 59                	jae    100a1f <memmove+0x98>
        s += n, d += n;
  1009c6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1009ca:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  1009ce:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1009d2:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  1009d6:	eb 17                	jmp    1009ef <memmove+0x68>
            *--d = *--s;
  1009d8:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  1009dd:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  1009e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009e6:	0f b6 10             	movzbl (%rax),%edx
  1009e9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1009ed:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  1009ef:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1009f3:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1009f7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  1009fb:	48 85 c0             	test   %rax,%rax
  1009fe:	75 d8                	jne    1009d8 <memmove+0x51>
    if (s < d && s + n > d) {
  100a00:	eb 2e                	jmp    100a30 <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  100a02:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  100a06:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100a0a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100a0e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100a12:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100a16:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  100a1a:	0f b6 12             	movzbl (%rdx),%edx
  100a1d:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  100a1f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  100a23:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  100a27:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  100a2b:	48 85 c0             	test   %rax,%rax
  100a2e:	75 d2                	jne    100a02 <memmove+0x7b>
        }
    }
    return dst;
  100a30:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100a34:	c9                   	leave  
  100a35:	c3                   	ret    

0000000000100a36 <memset>:

void* memset(void* v, int c, size_t n) {
  100a36:	55                   	push   %rbp
  100a37:	48 89 e5             	mov    %rsp,%rbp
  100a3a:	48 83 ec 28          	sub    $0x28,%rsp
  100a3e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100a42:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  100a45:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100a49:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100a4d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  100a51:	eb 15                	jmp    100a68 <memset+0x32>
        *p = c;
  100a53:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  100a56:	89 c2                	mov    %eax,%edx
  100a58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a5c:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100a5e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100a63:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  100a68:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  100a6d:	75 e4                	jne    100a53 <memset+0x1d>
    }
    return v;
  100a6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100a73:	c9                   	leave  
  100a74:	c3                   	ret    

0000000000100a75 <strlen>:

size_t strlen(const char* s) {
  100a75:	55                   	push   %rbp
  100a76:	48 89 e5             	mov    %rsp,%rbp
  100a79:	48 83 ec 18          	sub    $0x18,%rsp
  100a7d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  100a81:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100a88:	00 
  100a89:	eb 0a                	jmp    100a95 <strlen+0x20>
        ++n;
  100a8b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  100a90:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100a95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100a99:	0f b6 00             	movzbl (%rax),%eax
  100a9c:	84 c0                	test   %al,%al
  100a9e:	75 eb                	jne    100a8b <strlen+0x16>
    }
    return n;
  100aa0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100aa4:	c9                   	leave  
  100aa5:	c3                   	ret    

0000000000100aa6 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  100aa6:	55                   	push   %rbp
  100aa7:	48 89 e5             	mov    %rsp,%rbp
  100aaa:	48 83 ec 20          	sub    $0x20,%rsp
  100aae:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100ab2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100ab6:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  100abd:	00 
  100abe:	eb 0a                	jmp    100aca <strnlen+0x24>
        ++n;
  100ac0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100ac5:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  100aca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100ace:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  100ad2:	74 0b                	je     100adf <strnlen+0x39>
  100ad4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100ad8:	0f b6 00             	movzbl (%rax),%eax
  100adb:	84 c0                	test   %al,%al
  100add:	75 e1                	jne    100ac0 <strnlen+0x1a>
    }
    return n;
  100adf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  100ae3:	c9                   	leave  
  100ae4:	c3                   	ret    

0000000000100ae5 <strcpy>:

char* strcpy(char* dst, const char* src) {
  100ae5:	55                   	push   %rbp
  100ae6:	48 89 e5             	mov    %rsp,%rbp
  100ae9:	48 83 ec 20          	sub    $0x20,%rsp
  100aed:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100af1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  100af5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100af9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  100afd:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  100b01:	48 8d 42 01          	lea    0x1(%rdx),%rax
  100b05:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  100b09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b0d:	48 8d 48 01          	lea    0x1(%rax),%rcx
  100b11:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  100b15:	0f b6 12             	movzbl (%rdx),%edx
  100b18:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  100b1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b1e:	48 83 e8 01          	sub    $0x1,%rax
  100b22:	0f b6 00             	movzbl (%rax),%eax
  100b25:	84 c0                	test   %al,%al
  100b27:	75 d4                	jne    100afd <strcpy+0x18>
    return dst;
  100b29:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100b2d:	c9                   	leave  
  100b2e:	c3                   	ret    

0000000000100b2f <strcmp>:

int strcmp(const char* a, const char* b) {
  100b2f:	55                   	push   %rbp
  100b30:	48 89 e5             	mov    %rsp,%rbp
  100b33:	48 83 ec 10          	sub    $0x10,%rsp
  100b37:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100b3b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100b3f:	eb 0a                	jmp    100b4b <strcmp+0x1c>
        ++a, ++b;
  100b41:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  100b46:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  100b4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b4f:	0f b6 00             	movzbl (%rax),%eax
  100b52:	84 c0                	test   %al,%al
  100b54:	74 1d                	je     100b73 <strcmp+0x44>
  100b56:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100b5a:	0f b6 00             	movzbl (%rax),%eax
  100b5d:	84 c0                	test   %al,%al
  100b5f:	74 12                	je     100b73 <strcmp+0x44>
  100b61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b65:	0f b6 10             	movzbl (%rax),%edx
  100b68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100b6c:	0f b6 00             	movzbl (%rax),%eax
  100b6f:	38 c2                	cmp    %al,%dl
  100b71:	74 ce                	je     100b41 <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  100b73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b77:	0f b6 00             	movzbl (%rax),%eax
  100b7a:	89 c2                	mov    %eax,%edx
  100b7c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100b80:	0f b6 00             	movzbl (%rax),%eax
  100b83:	38 d0                	cmp    %dl,%al
  100b85:	0f 92 c0             	setb   %al
  100b88:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  100b8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b8f:	0f b6 00             	movzbl (%rax),%eax
  100b92:	89 c1                	mov    %eax,%ecx
  100b94:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100b98:	0f b6 00             	movzbl (%rax),%eax
  100b9b:	38 c1                	cmp    %al,%cl
  100b9d:	0f 92 c0             	setb   %al
  100ba0:	0f b6 c0             	movzbl %al,%eax
  100ba3:	29 c2                	sub    %eax,%edx
  100ba5:	89 d0                	mov    %edx,%eax
}
  100ba7:	c9                   	leave  
  100ba8:	c3                   	ret    

0000000000100ba9 <strchr>:

char* strchr(const char* s, int c) {
  100ba9:	55                   	push   %rbp
  100baa:	48 89 e5             	mov    %rsp,%rbp
  100bad:	48 83 ec 10          	sub    $0x10,%rsp
  100bb1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  100bb5:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  100bb8:	eb 05                	jmp    100bbf <strchr+0x16>
        ++s;
  100bba:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  100bbf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bc3:	0f b6 00             	movzbl (%rax),%eax
  100bc6:	84 c0                	test   %al,%al
  100bc8:	74 0e                	je     100bd8 <strchr+0x2f>
  100bca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bce:	0f b6 00             	movzbl (%rax),%eax
  100bd1:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100bd4:	38 d0                	cmp    %dl,%al
  100bd6:	75 e2                	jne    100bba <strchr+0x11>
    }
    if (*s == (char) c) {
  100bd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bdc:	0f b6 00             	movzbl (%rax),%eax
  100bdf:	8b 55 f4             	mov    -0xc(%rbp),%edx
  100be2:	38 d0                	cmp    %dl,%al
  100be4:	75 06                	jne    100bec <strchr+0x43>
        return (char*) s;
  100be6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100bea:	eb 05                	jmp    100bf1 <strchr+0x48>
    } else {
        return NULL;
  100bec:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  100bf1:	c9                   	leave  
  100bf2:	c3                   	ret    

0000000000100bf3 <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  100bf3:	55                   	push   %rbp
  100bf4:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  100bf7:	8b 05 4b 14 00 00    	mov    0x144b(%rip),%eax        # 102048 <rand_seed_set>
  100bfd:	85 c0                	test   %eax,%eax
  100bff:	75 0a                	jne    100c0b <rand+0x18>
        srand(819234718U);
  100c01:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  100c06:	e8 24 00 00 00       	call   100c2f <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100c0b:	8b 05 3b 14 00 00    	mov    0x143b(%rip),%eax        # 10204c <rand_seed>
  100c11:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  100c17:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100c1c:	89 05 2a 14 00 00    	mov    %eax,0x142a(%rip)        # 10204c <rand_seed>
    return rand_seed & RAND_MAX;
  100c22:	8b 05 24 14 00 00    	mov    0x1424(%rip),%eax        # 10204c <rand_seed>
  100c28:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100c2d:	5d                   	pop    %rbp
  100c2e:	c3                   	ret    

0000000000100c2f <srand>:

void srand(unsigned seed) {
  100c2f:	55                   	push   %rbp
  100c30:	48 89 e5             	mov    %rsp,%rbp
  100c33:	48 83 ec 08          	sub    $0x8,%rsp
  100c37:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  100c3a:	8b 45 fc             	mov    -0x4(%rbp),%eax
  100c3d:	89 05 09 14 00 00    	mov    %eax,0x1409(%rip)        # 10204c <rand_seed>
    rand_seed_set = 1;
  100c43:	c7 05 fb 13 00 00 01 	movl   $0x1,0x13fb(%rip)        # 102048 <rand_seed_set>
  100c4a:	00 00 00 
}
  100c4d:	90                   	nop
  100c4e:	c9                   	leave  
  100c4f:	c3                   	ret    

0000000000100c50 <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  100c50:	55                   	push   %rbp
  100c51:	48 89 e5             	mov    %rsp,%rbp
  100c54:	48 83 ec 28          	sub    $0x28,%rsp
  100c58:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  100c5c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  100c60:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  100c63:	48 c7 45 f8 60 1c 10 	movq   $0x101c60,-0x8(%rbp)
  100c6a:	00 
    if (base < 0) {
  100c6b:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  100c6f:	79 0b                	jns    100c7c <fill_numbuf+0x2c>
        digits = lower_digits;
  100c71:	48 c7 45 f8 80 1c 10 	movq   $0x101c80,-0x8(%rbp)
  100c78:	00 
        base = -base;
  100c79:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  100c7c:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100c81:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100c85:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  100c88:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100c8b:	48 63 c8             	movslq %eax,%rcx
  100c8e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100c92:	ba 00 00 00 00       	mov    $0x0,%edx
  100c97:	48 f7 f1             	div    %rcx
  100c9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100c9e:	48 01 d0             	add    %rdx,%rax
  100ca1:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  100ca6:	0f b6 10             	movzbl (%rax),%edx
  100ca9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  100cad:	88 10                	mov    %dl,(%rax)
        val /= base;
  100caf:	8b 45 dc             	mov    -0x24(%rbp),%eax
  100cb2:	48 63 f0             	movslq %eax,%rsi
  100cb5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100cb9:	ba 00 00 00 00       	mov    $0x0,%edx
  100cbe:	48 f7 f6             	div    %rsi
  100cc1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  100cc5:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  100cca:	75 bc                	jne    100c88 <fill_numbuf+0x38>
    return numbuf_end;
  100ccc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  100cd0:	c9                   	leave  
  100cd1:	c3                   	ret    

0000000000100cd2 <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100cd2:	55                   	push   %rbp
  100cd3:	48 89 e5             	mov    %rsp,%rbp
  100cd6:	53                   	push   %rbx
  100cd7:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  100cde:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  100ce5:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  100ceb:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100cf2:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  100cf9:	e9 8a 09 00 00       	jmp    101688 <printer_vprintf+0x9b6>
        if (*format != '%') {
  100cfe:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d05:	0f b6 00             	movzbl (%rax),%eax
  100d08:	3c 25                	cmp    $0x25,%al
  100d0a:	74 31                	je     100d3d <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  100d0c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d13:	4c 8b 00             	mov    (%rax),%r8
  100d16:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d1d:	0f b6 00             	movzbl (%rax),%eax
  100d20:	0f b6 c8             	movzbl %al,%ecx
  100d23:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  100d29:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  100d30:	89 ce                	mov    %ecx,%esi
  100d32:	48 89 c7             	mov    %rax,%rdi
  100d35:	41 ff d0             	call   *%r8
            continue;
  100d38:	e9 43 09 00 00       	jmp    101680 <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  100d3d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  100d44:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100d4b:	01 
  100d4c:	eb 44                	jmp    100d92 <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  100d4e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d55:	0f b6 00             	movzbl (%rax),%eax
  100d58:	0f be c0             	movsbl %al,%eax
  100d5b:	89 c6                	mov    %eax,%esi
  100d5d:	bf 80 1a 10 00       	mov    $0x101a80,%edi
  100d62:	e8 42 fe ff ff       	call   100ba9 <strchr>
  100d67:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  100d6b:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  100d70:	74 30                	je     100da2 <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  100d72:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100d76:	48 2d 80 1a 10 00    	sub    $0x101a80,%rax
  100d7c:	ba 01 00 00 00       	mov    $0x1,%edx
  100d81:	89 c1                	mov    %eax,%ecx
  100d83:	d3 e2                	shl    %cl,%edx
  100d85:	89 d0                	mov    %edx,%eax
  100d87:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  100d8a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100d91:	01 
  100d92:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100d99:	0f b6 00             	movzbl (%rax),%eax
  100d9c:	84 c0                	test   %al,%al
  100d9e:	75 ae                	jne    100d4e <printer_vprintf+0x7c>
  100da0:	eb 01                	jmp    100da3 <printer_vprintf+0xd1>
            } else {
                break;
  100da2:	90                   	nop
            }
        }

        // process width
        int width = -1;
  100da3:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  100daa:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100db1:	0f b6 00             	movzbl (%rax),%eax
  100db4:	3c 30                	cmp    $0x30,%al
  100db6:	7e 67                	jle    100e1f <printer_vprintf+0x14d>
  100db8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100dbf:	0f b6 00             	movzbl (%rax),%eax
  100dc2:	3c 39                	cmp    $0x39,%al
  100dc4:	7f 59                	jg     100e1f <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100dc6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  100dcd:	eb 2e                	jmp    100dfd <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  100dcf:	8b 55 e8             	mov    -0x18(%rbp),%edx
  100dd2:	89 d0                	mov    %edx,%eax
  100dd4:	c1 e0 02             	shl    $0x2,%eax
  100dd7:	01 d0                	add    %edx,%eax
  100dd9:	01 c0                	add    %eax,%eax
  100ddb:	89 c1                	mov    %eax,%ecx
  100ddd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100de4:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100de8:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100def:	0f b6 00             	movzbl (%rax),%eax
  100df2:	0f be c0             	movsbl %al,%eax
  100df5:	01 c8                	add    %ecx,%eax
  100df7:	83 e8 30             	sub    $0x30,%eax
  100dfa:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100dfd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e04:	0f b6 00             	movzbl (%rax),%eax
  100e07:	3c 2f                	cmp    $0x2f,%al
  100e09:	0f 8e 85 00 00 00    	jle    100e94 <printer_vprintf+0x1c2>
  100e0f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e16:	0f b6 00             	movzbl (%rax),%eax
  100e19:	3c 39                	cmp    $0x39,%al
  100e1b:	7e b2                	jle    100dcf <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  100e1d:	eb 75                	jmp    100e94 <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  100e1f:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100e26:	0f b6 00             	movzbl (%rax),%eax
  100e29:	3c 2a                	cmp    $0x2a,%al
  100e2b:	75 68                	jne    100e95 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  100e2d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e34:	8b 00                	mov    (%rax),%eax
  100e36:	83 f8 2f             	cmp    $0x2f,%eax
  100e39:	77 30                	ja     100e6b <printer_vprintf+0x199>
  100e3b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e42:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100e46:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e4d:	8b 00                	mov    (%rax),%eax
  100e4f:	89 c0                	mov    %eax,%eax
  100e51:	48 01 d0             	add    %rdx,%rax
  100e54:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e5b:	8b 12                	mov    (%rdx),%edx
  100e5d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100e60:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e67:	89 0a                	mov    %ecx,(%rdx)
  100e69:	eb 1a                	jmp    100e85 <printer_vprintf+0x1b3>
  100e6b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100e72:	48 8b 40 08          	mov    0x8(%rax),%rax
  100e76:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100e7a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100e81:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100e85:	8b 00                	mov    (%rax),%eax
  100e87:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  100e8a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100e91:	01 
  100e92:	eb 01                	jmp    100e95 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  100e94:	90                   	nop
        }

        // process precision
        int precision = -1;
  100e95:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  100e9c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ea3:	0f b6 00             	movzbl (%rax),%eax
  100ea6:	3c 2e                	cmp    $0x2e,%al
  100ea8:	0f 85 00 01 00 00    	jne    100fae <printer_vprintf+0x2dc>
            ++format;
  100eae:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100eb5:	01 
            if (*format >= '0' && *format <= '9') {
  100eb6:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ebd:	0f b6 00             	movzbl (%rax),%eax
  100ec0:	3c 2f                	cmp    $0x2f,%al
  100ec2:	7e 67                	jle    100f2b <printer_vprintf+0x259>
  100ec4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ecb:	0f b6 00             	movzbl (%rax),%eax
  100ece:	3c 39                	cmp    $0x39,%al
  100ed0:	7f 59                	jg     100f2b <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100ed2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  100ed9:	eb 2e                	jmp    100f09 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  100edb:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  100ede:	89 d0                	mov    %edx,%eax
  100ee0:	c1 e0 02             	shl    $0x2,%eax
  100ee3:	01 d0                	add    %edx,%eax
  100ee5:	01 c0                	add    %eax,%eax
  100ee7:	89 c1                	mov    %eax,%ecx
  100ee9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100ef0:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100ef4:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  100efb:	0f b6 00             	movzbl (%rax),%eax
  100efe:	0f be c0             	movsbl %al,%eax
  100f01:	01 c8                	add    %ecx,%eax
  100f03:	83 e8 30             	sub    $0x30,%eax
  100f06:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100f09:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f10:	0f b6 00             	movzbl (%rax),%eax
  100f13:	3c 2f                	cmp    $0x2f,%al
  100f15:	0f 8e 85 00 00 00    	jle    100fa0 <printer_vprintf+0x2ce>
  100f1b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f22:	0f b6 00             	movzbl (%rax),%eax
  100f25:	3c 39                	cmp    $0x39,%al
  100f27:	7e b2                	jle    100edb <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  100f29:	eb 75                	jmp    100fa0 <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  100f2b:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100f32:	0f b6 00             	movzbl (%rax),%eax
  100f35:	3c 2a                	cmp    $0x2a,%al
  100f37:	75 68                	jne    100fa1 <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  100f39:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f40:	8b 00                	mov    (%rax),%eax
  100f42:	83 f8 2f             	cmp    $0x2f,%eax
  100f45:	77 30                	ja     100f77 <printer_vprintf+0x2a5>
  100f47:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f4e:	48 8b 50 10          	mov    0x10(%rax),%rdx
  100f52:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f59:	8b 00                	mov    (%rax),%eax
  100f5b:	89 c0                	mov    %eax,%eax
  100f5d:	48 01 d0             	add    %rdx,%rax
  100f60:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f67:	8b 12                	mov    (%rdx),%edx
  100f69:	8d 4a 08             	lea    0x8(%rdx),%ecx
  100f6c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f73:	89 0a                	mov    %ecx,(%rdx)
  100f75:	eb 1a                	jmp    100f91 <printer_vprintf+0x2bf>
  100f77:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  100f7e:	48 8b 40 08          	mov    0x8(%rax),%rax
  100f82:	48 8d 48 08          	lea    0x8(%rax),%rcx
  100f86:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  100f8d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  100f91:	8b 00                	mov    (%rax),%eax
  100f93:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  100f96:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100f9d:	01 
  100f9e:	eb 01                	jmp    100fa1 <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  100fa0:	90                   	nop
            }
            if (precision < 0) {
  100fa1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  100fa5:	79 07                	jns    100fae <printer_vprintf+0x2dc>
                precision = 0;
  100fa7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  100fae:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  100fb5:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  100fbc:	00 
        int length = 0;
  100fbd:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  100fc4:	48 c7 45 c8 86 1a 10 	movq   $0x101a86,-0x38(%rbp)
  100fcb:	00 
    again:
        switch (*format) {
  100fcc:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  100fd3:	0f b6 00             	movzbl (%rax),%eax
  100fd6:	0f be c0             	movsbl %al,%eax
  100fd9:	83 e8 43             	sub    $0x43,%eax
  100fdc:	83 f8 37             	cmp    $0x37,%eax
  100fdf:	0f 87 9f 03 00 00    	ja     101384 <printer_vprintf+0x6b2>
  100fe5:	89 c0                	mov    %eax,%eax
  100fe7:	48 8b 04 c5 98 1a 10 	mov    0x101a98(,%rax,8),%rax
  100fee:	00 
  100fef:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  100ff1:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  100ff8:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  100fff:	01 
            goto again;
  101000:	eb ca                	jmp    100fcc <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  101002:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  101006:	74 5d                	je     101065 <printer_vprintf+0x393>
  101008:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10100f:	8b 00                	mov    (%rax),%eax
  101011:	83 f8 2f             	cmp    $0x2f,%eax
  101014:	77 30                	ja     101046 <printer_vprintf+0x374>
  101016:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10101d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101021:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101028:	8b 00                	mov    (%rax),%eax
  10102a:	89 c0                	mov    %eax,%eax
  10102c:	48 01 d0             	add    %rdx,%rax
  10102f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101036:	8b 12                	mov    (%rdx),%edx
  101038:	8d 4a 08             	lea    0x8(%rdx),%ecx
  10103b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101042:	89 0a                	mov    %ecx,(%rdx)
  101044:	eb 1a                	jmp    101060 <printer_vprintf+0x38e>
  101046:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10104d:	48 8b 40 08          	mov    0x8(%rax),%rax
  101051:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101055:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10105c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101060:	48 8b 00             	mov    (%rax),%rax
  101063:	eb 5c                	jmp    1010c1 <printer_vprintf+0x3ef>
  101065:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10106c:	8b 00                	mov    (%rax),%eax
  10106e:	83 f8 2f             	cmp    $0x2f,%eax
  101071:	77 30                	ja     1010a3 <printer_vprintf+0x3d1>
  101073:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10107a:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10107e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101085:	8b 00                	mov    (%rax),%eax
  101087:	89 c0                	mov    %eax,%eax
  101089:	48 01 d0             	add    %rdx,%rax
  10108c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101093:	8b 12                	mov    (%rdx),%edx
  101095:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101098:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10109f:	89 0a                	mov    %ecx,(%rdx)
  1010a1:	eb 1a                	jmp    1010bd <printer_vprintf+0x3eb>
  1010a3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1010aa:	48 8b 40 08          	mov    0x8(%rax),%rax
  1010ae:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1010b2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1010b9:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1010bd:	8b 00                	mov    (%rax),%eax
  1010bf:	48 98                	cltq   
  1010c1:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  1010c5:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1010c9:	48 c1 f8 38          	sar    $0x38,%rax
  1010cd:	25 80 00 00 00       	and    $0x80,%eax
  1010d2:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  1010d5:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  1010d9:	74 09                	je     1010e4 <printer_vprintf+0x412>
  1010db:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1010df:	48 f7 d8             	neg    %rax
  1010e2:	eb 04                	jmp    1010e8 <printer_vprintf+0x416>
  1010e4:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  1010e8:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  1010ec:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  1010ef:	83 c8 60             	or     $0x60,%eax
  1010f2:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  1010f5:	e9 cf 02 00 00       	jmp    1013c9 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1010fa:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  1010fe:	74 5d                	je     10115d <printer_vprintf+0x48b>
  101100:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101107:	8b 00                	mov    (%rax),%eax
  101109:	83 f8 2f             	cmp    $0x2f,%eax
  10110c:	77 30                	ja     10113e <printer_vprintf+0x46c>
  10110e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101115:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101119:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101120:	8b 00                	mov    (%rax),%eax
  101122:	89 c0                	mov    %eax,%eax
  101124:	48 01 d0             	add    %rdx,%rax
  101127:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10112e:	8b 12                	mov    (%rdx),%edx
  101130:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101133:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10113a:	89 0a                	mov    %ecx,(%rdx)
  10113c:	eb 1a                	jmp    101158 <printer_vprintf+0x486>
  10113e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101145:	48 8b 40 08          	mov    0x8(%rax),%rax
  101149:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10114d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101154:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101158:	48 8b 00             	mov    (%rax),%rax
  10115b:	eb 5c                	jmp    1011b9 <printer_vprintf+0x4e7>
  10115d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101164:	8b 00                	mov    (%rax),%eax
  101166:	83 f8 2f             	cmp    $0x2f,%eax
  101169:	77 30                	ja     10119b <printer_vprintf+0x4c9>
  10116b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101172:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101176:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  10117d:	8b 00                	mov    (%rax),%eax
  10117f:	89 c0                	mov    %eax,%eax
  101181:	48 01 d0             	add    %rdx,%rax
  101184:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10118b:	8b 12                	mov    (%rdx),%edx
  10118d:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101190:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101197:	89 0a                	mov    %ecx,(%rdx)
  101199:	eb 1a                	jmp    1011b5 <printer_vprintf+0x4e3>
  10119b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011a2:	48 8b 40 08          	mov    0x8(%rax),%rax
  1011a6:	48 8d 48 08          	lea    0x8(%rax),%rcx
  1011aa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1011b1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1011b5:	8b 00                	mov    (%rax),%eax
  1011b7:	89 c0                	mov    %eax,%eax
  1011b9:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  1011bd:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  1011c1:	e9 03 02 00 00       	jmp    1013c9 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  1011c6:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  1011cd:	e9 28 ff ff ff       	jmp    1010fa <printer_vprintf+0x428>
        case 'X':
            base = 16;
  1011d2:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  1011d9:	e9 1c ff ff ff       	jmp    1010fa <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  1011de:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011e5:	8b 00                	mov    (%rax),%eax
  1011e7:	83 f8 2f             	cmp    $0x2f,%eax
  1011ea:	77 30                	ja     10121c <printer_vprintf+0x54a>
  1011ec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011f3:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1011f7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1011fe:	8b 00                	mov    (%rax),%eax
  101200:	89 c0                	mov    %eax,%eax
  101202:	48 01 d0             	add    %rdx,%rax
  101205:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10120c:	8b 12                	mov    (%rdx),%edx
  10120e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101211:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101218:	89 0a                	mov    %ecx,(%rdx)
  10121a:	eb 1a                	jmp    101236 <printer_vprintf+0x564>
  10121c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101223:	48 8b 40 08          	mov    0x8(%rax),%rax
  101227:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10122b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101232:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101236:	48 8b 00             	mov    (%rax),%rax
  101239:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  10123d:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  101244:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  10124b:	e9 79 01 00 00       	jmp    1013c9 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  101250:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101257:	8b 00                	mov    (%rax),%eax
  101259:	83 f8 2f             	cmp    $0x2f,%eax
  10125c:	77 30                	ja     10128e <printer_vprintf+0x5bc>
  10125e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101265:	48 8b 50 10          	mov    0x10(%rax),%rdx
  101269:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101270:	8b 00                	mov    (%rax),%eax
  101272:	89 c0                	mov    %eax,%eax
  101274:	48 01 d0             	add    %rdx,%rax
  101277:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10127e:	8b 12                	mov    (%rdx),%edx
  101280:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101283:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10128a:	89 0a                	mov    %ecx,(%rdx)
  10128c:	eb 1a                	jmp    1012a8 <printer_vprintf+0x5d6>
  10128e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101295:	48 8b 40 08          	mov    0x8(%rax),%rax
  101299:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10129d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012a4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  1012a8:	48 8b 00             	mov    (%rax),%rax
  1012ab:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  1012af:	e9 15 01 00 00       	jmp    1013c9 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  1012b4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012bb:	8b 00                	mov    (%rax),%eax
  1012bd:	83 f8 2f             	cmp    $0x2f,%eax
  1012c0:	77 30                	ja     1012f2 <printer_vprintf+0x620>
  1012c2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012c9:	48 8b 50 10          	mov    0x10(%rax),%rdx
  1012cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012d4:	8b 00                	mov    (%rax),%eax
  1012d6:	89 c0                	mov    %eax,%eax
  1012d8:	48 01 d0             	add    %rdx,%rax
  1012db:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012e2:	8b 12                	mov    (%rdx),%edx
  1012e4:	8d 4a 08             	lea    0x8(%rdx),%ecx
  1012e7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  1012ee:	89 0a                	mov    %ecx,(%rdx)
  1012f0:	eb 1a                	jmp    10130c <printer_vprintf+0x63a>
  1012f2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  1012f9:	48 8b 40 08          	mov    0x8(%rax),%rax
  1012fd:	48 8d 48 08          	lea    0x8(%rax),%rcx
  101301:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101308:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  10130c:	8b 00                	mov    (%rax),%eax
  10130e:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  101314:	e9 67 03 00 00       	jmp    101680 <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  101319:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  10131d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  101321:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101328:	8b 00                	mov    (%rax),%eax
  10132a:	83 f8 2f             	cmp    $0x2f,%eax
  10132d:	77 30                	ja     10135f <printer_vprintf+0x68d>
  10132f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101336:	48 8b 50 10          	mov    0x10(%rax),%rdx
  10133a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101341:	8b 00                	mov    (%rax),%eax
  101343:	89 c0                	mov    %eax,%eax
  101345:	48 01 d0             	add    %rdx,%rax
  101348:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10134f:	8b 12                	mov    (%rdx),%edx
  101351:	8d 4a 08             	lea    0x8(%rdx),%ecx
  101354:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  10135b:	89 0a                	mov    %ecx,(%rdx)
  10135d:	eb 1a                	jmp    101379 <printer_vprintf+0x6a7>
  10135f:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  101366:	48 8b 40 08          	mov    0x8(%rax),%rax
  10136a:	48 8d 48 08          	lea    0x8(%rax),%rcx
  10136e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  101375:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101379:	8b 00                	mov    (%rax),%eax
  10137b:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  10137e:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  101382:	eb 45                	jmp    1013c9 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  101384:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  101388:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  10138c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  101393:	0f b6 00             	movzbl (%rax),%eax
  101396:	84 c0                	test   %al,%al
  101398:	74 0c                	je     1013a6 <printer_vprintf+0x6d4>
  10139a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1013a1:	0f b6 00             	movzbl (%rax),%eax
  1013a4:	eb 05                	jmp    1013ab <printer_vprintf+0x6d9>
  1013a6:	b8 25 00 00 00       	mov    $0x25,%eax
  1013ab:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  1013ae:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  1013b2:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  1013b9:	0f b6 00             	movzbl (%rax),%eax
  1013bc:	84 c0                	test   %al,%al
  1013be:	75 08                	jne    1013c8 <printer_vprintf+0x6f6>
                format--;
  1013c0:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  1013c7:	01 
            }
            break;
  1013c8:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  1013c9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1013cc:	83 e0 20             	and    $0x20,%eax
  1013cf:	85 c0                	test   %eax,%eax
  1013d1:	74 1e                	je     1013f1 <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  1013d3:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  1013d7:	48 83 c0 18          	add    $0x18,%rax
  1013db:	8b 55 e0             	mov    -0x20(%rbp),%edx
  1013de:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1013e2:	48 89 ce             	mov    %rcx,%rsi
  1013e5:	48 89 c7             	mov    %rax,%rdi
  1013e8:	e8 63 f8 ff ff       	call   100c50 <fill_numbuf>
  1013ed:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  1013f1:	48 c7 45 c0 86 1a 10 	movq   $0x101a86,-0x40(%rbp)
  1013f8:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1013f9:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1013fc:	83 e0 20             	and    $0x20,%eax
  1013ff:	85 c0                	test   %eax,%eax
  101401:	74 48                	je     10144b <printer_vprintf+0x779>
  101403:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101406:	83 e0 40             	and    $0x40,%eax
  101409:	85 c0                	test   %eax,%eax
  10140b:	74 3e                	je     10144b <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  10140d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101410:	25 80 00 00 00       	and    $0x80,%eax
  101415:	85 c0                	test   %eax,%eax
  101417:	74 0a                	je     101423 <printer_vprintf+0x751>
                prefix = "-";
  101419:	48 c7 45 c0 87 1a 10 	movq   $0x101a87,-0x40(%rbp)
  101420:	00 
            if (flags & FLAG_NEGATIVE) {
  101421:	eb 73                	jmp    101496 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  101423:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101426:	83 e0 10             	and    $0x10,%eax
  101429:	85 c0                	test   %eax,%eax
  10142b:	74 0a                	je     101437 <printer_vprintf+0x765>
                prefix = "+";
  10142d:	48 c7 45 c0 89 1a 10 	movq   $0x101a89,-0x40(%rbp)
  101434:	00 
            if (flags & FLAG_NEGATIVE) {
  101435:	eb 5f                	jmp    101496 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  101437:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10143a:	83 e0 08             	and    $0x8,%eax
  10143d:	85 c0                	test   %eax,%eax
  10143f:	74 55                	je     101496 <printer_vprintf+0x7c4>
                prefix = " ";
  101441:	48 c7 45 c0 8b 1a 10 	movq   $0x101a8b,-0x40(%rbp)
  101448:	00 
            if (flags & FLAG_NEGATIVE) {
  101449:	eb 4b                	jmp    101496 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  10144b:	8b 45 ec             	mov    -0x14(%rbp),%eax
  10144e:	83 e0 20             	and    $0x20,%eax
  101451:	85 c0                	test   %eax,%eax
  101453:	74 42                	je     101497 <printer_vprintf+0x7c5>
  101455:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101458:	83 e0 01             	and    $0x1,%eax
  10145b:	85 c0                	test   %eax,%eax
  10145d:	74 38                	je     101497 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  10145f:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  101463:	74 06                	je     10146b <printer_vprintf+0x799>
  101465:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101469:	75 2c                	jne    101497 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  10146b:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  101470:	75 0c                	jne    10147e <printer_vprintf+0x7ac>
  101472:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101475:	25 00 01 00 00       	and    $0x100,%eax
  10147a:	85 c0                	test   %eax,%eax
  10147c:	74 19                	je     101497 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  10147e:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  101482:	75 07                	jne    10148b <printer_vprintf+0x7b9>
  101484:	b8 8d 1a 10 00       	mov    $0x101a8d,%eax
  101489:	eb 05                	jmp    101490 <printer_vprintf+0x7be>
  10148b:	b8 90 1a 10 00       	mov    $0x101a90,%eax
  101490:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  101494:	eb 01                	jmp    101497 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  101496:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  101497:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  10149b:	78 24                	js     1014c1 <printer_vprintf+0x7ef>
  10149d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014a0:	83 e0 20             	and    $0x20,%eax
  1014a3:	85 c0                	test   %eax,%eax
  1014a5:	75 1a                	jne    1014c1 <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  1014a7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1014aa:	48 63 d0             	movslq %eax,%rdx
  1014ad:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1014b1:	48 89 d6             	mov    %rdx,%rsi
  1014b4:	48 89 c7             	mov    %rax,%rdi
  1014b7:	e8 ea f5 ff ff       	call   100aa6 <strnlen>
  1014bc:	89 45 bc             	mov    %eax,-0x44(%rbp)
  1014bf:	eb 0f                	jmp    1014d0 <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  1014c1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  1014c5:	48 89 c7             	mov    %rax,%rdi
  1014c8:	e8 a8 f5 ff ff       	call   100a75 <strlen>
  1014cd:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1014d0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014d3:	83 e0 20             	and    $0x20,%eax
  1014d6:	85 c0                	test   %eax,%eax
  1014d8:	74 20                	je     1014fa <printer_vprintf+0x828>
  1014da:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  1014de:	78 1a                	js     1014fa <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  1014e0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1014e3:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  1014e6:	7e 08                	jle    1014f0 <printer_vprintf+0x81e>
  1014e8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  1014eb:	2b 45 bc             	sub    -0x44(%rbp),%eax
  1014ee:	eb 05                	jmp    1014f5 <printer_vprintf+0x823>
  1014f0:	b8 00 00 00 00       	mov    $0x0,%eax
  1014f5:	89 45 b8             	mov    %eax,-0x48(%rbp)
  1014f8:	eb 5c                	jmp    101556 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1014fa:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1014fd:	83 e0 20             	and    $0x20,%eax
  101500:	85 c0                	test   %eax,%eax
  101502:	74 4b                	je     10154f <printer_vprintf+0x87d>
  101504:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101507:	83 e0 02             	and    $0x2,%eax
  10150a:	85 c0                	test   %eax,%eax
  10150c:	74 41                	je     10154f <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  10150e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  101511:	83 e0 04             	and    $0x4,%eax
  101514:	85 c0                	test   %eax,%eax
  101516:	75 37                	jne    10154f <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  101518:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10151c:	48 89 c7             	mov    %rax,%rdi
  10151f:	e8 51 f5 ff ff       	call   100a75 <strlen>
  101524:	89 c2                	mov    %eax,%edx
  101526:	8b 45 bc             	mov    -0x44(%rbp),%eax
  101529:	01 d0                	add    %edx,%eax
  10152b:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  10152e:	7e 1f                	jle    10154f <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  101530:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101533:	2b 45 bc             	sub    -0x44(%rbp),%eax
  101536:	89 c3                	mov    %eax,%ebx
  101538:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10153c:	48 89 c7             	mov    %rax,%rdi
  10153f:	e8 31 f5 ff ff       	call   100a75 <strlen>
  101544:	89 c2                	mov    %eax,%edx
  101546:	89 d8                	mov    %ebx,%eax
  101548:	29 d0                	sub    %edx,%eax
  10154a:	89 45 b8             	mov    %eax,-0x48(%rbp)
  10154d:	eb 07                	jmp    101556 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  10154f:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  101556:	8b 55 bc             	mov    -0x44(%rbp),%edx
  101559:	8b 45 b8             	mov    -0x48(%rbp),%eax
  10155c:	01 d0                	add    %edx,%eax
  10155e:	48 63 d8             	movslq %eax,%rbx
  101561:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  101565:	48 89 c7             	mov    %rax,%rdi
  101568:	e8 08 f5 ff ff       	call   100a75 <strlen>
  10156d:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  101571:	8b 45 e8             	mov    -0x18(%rbp),%eax
  101574:	29 d0                	sub    %edx,%eax
  101576:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  101579:	eb 25                	jmp    1015a0 <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  10157b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101582:	48 8b 08             	mov    (%rax),%rcx
  101585:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  10158b:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101592:	be 20 00 00 00       	mov    $0x20,%esi
  101597:	48 89 c7             	mov    %rax,%rdi
  10159a:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10159c:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  1015a0:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1015a3:	83 e0 04             	and    $0x4,%eax
  1015a6:	85 c0                	test   %eax,%eax
  1015a8:	75 36                	jne    1015e0 <printer_vprintf+0x90e>
  1015aa:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  1015ae:	7f cb                	jg     10157b <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  1015b0:	eb 2e                	jmp    1015e0 <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  1015b2:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1015b9:	4c 8b 00             	mov    (%rax),%r8
  1015bc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1015c0:	0f b6 00             	movzbl (%rax),%eax
  1015c3:	0f b6 c8             	movzbl %al,%ecx
  1015c6:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1015cc:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1015d3:	89 ce                	mov    %ecx,%esi
  1015d5:	48 89 c7             	mov    %rax,%rdi
  1015d8:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  1015db:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  1015e0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1015e4:	0f b6 00             	movzbl (%rax),%eax
  1015e7:	84 c0                	test   %al,%al
  1015e9:	75 c7                	jne    1015b2 <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  1015eb:	eb 25                	jmp    101612 <printer_vprintf+0x940>
            p->putc(p, '0', color);
  1015ed:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  1015f4:	48 8b 08             	mov    (%rax),%rcx
  1015f7:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  1015fd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101604:	be 30 00 00 00       	mov    $0x30,%esi
  101609:	48 89 c7             	mov    %rax,%rdi
  10160c:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  10160e:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  101612:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  101616:	7f d5                	jg     1015ed <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  101618:	eb 32                	jmp    10164c <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  10161a:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  101621:	4c 8b 00             	mov    (%rax),%r8
  101624:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  101628:	0f b6 00             	movzbl (%rax),%eax
  10162b:	0f b6 c8             	movzbl %al,%ecx
  10162e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101634:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10163b:	89 ce                	mov    %ecx,%esi
  10163d:	48 89 c7             	mov    %rax,%rdi
  101640:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  101643:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  101648:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  10164c:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  101650:	7f c8                	jg     10161a <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  101652:	eb 25                	jmp    101679 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  101654:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10165b:	48 8b 08             	mov    (%rax),%rcx
  10165e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  101664:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  10166b:	be 20 00 00 00       	mov    $0x20,%esi
  101670:	48 89 c7             	mov    %rax,%rdi
  101673:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  101675:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  101679:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  10167d:	7f d5                	jg     101654 <printer_vprintf+0x982>
        }
    done: ;
  10167f:	90                   	nop
    for (; *format; ++format) {
  101680:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  101687:	01 
  101688:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  10168f:	0f b6 00             	movzbl (%rax),%eax
  101692:	84 c0                	test   %al,%al
  101694:	0f 85 64 f6 ff ff    	jne    100cfe <printer_vprintf+0x2c>
    }
}
  10169a:	90                   	nop
  10169b:	90                   	nop
  10169c:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  1016a0:	c9                   	leave  
  1016a1:	c3                   	ret    

00000000001016a2 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1016a2:	55                   	push   %rbp
  1016a3:	48 89 e5             	mov    %rsp,%rbp
  1016a6:	48 83 ec 20          	sub    $0x20,%rsp
  1016aa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  1016ae:	89 f0                	mov    %esi,%eax
  1016b0:	89 55 e0             	mov    %edx,-0x20(%rbp)
  1016b3:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  1016b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  1016ba:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1016be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1016c2:	48 8b 40 08          	mov    0x8(%rax),%rax
  1016c6:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  1016cb:	48 39 d0             	cmp    %rdx,%rax
  1016ce:	72 0c                	jb     1016dc <console_putc+0x3a>
        cp->cursor = console;
  1016d0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1016d4:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  1016db:	00 
    }
    if (c == '\n') {
  1016dc:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  1016e0:	75 78                	jne    10175a <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  1016e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1016e6:	48 8b 40 08          	mov    0x8(%rax),%rax
  1016ea:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1016f0:	48 d1 f8             	sar    %rax
  1016f3:	48 89 c1             	mov    %rax,%rcx
  1016f6:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1016fd:	66 66 66 
  101700:	48 89 c8             	mov    %rcx,%rax
  101703:	48 f7 ea             	imul   %rdx
  101706:	48 c1 fa 05          	sar    $0x5,%rdx
  10170a:	48 89 c8             	mov    %rcx,%rax
  10170d:	48 c1 f8 3f          	sar    $0x3f,%rax
  101711:	48 29 c2             	sub    %rax,%rdx
  101714:	48 89 d0             	mov    %rdx,%rax
  101717:	48 c1 e0 02          	shl    $0x2,%rax
  10171b:	48 01 d0             	add    %rdx,%rax
  10171e:	48 c1 e0 04          	shl    $0x4,%rax
  101722:	48 29 c1             	sub    %rax,%rcx
  101725:	48 89 ca             	mov    %rcx,%rdx
  101728:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  10172b:	eb 25                	jmp    101752 <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  10172d:	8b 45 e0             	mov    -0x20(%rbp),%eax
  101730:	83 c8 20             	or     $0x20,%eax
  101733:	89 c6                	mov    %eax,%esi
  101735:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101739:	48 8b 40 08          	mov    0x8(%rax),%rax
  10173d:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101741:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101745:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101749:	89 f2                	mov    %esi,%edx
  10174b:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  10174e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101752:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  101756:	75 d5                	jne    10172d <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  101758:	eb 24                	jmp    10177e <console_putc+0xdc>
        *cp->cursor++ = c | color;
  10175a:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  10175e:	8b 55 e0             	mov    -0x20(%rbp),%edx
  101761:	09 d0                	or     %edx,%eax
  101763:	89 c6                	mov    %eax,%esi
  101765:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  101769:	48 8b 40 08          	mov    0x8(%rax),%rax
  10176d:	48 8d 48 02          	lea    0x2(%rax),%rcx
  101771:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  101775:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101779:	89 f2                	mov    %esi,%edx
  10177b:	66 89 10             	mov    %dx,(%rax)
}
  10177e:	90                   	nop
  10177f:	c9                   	leave  
  101780:	c3                   	ret    

0000000000101781 <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  101781:	55                   	push   %rbp
  101782:	48 89 e5             	mov    %rsp,%rbp
  101785:	48 83 ec 30          	sub    $0x30,%rsp
  101789:	89 7d ec             	mov    %edi,-0x14(%rbp)
  10178c:	89 75 e8             	mov    %esi,-0x18(%rbp)
  10178f:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101793:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  101797:	48 c7 45 f0 a2 16 10 	movq   $0x1016a2,-0x10(%rbp)
  10179e:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10179f:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  1017a3:	78 09                	js     1017ae <console_vprintf+0x2d>
  1017a5:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  1017ac:	7e 07                	jle    1017b5 <console_vprintf+0x34>
        cpos = 0;
  1017ae:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  1017b5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  1017b8:	48 98                	cltq   
  1017ba:	48 01 c0             	add    %rax,%rax
  1017bd:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  1017c3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  1017c7:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  1017cb:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  1017cf:	8b 75 e8             	mov    -0x18(%rbp),%esi
  1017d2:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  1017d6:	48 89 c7             	mov    %rax,%rdi
  1017d9:	e8 f4 f4 ff ff       	call   100cd2 <printer_vprintf>
    return cp.cursor - console;
  1017de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1017e2:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1017e8:	48 d1 f8             	sar    %rax
}
  1017eb:	c9                   	leave  
  1017ec:	c3                   	ret    

00000000001017ed <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  1017ed:	55                   	push   %rbp
  1017ee:	48 89 e5             	mov    %rsp,%rbp
  1017f1:	48 83 ec 60          	sub    $0x60,%rsp
  1017f5:	89 7d ac             	mov    %edi,-0x54(%rbp)
  1017f8:	89 75 a8             	mov    %esi,-0x58(%rbp)
  1017fb:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  1017ff:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101803:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101807:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  10180b:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  101812:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101816:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  10181a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10181e:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  101822:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  101826:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  10182a:	8b 75 a8             	mov    -0x58(%rbp),%esi
  10182d:	8b 45 ac             	mov    -0x54(%rbp),%eax
  101830:	89 c7                	mov    %eax,%edi
  101832:	e8 4a ff ff ff       	call   101781 <console_vprintf>
  101837:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  10183a:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  10183d:	c9                   	leave  
  10183e:	c3                   	ret    

000000000010183f <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  10183f:	55                   	push   %rbp
  101840:	48 89 e5             	mov    %rsp,%rbp
  101843:	48 83 ec 20          	sub    $0x20,%rsp
  101847:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  10184b:	89 f0                	mov    %esi,%eax
  10184d:	89 55 e0             	mov    %edx,-0x20(%rbp)
  101850:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  101853:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  101857:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  10185b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  10185f:	48 8b 50 08          	mov    0x8(%rax),%rdx
  101863:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101867:	48 8b 40 10          	mov    0x10(%rax),%rax
  10186b:	48 39 c2             	cmp    %rax,%rdx
  10186e:	73 1a                	jae    10188a <string_putc+0x4b>
        *sp->s++ = c;
  101870:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  101874:	48 8b 40 08          	mov    0x8(%rax),%rax
  101878:	48 8d 48 01          	lea    0x1(%rax),%rcx
  10187c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  101880:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  101884:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  101888:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  10188a:	90                   	nop
  10188b:	c9                   	leave  
  10188c:	c3                   	ret    

000000000010188d <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  10188d:	55                   	push   %rbp
  10188e:	48 89 e5             	mov    %rsp,%rbp
  101891:	48 83 ec 40          	sub    $0x40,%rsp
  101895:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  101899:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  10189d:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  1018a1:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  1018a5:	48 c7 45 e8 3f 18 10 	movq   $0x10183f,-0x18(%rbp)
  1018ac:	00 
    sp.s = s;
  1018ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1018b1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  1018b5:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  1018ba:	74 33                	je     1018ef <vsnprintf+0x62>
        sp.end = s + size - 1;
  1018bc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  1018c0:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  1018c4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  1018c8:	48 01 d0             	add    %rdx,%rax
  1018cb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  1018cf:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  1018d3:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1018d7:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  1018db:	be 00 00 00 00       	mov    $0x0,%esi
  1018e0:	48 89 c7             	mov    %rax,%rdi
  1018e3:	e8 ea f3 ff ff       	call   100cd2 <printer_vprintf>
        *sp.s = 0;
  1018e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1018ec:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  1018ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  1018f3:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  1018f7:	c9                   	leave  
  1018f8:	c3                   	ret    

00000000001018f9 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  1018f9:	55                   	push   %rbp
  1018fa:	48 89 e5             	mov    %rsp,%rbp
  1018fd:	48 83 ec 70          	sub    $0x70,%rsp
  101901:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  101905:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  101909:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  10190d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  101911:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  101915:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  101919:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  101920:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101924:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  101928:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  10192c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  101930:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  101934:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  101938:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  10193c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  101940:	48 89 c7             	mov    %rax,%rdi
  101943:	e8 45 ff ff ff       	call   10188d <vsnprintf>
  101948:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  10194b:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  10194e:	c9                   	leave  
  10194f:	c3                   	ret    

0000000000101950 <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  101950:	55                   	push   %rbp
  101951:	48 89 e5             	mov    %rsp,%rbp
  101954:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101958:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  10195f:	eb 13                	jmp    101974 <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  101961:	8b 45 fc             	mov    -0x4(%rbp),%eax
  101964:	48 98                	cltq   
  101966:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  10196d:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  101970:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  101974:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  10197b:	7e e4                	jle    101961 <console_clear+0x11>
    }
    cursorpos = 0;
  10197d:	c7 05 75 76 fb ff 00 	movl   $0x0,-0x4898b(%rip)        # b8ffc <cursorpos>
  101984:	00 00 00 
}
  101987:	90                   	nop
  101988:	c9                   	leave  
  101989:	c3                   	ret    
