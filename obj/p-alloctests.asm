
obj/p-alloctests.full:     file format elf64-x86-64


Disassembly of section .text:

00000000002c0000 <process_main>:
#include "time.h"
#include "malloc.h"

extern uint8_t end[];

void process_main(void) {
  2c0000:	55                   	push   %rbp
  2c0001:	48 89 e5             	mov    %rsp,%rbp
  2c0004:	41 56                	push   %r14
  2c0006:	41 55                	push   %r13
  2c0008:	41 54                	push   %r12
  2c000a:	53                   	push   %rbx
  2c000b:	48 83 ec 20          	sub    $0x20,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  2c000f:	cd 31                	int    $0x31
  2c0011:	41 89 c4             	mov    %eax,%r12d
    
    pid_t p = getpid();
    srand(p);
  2c0014:	89 c7                	mov    %eax,%edi
  2c0016:	e8 ae 0b 00 00       	call   2c0bc9 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001b:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0020:	e8 a1 05 00 00       	call   2c05c6 <malloc>
  2c0025:	48 89 c7             	mov    %rax,%rdi
  2c0028:	ba 00 00 00 00       	mov    $0x0,%edx
    
    // set array elements
    for(int  i = 0 ; i < 10; i++){
	array[i] = i;
  2c002d:	89 14 97             	mov    %edx,(%rdi,%rdx,4)
    for(int  i = 0 ; i < 10; i++){
  2c0030:	48 83 c2 01          	add    $0x1,%rdx
  2c0034:	48 83 fa 0a          	cmp    $0xa,%rdx
  2c0038:	75 f3                	jne    2c002d <process_main+0x2d>
    }

    // realloc array to size 20
    array = (int*)realloc(array, sizeof(int) * 20);
  2c003a:	be 50 00 00 00       	mov    $0x50,%esi
  2c003f:	e8 bc 06 00 00       	call   2c0700 <realloc>
  2c0044:	49 89 c5             	mov    %rax,%r13
  2c0047:	b8 00 00 00 00       	mov    $0x0,%eax

    // check if contents are same
    for(int i = 0 ; i < 10 ; i++){
	assert(array[i] == i);
  2c004c:	41 39 44 85 00       	cmp    %eax,0x0(%r13,%rax,4)
  2c0051:	75 64                	jne    2c00b7 <process_main+0xb7>
    for(int i = 0 ; i < 10 ; i++){
  2c0053:	48 83 c0 01          	add    $0x1,%rax
  2c0057:	48 83 f8 0a          	cmp    $0xa,%rax
  2c005b:	75 ef                	jne    2c004c <process_main+0x4c>
    }

    // alloc int array of size 30 using calloc
    int * array2 = (int *)calloc(30, sizeof(int));
  2c005d:	be 04 00 00 00       	mov    $0x4,%esi
  2c0062:	bf 1e 00 00 00       	mov    $0x1e,%edi
  2c0067:	e8 42 06 00 00       	call   2c06ae <calloc>
  2c006c:	49 89 c6             	mov    %rax,%r14

    // assert array[i] == 0
    for(int i = 0 ; i < 30; i++){
  2c006f:	48 8d 50 78          	lea    0x78(%rax),%rdx
	assert(array2[i] == 0);
  2c0073:	8b 18                	mov    (%rax),%ebx
  2c0075:	85 db                	test   %ebx,%ebx
  2c0077:	75 52                	jne    2c00cb <process_main+0xcb>
    for(int i = 0 ; i < 30; i++){
  2c0079:	48 83 c0 04          	add    $0x4,%rax
  2c007d:	48 39 d0             	cmp    %rdx,%rax
  2c0080:	75 f1                	jne    2c0073 <process_main+0x73>
    }
    
    heap_info_struct info;
    if(heap_info(&info) == 0){
  2c0082:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
  2c0086:	e8 40 07 00 00       	call   2c07cb <heap_info>
  2c008b:	85 c0                	test   %eax,%eax
  2c008d:	75 64                	jne    2c00f3 <process_main+0xf3>
	// check if allocations are in sorted order
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c008f:	8b 55 c0             	mov    -0x40(%rbp),%edx
  2c0092:	83 fa 01             	cmp    $0x1,%edx
  2c0095:	7e 70                	jle    2c0107 <process_main+0x107>
  2c0097:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c009b:	8d 52 fe             	lea    -0x2(%rdx),%edx
  2c009e:	48 8d 54 d0 08       	lea    0x8(%rax,%rdx,8),%rdx
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00a3:	48 8b 30             	mov    (%rax),%rsi
  2c00a6:	48 39 70 08          	cmp    %rsi,0x8(%rax)
  2c00aa:	7d 33                	jge    2c00df <process_main+0xdf>
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c00ac:	48 83 c0 08          	add    $0x8,%rax
  2c00b0:	48 39 d0             	cmp    %rdx,%rax
  2c00b3:	75 ee                	jne    2c00a3 <process_main+0xa3>
  2c00b5:	eb 50                	jmp    2c0107 <process_main+0x107>
	assert(array[i] == i);
  2c00b7:	ba 30 19 2c 00       	mov    $0x2c1930,%edx
  2c00bc:	be 19 00 00 00       	mov    $0x19,%esi
  2c00c1:	bf 3e 19 2c 00       	mov    $0x2c193e,%edi
  2c00c6:	e8 13 02 00 00       	call   2c02de <assert_fail>
	assert(array2[i] == 0);
  2c00cb:	ba 54 19 2c 00       	mov    $0x2c1954,%edx
  2c00d0:	be 21 00 00 00       	mov    $0x21,%esi
  2c00d5:	bf 3e 19 2c 00       	mov    $0x2c193e,%edi
  2c00da:	e8 ff 01 00 00       	call   2c02de <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00df:	ba 78 19 2c 00       	mov    $0x2c1978,%edx
  2c00e4:	be 28 00 00 00       	mov    $0x28,%esi
  2c00e9:	bf 3e 19 2c 00       	mov    $0x2c193e,%edi
  2c00ee:	e8 eb 01 00 00       	call   2c02de <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c00f3:	be 63 19 2c 00       	mov    $0x2c1963,%esi
  2c00f8:	bf 00 00 00 00       	mov    $0x0,%edi
  2c00fd:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0102:	e8 79 00 00 00       	call   2c0180 <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0107:	4c 89 ef             	mov    %r13,%rdi
  2c010a:	e8 7b 04 00 00       	call   2c058a <free>
    free(array2);
  2c010f:	4c 89 f7             	mov    %r14,%rdi
  2c0112:	e8 73 04 00 00       	call   2c058a <free>

    uint64_t total_time = 0;
  2c0117:	41 bd 00 00 00 00    	mov    $0x0,%r13d
/* rdtscp */
static uint64_t rdtsc(void) {
	uint64_t var;
	uint32_t hi, lo;

	__asm volatile
  2c011d:	0f 31                	rdtsc  
	    ("rdtsc" : "=a" (lo), "=d" (hi));

	var = ((uint64_t)hi << 32) | lo;
  2c011f:	48 c1 e2 20          	shl    $0x20,%rdx
  2c0123:	89 c0                	mov    %eax,%eax
  2c0125:	48 09 c2             	or     %rax,%rdx
  2c0128:	49 89 d6             	mov    %rdx,%r14
    int total_pages = 0;
    
    // allocate pages till no more memory
    while (1) {
	uint64_t time = rdtsc();
	void * ptr = malloc(PAGESIZE);
  2c012b:	bf 00 10 00 00       	mov    $0x1000,%edi
  2c0130:	e8 91 04 00 00       	call   2c05c6 <malloc>
  2c0135:	48 89 c1             	mov    %rax,%rcx
	__asm volatile
  2c0138:	0f 31                	rdtsc  
	var = ((uint64_t)hi << 32) | lo;
  2c013a:	48 c1 e2 20          	shl    $0x20,%rdx
  2c013e:	89 c0                	mov    %eax,%eax
  2c0140:	48 09 c2             	or     %rax,%rdx
	total_time += (rdtsc() - time);
  2c0143:	4c 29 f2             	sub    %r14,%rdx
  2c0146:	49 01 d5             	add    %rdx,%r13
	if(ptr == NULL)
  2c0149:	48 85 c9             	test   %rcx,%rcx
  2c014c:	74 08                	je     2c0156 <process_main+0x156>
	    break;
	total_pages++;
  2c014e:	83 c3 01             	add    $0x1,%ebx
	*((int *)ptr) = p; // check write access
  2c0151:	44 89 21             	mov    %r12d,(%rcx)
    while (1) {
  2c0154:	eb c7                	jmp    2c011d <process_main+0x11d>
    }

    app_printf(p, "Total_time taken to alloc: %d Average time: %d\n", total_time, total_time/total_pages);
  2c0156:	48 63 db             	movslq %ebx,%rbx
  2c0159:	4c 89 e8             	mov    %r13,%rax
  2c015c:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0161:	48 f7 f3             	div    %rbx
  2c0164:	48 89 c1             	mov    %rax,%rcx
  2c0167:	4c 89 ea             	mov    %r13,%rdx
  2c016a:	be a8 19 2c 00       	mov    $0x2c19a8,%esi
  2c016f:	44 89 e7             	mov    %r12d,%edi
  2c0172:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0177:	e8 04 00 00 00       	call   2c0180 <app_printf>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  2c017c:	cd 32                	int    $0x32
  2c017e:	eb fc                	jmp    2c017c <process_main+0x17c>

00000000002c0180 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  2c0180:	55                   	push   %rbp
  2c0181:	48 89 e5             	mov    %rsp,%rbp
  2c0184:	48 83 ec 50          	sub    $0x50,%rsp
  2c0188:	49 89 f2             	mov    %rsi,%r10
  2c018b:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c018f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c0193:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c0197:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  2c019b:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  2c01a0:	85 ff                	test   %edi,%edi
  2c01a2:	78 2e                	js     2c01d2 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  2c01a4:	48 63 ff             	movslq %edi,%rdi
  2c01a7:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  2c01ae:	cc cc cc 
  2c01b1:	48 89 f8             	mov    %rdi,%rax
  2c01b4:	48 f7 e2             	mul    %rdx
  2c01b7:	48 89 d0             	mov    %rdx,%rax
  2c01ba:	48 c1 e8 02          	shr    $0x2,%rax
  2c01be:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  2c01c2:	48 01 c2             	add    %rax,%rdx
  2c01c5:	48 29 d7             	sub    %rdx,%rdi
  2c01c8:	0f b6 b7 0d 1a 2c 00 	movzbl 0x2c1a0d(%rdi),%esi
  2c01cf:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  2c01d2:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  2c01d9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c01dd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c01e1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c01e5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  2c01e9:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c01ed:	4c 89 d2             	mov    %r10,%rdx
  2c01f0:	8b 3d 06 8e df ff    	mov    -0x2071fa(%rip),%edi        # b8ffc <cursorpos>
  2c01f6:	e8 20 15 00 00       	call   2c171b <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  2c01fb:	3d 30 07 00 00       	cmp    $0x730,%eax
  2c0200:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0205:	0f 4d c2             	cmovge %edx,%eax
  2c0208:	89 05 ee 8d df ff    	mov    %eax,-0x207212(%rip)        # b8ffc <cursorpos>
    }
}
  2c020e:	c9                   	leave  
  2c020f:	c3                   	ret    

00000000002c0210 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  2c0210:	55                   	push   %rbp
  2c0211:	48 89 e5             	mov    %rsp,%rbp
  2c0214:	53                   	push   %rbx
  2c0215:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  2c021c:	48 89 fb             	mov    %rdi,%rbx
  2c021f:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  2c0223:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  2c0227:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  2c022b:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  2c022f:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  2c0233:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  2c023a:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c023e:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  2c0242:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  2c0246:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  2c024a:	ba 07 00 00 00       	mov    $0x7,%edx
  2c024f:	be d8 19 2c 00       	mov    $0x2c19d8,%esi
  2c0254:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c025b:	e8 72 06 00 00       	call   2c08d2 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c0260:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c0264:	48 89 da             	mov    %rbx,%rdx
  2c0267:	be 99 00 00 00       	mov    $0x99,%esi
  2c026c:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c0273:	e8 af 15 00 00       	call   2c1827 <vsnprintf>
  2c0278:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  2c027b:	85 d2                	test   %edx,%edx
  2c027d:	7e 0f                	jle    2c028e <kernel_panic+0x7e>
  2c027f:	83 c0 06             	add    $0x6,%eax
  2c0282:	48 98                	cltq   
  2c0284:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  2c028b:	0a 
  2c028c:	75 2a                	jne    2c02b8 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  2c028e:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  2c0295:	48 89 d9             	mov    %rbx,%rcx
  2c0298:	ba e0 19 2c 00       	mov    $0x2c19e0,%edx
  2c029d:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02a2:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02a7:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ac:	e8 d6 14 00 00       	call   2c1787 <console_printf>
}

// panic(msg)
//    Panic.
static inline pid_t __attribute__((noreturn)) panic(const char* msg) {
    asm volatile ("int %0" : /* no result */
  2c02b1:	48 89 df             	mov    %rbx,%rdi
  2c02b4:	cd 30                	int    $0x30
                  : "i" (INT_SYS_PANIC), "D" (msg)
                  : "cc", "memory");
 loop: goto loop;
  2c02b6:	eb fe                	jmp    2c02b6 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  2c02b8:	48 63 c2             	movslq %edx,%rax
  2c02bb:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  2c02c1:	0f 94 c2             	sete   %dl
  2c02c4:	0f b6 d2             	movzbl %dl,%edx
  2c02c7:	48 29 d0             	sub    %rdx,%rax
  2c02ca:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  2c02d1:	ff 
  2c02d2:	be 73 19 2c 00       	mov    $0x2c1973,%esi
  2c02d7:	e8 a3 07 00 00       	call   2c0a7f <strcpy>
  2c02dc:	eb b0                	jmp    2c028e <kernel_panic+0x7e>

00000000002c02de <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  2c02de:	55                   	push   %rbp
  2c02df:	48 89 e5             	mov    %rsp,%rbp
  2c02e2:	48 89 f9             	mov    %rdi,%rcx
  2c02e5:	41 89 f0             	mov    %esi,%r8d
  2c02e8:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  2c02eb:	ba e8 19 2c 00       	mov    $0x2c19e8,%edx
  2c02f0:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c02f5:	bf 30 07 00 00       	mov    $0x730,%edi
  2c02fa:	b8 00 00 00 00       	mov    $0x0,%eax
  2c02ff:	e8 83 14 00 00       	call   2c1787 <console_printf>
    asm volatile ("int %0" : /* no result */
  2c0304:	bf 00 00 00 00       	mov    $0x0,%edi
  2c0309:	cd 30                	int    $0x30
 loop: goto loop;
  2c030b:	eb fe                	jmp    2c030b <assert_fail+0x2d>

00000000002c030d <append_list>:
elt * alloc_tail = NULL;
int free_list_size = 0;
int alloc_list_size = 0;

void append_list (elt * node, size_t size, int free) {
    node->size = size;
  2c030d:	48 89 37             	mov    %rsi,(%rdi)
    node->next = NULL;
  2c0310:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  2c0317:	00 
    if(free) {
  2c0318:	85 d2                	test   %edx,%edx
  2c031a:	74 40                	je     2c035c <append_list+0x4f>
        if(free_head == NULL) {
  2c031c:	48 83 3d fc 1c 00 00 	cmpq   $0x0,0x1cfc(%rip)        # 2c2020 <free_head>
  2c0323:	00 
  2c0324:	74 1e                	je     2c0344 <append_list+0x37>
            free_head = node;
            free_tail = node;
            node->prev = NULL;
        } else {
            free_tail->next = node;
  2c0326:	48 8b 05 eb 1c 00 00 	mov    0x1ceb(%rip),%rax        # 2c2018 <free_tail>
  2c032d:	48 89 78 18          	mov    %rdi,0x18(%rax)
            node->prev = free_tail;
  2c0331:	48 89 47 10          	mov    %rax,0x10(%rdi)
            free_tail = node;
  2c0335:	48 89 3d dc 1c 00 00 	mov    %rdi,0x1cdc(%rip)        # 2c2018 <free_tail>
        }
        free_list_size++;
  2c033c:	83 05 c1 1c 00 00 01 	addl   $0x1,0x1cc1(%rip)        # 2c2004 <free_list_size>
  2c0343:	c3                   	ret    
            free_head = node;
  2c0344:	48 89 3d d5 1c 00 00 	mov    %rdi,0x1cd5(%rip)        # 2c2020 <free_head>
            free_tail = node;
  2c034b:	48 89 3d c6 1c 00 00 	mov    %rdi,0x1cc6(%rip)        # 2c2018 <free_tail>
            node->prev = NULL;
  2c0352:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  2c0359:	00 
  2c035a:	eb e0                	jmp    2c033c <append_list+0x2f>
    } else {
        if(alloc_head == NULL) {
  2c035c:	48 83 3d ac 1c 00 00 	cmpq   $0x0,0x1cac(%rip)        # 2c2010 <alloc_head>
  2c0363:	00 
  2c0364:	74 1e                	je     2c0384 <append_list+0x77>
            alloc_head = node;
            alloc_tail = node;
            node->prev = NULL;
        } else {
            alloc_tail->next = node;
  2c0366:	48 8b 05 9b 1c 00 00 	mov    0x1c9b(%rip),%rax        # 2c2008 <alloc_tail>
  2c036d:	48 89 78 18          	mov    %rdi,0x18(%rax)
            node->prev = alloc_tail;
  2c0371:	48 89 47 10          	mov    %rax,0x10(%rdi)
            alloc_tail = node;
  2c0375:	48 89 3d 8c 1c 00 00 	mov    %rdi,0x1c8c(%rip)        # 2c2008 <alloc_tail>
        }
        alloc_list_size++;
  2c037c:	83 05 7d 1c 00 00 01 	addl   $0x1,0x1c7d(%rip)        # 2c2000 <alloc_list_size>
    }
}
  2c0383:	c3                   	ret    
            alloc_head = node;
  2c0384:	48 89 3d 85 1c 00 00 	mov    %rdi,0x1c85(%rip)        # 2c2010 <alloc_head>
            alloc_tail = node;
  2c038b:	48 89 3d 76 1c 00 00 	mov    %rdi,0x1c76(%rip)        # 2c2008 <alloc_tail>
            node->prev = NULL;
  2c0392:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  2c0399:	00 
  2c039a:	eb e0                	jmp    2c037c <append_list+0x6f>

00000000002c039c <append_list_ordered>:

void append_list_ordered (elt * node, size_t size, size_t alloc_bytes, int free) {
    node->size = size;
  2c039c:	48 89 37             	mov    %rsi,(%rdi)
    if(free) {
  2c039f:	85 c9                	test   %ecx,%ecx
  2c03a1:	0f 84 9c 00 00 00    	je     2c0443 <append_list_ordered+0xa7>
        uintptr_t node_addr = (uintptr_t) node;
        free_list_size++;
  2c03a7:	83 05 56 1c 00 00 01 	addl   $0x1,0x1c56(%rip)        # 2c2004 <free_list_size>
        if(free_head == NULL) { // list is empty
  2c03ae:	48 8b 15 6b 1c 00 00 	mov    0x1c6b(%rip),%rdx        # 2c2020 <free_head>
  2c03b5:	48 85 d2             	test   %rdx,%rdx
  2c03b8:	74 3a                	je     2c03f4 <append_list_ordered+0x58>
            free_head = node;
            free_tail = node;
            node->prev = NULL;
            node->next = NULL;
            return;
        } else if (node_addr < (uintptr_t) free_head) { // insert at list head
  2c03ba:	48 39 d7             	cmp    %rdx,%rdi
  2c03bd:	72 54                	jb     2c0413 <append_list_ordered+0x77>
            free_head->prev = node;
            free_head = node;
            return;
        } else { // insert in ascending order of address
            elt * p1 = free_head;
            elt * p2 = p1->next;
  2c03bf:	48 8b 42 18          	mov    0x18(%rdx),%rax
            while(p2 != NULL) {
  2c03c3:	48 85 c0             	test   %rax,%rax
  2c03c6:	74 63                	je     2c042b <append_list_ordered+0x8f>
                if((node_addr >= ((uintptr_t) p1)) && (node_addr < ((uintptr_t) p2))) {
  2c03c8:	48 39 c7             	cmp    %rax,%rdi
  2c03cb:	72 16                	jb     2c03e3 <append_list_ordered+0x47>
                    p1->next = node;
                    p2->prev = node;
                    return;
                }
                p1 = p2;
                p2 = p2->next;
  2c03cd:	48 89 c2             	mov    %rax,%rdx
  2c03d0:	48 8b 40 18          	mov    0x18(%rax),%rax
            while(p2 != NULL) {
  2c03d4:	48 85 c0             	test   %rax,%rax
  2c03d7:	74 52                	je     2c042b <append_list_ordered+0x8f>
                if((node_addr >= ((uintptr_t) p1)) && (node_addr < ((uintptr_t) p2))) {
  2c03d9:	48 39 d7             	cmp    %rdx,%rdi
  2c03dc:	72 ef                	jb     2c03cd <append_list_ordered+0x31>
  2c03de:	48 39 c7             	cmp    %rax,%rdi
  2c03e1:	73 ea                	jae    2c03cd <append_list_ordered+0x31>
                    node->prev = p1;
  2c03e3:	48 89 57 10          	mov    %rdx,0x10(%rdi)
                    node->next = p2;
  2c03e7:	48 89 47 18          	mov    %rax,0x18(%rdi)
                    p1->next = node;
  2c03eb:	48 89 7a 18          	mov    %rdi,0x18(%rdx)
                    p2->prev = node;
  2c03ef:	48 89 78 10          	mov    %rdi,0x10(%rax)
                    return;
  2c03f3:	c3                   	ret    
            free_head = node;
  2c03f4:	48 89 3d 25 1c 00 00 	mov    %rdi,0x1c25(%rip)        # 2c2020 <free_head>
            free_tail = node;
  2c03fb:	48 89 3d 16 1c 00 00 	mov    %rdi,0x1c16(%rip)        # 2c2018 <free_tail>
            node->prev = NULL;
  2c0402:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  2c0409:	00 
            node->next = NULL;
  2c040a:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  2c0411:	00 
            return;
  2c0412:	c3                   	ret    
            node->prev = NULL;
  2c0413:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  2c041a:	00 
            node->next = free_head;
  2c041b:	48 89 57 18          	mov    %rdx,0x18(%rdi)
            free_head->prev = node;
  2c041f:	48 89 7a 10          	mov    %rdi,0x10(%rdx)
            free_head = node;
  2c0423:	48 89 3d f6 1b 00 00 	mov    %rdi,0x1bf6(%rip)        # 2c2020 <free_head>
            return;
  2c042a:	c3                   	ret    
            }
            // last elt in list
            p1->next = node;
  2c042b:	48 89 7a 18          	mov    %rdi,0x18(%rdx)
            node->prev = p1;
  2c042f:	48 89 57 10          	mov    %rdx,0x10(%rdi)
            node->next = NULL;
  2c0433:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  2c043a:	00 
            free_tail = node;
  2c043b:	48 89 3d d6 1b 00 00 	mov    %rdi,0x1bd6(%rip)        # 2c2018 <free_tail>
            return;
  2c0442:	c3                   	ret    
        }
    } else {
        alloc_list_size++;
  2c0443:	83 05 b6 1b 00 00 01 	addl   $0x1,0x1bb6(%rip)        # 2c2000 <alloc_list_size>
        node->alloc_bytes = alloc_bytes;
  2c044a:	48 89 57 08          	mov    %rdx,0x8(%rdi)
        if(alloc_head == NULL) {
  2c044e:	48 8b 35 bb 1b 00 00 	mov    0x1bbb(%rip),%rsi        # 2c2010 <alloc_head>
  2c0455:	48 85 f6             	test   %rsi,%rsi
  2c0458:	74 2a                	je     2c0484 <append_list_ordered+0xe8>
            alloc_head = node;
            alloc_tail = node;
            node->prev = NULL;
            node->next = NULL;
            return;
        } else if(alloc_bytes > alloc_head->alloc_bytes) {
  2c045a:	48 39 56 08          	cmp    %rdx,0x8(%rsi)
  2c045e:	72 43                	jb     2c04a3 <append_list_ordered+0x107>
            alloc_head->prev = node;
            alloc_head = node;
            return;
        } else {
            elt * a1 = alloc_head;
            elt * a2 = a1->next;
  2c0460:	48 8b 46 18          	mov    0x18(%rsi),%rax
            while(a2 != NULL) {
  2c0464:	48 85 c0             	test   %rax,%rax
  2c0467:	75 61                	jne    2c04ca <append_list_ordered+0x12e>
            elt * a1 = alloc_head;
  2c0469:	48 89 f0             	mov    %rsi,%rax
                    return;
                }
                a1 = a2;
                a2 = a2->next;
            }
            a1->next = node;
  2c046c:	48 89 78 18          	mov    %rdi,0x18(%rax)
            node->prev = a1;
  2c0470:	48 89 47 10          	mov    %rax,0x10(%rdi)
            node->next = NULL;
  2c0474:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  2c047b:	00 
            alloc_tail = node;
  2c047c:	48 89 3d 85 1b 00 00 	mov    %rdi,0x1b85(%rip)        # 2c2008 <alloc_tail>
            return;
        }
        return;
    }
}
  2c0483:	c3                   	ret    
            alloc_head = node;
  2c0484:	48 89 3d 85 1b 00 00 	mov    %rdi,0x1b85(%rip)        # 2c2010 <alloc_head>
            alloc_tail = node;
  2c048b:	48 89 3d 76 1b 00 00 	mov    %rdi,0x1b76(%rip)        # 2c2008 <alloc_tail>
            node->prev = NULL;
  2c0492:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  2c0499:	00 
            node->next = NULL;
  2c049a:	48 c7 47 18 00 00 00 	movq   $0x0,0x18(%rdi)
  2c04a1:	00 
            return;
  2c04a2:	c3                   	ret    
            node->prev = NULL;
  2c04a3:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  2c04aa:	00 
            node->next = alloc_head;
  2c04ab:	48 89 77 18          	mov    %rsi,0x18(%rdi)
            alloc_head->prev = node;
  2c04af:	48 89 7e 10          	mov    %rdi,0x10(%rsi)
            alloc_head = node;
  2c04b3:	48 89 3d 56 1b 00 00 	mov    %rdi,0x1b56(%rip)        # 2c2010 <alloc_head>
            return;
  2c04ba:	c3                   	ret    
                a2 = a2->next;
  2c04bb:	48 8b 48 18          	mov    0x18(%rax),%rcx
            while(a2 != NULL) {
  2c04bf:	48 89 c6             	mov    %rax,%rsi
  2c04c2:	48 85 c9             	test   %rcx,%rcx
  2c04c5:	74 a5                	je     2c046c <append_list_ordered+0xd0>
                a2 = a2->next;
  2c04c7:	48 89 c8             	mov    %rcx,%rax
                if(alloc_bytes <= a1->alloc_bytes && alloc_bytes > a2->alloc_bytes) {
  2c04ca:	48 39 56 08          	cmp    %rdx,0x8(%rsi)
  2c04ce:	72 eb                	jb     2c04bb <append_list_ordered+0x11f>
  2c04d0:	48 39 50 08          	cmp    %rdx,0x8(%rax)
  2c04d4:	73 e5                	jae    2c04bb <append_list_ordered+0x11f>
                    node->prev = a1;
  2c04d6:	48 89 77 10          	mov    %rsi,0x10(%rdi)
                    node->next = a2;
  2c04da:	48 89 47 18          	mov    %rax,0x18(%rdi)
                    a1->next = node;
  2c04de:	48 89 7e 18          	mov    %rdi,0x18(%rsi)
                    a2->prev = node;
  2c04e2:	48 89 78 10          	mov    %rdi,0x10(%rax)
                    return;
  2c04e6:	c3                   	ret    

00000000002c04e7 <remove_list>:

void remove_list (elt * node, int free) {
    elt * prev = node->prev;
  2c04e7:	48 8b 57 10          	mov    0x10(%rdi),%rdx
    elt * next = node->next;
  2c04eb:	48 8b 47 18          	mov    0x18(%rdi),%rax
    if(free) {
  2c04ef:	85 f6                	test   %esi,%esi
  2c04f1:	74 3e                	je     2c0531 <remove_list+0x4a>
        if(node == free_head) {
  2c04f3:	48 39 3d 26 1b 00 00 	cmp    %rdi,0x1b26(%rip)        # 2c2020 <free_head>
  2c04fa:	74 23                	je     2c051f <remove_list+0x38>
            free_head = node->next;
        }
        if(node == free_tail) {
  2c04fc:	48 39 3d 15 1b 00 00 	cmp    %rdi,0x1b15(%rip)        # 2c2018 <free_tail>
  2c0503:	74 23                	je     2c0528 <remove_list+0x41>
            free_tail = prev;
        }
        if(prev) {
  2c0505:	48 85 d2             	test   %rdx,%rdx
  2c0508:	74 04                	je     2c050e <remove_list+0x27>
            prev->next = next;
  2c050a:	48 89 42 18          	mov    %rax,0x18(%rdx)
        }
        if(next) {
  2c050e:	48 85 c0             	test   %rax,%rax
  2c0511:	74 04                	je     2c0517 <remove_list+0x30>
            next->prev = prev;
  2c0513:	48 89 50 10          	mov    %rdx,0x10(%rax)
        }
        free_list_size--;
  2c0517:	83 2d e6 1a 00 00 01 	subl   $0x1,0x1ae6(%rip)        # 2c2004 <free_list_size>
        return;
  2c051e:	c3                   	ret    
            free_head = node->next;
  2c051f:	48 89 05 fa 1a 00 00 	mov    %rax,0x1afa(%rip)        # 2c2020 <free_head>
  2c0526:	eb d4                	jmp    2c04fc <remove_list+0x15>
            free_tail = prev;
  2c0528:	48 89 15 e9 1a 00 00 	mov    %rdx,0x1ae9(%rip)        # 2c2018 <free_tail>
  2c052f:	eb d4                	jmp    2c0505 <remove_list+0x1e>
    } else {
        if(node == alloc_head) {
  2c0531:	48 39 3d d8 1a 00 00 	cmp    %rdi,0x1ad8(%rip)        # 2c2010 <alloc_head>
  2c0538:	74 23                	je     2c055d <remove_list+0x76>
            alloc_head = node->next;
        }
        if(node == alloc_tail) {
  2c053a:	48 39 3d c7 1a 00 00 	cmp    %rdi,0x1ac7(%rip)        # 2c2008 <alloc_tail>
  2c0541:	74 23                	je     2c0566 <remove_list+0x7f>
            alloc_tail = prev;
        }
        if(prev) {
  2c0543:	48 85 d2             	test   %rdx,%rdx
  2c0546:	74 04                	je     2c054c <remove_list+0x65>
            prev->next = next;
  2c0548:	48 89 42 18          	mov    %rax,0x18(%rdx)
        }
        if(next) {
  2c054c:	48 85 c0             	test   %rax,%rax
  2c054f:	74 04                	je     2c0555 <remove_list+0x6e>
            next->prev = prev;
  2c0551:	48 89 50 10          	mov    %rdx,0x10(%rax)
        }
        alloc_list_size--;
  2c0555:	83 2d a4 1a 00 00 01 	subl   $0x1,0x1aa4(%rip)        # 2c2000 <alloc_list_size>
        return;
    }
}
  2c055c:	c3                   	ret    
            alloc_head = node->next;
  2c055d:	48 89 05 ac 1a 00 00 	mov    %rax,0x1aac(%rip)        # 2c2010 <alloc_head>
  2c0564:	eb d4                	jmp    2c053a <remove_list+0x53>
            alloc_tail = prev;
  2c0566:	48 89 15 9b 1a 00 00 	mov    %rdx,0x1a9b(%rip)        # 2c2008 <alloc_tail>
  2c056d:	eb d4                	jmp    2c0543 <remove_list+0x5c>

00000000002c056f <search_free>:

elt * search_free (size_t size) {
    elt * p = free_head;
  2c056f:	48 8b 05 aa 1a 00 00 	mov    0x1aaa(%rip),%rax        # 2c2020 <free_head>
    while(p != NULL) {
  2c0576:	48 85 c0             	test   %rax,%rax
  2c0579:	74 0e                	je     2c0589 <search_free+0x1a>
        // is free node big enough?
        if(p->size >= size) {
  2c057b:	48 39 38             	cmp    %rdi,(%rax)
  2c057e:	73 09                	jae    2c0589 <search_free+0x1a>
            return p;
        }
        p = p->next;
  2c0580:	48 8b 40 18          	mov    0x18(%rax),%rax
    while(p != NULL) {
  2c0584:	48 85 c0             	test   %rax,%rax
  2c0587:	75 f2                	jne    2c057b <search_free+0xc>
    }
    return NULL;
}
  2c0589:	c3                   	ret    

00000000002c058a <free>:

void free(void *firstbyte) {
    if(firstbyte == NULL) {
  2c058a:	48 85 ff             	test   %rdi,%rdi
  2c058d:	74 36                	je     2c05c5 <free+0x3b>
void free(void *firstbyte) {
  2c058f:	55                   	push   %rbp
  2c0590:	48 89 e5             	mov    %rsp,%rbp
  2c0593:	41 54                	push   %r12
  2c0595:	53                   	push   %rbx
  2c0596:	48 89 fb             	mov    %rdi,%rbx
        return;
    }
    elt* entire_block = (elt *) ((uintptr_t) firstbyte - HEADER);
  2c0599:	4c 8d 67 e0          	lea    -0x20(%rdi),%r12
    remove_list(entire_block, 0);
  2c059d:	be 00 00 00 00       	mov    $0x0,%esi
  2c05a2:	4c 89 e7             	mov    %r12,%rdi
  2c05a5:	e8 3d ff ff ff       	call   2c04e7 <remove_list>
    append_list_ordered(entire_block, entire_block->size, 0, 1);
  2c05aa:	48 8b 73 e0          	mov    -0x20(%rbx),%rsi
  2c05ae:	b9 01 00 00 00       	mov    $0x1,%ecx
  2c05b3:	ba 00 00 00 00       	mov    $0x0,%edx
  2c05b8:	4c 89 e7             	mov    %r12,%rdi
  2c05bb:	e8 dc fd ff ff       	call   2c039c <append_list_ordered>
    return;
}
  2c05c0:	5b                   	pop    %rbx
  2c05c1:	41 5c                	pop    %r12
  2c05c3:	5d                   	pop    %rbp
  2c05c4:	c3                   	ret    
  2c05c5:	c3                   	ret    

00000000002c05c6 <malloc>:

void *malloc(uint64_t numbytes) {
  2c05c6:	55                   	push   %rbp
  2c05c7:	48 89 e5             	mov    %rsp,%rbp
  2c05ca:	41 57                	push   %r15
  2c05cc:	41 56                	push   %r14
  2c05ce:	41 55                	push   %r13
  2c05d0:	41 54                	push   %r12
  2c05d2:	53                   	push   %rbx
  2c05d3:	48 83 ec 08          	sub    $0x8,%rsp
    if (numbytes == 0) {
        return NULL;
  2c05d7:	bb 00 00 00 00       	mov    $0x0,%ebx
    if (numbytes == 0) {
  2c05dc:	48 85 ff             	test   %rdi,%rdi
  2c05df:	74 64                	je     2c0645 <malloc+0x7f>
  2c05e1:	49 89 fc             	mov    %rdi,%r12
    }
    // required bytes: sizeof(header) + numbytes, then ROUNDUP(8)
    size_t required_size = ROUNDUP(HEADER + numbytes, 8);
  2c05e4:	4c 8d 6f 27          	lea    0x27(%rdi),%r13
  2c05e8:	49 83 e5 f8          	and    $0xfffffffffffffff8,%r13
    // search free list, grow heap if needed
    elt * p = search_free(required_size);
  2c05ec:	4c 89 ef             	mov    %r13,%rdi
  2c05ef:	e8 7b ff ff ff       	call   2c056f <search_free>
  2c05f4:	48 89 c3             	mov    %rax,%rbx
    if(p == NULL) { // grow heap, search again
  2c05f7:	48 85 c0             	test   %rax,%rax
  2c05fa:	74 5b                	je     2c0657 <malloc+0x91>
        }
        elt * chunk = (elt *) chunk_ret;
        append_list_ordered(chunk, chunk_size, 0, 1);
        p = search_free(required_size);
    }
    size_t initial_free_block_size = p->size; // size of free block
  2c05fc:	4c 8b 33             	mov    (%rbx),%r14
    uintptr_t alloc_start = (uintptr_t) p; // start of to-be-allocated block
  2c05ff:	49 89 df             	mov    %rbx,%r15
    remove_list(p, 1); // remove the free block from free list, since we are allocating it
  2c0602:	be 01 00 00 00       	mov    $0x1,%esi
  2c0607:	48 89 df             	mov    %rbx,%rdi
  2c060a:	e8 d8 fe ff ff       	call   2c04e7 <remove_list>
    if(initial_free_block_size - required_size >= HEADER) { // free block split into alloc and free
  2c060f:	4c 89 f6             	mov    %r14,%rsi
  2c0612:	4c 29 ee             	sub    %r13,%rsi
  2c0615:	48 83 fe 1f          	cmp    $0x1f,%rsi
  2c0619:	76 7e                	jbe    2c0699 <malloc+0xd3>
        elt * free_part = (elt *) (alloc_start + required_size);
  2c061b:	4a 8d 3c 2b          	lea    (%rbx,%r13,1),%rdi
        append_list_ordered(free_part, initial_free_block_size - required_size, 0, 1);
  2c061f:	b9 01 00 00 00       	mov    $0x1,%ecx
  2c0624:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0629:	e8 6e fd ff ff       	call   2c039c <append_list_ordered>
        append_list_ordered(p, required_size, numbytes, 0);
  2c062e:	b9 00 00 00 00       	mov    $0x0,%ecx
  2c0633:	4c 89 e2             	mov    %r12,%rdx
  2c0636:	4c 89 ee             	mov    %r13,%rsi
  2c0639:	48 89 df             	mov    %rbx,%rdi
  2c063c:	e8 5b fd ff ff       	call   2c039c <append_list_ordered>
    } else { // add to alloc list w/ initial size, since we didn't split
        append_list_ordered(p, initial_free_block_size, numbytes, 0);
    }
    // return address of payload
    void * payload = (void *) (alloc_start + HEADER);
  2c0641:	49 8d 5f 20          	lea    0x20(%r15),%rbx
    return payload;
}
  2c0645:	48 89 d8             	mov    %rbx,%rax
  2c0648:	48 83 c4 08          	add    $0x8,%rsp
  2c064c:	5b                   	pop    %rbx
  2c064d:	41 5c                	pop    %r12
  2c064f:	41 5d                	pop    %r13
  2c0651:	41 5e                	pop    %r14
  2c0653:	41 5f                	pop    %r15
  2c0655:	5d                   	pop    %rbp
  2c0656:	c3                   	ret    
        size_t chunk_size = ROUNDUP(required_size, PAGESIZE * 4);
  2c0657:	49 8d b5 ff 3f 00 00 	lea    0x3fff(%r13),%rsi
  2c065e:	48 81 e6 00 c0 ff ff 	and    $0xffffffffffffc000,%rsi
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  2c0665:	48 89 f7             	mov    %rsi,%rdi
  2c0668:	cd 3a                	int    $0x3a
  2c066a:	48 89 c7             	mov    %rax,%rdi
  2c066d:	48 89 05 b4 19 00 00 	mov    %rax,0x19b4(%rip)        # 2c2028 <result.0>
        if(chunk_ret == (void *) -1) {
  2c0674:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  2c0678:	74 cb                	je     2c0645 <malloc+0x7f>
        append_list_ordered(chunk, chunk_size, 0, 1);
  2c067a:	b9 01 00 00 00       	mov    $0x1,%ecx
  2c067f:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0684:	e8 13 fd ff ff       	call   2c039c <append_list_ordered>
        p = search_free(required_size);
  2c0689:	4c 89 ef             	mov    %r13,%rdi
  2c068c:	e8 de fe ff ff       	call   2c056f <search_free>
  2c0691:	48 89 c3             	mov    %rax,%rbx
  2c0694:	e9 63 ff ff ff       	jmp    2c05fc <malloc+0x36>
        append_list_ordered(p, initial_free_block_size, numbytes, 0);
  2c0699:	b9 00 00 00 00       	mov    $0x0,%ecx
  2c069e:	4c 89 e2             	mov    %r12,%rdx
  2c06a1:	4c 89 f6             	mov    %r14,%rsi
  2c06a4:	48 89 df             	mov    %rbx,%rdi
  2c06a7:	e8 f0 fc ff ff       	call   2c039c <append_list_ordered>
  2c06ac:	eb 93                	jmp    2c0641 <malloc+0x7b>

00000000002c06ae <calloc>:


void * calloc(uint64_t num, uint64_t sz) {
  2c06ae:	55                   	push   %rbp
  2c06af:	48 89 e5             	mov    %rsp,%rbp
  2c06b2:	41 54                	push   %r12
  2c06b4:	53                   	push   %rbx
    if(num == 0 || sz == 0) {
  2c06b5:	48 85 ff             	test   %rdi,%rdi
  2c06b8:	74 3e                	je     2c06f8 <calloc+0x4a>
  2c06ba:	48 85 f6             	test   %rsi,%rsi
  2c06bd:	74 39                	je     2c06f8 <calloc+0x4a>
        return NULL;
    }
    if(sz > ((uint64_t) -1) / num) {
        return NULL;
  2c06bf:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    if(sz > ((uint64_t) -1) / num) {
  2c06c5:	48 89 f8             	mov    %rdi,%rax
  2c06c8:	48 f7 e6             	mul    %rsi
  2c06cb:	70 23                	jo     2c06f0 <calloc+0x42>
    }
    void * malloc_ret = malloc(num*sz);
  2c06cd:	48 89 c3             	mov    %rax,%rbx
  2c06d0:	48 89 c7             	mov    %rax,%rdi
  2c06d3:	e8 ee fe ff ff       	call   2c05c6 <malloc>
  2c06d8:	49 89 c4             	mov    %rax,%r12
    if(malloc_ret == NULL) {
  2c06db:	48 85 c0             	test   %rax,%rax
  2c06de:	74 10                	je     2c06f0 <calloc+0x42>
        return NULL;
    }
    memset(malloc_ret, 0, num*sz);
  2c06e0:	48 89 da             	mov    %rbx,%rdx
  2c06e3:	be 00 00 00 00       	mov    $0x0,%esi
  2c06e8:	48 89 c7             	mov    %rax,%rdi
  2c06eb:	e8 e0 02 00 00       	call   2c09d0 <memset>
    return malloc_ret;
}
  2c06f0:	4c 89 e0             	mov    %r12,%rax
  2c06f3:	5b                   	pop    %rbx
  2c06f4:	41 5c                	pop    %r12
  2c06f6:	5d                   	pop    %rbp
  2c06f7:	c3                   	ret    
        return NULL;
  2c06f8:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c06fe:	eb f0                	jmp    2c06f0 <calloc+0x42>

00000000002c0700 <realloc>:

void * realloc(void * ptr, uint64_t sz) {
  2c0700:	55                   	push   %rbp
  2c0701:	48 89 e5             	mov    %rsp,%rbp
  2c0704:	41 55                	push   %r13
  2c0706:	41 54                	push   %r12
  2c0708:	53                   	push   %rbx
  2c0709:	48 83 ec 08          	sub    $0x8,%rsp
  2c070d:	48 89 f3             	mov    %rsi,%rbx
    if(ptr == NULL) {
  2c0710:	48 85 ff             	test   %rdi,%rdi
  2c0713:	74 48                	je     2c075d <realloc+0x5d>
  2c0715:	49 89 fc             	mov    %rdi,%r12
        return malloc(sz);
    }
    if(sz == 0) {
  2c0718:	48 85 f6             	test   %rsi,%rsi
  2c071b:	74 4d                	je     2c076a <realloc+0x6a>
        free(ptr);
        return NULL;
    }
    void * new_payload = malloc(sz);
  2c071d:	48 89 f7             	mov    %rsi,%rdi
  2c0720:	e8 a1 fe ff ff       	call   2c05c6 <malloc>
  2c0725:	49 89 c5             	mov    %rax,%r13
    if(new_payload == NULL) {
  2c0728:	48 85 c0             	test   %rax,%rax
  2c072b:	74 22                	je     2c074f <realloc+0x4f>
    if(original_header->size < sz) {
        newsize = original_header->size;
    } else {
        newsize = sz;
    }
    memcpy(new_payload, ptr, newsize);
  2c072d:	49 8b 44 24 e0       	mov    -0x20(%r12),%rax
  2c0732:	48 39 c3             	cmp    %rax,%rbx
  2c0735:	48 0f 46 c3          	cmovbe %rbx,%rax
  2c0739:	48 89 c2             	mov    %rax,%rdx
  2c073c:	4c 89 e6             	mov    %r12,%rsi
  2c073f:	4c 89 ef             	mov    %r13,%rdi
  2c0742:	e8 8b 01 00 00       	call   2c08d2 <memcpy>
    free(ptr);
  2c0747:	4c 89 e7             	mov    %r12,%rdi
  2c074a:	e8 3b fe ff ff       	call   2c058a <free>
    return new_payload;
}
  2c074f:	4c 89 e8             	mov    %r13,%rax
  2c0752:	48 83 c4 08          	add    $0x8,%rsp
  2c0756:	5b                   	pop    %rbx
  2c0757:	41 5c                	pop    %r12
  2c0759:	41 5d                	pop    %r13
  2c075b:	5d                   	pop    %rbp
  2c075c:	c3                   	ret    
        return malloc(sz);
  2c075d:	48 89 f7             	mov    %rsi,%rdi
  2c0760:	e8 61 fe ff ff       	call   2c05c6 <malloc>
  2c0765:	49 89 c5             	mov    %rax,%r13
  2c0768:	eb e5                	jmp    2c074f <realloc+0x4f>
        free(ptr);
  2c076a:	e8 1b fe ff ff       	call   2c058a <free>
        return NULL;
  2c076f:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  2c0775:	eb d8                	jmp    2c074f <realloc+0x4f>

00000000002c0777 <defrag>:

void defrag() {
  2c0777:	55                   	push   %rbp
  2c0778:	48 89 e5             	mov    %rsp,%rbp
  2c077b:	53                   	push   %rbx
  2c077c:	48 83 ec 08          	sub    $0x8,%rsp
    // change append function to insert free blocks by ascending order of address
    if(free_head == NULL) {
  2c0780:	48 8b 1d 99 18 00 00 	mov    0x1899(%rip),%rbx        # 2c2020 <free_head>
  2c0787:	48 85 db             	test   %rbx,%rbx
  2c078a:	74 09                	je     2c0795 <defrag+0x1e>
        return;
    }
    elt * p1 = free_head;
    elt * p2 = p1->next;
  2c078c:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    while(p2 != NULL) {
  2c0790:	48 85 ff             	test   %rdi,%rdi
  2c0793:	75 1f                	jne    2c07b4 <defrag+0x3d>
            p1 = p2;
            p2 = p2->next;
        }
    }
    return;
}
  2c0795:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c0799:	c9                   	leave  
  2c079a:	c3                   	ret    
            p1->size += p2->size;
  2c079b:	48 03 07             	add    (%rdi),%rax
  2c079e:	48 89 03             	mov    %rax,(%rbx)
            remove_list(p2, 1);
  2c07a1:	be 01 00 00 00       	mov    $0x1,%esi
  2c07a6:	e8 3c fd ff ff       	call   2c04e7 <remove_list>
            p2 = p1->next;
  2c07ab:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    while(p2 != NULL) {
  2c07af:	48 85 ff             	test   %rdi,%rdi
  2c07b2:	74 e1                	je     2c0795 <defrag+0x1e>
        if(p2_addr - p1_addr == p1->size) { // coalesce
  2c07b4:	48 8b 03             	mov    (%rbx),%rax
  2c07b7:	48 89 fa             	mov    %rdi,%rdx
  2c07ba:	48 29 da             	sub    %rbx,%rdx
  2c07bd:	48 39 c2             	cmp    %rax,%rdx
  2c07c0:	74 d9                	je     2c079b <defrag+0x24>
            p2 = p2->next;
  2c07c2:	48 89 fb             	mov    %rdi,%rbx
  2c07c5:	48 8b 7f 18          	mov    0x18(%rdi),%rdi
  2c07c9:	eb e4                	jmp    2c07af <defrag+0x38>

00000000002c07cb <heap_info>:

int heap_info(heap_info_struct * info) {
  2c07cb:	55                   	push   %rbp
  2c07cc:	48 89 e5             	mov    %rsp,%rbp
  2c07cf:	41 55                	push   %r13
  2c07d1:	41 54                	push   %r12
  2c07d3:	53                   	push   %rbx
  2c07d4:	48 83 ec 08          	sub    $0x8,%rsp
  2c07d8:	48 89 fb             	mov    %rdi,%rbx
    // change append function to insert alloc'd blocks by descending order of size
    info->num_allocs = alloc_list_size;
  2c07db:	8b 0d 1f 18 00 00    	mov    0x181f(%rip),%ecx        # 2c2000 <alloc_list_size>
  2c07e1:	89 0f                	mov    %ecx,(%rdi)

    elt * f1 = free_head;
  2c07e3:	48 8b 05 36 18 00 00 	mov    0x1836(%rip),%rax        # 2c2020 <free_head>
    info->free_space = 0;
  2c07ea:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
    info->largest_free_chunk = 0;
  2c07f1:	c7 47 1c 00 00 00 00 	movl   $0x0,0x1c(%rdi)
    while (f1 != NULL) {
  2c07f8:	48 85 c0             	test   %rax,%rax
  2c07fb:	75 2a                	jne    2c0827 <heap_info+0x5c>
            info->largest_free_chunk = (int) f1->size;
        }
        f1 = f1->next;
    }

    if(info->num_allocs == 0) {
  2c07fd:	85 c9                	test   %ecx,%ecx
  2c07ff:	75 39                	jne    2c083a <heap_info+0x6f>
        info->size_array = NULL;
  2c0801:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  2c0808:	00 
        info->ptr_array = NULL;
  2c0809:	48 c7 43 10 00 00 00 	movq   $0x0,0x10(%rbx)
  2c0810:	00 
        x1 = x1->next;
    }
    info->size_array = size_array;
    info->ptr_array = ptr_array;
    return 0;
}
  2c0811:	89 c8                	mov    %ecx,%eax
  2c0813:	48 83 c4 08          	add    $0x8,%rsp
  2c0817:	5b                   	pop    %rbx
  2c0818:	41 5c                	pop    %r12
  2c081a:	41 5d                	pop    %r13
  2c081c:	5d                   	pop    %rbp
  2c081d:	c3                   	ret    
        f1 = f1->next;
  2c081e:	48 8b 40 18          	mov    0x18(%rax),%rax
    while (f1 != NULL) {
  2c0822:	48 85 c0             	test   %rax,%rax
  2c0825:	74 d6                	je     2c07fd <heap_info+0x32>
        info->free_space += f1->size;
  2c0827:	48 8b 10             	mov    (%rax),%rdx
  2c082a:	01 53 18             	add    %edx,0x18(%rbx)
        if((int) f1->size >= info->largest_free_chunk) {
  2c082d:	48 8b 10             	mov    (%rax),%rdx
  2c0830:	3b 53 1c             	cmp    0x1c(%rbx),%edx
  2c0833:	7c e9                	jl     2c081e <heap_info+0x53>
            info->largest_free_chunk = (int) f1->size;
  2c0835:	89 53 1c             	mov    %edx,0x1c(%rbx)
  2c0838:	eb e4                	jmp    2c081e <heap_info+0x53>
    long * size_array = malloc(info->num_allocs * sizeof(long));
  2c083a:	48 63 c9             	movslq %ecx,%rcx
  2c083d:	48 8d 3c cd 00 00 00 	lea    0x0(,%rcx,8),%rdi
  2c0844:	00 
  2c0845:	e8 7c fd ff ff       	call   2c05c6 <malloc>
  2c084a:	49 89 c4             	mov    %rax,%r12
    if(size_array == NULL) {
  2c084d:	48 85 c0             	test   %rax,%rax
  2c0850:	74 6c                	je     2c08be <heap_info+0xf3>
    uintptr_t size_array_addr = (uintptr_t) size_array - HEADER;
  2c0852:	4c 8d 68 e0          	lea    -0x20(%rax),%r13
    void ** ptr_array = malloc(info->num_allocs * sizeof(void *));
  2c0856:	48 63 3b             	movslq (%rbx),%rdi
  2c0859:	48 c1 e7 03          	shl    $0x3,%rdi
  2c085d:	e8 64 fd ff ff       	call   2c05c6 <malloc>
    if(ptr_array == NULL) {
  2c0862:	48 85 c0             	test   %rax,%rax
  2c0865:	74 61                	je     2c08c8 <heap_info+0xfd>
    uintptr_t ptr_array_addr = (uintptr_t) ptr_array - HEADER;
  2c0867:	4c 8d 48 e0          	lea    -0x20(%rax),%r9
    elt * x1 = alloc_head;
  2c086b:	48 8b 15 9e 17 00 00 	mov    0x179e(%rip),%rdx        # 2c2010 <alloc_head>
    while (x1 != NULL) {
  2c0872:	48 85 d2             	test   %rdx,%rdx
  2c0875:	74 35                	je     2c08ac <heap_info+0xe1>
    int i = 0;
  2c0877:	be 00 00 00 00       	mov    $0x0,%esi
  2c087c:	eb 1f                	jmp    2c089d <heap_info+0xd2>
            size_array[i] = (long) x1->alloc_bytes;
  2c087e:	48 63 fe             	movslq %esi,%rdi
  2c0881:	4c 8b 42 08          	mov    0x8(%rdx),%r8
  2c0885:	4d 89 04 fc          	mov    %r8,(%r12,%rdi,8)
            ptr_array[i] = (void *) ((uintptr_t) x1 + HEADER);
  2c0889:	48 83 c1 20          	add    $0x20,%rcx
  2c088d:	48 89 0c f8          	mov    %rcx,(%rax,%rdi,8)
            i++;
  2c0891:	83 c6 01             	add    $0x1,%esi
        x1 = x1->next;
  2c0894:	48 8b 52 18          	mov    0x18(%rdx),%rdx
    while (x1 != NULL) {
  2c0898:	48 85 d2             	test   %rdx,%rdx
  2c089b:	74 0f                	je     2c08ac <heap_info+0xe1>
        if(((uintptr_t) x1 != size_array_addr) && ((uintptr_t) x1 != ptr_array_addr)) {
  2c089d:	48 89 d1             	mov    %rdx,%rcx
  2c08a0:	4c 39 ea             	cmp    %r13,%rdx
  2c08a3:	74 ef                	je     2c0894 <heap_info+0xc9>
  2c08a5:	4c 39 ca             	cmp    %r9,%rdx
  2c08a8:	75 d4                	jne    2c087e <heap_info+0xb3>
  2c08aa:	eb e8                	jmp    2c0894 <heap_info+0xc9>
    info->size_array = size_array;
  2c08ac:	4c 89 63 08          	mov    %r12,0x8(%rbx)
    info->ptr_array = ptr_array;
  2c08b0:	48 89 43 10          	mov    %rax,0x10(%rbx)
    return 0;
  2c08b4:	b9 00 00 00 00       	mov    $0x0,%ecx
  2c08b9:	e9 53 ff ff ff       	jmp    2c0811 <heap_info+0x46>
        return -1;
  2c08be:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  2c08c3:	e9 49 ff ff ff       	jmp    2c0811 <heap_info+0x46>
        return -1;
  2c08c8:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  2c08cd:	e9 3f ff ff ff       	jmp    2c0811 <heap_info+0x46>

00000000002c08d2 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
  2c08d2:	55                   	push   %rbp
  2c08d3:	48 89 e5             	mov    %rsp,%rbp
  2c08d6:	48 83 ec 28          	sub    $0x28,%rsp
  2c08da:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c08de:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c08e2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c08e6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c08ea:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c08ee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c08f2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  2c08f6:	eb 1c                	jmp    2c0914 <memcpy+0x42>
        *d = *s;
  2c08f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c08fc:	0f b6 10             	movzbl (%rax),%edx
  2c08ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0903:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0905:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c090a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c090f:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  2c0914:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0919:	75 dd                	jne    2c08f8 <memcpy+0x26>
    }
    return dst;
  2c091b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c091f:	c9                   	leave  
  2c0920:	c3                   	ret    

00000000002c0921 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
  2c0921:	55                   	push   %rbp
  2c0922:	48 89 e5             	mov    %rsp,%rbp
  2c0925:	48 83 ec 28          	sub    $0x28,%rsp
  2c0929:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c092d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0931:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
  2c0935:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0939:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
  2c093d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0941:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
  2c0945:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0949:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
  2c094d:	73 6a                	jae    2c09b9 <memmove+0x98>
  2c094f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c0953:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0957:	48 01 d0             	add    %rdx,%rax
  2c095a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
  2c095e:	73 59                	jae    2c09b9 <memmove+0x98>
        s += n, d += n;
  2c0960:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c0964:	48 01 45 f8          	add    %rax,-0x8(%rbp)
  2c0968:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c096c:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
  2c0970:	eb 17                	jmp    2c0989 <memmove+0x68>
            *--d = *--s;
  2c0972:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
  2c0977:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
  2c097c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0980:	0f b6 10             	movzbl (%rax),%edx
  2c0983:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0987:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c0989:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c098d:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c0991:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c0995:	48 85 c0             	test   %rax,%rax
  2c0998:	75 d8                	jne    2c0972 <memmove+0x51>
    if (s < d && s + n > d) {
  2c099a:	eb 2e                	jmp    2c09ca <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
  2c099c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c09a0:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c09a4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c09a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c09ac:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c09b0:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
  2c09b4:	0f b6 12             	movzbl (%rdx),%edx
  2c09b7:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
  2c09b9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c09bd:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c09c1:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  2c09c5:	48 85 c0             	test   %rax,%rax
  2c09c8:	75 d2                	jne    2c099c <memmove+0x7b>
        }
    }
    return dst;
  2c09ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c09ce:	c9                   	leave  
  2c09cf:	c3                   	ret    

00000000002c09d0 <memset>:

void* memset(void* v, int c, size_t n) {
  2c09d0:	55                   	push   %rbp
  2c09d1:	48 89 e5             	mov    %rsp,%rbp
  2c09d4:	48 83 ec 28          	sub    $0x28,%rsp
  2c09d8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c09dc:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  2c09df:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c09e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c09e7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  2c09eb:	eb 15                	jmp    2c0a02 <memset+0x32>
        *p = c;
  2c09ed:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c09f0:	89 c2                	mov    %eax,%edx
  2c09f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c09f6:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c09f8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c09fd:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
  2c0a02:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c0a07:	75 e4                	jne    2c09ed <memset+0x1d>
    }
    return v;
  2c0a09:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0a0d:	c9                   	leave  
  2c0a0e:	c3                   	ret    

00000000002c0a0f <strlen>:

size_t strlen(const char* s) {
  2c0a0f:	55                   	push   %rbp
  2c0a10:	48 89 e5             	mov    %rsp,%rbp
  2c0a13:	48 83 ec 18          	sub    $0x18,%rsp
  2c0a17:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
  2c0a1b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0a22:	00 
  2c0a23:	eb 0a                	jmp    2c0a2f <strlen+0x20>
        ++n;
  2c0a25:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
  2c0a2a:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0a2f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0a33:	0f b6 00             	movzbl (%rax),%eax
  2c0a36:	84 c0                	test   %al,%al
  2c0a38:	75 eb                	jne    2c0a25 <strlen+0x16>
    }
    return n;
  2c0a3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0a3e:	c9                   	leave  
  2c0a3f:	c3                   	ret    

00000000002c0a40 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
  2c0a40:	55                   	push   %rbp
  2c0a41:	48 89 e5             	mov    %rsp,%rbp
  2c0a44:	48 83 ec 20          	sub    $0x20,%rsp
  2c0a48:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0a4c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0a50:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
  2c0a57:	00 
  2c0a58:	eb 0a                	jmp    2c0a64 <strnlen+0x24>
        ++n;
  2c0a5a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c0a5f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  2c0a64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0a68:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
  2c0a6c:	74 0b                	je     2c0a79 <strnlen+0x39>
  2c0a6e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0a72:	0f b6 00             	movzbl (%rax),%eax
  2c0a75:	84 c0                	test   %al,%al
  2c0a77:	75 e1                	jne    2c0a5a <strnlen+0x1a>
    }
    return n;
  2c0a79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
  2c0a7d:	c9                   	leave  
  2c0a7e:	c3                   	ret    

00000000002c0a7f <strcpy>:

char* strcpy(char* dst, const char* src) {
  2c0a7f:	55                   	push   %rbp
  2c0a80:	48 89 e5             	mov    %rsp,%rbp
  2c0a83:	48 83 ec 20          	sub    $0x20,%rsp
  2c0a87:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0a8b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
  2c0a8f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0a93:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
  2c0a97:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c0a9b:	48 8d 42 01          	lea    0x1(%rdx),%rax
  2c0a9f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  2c0aa3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0aa7:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c0aab:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
  2c0aaf:	0f b6 12             	movzbl (%rdx),%edx
  2c0ab2:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
  2c0ab4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ab8:	48 83 e8 01          	sub    $0x1,%rax
  2c0abc:	0f b6 00             	movzbl (%rax),%eax
  2c0abf:	84 c0                	test   %al,%al
  2c0ac1:	75 d4                	jne    2c0a97 <strcpy+0x18>
    return dst;
  2c0ac3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0ac7:	c9                   	leave  
  2c0ac8:	c3                   	ret    

00000000002c0ac9 <strcmp>:

int strcmp(const char* a, const char* b) {
  2c0ac9:	55                   	push   %rbp
  2c0aca:	48 89 e5             	mov    %rsp,%rbp
  2c0acd:	48 83 ec 10          	sub    $0x10,%rsp
  2c0ad1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0ad5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0ad9:	eb 0a                	jmp    2c0ae5 <strcmp+0x1c>
        ++a, ++b;
  2c0adb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
  2c0ae0:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
  2c0ae5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0ae9:	0f b6 00             	movzbl (%rax),%eax
  2c0aec:	84 c0                	test   %al,%al
  2c0aee:	74 1d                	je     2c0b0d <strcmp+0x44>
  2c0af0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0af4:	0f b6 00             	movzbl (%rax),%eax
  2c0af7:	84 c0                	test   %al,%al
  2c0af9:	74 12                	je     2c0b0d <strcmp+0x44>
  2c0afb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0aff:	0f b6 10             	movzbl (%rax),%edx
  2c0b02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0b06:	0f b6 00             	movzbl (%rax),%eax
  2c0b09:	38 c2                	cmp    %al,%dl
  2c0b0b:	74 ce                	je     2c0adb <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
  2c0b0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0b11:	0f b6 00             	movzbl (%rax),%eax
  2c0b14:	89 c2                	mov    %eax,%edx
  2c0b16:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0b1a:	0f b6 00             	movzbl (%rax),%eax
  2c0b1d:	38 d0                	cmp    %dl,%al
  2c0b1f:	0f 92 c0             	setb   %al
  2c0b22:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
  2c0b25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0b29:	0f b6 00             	movzbl (%rax),%eax
  2c0b2c:	89 c1                	mov    %eax,%ecx
  2c0b2e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c0b32:	0f b6 00             	movzbl (%rax),%eax
  2c0b35:	38 c1                	cmp    %al,%cl
  2c0b37:	0f 92 c0             	setb   %al
  2c0b3a:	0f b6 c0             	movzbl %al,%eax
  2c0b3d:	29 c2                	sub    %eax,%edx
  2c0b3f:	89 d0                	mov    %edx,%eax
}
  2c0b41:	c9                   	leave  
  2c0b42:	c3                   	ret    

00000000002c0b43 <strchr>:

char* strchr(const char* s, int c) {
  2c0b43:	55                   	push   %rbp
  2c0b44:	48 89 e5             	mov    %rsp,%rbp
  2c0b47:	48 83 ec 10          	sub    $0x10,%rsp
  2c0b4b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  2c0b4f:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
  2c0b52:	eb 05                	jmp    2c0b59 <strchr+0x16>
        ++s;
  2c0b54:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
  2c0b59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0b5d:	0f b6 00             	movzbl (%rax),%eax
  2c0b60:	84 c0                	test   %al,%al
  2c0b62:	74 0e                	je     2c0b72 <strchr+0x2f>
  2c0b64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0b68:	0f b6 00             	movzbl (%rax),%eax
  2c0b6b:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0b6e:	38 d0                	cmp    %dl,%al
  2c0b70:	75 e2                	jne    2c0b54 <strchr+0x11>
    }
    if (*s == (char) c) {
  2c0b72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0b76:	0f b6 00             	movzbl (%rax),%eax
  2c0b79:	8b 55 f4             	mov    -0xc(%rbp),%edx
  2c0b7c:	38 d0                	cmp    %dl,%al
  2c0b7e:	75 06                	jne    2c0b86 <strchr+0x43>
        return (char*) s;
  2c0b80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0b84:	eb 05                	jmp    2c0b8b <strchr+0x48>
    } else {
        return NULL;
  2c0b86:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
  2c0b8b:	c9                   	leave  
  2c0b8c:	c3                   	ret    

00000000002c0b8d <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
  2c0b8d:	55                   	push   %rbp
  2c0b8e:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
  2c0b91:	8b 05 99 14 00 00    	mov    0x1499(%rip),%eax        # 2c2030 <rand_seed_set>
  2c0b97:	85 c0                	test   %eax,%eax
  2c0b99:	75 0a                	jne    2c0ba5 <rand+0x18>
        srand(819234718U);
  2c0b9b:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
  2c0ba0:	e8 24 00 00 00       	call   2c0bc9 <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0ba5:	8b 05 89 14 00 00    	mov    0x1489(%rip),%eax        # 2c2034 <rand_seed>
  2c0bab:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
  2c0bb1:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0bb6:	89 05 78 14 00 00    	mov    %eax,0x1478(%rip)        # 2c2034 <rand_seed>
    return rand_seed & RAND_MAX;
  2c0bbc:	8b 05 72 14 00 00    	mov    0x1472(%rip),%eax        # 2c2034 <rand_seed>
  2c0bc2:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c0bc7:	5d                   	pop    %rbp
  2c0bc8:	c3                   	ret    

00000000002c0bc9 <srand>:

void srand(unsigned seed) {
  2c0bc9:	55                   	push   %rbp
  2c0bca:	48 89 e5             	mov    %rsp,%rbp
  2c0bcd:	48 83 ec 08          	sub    $0x8,%rsp
  2c0bd1:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
  2c0bd4:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c0bd7:	89 05 57 14 00 00    	mov    %eax,0x1457(%rip)        # 2c2034 <rand_seed>
    rand_seed_set = 1;
  2c0bdd:	c7 05 49 14 00 00 01 	movl   $0x1,0x1449(%rip)        # 2c2030 <rand_seed_set>
  2c0be4:	00 00 00 
}
  2c0be7:	90                   	nop
  2c0be8:	c9                   	leave  
  2c0be9:	c3                   	ret    

00000000002c0bea <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
  2c0bea:	55                   	push   %rbp
  2c0beb:	48 89 e5             	mov    %rsp,%rbp
  2c0bee:	48 83 ec 28          	sub    $0x28,%rsp
  2c0bf2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c0bf6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  2c0bfa:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
  2c0bfd:	48 c7 45 f8 00 1c 2c 	movq   $0x2c1c00,-0x8(%rbp)
  2c0c04:	00 
    if (base < 0) {
  2c0c05:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
  2c0c09:	79 0b                	jns    2c0c16 <fill_numbuf+0x2c>
        digits = lower_digits;
  2c0c0b:	48 c7 45 f8 20 1c 2c 	movq   $0x2c1c20,-0x8(%rbp)
  2c0c12:	00 
        base = -base;
  2c0c13:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
  2c0c16:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0c1b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0c1f:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
  2c0c22:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0c25:	48 63 c8             	movslq %eax,%rcx
  2c0c28:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0c2c:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0c31:	48 f7 f1             	div    %rcx
  2c0c34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0c38:	48 01 d0             	add    %rdx,%rax
  2c0c3b:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
  2c0c40:	0f b6 10             	movzbl (%rax),%edx
  2c0c43:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c0c47:	88 10                	mov    %dl,(%rax)
        val /= base;
  2c0c49:	8b 45 dc             	mov    -0x24(%rbp),%eax
  2c0c4c:	48 63 f0             	movslq %eax,%rsi
  2c0c4f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0c53:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0c58:	48 f7 f6             	div    %rsi
  2c0c5b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
  2c0c5f:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
  2c0c64:	75 bc                	jne    2c0c22 <fill_numbuf+0x38>
    return numbuf_end;
  2c0c66:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
  2c0c6a:	c9                   	leave  
  2c0c6b:	c3                   	ret    

00000000002c0c6c <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0c6c:	55                   	push   %rbp
  2c0c6d:	48 89 e5             	mov    %rsp,%rbp
  2c0c70:	53                   	push   %rbx
  2c0c71:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
  2c0c78:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
  2c0c7f:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
  2c0c85:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0c8c:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
  2c0c93:	e9 8a 09 00 00       	jmp    2c1622 <printer_vprintf+0x9b6>
        if (*format != '%') {
  2c0c98:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0c9f:	0f b6 00             	movzbl (%rax),%eax
  2c0ca2:	3c 25                	cmp    $0x25,%al
  2c0ca4:	74 31                	je     2c0cd7 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
  2c0ca6:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0cad:	4c 8b 00             	mov    (%rax),%r8
  2c0cb0:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0cb7:	0f b6 00             	movzbl (%rax),%eax
  2c0cba:	0f b6 c8             	movzbl %al,%ecx
  2c0cbd:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c0cc3:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c0cca:	89 ce                	mov    %ecx,%esi
  2c0ccc:	48 89 c7             	mov    %rax,%rdi
  2c0ccf:	41 ff d0             	call   *%r8
            continue;
  2c0cd2:	e9 43 09 00 00       	jmp    2c161a <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
  2c0cd7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0cde:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0ce5:	01 
  2c0ce6:	eb 44                	jmp    2c0d2c <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
  2c0ce8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0cef:	0f b6 00             	movzbl (%rax),%eax
  2c0cf2:	0f be c0             	movsbl %al,%eax
  2c0cf5:	89 c6                	mov    %eax,%esi
  2c0cf7:	bf 20 1a 2c 00       	mov    $0x2c1a20,%edi
  2c0cfc:	e8 42 fe ff ff       	call   2c0b43 <strchr>
  2c0d01:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
  2c0d05:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
  2c0d0a:	74 30                	je     2c0d3c <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
  2c0d0c:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c0d10:	48 2d 20 1a 2c 00    	sub    $0x2c1a20,%rax
  2c0d16:	ba 01 00 00 00       	mov    $0x1,%edx
  2c0d1b:	89 c1                	mov    %eax,%ecx
  2c0d1d:	d3 e2                	shl    %cl,%edx
  2c0d1f:	89 d0                	mov    %edx,%eax
  2c0d21:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
  2c0d24:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0d2b:	01 
  2c0d2c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d33:	0f b6 00             	movzbl (%rax),%eax
  2c0d36:	84 c0                	test   %al,%al
  2c0d38:	75 ae                	jne    2c0ce8 <printer_vprintf+0x7c>
  2c0d3a:	eb 01                	jmp    2c0d3d <printer_vprintf+0xd1>
            } else {
                break;
  2c0d3c:	90                   	nop
            }
        }

        // process width
        int width = -1;
  2c0d3d:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
  2c0d44:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d4b:	0f b6 00             	movzbl (%rax),%eax
  2c0d4e:	3c 30                	cmp    $0x30,%al
  2c0d50:	7e 67                	jle    2c0db9 <printer_vprintf+0x14d>
  2c0d52:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d59:	0f b6 00             	movzbl (%rax),%eax
  2c0d5c:	3c 39                	cmp    $0x39,%al
  2c0d5e:	7f 59                	jg     2c0db9 <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0d60:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
  2c0d67:	eb 2e                	jmp    2c0d97 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
  2c0d69:	8b 55 e8             	mov    -0x18(%rbp),%edx
  2c0d6c:	89 d0                	mov    %edx,%eax
  2c0d6e:	c1 e0 02             	shl    $0x2,%eax
  2c0d71:	01 d0                	add    %edx,%eax
  2c0d73:	01 c0                	add    %eax,%eax
  2c0d75:	89 c1                	mov    %eax,%ecx
  2c0d77:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d7e:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0d82:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0d89:	0f b6 00             	movzbl (%rax),%eax
  2c0d8c:	0f be c0             	movsbl %al,%eax
  2c0d8f:	01 c8                	add    %ecx,%eax
  2c0d91:	83 e8 30             	sub    $0x30,%eax
  2c0d94:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0d97:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0d9e:	0f b6 00             	movzbl (%rax),%eax
  2c0da1:	3c 2f                	cmp    $0x2f,%al
  2c0da3:	0f 8e 85 00 00 00    	jle    2c0e2e <printer_vprintf+0x1c2>
  2c0da9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0db0:	0f b6 00             	movzbl (%rax),%eax
  2c0db3:	3c 39                	cmp    $0x39,%al
  2c0db5:	7e b2                	jle    2c0d69 <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
  2c0db7:	eb 75                	jmp    2c0e2e <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
  2c0db9:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0dc0:	0f b6 00             	movzbl (%rax),%eax
  2c0dc3:	3c 2a                	cmp    $0x2a,%al
  2c0dc5:	75 68                	jne    2c0e2f <printer_vprintf+0x1c3>
            width = va_arg(val, int);
  2c0dc7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0dce:	8b 00                	mov    (%rax),%eax
  2c0dd0:	83 f8 2f             	cmp    $0x2f,%eax
  2c0dd3:	77 30                	ja     2c0e05 <printer_vprintf+0x199>
  2c0dd5:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ddc:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0de0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0de7:	8b 00                	mov    (%rax),%eax
  2c0de9:	89 c0                	mov    %eax,%eax
  2c0deb:	48 01 d0             	add    %rdx,%rax
  2c0dee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0df5:	8b 12                	mov    (%rdx),%edx
  2c0df7:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0dfa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e01:	89 0a                	mov    %ecx,(%rdx)
  2c0e03:	eb 1a                	jmp    2c0e1f <printer_vprintf+0x1b3>
  2c0e05:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0e0c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0e10:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0e14:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0e1b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0e1f:	8b 00                	mov    (%rax),%eax
  2c0e21:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
  2c0e24:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0e2b:	01 
  2c0e2c:	eb 01                	jmp    2c0e2f <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
  2c0e2e:	90                   	nop
        }

        // process precision
        int precision = -1;
  2c0e2f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
  2c0e36:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e3d:	0f b6 00             	movzbl (%rax),%eax
  2c0e40:	3c 2e                	cmp    $0x2e,%al
  2c0e42:	0f 85 00 01 00 00    	jne    2c0f48 <printer_vprintf+0x2dc>
            ++format;
  2c0e48:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0e4f:	01 
            if (*format >= '0' && *format <= '9') {
  2c0e50:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e57:	0f b6 00             	movzbl (%rax),%eax
  2c0e5a:	3c 2f                	cmp    $0x2f,%al
  2c0e5c:	7e 67                	jle    2c0ec5 <printer_vprintf+0x259>
  2c0e5e:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e65:	0f b6 00             	movzbl (%rax),%eax
  2c0e68:	3c 39                	cmp    $0x39,%al
  2c0e6a:	7f 59                	jg     2c0ec5 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0e6c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
  2c0e73:	eb 2e                	jmp    2c0ea3 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
  2c0e75:	8b 55 e4             	mov    -0x1c(%rbp),%edx
  2c0e78:	89 d0                	mov    %edx,%eax
  2c0e7a:	c1 e0 02             	shl    $0x2,%eax
  2c0e7d:	01 d0                	add    %edx,%eax
  2c0e7f:	01 c0                	add    %eax,%eax
  2c0e81:	89 c1                	mov    %eax,%ecx
  2c0e83:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0e8a:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0e8e:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
  2c0e95:	0f b6 00             	movzbl (%rax),%eax
  2c0e98:	0f be c0             	movsbl %al,%eax
  2c0e9b:	01 c8                	add    %ecx,%eax
  2c0e9d:	83 e8 30             	sub    $0x30,%eax
  2c0ea0:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c0ea3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0eaa:	0f b6 00             	movzbl (%rax),%eax
  2c0ead:	3c 2f                	cmp    $0x2f,%al
  2c0eaf:	0f 8e 85 00 00 00    	jle    2c0f3a <printer_vprintf+0x2ce>
  2c0eb5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ebc:	0f b6 00             	movzbl (%rax),%eax
  2c0ebf:	3c 39                	cmp    $0x39,%al
  2c0ec1:	7e b2                	jle    2c0e75 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
  2c0ec3:	eb 75                	jmp    2c0f3a <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
  2c0ec5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0ecc:	0f b6 00             	movzbl (%rax),%eax
  2c0ecf:	3c 2a                	cmp    $0x2a,%al
  2c0ed1:	75 68                	jne    2c0f3b <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
  2c0ed3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0eda:	8b 00                	mov    (%rax),%eax
  2c0edc:	83 f8 2f             	cmp    $0x2f,%eax
  2c0edf:	77 30                	ja     2c0f11 <printer_vprintf+0x2a5>
  2c0ee1:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ee8:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0eec:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0ef3:	8b 00                	mov    (%rax),%eax
  2c0ef5:	89 c0                	mov    %eax,%eax
  2c0ef7:	48 01 d0             	add    %rdx,%rax
  2c0efa:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f01:	8b 12                	mov    (%rdx),%edx
  2c0f03:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0f06:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f0d:	89 0a                	mov    %ecx,(%rdx)
  2c0f0f:	eb 1a                	jmp    2c0f2b <printer_vprintf+0x2bf>
  2c0f11:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0f18:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0f1c:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0f20:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0f27:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0f2b:	8b 00                	mov    (%rax),%eax
  2c0f2d:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
  2c0f30:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0f37:	01 
  2c0f38:	eb 01                	jmp    2c0f3b <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
  2c0f3a:	90                   	nop
            }
            if (precision < 0) {
  2c0f3b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c0f3f:	79 07                	jns    2c0f48 <printer_vprintf+0x2dc>
                precision = 0;
  2c0f41:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
  2c0f48:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
  2c0f4f:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
  2c0f56:	00 
        int length = 0;
  2c0f57:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
  2c0f5e:	48 c7 45 c8 26 1a 2c 	movq   $0x2c1a26,-0x38(%rbp)
  2c0f65:	00 
    again:
        switch (*format) {
  2c0f66:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c0f6d:	0f b6 00             	movzbl (%rax),%eax
  2c0f70:	0f be c0             	movsbl %al,%eax
  2c0f73:	83 e8 43             	sub    $0x43,%eax
  2c0f76:	83 f8 37             	cmp    $0x37,%eax
  2c0f79:	0f 87 9f 03 00 00    	ja     2c131e <printer_vprintf+0x6b2>
  2c0f7f:	89 c0                	mov    %eax,%eax
  2c0f81:	48 8b 04 c5 38 1a 2c 	mov    0x2c1a38(,%rax,8),%rax
  2c0f88:	00 
  2c0f89:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
  2c0f8b:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
  2c0f92:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c0f99:	01 
            goto again;
  2c0f9a:	eb ca                	jmp    2c0f66 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0f9c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c0fa0:	74 5d                	je     2c0fff <printer_vprintf+0x393>
  2c0fa2:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fa9:	8b 00                	mov    (%rax),%eax
  2c0fab:	83 f8 2f             	cmp    $0x2f,%eax
  2c0fae:	77 30                	ja     2c0fe0 <printer_vprintf+0x374>
  2c0fb0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fb7:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c0fbb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fc2:	8b 00                	mov    (%rax),%eax
  2c0fc4:	89 c0                	mov    %eax,%eax
  2c0fc6:	48 01 d0             	add    %rdx,%rax
  2c0fc9:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fd0:	8b 12                	mov    (%rdx),%edx
  2c0fd2:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c0fd5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0fdc:	89 0a                	mov    %ecx,(%rdx)
  2c0fde:	eb 1a                	jmp    2c0ffa <printer_vprintf+0x38e>
  2c0fe0:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c0fe7:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c0feb:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c0fef:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c0ff6:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c0ffa:	48 8b 00             	mov    (%rax),%rax
  2c0ffd:	eb 5c                	jmp    2c105b <printer_vprintf+0x3ef>
  2c0fff:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1006:	8b 00                	mov    (%rax),%eax
  2c1008:	83 f8 2f             	cmp    $0x2f,%eax
  2c100b:	77 30                	ja     2c103d <printer_vprintf+0x3d1>
  2c100d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1014:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1018:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c101f:	8b 00                	mov    (%rax),%eax
  2c1021:	89 c0                	mov    %eax,%eax
  2c1023:	48 01 d0             	add    %rdx,%rax
  2c1026:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c102d:	8b 12                	mov    (%rdx),%edx
  2c102f:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1032:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1039:	89 0a                	mov    %ecx,(%rdx)
  2c103b:	eb 1a                	jmp    2c1057 <printer_vprintf+0x3eb>
  2c103d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1044:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1048:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c104c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1053:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1057:	8b 00                	mov    (%rax),%eax
  2c1059:	48 98                	cltq   
  2c105b:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c105f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1063:	48 c1 f8 38          	sar    $0x38,%rax
  2c1067:	25 80 00 00 00       	and    $0x80,%eax
  2c106c:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
  2c106f:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
  2c1073:	74 09                	je     2c107e <printer_vprintf+0x412>
  2c1075:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1079:	48 f7 d8             	neg    %rax
  2c107c:	eb 04                	jmp    2c1082 <printer_vprintf+0x416>
  2c107e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c1082:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c1086:	8b 45 a4             	mov    -0x5c(%rbp),%eax
  2c1089:	83 c8 60             	or     $0x60,%eax
  2c108c:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
  2c108f:	e9 cf 02 00 00       	jmp    2c1363 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c1094:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
  2c1098:	74 5d                	je     2c10f7 <printer_vprintf+0x48b>
  2c109a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10a1:	8b 00                	mov    (%rax),%eax
  2c10a3:	83 f8 2f             	cmp    $0x2f,%eax
  2c10a6:	77 30                	ja     2c10d8 <printer_vprintf+0x46c>
  2c10a8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10af:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c10b3:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10ba:	8b 00                	mov    (%rax),%eax
  2c10bc:	89 c0                	mov    %eax,%eax
  2c10be:	48 01 d0             	add    %rdx,%rax
  2c10c1:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10c8:	8b 12                	mov    (%rdx),%edx
  2c10ca:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c10cd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10d4:	89 0a                	mov    %ecx,(%rdx)
  2c10d6:	eb 1a                	jmp    2c10f2 <printer_vprintf+0x486>
  2c10d8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10df:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c10e3:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c10e7:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c10ee:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c10f2:	48 8b 00             	mov    (%rax),%rax
  2c10f5:	eb 5c                	jmp    2c1153 <printer_vprintf+0x4e7>
  2c10f7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c10fe:	8b 00                	mov    (%rax),%eax
  2c1100:	83 f8 2f             	cmp    $0x2f,%eax
  2c1103:	77 30                	ja     2c1135 <printer_vprintf+0x4c9>
  2c1105:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c110c:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1110:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1117:	8b 00                	mov    (%rax),%eax
  2c1119:	89 c0                	mov    %eax,%eax
  2c111b:	48 01 d0             	add    %rdx,%rax
  2c111e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1125:	8b 12                	mov    (%rdx),%edx
  2c1127:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c112a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1131:	89 0a                	mov    %ecx,(%rdx)
  2c1133:	eb 1a                	jmp    2c114f <printer_vprintf+0x4e3>
  2c1135:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c113c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1140:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1144:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c114b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c114f:	8b 00                	mov    (%rax),%eax
  2c1151:	89 c0                	mov    %eax,%eax
  2c1153:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
  2c1157:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
  2c115b:	e9 03 02 00 00       	jmp    2c1363 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
  2c1160:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
  2c1167:	e9 28 ff ff ff       	jmp    2c1094 <printer_vprintf+0x428>
        case 'X':
            base = 16;
  2c116c:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
  2c1173:	e9 1c ff ff ff       	jmp    2c1094 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
  2c1178:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c117f:	8b 00                	mov    (%rax),%eax
  2c1181:	83 f8 2f             	cmp    $0x2f,%eax
  2c1184:	77 30                	ja     2c11b6 <printer_vprintf+0x54a>
  2c1186:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c118d:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1191:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1198:	8b 00                	mov    (%rax),%eax
  2c119a:	89 c0                	mov    %eax,%eax
  2c119c:	48 01 d0             	add    %rdx,%rax
  2c119f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11a6:	8b 12                	mov    (%rdx),%edx
  2c11a8:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c11ab:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11b2:	89 0a                	mov    %ecx,(%rdx)
  2c11b4:	eb 1a                	jmp    2c11d0 <printer_vprintf+0x564>
  2c11b6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11bd:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c11c1:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c11c5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c11cc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c11d0:	48 8b 00             	mov    (%rax),%rax
  2c11d3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
  2c11d7:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c11de:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
  2c11e5:	e9 79 01 00 00       	jmp    2c1363 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
  2c11ea:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11f1:	8b 00                	mov    (%rax),%eax
  2c11f3:	83 f8 2f             	cmp    $0x2f,%eax
  2c11f6:	77 30                	ja     2c1228 <printer_vprintf+0x5bc>
  2c11f8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c11ff:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1203:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c120a:	8b 00                	mov    (%rax),%eax
  2c120c:	89 c0                	mov    %eax,%eax
  2c120e:	48 01 d0             	add    %rdx,%rax
  2c1211:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1218:	8b 12                	mov    (%rdx),%edx
  2c121a:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c121d:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1224:	89 0a                	mov    %ecx,(%rdx)
  2c1226:	eb 1a                	jmp    2c1242 <printer_vprintf+0x5d6>
  2c1228:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c122f:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1233:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1237:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c123e:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1242:	48 8b 00             	mov    (%rax),%rax
  2c1245:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
  2c1249:	e9 15 01 00 00       	jmp    2c1363 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
  2c124e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1255:	8b 00                	mov    (%rax),%eax
  2c1257:	83 f8 2f             	cmp    $0x2f,%eax
  2c125a:	77 30                	ja     2c128c <printer_vprintf+0x620>
  2c125c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1263:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c1267:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c126e:	8b 00                	mov    (%rax),%eax
  2c1270:	89 c0                	mov    %eax,%eax
  2c1272:	48 01 d0             	add    %rdx,%rax
  2c1275:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c127c:	8b 12                	mov    (%rdx),%edx
  2c127e:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c1281:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c1288:	89 0a                	mov    %ecx,(%rdx)
  2c128a:	eb 1a                	jmp    2c12a6 <printer_vprintf+0x63a>
  2c128c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1293:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1297:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c129b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12a2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c12a6:	8b 00                	mov    (%rax),%eax
  2c12a8:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
  2c12ae:	e9 67 03 00 00       	jmp    2c161a <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
  2c12b3:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c12b7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
  2c12bb:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12c2:	8b 00                	mov    (%rax),%eax
  2c12c4:	83 f8 2f             	cmp    $0x2f,%eax
  2c12c7:	77 30                	ja     2c12f9 <printer_vprintf+0x68d>
  2c12c9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12d0:	48 8b 50 10          	mov    0x10(%rax),%rdx
  2c12d4:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c12db:	8b 00                	mov    (%rax),%eax
  2c12dd:	89 c0                	mov    %eax,%eax
  2c12df:	48 01 d0             	add    %rdx,%rax
  2c12e2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12e9:	8b 12                	mov    (%rdx),%edx
  2c12eb:	8d 4a 08             	lea    0x8(%rdx),%ecx
  2c12ee:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c12f5:	89 0a                	mov    %ecx,(%rdx)
  2c12f7:	eb 1a                	jmp    2c1313 <printer_vprintf+0x6a7>
  2c12f9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
  2c1300:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1304:	48 8d 48 08          	lea    0x8(%rax),%rcx
  2c1308:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
  2c130f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1313:	8b 00                	mov    (%rax),%eax
  2c1315:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c1318:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
  2c131c:	eb 45                	jmp    2c1363 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
  2c131e:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1322:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
  2c1326:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c132d:	0f b6 00             	movzbl (%rax),%eax
  2c1330:	84 c0                	test   %al,%al
  2c1332:	74 0c                	je     2c1340 <printer_vprintf+0x6d4>
  2c1334:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c133b:	0f b6 00             	movzbl (%rax),%eax
  2c133e:	eb 05                	jmp    2c1345 <printer_vprintf+0x6d9>
  2c1340:	b8 25 00 00 00       	mov    $0x25,%eax
  2c1345:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
  2c1348:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
  2c134c:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1353:	0f b6 00             	movzbl (%rax),%eax
  2c1356:	84 c0                	test   %al,%al
  2c1358:	75 08                	jne    2c1362 <printer_vprintf+0x6f6>
                format--;
  2c135a:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
  2c1361:	01 
            }
            break;
  2c1362:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
  2c1363:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1366:	83 e0 20             	and    $0x20,%eax
  2c1369:	85 c0                	test   %eax,%eax
  2c136b:	74 1e                	je     2c138b <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
  2c136d:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
  2c1371:	48 83 c0 18          	add    $0x18,%rax
  2c1375:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c1378:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c137c:	48 89 ce             	mov    %rcx,%rsi
  2c137f:	48 89 c7             	mov    %rax,%rdi
  2c1382:	e8 63 f8 ff ff       	call   2c0bea <fill_numbuf>
  2c1387:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
  2c138b:	48 c7 45 c0 26 1a 2c 	movq   $0x2c1a26,-0x40(%rbp)
  2c1392:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c1393:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1396:	83 e0 20             	and    $0x20,%eax
  2c1399:	85 c0                	test   %eax,%eax
  2c139b:	74 48                	je     2c13e5 <printer_vprintf+0x779>
  2c139d:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c13a0:	83 e0 40             	and    $0x40,%eax
  2c13a3:	85 c0                	test   %eax,%eax
  2c13a5:	74 3e                	je     2c13e5 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
  2c13a7:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c13aa:	25 80 00 00 00       	and    $0x80,%eax
  2c13af:	85 c0                	test   %eax,%eax
  2c13b1:	74 0a                	je     2c13bd <printer_vprintf+0x751>
                prefix = "-";
  2c13b3:	48 c7 45 c0 27 1a 2c 	movq   $0x2c1a27,-0x40(%rbp)
  2c13ba:	00 
            if (flags & FLAG_NEGATIVE) {
  2c13bb:	eb 73                	jmp    2c1430 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c13bd:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c13c0:	83 e0 10             	and    $0x10,%eax
  2c13c3:	85 c0                	test   %eax,%eax
  2c13c5:	74 0a                	je     2c13d1 <printer_vprintf+0x765>
                prefix = "+";
  2c13c7:	48 c7 45 c0 29 1a 2c 	movq   $0x2c1a29,-0x40(%rbp)
  2c13ce:	00 
            if (flags & FLAG_NEGATIVE) {
  2c13cf:	eb 5f                	jmp    2c1430 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
  2c13d1:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c13d4:	83 e0 08             	and    $0x8,%eax
  2c13d7:	85 c0                	test   %eax,%eax
  2c13d9:	74 55                	je     2c1430 <printer_vprintf+0x7c4>
                prefix = " ";
  2c13db:	48 c7 45 c0 2b 1a 2c 	movq   $0x2c1a2b,-0x40(%rbp)
  2c13e2:	00 
            if (flags & FLAG_NEGATIVE) {
  2c13e3:	eb 4b                	jmp    2c1430 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c13e5:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c13e8:	83 e0 20             	and    $0x20,%eax
  2c13eb:	85 c0                	test   %eax,%eax
  2c13ed:	74 42                	je     2c1431 <printer_vprintf+0x7c5>
  2c13ef:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c13f2:	83 e0 01             	and    $0x1,%eax
  2c13f5:	85 c0                	test   %eax,%eax
  2c13f7:	74 38                	je     2c1431 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
  2c13f9:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
  2c13fd:	74 06                	je     2c1405 <printer_vprintf+0x799>
  2c13ff:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c1403:	75 2c                	jne    2c1431 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
  2c1405:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
  2c140a:	75 0c                	jne    2c1418 <printer_vprintf+0x7ac>
  2c140c:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c140f:	25 00 01 00 00       	and    $0x100,%eax
  2c1414:	85 c0                	test   %eax,%eax
  2c1416:	74 19                	je     2c1431 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
  2c1418:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
  2c141c:	75 07                	jne    2c1425 <printer_vprintf+0x7b9>
  2c141e:	b8 2d 1a 2c 00       	mov    $0x2c1a2d,%eax
  2c1423:	eb 05                	jmp    2c142a <printer_vprintf+0x7be>
  2c1425:	b8 30 1a 2c 00       	mov    $0x2c1a30,%eax
  2c142a:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c142e:	eb 01                	jmp    2c1431 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
  2c1430:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c1431:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1435:	78 24                	js     2c145b <printer_vprintf+0x7ef>
  2c1437:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c143a:	83 e0 20             	and    $0x20,%eax
  2c143d:	85 c0                	test   %eax,%eax
  2c143f:	75 1a                	jne    2c145b <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
  2c1441:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1444:	48 63 d0             	movslq %eax,%rdx
  2c1447:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c144b:	48 89 d6             	mov    %rdx,%rsi
  2c144e:	48 89 c7             	mov    %rax,%rdi
  2c1451:	e8 ea f5 ff ff       	call   2c0a40 <strnlen>
  2c1456:	89 45 bc             	mov    %eax,-0x44(%rbp)
  2c1459:	eb 0f                	jmp    2c146a <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
  2c145b:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c145f:	48 89 c7             	mov    %rax,%rdi
  2c1462:	e8 a8 f5 ff ff       	call   2c0a0f <strlen>
  2c1467:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c146a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c146d:	83 e0 20             	and    $0x20,%eax
  2c1470:	85 c0                	test   %eax,%eax
  2c1472:	74 20                	je     2c1494 <printer_vprintf+0x828>
  2c1474:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
  2c1478:	78 1a                	js     2c1494 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
  2c147a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c147d:	3b 45 bc             	cmp    -0x44(%rbp),%eax
  2c1480:	7e 08                	jle    2c148a <printer_vprintf+0x81e>
  2c1482:	8b 45 e4             	mov    -0x1c(%rbp),%eax
  2c1485:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c1488:	eb 05                	jmp    2c148f <printer_vprintf+0x823>
  2c148a:	b8 00 00 00 00       	mov    $0x0,%eax
  2c148f:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c1492:	eb 5c                	jmp    2c14f0 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c1494:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1497:	83 e0 20             	and    $0x20,%eax
  2c149a:	85 c0                	test   %eax,%eax
  2c149c:	74 4b                	je     2c14e9 <printer_vprintf+0x87d>
  2c149e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14a1:	83 e0 02             	and    $0x2,%eax
  2c14a4:	85 c0                	test   %eax,%eax
  2c14a6:	74 41                	je     2c14e9 <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c14a8:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c14ab:	83 e0 04             	and    $0x4,%eax
  2c14ae:	85 c0                	test   %eax,%eax
  2c14b0:	75 37                	jne    2c14e9 <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
  2c14b2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c14b6:	48 89 c7             	mov    %rax,%rdi
  2c14b9:	e8 51 f5 ff ff       	call   2c0a0f <strlen>
  2c14be:	89 c2                	mov    %eax,%edx
  2c14c0:	8b 45 bc             	mov    -0x44(%rbp),%eax
  2c14c3:	01 d0                	add    %edx,%eax
  2c14c5:	39 45 e8             	cmp    %eax,-0x18(%rbp)
  2c14c8:	7e 1f                	jle    2c14e9 <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
  2c14ca:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c14cd:	2b 45 bc             	sub    -0x44(%rbp),%eax
  2c14d0:	89 c3                	mov    %eax,%ebx
  2c14d2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c14d6:	48 89 c7             	mov    %rax,%rdi
  2c14d9:	e8 31 f5 ff ff       	call   2c0a0f <strlen>
  2c14de:	89 c2                	mov    %eax,%edx
  2c14e0:	89 d8                	mov    %ebx,%eax
  2c14e2:	29 d0                	sub    %edx,%eax
  2c14e4:	89 45 b8             	mov    %eax,-0x48(%rbp)
  2c14e7:	eb 07                	jmp    2c14f0 <printer_vprintf+0x884>
        } else {
            zeros = 0;
  2c14e9:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
  2c14f0:	8b 55 bc             	mov    -0x44(%rbp),%edx
  2c14f3:	8b 45 b8             	mov    -0x48(%rbp),%eax
  2c14f6:	01 d0                	add    %edx,%eax
  2c14f8:	48 63 d8             	movslq %eax,%rbx
  2c14fb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c14ff:	48 89 c7             	mov    %rax,%rdi
  2c1502:	e8 08 f5 ff ff       	call   2c0a0f <strlen>
  2c1507:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
  2c150b:	8b 45 e8             	mov    -0x18(%rbp),%eax
  2c150e:	29 d0                	sub    %edx,%eax
  2c1510:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1513:	eb 25                	jmp    2c153a <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
  2c1515:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c151c:	48 8b 08             	mov    (%rax),%rcx
  2c151f:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1525:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c152c:	be 20 00 00 00       	mov    $0x20,%esi
  2c1531:	48 89 c7             	mov    %rax,%rdi
  2c1534:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c1536:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c153a:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c153d:	83 e0 04             	and    $0x4,%eax
  2c1540:	85 c0                	test   %eax,%eax
  2c1542:	75 36                	jne    2c157a <printer_vprintf+0x90e>
  2c1544:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1548:	7f cb                	jg     2c1515 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
  2c154a:	eb 2e                	jmp    2c157a <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
  2c154c:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1553:	4c 8b 00             	mov    (%rax),%r8
  2c1556:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c155a:	0f b6 00             	movzbl (%rax),%eax
  2c155d:	0f b6 c8             	movzbl %al,%ecx
  2c1560:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1566:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c156d:	89 ce                	mov    %ecx,%esi
  2c156f:	48 89 c7             	mov    %rax,%rdi
  2c1572:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
  2c1575:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
  2c157a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c157e:	0f b6 00             	movzbl (%rax),%eax
  2c1581:	84 c0                	test   %al,%al
  2c1583:	75 c7                	jne    2c154c <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
  2c1585:	eb 25                	jmp    2c15ac <printer_vprintf+0x940>
            p->putc(p, '0', color);
  2c1587:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c158e:	48 8b 08             	mov    (%rax),%rcx
  2c1591:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c1597:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c159e:	be 30 00 00 00       	mov    $0x30,%esi
  2c15a3:	48 89 c7             	mov    %rax,%rdi
  2c15a6:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
  2c15a8:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
  2c15ac:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
  2c15b0:	7f d5                	jg     2c1587 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
  2c15b2:	eb 32                	jmp    2c15e6 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
  2c15b4:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c15bb:	4c 8b 00             	mov    (%rax),%r8
  2c15be:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c15c2:	0f b6 00             	movzbl (%rax),%eax
  2c15c5:	0f b6 c8             	movzbl %al,%ecx
  2c15c8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c15ce:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c15d5:	89 ce                	mov    %ecx,%esi
  2c15d7:	48 89 c7             	mov    %rax,%rdi
  2c15da:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
  2c15dd:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
  2c15e2:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
  2c15e6:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
  2c15ea:	7f c8                	jg     2c15b4 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
  2c15ec:	eb 25                	jmp    2c1613 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
  2c15ee:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c15f5:	48 8b 08             	mov    (%rax),%rcx
  2c15f8:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
  2c15fe:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
  2c1605:	be 20 00 00 00       	mov    $0x20,%esi
  2c160a:	48 89 c7             	mov    %rax,%rdi
  2c160d:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
  2c160f:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
  2c1613:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  2c1617:	7f d5                	jg     2c15ee <printer_vprintf+0x982>
        }
    done: ;
  2c1619:	90                   	nop
    for (; *format; ++format) {
  2c161a:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
  2c1621:	01 
  2c1622:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
  2c1629:	0f b6 00             	movzbl (%rax),%eax
  2c162c:	84 c0                	test   %al,%al
  2c162e:	0f 85 64 f6 ff ff    	jne    2c0c98 <printer_vprintf+0x2c>
    }
}
  2c1634:	90                   	nop
  2c1635:	90                   	nop
  2c1636:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c163a:	c9                   	leave  
  2c163b:	c3                   	ret    

00000000002c163c <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c163c:	55                   	push   %rbp
  2c163d:	48 89 e5             	mov    %rsp,%rbp
  2c1640:	48 83 ec 20          	sub    $0x20,%rsp
  2c1644:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c1648:	89 f0                	mov    %esi,%eax
  2c164a:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c164d:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
  2c1650:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c1654:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1658:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c165c:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1660:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
  2c1665:	48 39 d0             	cmp    %rdx,%rax
  2c1668:	72 0c                	jb     2c1676 <console_putc+0x3a>
        cp->cursor = console;
  2c166a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c166e:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
  2c1675:	00 
    }
    if (c == '\n') {
  2c1676:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
  2c167a:	75 78                	jne    2c16f4 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
  2c167c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1680:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1684:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c168a:	48 d1 f8             	sar    %rax
  2c168d:	48 89 c1             	mov    %rax,%rcx
  2c1690:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c1697:	66 66 66 
  2c169a:	48 89 c8             	mov    %rcx,%rax
  2c169d:	48 f7 ea             	imul   %rdx
  2c16a0:	48 c1 fa 05          	sar    $0x5,%rdx
  2c16a4:	48 89 c8             	mov    %rcx,%rax
  2c16a7:	48 c1 f8 3f          	sar    $0x3f,%rax
  2c16ab:	48 29 c2             	sub    %rax,%rdx
  2c16ae:	48 89 d0             	mov    %rdx,%rax
  2c16b1:	48 c1 e0 02          	shl    $0x2,%rax
  2c16b5:	48 01 d0             	add    %rdx,%rax
  2c16b8:	48 c1 e0 04          	shl    $0x4,%rax
  2c16bc:	48 29 c1             	sub    %rax,%rcx
  2c16bf:	48 89 ca             	mov    %rcx,%rdx
  2c16c2:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
  2c16c5:	eb 25                	jmp    2c16ec <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
  2c16c7:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c16ca:	83 c8 20             	or     $0x20,%eax
  2c16cd:	89 c6                	mov    %eax,%esi
  2c16cf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c16d3:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c16d7:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c16db:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c16df:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c16e3:	89 f2                	mov    %esi,%edx
  2c16e5:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
  2c16e8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c16ec:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
  2c16f0:	75 d5                	jne    2c16c7 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
  2c16f2:	eb 24                	jmp    2c1718 <console_putc+0xdc>
        *cp->cursor++ = c | color;
  2c16f4:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
  2c16f8:	8b 55 e0             	mov    -0x20(%rbp),%edx
  2c16fb:	09 d0                	or     %edx,%eax
  2c16fd:	89 c6                	mov    %eax,%esi
  2c16ff:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1703:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1707:	48 8d 48 02          	lea    0x2(%rax),%rcx
  2c170b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  2c170f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c1713:	89 f2                	mov    %esi,%edx
  2c1715:	66 89 10             	mov    %dx,(%rax)
}
  2c1718:	90                   	nop
  2c1719:	c9                   	leave  
  2c171a:	c3                   	ret    

00000000002c171b <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c171b:	55                   	push   %rbp
  2c171c:	48 89 e5             	mov    %rsp,%rbp
  2c171f:	48 83 ec 30          	sub    $0x30,%rsp
  2c1723:	89 7d ec             	mov    %edi,-0x14(%rbp)
  2c1726:	89 75 e8             	mov    %esi,-0x18(%rbp)
  2c1729:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c172d:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
  2c1731:	48 c7 45 f0 3c 16 2c 	movq   $0x2c163c,-0x10(%rbp)
  2c1738:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c1739:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  2c173d:	78 09                	js     2c1748 <console_vprintf+0x2d>
  2c173f:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
  2c1746:	7e 07                	jle    2c174f <console_vprintf+0x34>
        cpos = 0;
  2c1748:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
  2c174f:	8b 45 ec             	mov    -0x14(%rbp),%eax
  2c1752:	48 98                	cltq   
  2c1754:	48 01 c0             	add    %rax,%rax
  2c1757:	48 05 00 80 0b 00    	add    $0xb8000,%rax
  2c175d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c1761:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
  2c1765:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
  2c1769:	8b 75 e8             	mov    -0x18(%rbp),%esi
  2c176c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
  2c1770:	48 89 c7             	mov    %rax,%rdi
  2c1773:	e8 f4 f4 ff ff       	call   2c0c6c <printer_vprintf>
    return cp.cursor - console;
  2c1778:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c177c:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c1782:	48 d1 f8             	sar    %rax
}
  2c1785:	c9                   	leave  
  2c1786:	c3                   	ret    

00000000002c1787 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
  2c1787:	55                   	push   %rbp
  2c1788:	48 89 e5             	mov    %rsp,%rbp
  2c178b:	48 83 ec 60          	sub    $0x60,%rsp
  2c178f:	89 7d ac             	mov    %edi,-0x54(%rbp)
  2c1792:	89 75 a8             	mov    %esi,-0x58(%rbp)
  2c1795:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
  2c1799:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c179d:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c17a1:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c17a5:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c17ac:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c17b0:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c17b4:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c17b8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c17bc:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c17c0:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
  2c17c4:	8b 75 a8             	mov    -0x58(%rbp),%esi
  2c17c7:	8b 45 ac             	mov    -0x54(%rbp),%eax
  2c17ca:	89 c7                	mov    %eax,%edi
  2c17cc:	e8 4a ff ff ff       	call   2c171b <console_vprintf>
  2c17d1:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
  2c17d4:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
  2c17d7:	c9                   	leave  
  2c17d8:	c3                   	ret    

00000000002c17d9 <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
  2c17d9:	55                   	push   %rbp
  2c17da:	48 89 e5             	mov    %rsp,%rbp
  2c17dd:	48 83 ec 20          	sub    $0x20,%rsp
  2c17e1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  2c17e5:	89 f0                	mov    %esi,%eax
  2c17e7:	89 55 e0             	mov    %edx,-0x20(%rbp)
  2c17ea:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
  2c17ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  2c17f1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
  2c17f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c17f9:	48 8b 50 08          	mov    0x8(%rax),%rdx
  2c17fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c1801:	48 8b 40 10          	mov    0x10(%rax),%rax
  2c1805:	48 39 c2             	cmp    %rax,%rdx
  2c1808:	73 1a                	jae    2c1824 <string_putc+0x4b>
        *sp->s++ = c;
  2c180a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c180e:	48 8b 40 08          	mov    0x8(%rax),%rax
  2c1812:	48 8d 48 01          	lea    0x1(%rax),%rcx
  2c1816:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  2c181a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  2c181e:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
  2c1822:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
  2c1824:	90                   	nop
  2c1825:	c9                   	leave  
  2c1826:	c3                   	ret    

00000000002c1827 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c1827:	55                   	push   %rbp
  2c1828:	48 89 e5             	mov    %rsp,%rbp
  2c182b:	48 83 ec 40          	sub    $0x40,%rsp
  2c182f:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  2c1833:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  2c1837:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  2c183b:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
  2c183f:	48 c7 45 e8 d9 17 2c 	movq   $0x2c17d9,-0x18(%rbp)
  2c1846:	00 
    sp.s = s;
  2c1847:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c184b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
  2c184f:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
  2c1854:	74 33                	je     2c1889 <vsnprintf+0x62>
        sp.end = s + size - 1;
  2c1856:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
  2c185a:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
  2c185e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  2c1862:	48 01 d0             	add    %rdx,%rax
  2c1865:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c1869:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
  2c186d:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c1871:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
  2c1875:	be 00 00 00 00       	mov    $0x0,%esi
  2c187a:	48 89 c7             	mov    %rax,%rdi
  2c187d:	e8 ea f3 ff ff       	call   2c0c6c <printer_vprintf>
        *sp.s = 0;
  2c1882:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c1886:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
  2c1889:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  2c188d:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
  2c1891:	c9                   	leave  
  2c1892:	c3                   	ret    

00000000002c1893 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c1893:	55                   	push   %rbp
  2c1894:	48 89 e5             	mov    %rsp,%rbp
  2c1897:	48 83 ec 70          	sub    $0x70,%rsp
  2c189b:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c189f:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
  2c18a3:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
  2c18a7:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c18ab:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c18af:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c18b3:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
  2c18ba:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c18be:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
  2c18c2:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c18c6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c18ca:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
  2c18ce:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
  2c18d2:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
  2c18d6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c18da:	48 89 c7             	mov    %rax,%rdi
  2c18dd:	e8 45 ff ff ff       	call   2c1827 <vsnprintf>
  2c18e2:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
  2c18e5:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
  2c18e8:	c9                   	leave  
  2c18e9:	c3                   	ret    

00000000002c18ea <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
  2c18ea:	55                   	push   %rbp
  2c18eb:	48 89 e5             	mov    %rsp,%rbp
  2c18ee:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c18f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  2c18f9:	eb 13                	jmp    2c190e <console_clear+0x24>
        console[i] = ' ' | 0x0700;
  2c18fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
  2c18fe:	48 98                	cltq   
  2c1900:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
  2c1907:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c190a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
  2c190e:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
  2c1915:	7e e4                	jle    2c18fb <console_clear+0x11>
    }
    cursorpos = 0;
  2c1917:	c7 05 db 76 df ff 00 	movl   $0x0,-0x208925(%rip)        # b8ffc <cursorpos>
  2c191e:	00 00 00 
}
  2c1921:	90                   	nop
  2c1922:	c9                   	leave  
  2c1923:	c3                   	ret    
