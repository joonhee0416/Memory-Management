
obj/kernel.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000040000 <entry_from_boot>:
# The entry_from_boot routine sets the stack pointer to the top of the
# OS kernel stack, then jumps to the `kernel` routine.

.globl entry_from_boot
entry_from_boot:
        movq $0x80000, %rsp
   40000:	48 c7 c4 00 00 08 00 	mov    $0x80000,%rsp
        movq %rsp, %rbp
   40007:	48 89 e5             	mov    %rsp,%rbp
        pushq $0
   4000a:	6a 00                	push   $0x0
        popfq
   4000c:	9d                   	popf   
        // Check for multiboot command line; if found pass it along.
        cmpl $0x2BADB002, %eax
   4000d:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
        jne 1f
   40012:	75 0d                	jne    40021 <entry_from_boot+0x21>
        testl $4, (%rbx)
   40014:	f7 03 04 00 00 00    	testl  $0x4,(%rbx)
        je 1f
   4001a:	74 05                	je     40021 <entry_from_boot+0x21>
        movl 16(%rbx), %edi
   4001c:	8b 7b 10             	mov    0x10(%rbx),%edi
        jmp 2f
   4001f:	eb 07                	jmp    40028 <entry_from_boot+0x28>
1:      movq $0, %rdi
   40021:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
2:      jmp kernel
   40028:	e9 3a 01 00 00       	jmp    40167 <kernel>
   4002d:	90                   	nop

000000000004002e <gpf_int_handler>:
# Interrupt handlers
.align 2

        .globl gpf_int_handler
gpf_int_handler:
        pushq $13               // trap number
   4002e:	6a 0d                	push   $0xd
        jmp generic_exception_handler
   40030:	eb 6e                	jmp    400a0 <generic_exception_handler>

0000000000040032 <pagefault_int_handler>:

        .globl pagefault_int_handler
pagefault_int_handler:
        pushq $14
   40032:	6a 0e                	push   $0xe
        jmp generic_exception_handler
   40034:	eb 6a                	jmp    400a0 <generic_exception_handler>

0000000000040036 <timer_int_handler>:

        .globl timer_int_handler
timer_int_handler:
        pushq $0                // error code
   40036:	6a 00                	push   $0x0
        pushq $32
   40038:	6a 20                	push   $0x20
        jmp generic_exception_handler
   4003a:	eb 64                	jmp    400a0 <generic_exception_handler>

000000000004003c <sys48_int_handler>:

sys48_int_handler:
        pushq $0
   4003c:	6a 00                	push   $0x0
        pushq $48
   4003e:	6a 30                	push   $0x30
        jmp generic_exception_handler
   40040:	eb 5e                	jmp    400a0 <generic_exception_handler>

0000000000040042 <sys49_int_handler>:

sys49_int_handler:
        pushq $0
   40042:	6a 00                	push   $0x0
        pushq $49
   40044:	6a 31                	push   $0x31
        jmp generic_exception_handler
   40046:	eb 58                	jmp    400a0 <generic_exception_handler>

0000000000040048 <sys50_int_handler>:

sys50_int_handler:
        pushq $0
   40048:	6a 00                	push   $0x0
        pushq $50
   4004a:	6a 32                	push   $0x32
        jmp generic_exception_handler
   4004c:	eb 52                	jmp    400a0 <generic_exception_handler>

000000000004004e <sys51_int_handler>:

sys51_int_handler:
        pushq $0
   4004e:	6a 00                	push   $0x0
        pushq $51
   40050:	6a 33                	push   $0x33
        jmp generic_exception_handler
   40052:	eb 4c                	jmp    400a0 <generic_exception_handler>

0000000000040054 <sys52_int_handler>:

sys52_int_handler:
        pushq $0
   40054:	6a 00                	push   $0x0
        pushq $52
   40056:	6a 34                	push   $0x34
        jmp generic_exception_handler
   40058:	eb 46                	jmp    400a0 <generic_exception_handler>

000000000004005a <sys53_int_handler>:

sys53_int_handler:
        pushq $0
   4005a:	6a 00                	push   $0x0
        pushq $53
   4005c:	6a 35                	push   $0x35
        jmp generic_exception_handler
   4005e:	eb 40                	jmp    400a0 <generic_exception_handler>

0000000000040060 <sys54_int_handler>:

sys54_int_handler:
        pushq $0
   40060:	6a 00                	push   $0x0
        pushq $54
   40062:	6a 36                	push   $0x36
        jmp generic_exception_handler
   40064:	eb 3a                	jmp    400a0 <generic_exception_handler>

0000000000040066 <sys55_int_handler>:

sys55_int_handler:
        pushq $0
   40066:	6a 00                	push   $0x0
        pushq $55
   40068:	6a 37                	push   $0x37
        jmp generic_exception_handler
   4006a:	eb 34                	jmp    400a0 <generic_exception_handler>

000000000004006c <sys56_int_handler>:

sys56_int_handler:
        pushq $0
   4006c:	6a 00                	push   $0x0
        pushq $56
   4006e:	6a 38                	push   $0x38
        jmp generic_exception_handler
   40070:	eb 2e                	jmp    400a0 <generic_exception_handler>

0000000000040072 <sys57_int_handler>:

sys57_int_handler:
        pushq $0
   40072:	6a 00                	push   $0x0
        pushq $57
   40074:	6a 39                	push   $0x39
        jmp generic_exception_handler
   40076:	eb 28                	jmp    400a0 <generic_exception_handler>

0000000000040078 <sys58_int_handler>:

sys58_int_handler:
        pushq $0
   40078:	6a 00                	push   $0x0
        pushq $58
   4007a:	6a 3a                	push   $0x3a
        jmp generic_exception_handler
   4007c:	eb 22                	jmp    400a0 <generic_exception_handler>

000000000004007e <sys59_int_handler>:

sys59_int_handler:
        pushq $0
   4007e:	6a 00                	push   $0x0
        pushq $59
   40080:	6a 3b                	push   $0x3b
        jmp generic_exception_handler
   40082:	eb 1c                	jmp    400a0 <generic_exception_handler>

0000000000040084 <sys60_int_handler>:

sys60_int_handler:
        pushq $0
   40084:	6a 00                	push   $0x0
        pushq $60
   40086:	6a 3c                	push   $0x3c
        jmp generic_exception_handler
   40088:	eb 16                	jmp    400a0 <generic_exception_handler>

000000000004008a <sys61_int_handler>:

sys61_int_handler:
        pushq $0
   4008a:	6a 00                	push   $0x0
        pushq $61
   4008c:	6a 3d                	push   $0x3d
        jmp generic_exception_handler
   4008e:	eb 10                	jmp    400a0 <generic_exception_handler>

0000000000040090 <sys62_int_handler>:

sys62_int_handler:
        pushq $0
   40090:	6a 00                	push   $0x0
        pushq $62
   40092:	6a 3e                	push   $0x3e
        jmp generic_exception_handler
   40094:	eb 0a                	jmp    400a0 <generic_exception_handler>

0000000000040096 <sys63_int_handler>:

sys63_int_handler:
        pushq $0
   40096:	6a 00                	push   $0x0
        pushq $63
   40098:	6a 3f                	push   $0x3f
        jmp generic_exception_handler
   4009a:	eb 04                	jmp    400a0 <generic_exception_handler>

000000000004009c <default_int_handler>:

        .globl default_int_handler
default_int_handler:
        pushq $0
   4009c:	6a 00                	push   $0x0
        jmp generic_exception_handler
   4009e:	eb 00                	jmp    400a0 <generic_exception_handler>

00000000000400a0 <generic_exception_handler>:


generic_exception_handler:
        pushq %gs
   400a0:	0f a8                	push   %gs
        pushq %fs
   400a2:	0f a0                	push   %fs
        pushq %r15
   400a4:	41 57                	push   %r15
        pushq %r14
   400a6:	41 56                	push   %r14
        pushq %r13
   400a8:	41 55                	push   %r13
        pushq %r12
   400aa:	41 54                	push   %r12
        pushq %r11
   400ac:	41 53                	push   %r11
        pushq %r10
   400ae:	41 52                	push   %r10
        pushq %r9
   400b0:	41 51                	push   %r9
        pushq %r8
   400b2:	41 50                	push   %r8
        pushq %rdi
   400b4:	57                   	push   %rdi
        pushq %rsi
   400b5:	56                   	push   %rsi
        pushq %rbp
   400b6:	55                   	push   %rbp
        pushq %rbx
   400b7:	53                   	push   %rbx
        pushq %rdx
   400b8:	52                   	push   %rdx
        pushq %rcx
   400b9:	51                   	push   %rcx
        pushq %rax
   400ba:	50                   	push   %rax
        movq %rsp, %rdi
   400bb:	48 89 e7             	mov    %rsp,%rdi
        call exception
   400be:	e8 96 06 00 00       	call   40759 <exception>

00000000000400c3 <exception_return>:
        # `exception` should never return.


        .globl exception_return
exception_return:
        movq %rdi, %rsp
   400c3:	48 89 fc             	mov    %rdi,%rsp
        popq %rax
   400c6:	58                   	pop    %rax
        popq %rcx
   400c7:	59                   	pop    %rcx
        popq %rdx
   400c8:	5a                   	pop    %rdx
        popq %rbx
   400c9:	5b                   	pop    %rbx
        popq %rbp
   400ca:	5d                   	pop    %rbp
        popq %rsi
   400cb:	5e                   	pop    %rsi
        popq %rdi
   400cc:	5f                   	pop    %rdi
        popq %r8
   400cd:	41 58                	pop    %r8
        popq %r9
   400cf:	41 59                	pop    %r9
        popq %r10
   400d1:	41 5a                	pop    %r10
        popq %r11
   400d3:	41 5b                	pop    %r11
        popq %r12
   400d5:	41 5c                	pop    %r12
        popq %r13
   400d7:	41 5d                	pop    %r13
        popq %r14
   400d9:	41 5e                	pop    %r14
        popq %r15
   400db:	41 5f                	pop    %r15
        popq %fs
   400dd:	0f a1                	pop    %fs
        popq %gs
   400df:	0f a9                	pop    %gs
        addq $16, %rsp
   400e1:	48 83 c4 10          	add    $0x10,%rsp
        iretq
   400e5:	48 cf                	iretq  

00000000000400e7 <sys_int_handlers>:
   400e7:	3c 00                	cmp    $0x0,%al
   400e9:	04 00                	add    $0x0,%al
   400eb:	00 00                	add    %al,(%rax)
   400ed:	00 00                	add    %al,(%rax)
   400ef:	42 00 04 00          	add    %al,(%rax,%r8,1)
   400f3:	00 00                	add    %al,(%rax)
   400f5:	00 00                	add    %al,(%rax)
   400f7:	48 00 04 00          	rex.W add %al,(%rax,%rax,1)
   400fb:	00 00                	add    %al,(%rax)
   400fd:	00 00                	add    %al,(%rax)
   400ff:	4e 00 04 00          	rex.WRX add %r8b,(%rax,%r8,1)
   40103:	00 00                	add    %al,(%rax)
   40105:	00 00                	add    %al,(%rax)
   40107:	54                   	push   %rsp
   40108:	00 04 00             	add    %al,(%rax,%rax,1)
   4010b:	00 00                	add    %al,(%rax)
   4010d:	00 00                	add    %al,(%rax)
   4010f:	5a                   	pop    %rdx
   40110:	00 04 00             	add    %al,(%rax,%rax,1)
   40113:	00 00                	add    %al,(%rax)
   40115:	00 00                	add    %al,(%rax)
   40117:	60                   	(bad)  
   40118:	00 04 00             	add    %al,(%rax,%rax,1)
   4011b:	00 00                	add    %al,(%rax)
   4011d:	00 00                	add    %al,(%rax)
   4011f:	66 00 04 00          	data16 add %al,(%rax,%rax,1)
   40123:	00 00                	add    %al,(%rax)
   40125:	00 00                	add    %al,(%rax)
   40127:	6c                   	insb   (%dx),%es:(%rdi)
   40128:	00 04 00             	add    %al,(%rax,%rax,1)
   4012b:	00 00                	add    %al,(%rax)
   4012d:	00 00                	add    %al,(%rax)
   4012f:	72 00                	jb     40131 <sys_int_handlers+0x4a>
   40131:	04 00                	add    $0x0,%al
   40133:	00 00                	add    %al,(%rax)
   40135:	00 00                	add    %al,(%rax)
   40137:	78 00                	js     40139 <sys_int_handlers+0x52>
   40139:	04 00                	add    $0x0,%al
   4013b:	00 00                	add    %al,(%rax)
   4013d:	00 00                	add    %al,(%rax)
   4013f:	7e 00                	jle    40141 <sys_int_handlers+0x5a>
   40141:	04 00                	add    $0x0,%al
   40143:	00 00                	add    %al,(%rax)
   40145:	00 00                	add    %al,(%rax)
   40147:	84 00                	test   %al,(%rax)
   40149:	04 00                	add    $0x0,%al
   4014b:	00 00                	add    %al,(%rax)
   4014d:	00 00                	add    %al,(%rax)
   4014f:	8a 00                	mov    (%rax),%al
   40151:	04 00                	add    $0x0,%al
   40153:	00 00                	add    %al,(%rax)
   40155:	00 00                	add    %al,(%rax)
   40157:	90                   	nop
   40158:	00 04 00             	add    %al,(%rax,%rax,1)
   4015b:	00 00                	add    %al,(%rax)
   4015d:	00 00                	add    %al,(%rax)
   4015f:	96                   	xchg   %eax,%esi
   40160:	00 04 00             	add    %al,(%rax,%rax,1)
   40163:	00 00                	add    %al,(%rax)
	...

0000000000040167 <kernel>:

// kernel(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

void kernel(const char* command) {
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 20          	sub    $0x20,%rsp
   4016f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40173:	e8 02 15 00 00       	call   4167a <hardware_init>
    pageinfo_init();
   40178:	e8 76 0b 00 00       	call   40cf3 <pageinfo_init>
    console_clear();
   4017d:	e8 d9 4a 00 00       	call   44c5b <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 da 19 00 00       	call   41b66 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 00 f0 04 00       	mov    $0x4f000,%edi
   4019b:	e8 a1 3b 00 00       	call   43d41 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401a7:	eb 44                	jmp    401ed <kernel+0x86>
        processes[i].p_pid = i;
   401a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401ac:	48 63 d0             	movslq %eax,%rdx
   401af:	48 89 d0             	mov    %rdx,%rax
   401b2:	48 c1 e0 04          	shl    $0x4,%rax
   401b6:	48 29 d0             	sub    %rdx,%rax
   401b9:	48 c1 e0 04          	shl    $0x4,%rax
   401bd:	48 8d 90 00 f0 04 00 	lea    0x4f000(%rax),%rdx
   401c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401c7:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401cc:	48 63 d0             	movslq %eax,%rdx
   401cf:	48 89 d0             	mov    %rdx,%rax
   401d2:	48 c1 e0 04          	shl    $0x4,%rax
   401d6:	48 29 d0             	sub    %rdx,%rax
   401d9:	48 c1 e0 04          	shl    $0x4,%rax
   401dd:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   401e3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   401e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ed:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   401f1:	7e b6                	jle    401a9 <kernel+0x42>
    }

    if (command && strcmp(command, "malloc") == 0) {
   401f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   401f8:	74 29                	je     40223 <kernel+0xbc>
   401fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   401fe:	be c6 4c 04 00       	mov    $0x44cc6,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 2f 3c 00 00       	call   43e3a <strcmp>
   4020b:	85 c0                	test   %eax,%eax
   4020d:	75 14                	jne    40223 <kernel+0xbc>
        process_setup(1, 1);
   4020f:	be 01 00 00 00       	mov    $0x1,%esi
   40214:	bf 01 00 00 00       	mov    $0x1,%edi
   40219:	e8 b8 00 00 00       	call   402d6 <process_setup>
   4021e:	e9 a9 00 00 00       	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "alloctests") == 0) {
   40223:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40228:	74 26                	je     40250 <kernel+0xe9>
   4022a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4022e:	be cd 4c 04 00       	mov    $0x44ccd,%esi
   40233:	48 89 c7             	mov    %rax,%rdi
   40236:	e8 ff 3b 00 00       	call   43e3a <strcmp>
   4023b:	85 c0                	test   %eax,%eax
   4023d:	75 11                	jne    40250 <kernel+0xe9>
        process_setup(1, 2);
   4023f:	be 02 00 00 00       	mov    $0x2,%esi
   40244:	bf 01 00 00 00       	mov    $0x1,%edi
   40249:	e8 88 00 00 00       	call   402d6 <process_setup>
   4024e:	eb 7c                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test") == 0){
   40250:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40255:	74 26                	je     4027d <kernel+0x116>
   40257:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4025b:	be d8 4c 04 00       	mov    $0x44cd8,%esi
   40260:	48 89 c7             	mov    %rax,%rdi
   40263:	e8 d2 3b 00 00       	call   43e3a <strcmp>
   40268:	85 c0                	test   %eax,%eax
   4026a:	75 11                	jne    4027d <kernel+0x116>
        process_setup(1, 3);
   4026c:	be 03 00 00 00       	mov    $0x3,%esi
   40271:	bf 01 00 00 00       	mov    $0x1,%edi
   40276:	e8 5b 00 00 00       	call   402d6 <process_setup>
   4027b:	eb 4f                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test2") == 0) {
   4027d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40282:	74 39                	je     402bd <kernel+0x156>
   40284:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40288:	be dd 4c 04 00       	mov    $0x44cdd,%esi
   4028d:	48 89 c7             	mov    %rax,%rdi
   40290:	e8 a5 3b 00 00       	call   43e3a <strcmp>
   40295:	85 c0                	test   %eax,%eax
   40297:	75 24                	jne    402bd <kernel+0x156>
        for (pid_t i = 1; i <= 2; ++i) {
   40299:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402a0:	eb 13                	jmp    402b5 <kernel+0x14e>
            process_setup(i, 3);
   402a2:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402a5:	be 03 00 00 00       	mov    $0x3,%esi
   402aa:	89 c7                	mov    %eax,%edi
   402ac:	e8 25 00 00 00       	call   402d6 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402b1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   402b5:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   402b9:	7e e7                	jle    402a2 <kernel+0x13b>
   402bb:	eb 0f                	jmp    402cc <kernel+0x165>
        }
    } else {
        process_setup(1, 0);
   402bd:	be 00 00 00 00       	mov    $0x0,%esi
   402c2:	bf 01 00 00 00       	mov    $0x1,%edi
   402c7:	e8 0a 00 00 00       	call   402d6 <process_setup>
    }

    // Switch to the first process using run()
    run(&processes[1]);
   402cc:	bf f0 f0 04 00       	mov    $0x4f0f0,%edi
   402d1:	e8 8c 09 00 00       	call   40c62 <run>

00000000000402d6 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   402d6:	55                   	push   %rbp
   402d7:	48 89 e5             	mov    %rsp,%rbp
   402da:	48 83 ec 10          	sub    $0x10,%rsp
   402de:	89 7d fc             	mov    %edi,-0x4(%rbp)
   402e1:	89 75 f8             	mov    %esi,-0x8(%rbp)
    process_init(&processes[pid], 0);
   402e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402e7:	48 63 d0             	movslq %eax,%rdx
   402ea:	48 89 d0             	mov    %rdx,%rax
   402ed:	48 c1 e0 04          	shl    $0x4,%rax
   402f1:	48 29 d0             	sub    %rdx,%rax
   402f4:	48 c1 e0 04          	shl    $0x4,%rax
   402f8:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   402fe:	be 00 00 00 00       	mov    $0x0,%esi
   40303:	48 89 c7             	mov    %rax,%rdi
   40306:	e8 ec 1a 00 00       	call   41df7 <process_init>
    assert(process_config_tables(pid) == 0);
   4030b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4030e:	89 c7                	mov    %eax,%edi
   40310:	e8 f5 31 00 00       	call   4350a <process_config_tables>
   40315:	85 c0                	test   %eax,%eax
   40317:	74 14                	je     4032d <process_setup+0x57>
   40319:	ba e8 4c 04 00       	mov    $0x44ce8,%edx
   4031e:	be 77 00 00 00       	mov    $0x77,%esi
   40323:	bf 08 4d 04 00       	mov    $0x44d08,%edi
   40328:	e8 98 22 00 00       	call   425c5 <assert_fail>

    /* Calls program_load in k-loader */
    assert(process_load(&processes[pid], program_number) >= 0);
   4032d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40330:	48 63 d0             	movslq %eax,%rdx
   40333:	48 89 d0             	mov    %rdx,%rax
   40336:	48 c1 e0 04          	shl    $0x4,%rax
   4033a:	48 29 d0             	sub    %rdx,%rax
   4033d:	48 c1 e0 04          	shl    $0x4,%rax
   40341:	48 8d 90 00 f0 04 00 	lea    0x4f000(%rax),%rdx
   40348:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4034b:	89 c6                	mov    %eax,%esi
   4034d:	48 89 d7             	mov    %rdx,%rdi
   40350:	e8 03 35 00 00       	call   43858 <process_load>
   40355:	85 c0                	test   %eax,%eax
   40357:	79 14                	jns    4036d <process_setup+0x97>
   40359:	ba 18 4d 04 00       	mov    $0x44d18,%edx
   4035e:	be 7a 00 00 00       	mov    $0x7a,%esi
   40363:	bf 08 4d 04 00       	mov    $0x44d08,%edi
   40368:	e8 58 22 00 00       	call   425c5 <assert_fail>

    process_setup_stack(&processes[pid]);
   4036d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40370:	48 63 d0             	movslq %eax,%rdx
   40373:	48 89 d0             	mov    %rdx,%rax
   40376:	48 c1 e0 04          	shl    $0x4,%rax
   4037a:	48 29 d0             	sub    %rdx,%rax
   4037d:	48 c1 e0 04          	shl    $0x4,%rax
   40381:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   40387:	48 89 c7             	mov    %rax,%rdi
   4038a:	e8 01 35 00 00       	call   43890 <process_setup_stack>

    processes[pid].p_state = P_RUNNABLE;
   4038f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40392:	48 63 d0             	movslq %eax,%rdx
   40395:	48 89 d0             	mov    %rdx,%rax
   40398:	48 c1 e0 04          	shl    $0x4,%rax
   4039c:	48 29 d0             	sub    %rdx,%rax
   4039f:	48 c1 e0 04          	shl    $0x4,%rax
   403a3:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   403a9:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   403af:	90                   	nop
   403b0:	c9                   	leave  
   403b1:	c3                   	ret    

00000000000403b2 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   403b2:	55                   	push   %rbp
   403b3:	48 89 e5             	mov    %rsp,%rbp
   403b6:	48 83 ec 10          	sub    $0x10,%rsp
   403ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   403be:	89 f0                	mov    %esi,%eax
   403c0:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   403c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403c7:	25 ff 0f 00 00       	and    $0xfff,%eax
   403cc:	48 85 c0             	test   %rax,%rax
   403cf:	75 20                	jne    403f1 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   403d1:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   403d8:	00 
   403d9:	77 16                	ja     403f1 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   403db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403df:	48 c1 e8 0c          	shr    $0xc,%rax
   403e3:	48 98                	cltq   
   403e5:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   403ec:	00 
   403ed:	84 c0                	test   %al,%al
   403ef:	74 07                	je     403f8 <assign_physical_page+0x46>
        return -1;
   403f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   403f6:	eb 2c                	jmp    40424 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   403f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403fc:	48 c1 e8 0c          	shr    $0xc,%rax
   40400:	48 98                	cltq   
   40402:	c6 84 00 21 ff 04 00 	movb   $0x1,0x4ff21(%rax,%rax,1)
   40409:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4040a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4040e:	48 c1 e8 0c          	shr    $0xc,%rax
   40412:	48 98                	cltq   
   40414:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40418:	88 94 00 20 ff 04 00 	mov    %dl,0x4ff20(%rax,%rax,1)
        return 0;
   4041f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40424:	c9                   	leave  
   40425:	c3                   	ret    

0000000000040426 <syscall_fork>:

pid_t syscall_fork() {
   40426:	55                   	push   %rbp
   40427:	48 89 e5             	mov    %rsp,%rbp
    return process_fork(current);
   4042a:	48 8b 05 cf fa 00 00 	mov    0xfacf(%rip),%rax        # 4ff00 <current>
   40431:	48 89 c7             	mov    %rax,%rdi
   40434:	e8 0a 35 00 00       	call   43943 <process_fork>
}
   40439:	5d                   	pop    %rbp
   4043a:	c3                   	ret    

000000000004043b <syscall_exit>:


void syscall_exit() {
   4043b:	55                   	push   %rbp
   4043c:	48 89 e5             	mov    %rsp,%rbp
    process_free(current->p_pid);
   4043f:	48 8b 05 ba fa 00 00 	mov    0xfaba(%rip),%rax        # 4ff00 <current>
   40446:	8b 00                	mov    (%rax),%eax
   40448:	89 c7                	mov    %eax,%edi
   4044a:	e8 d9 2d 00 00       	call   43228 <process_free>
}
   4044f:	90                   	nop
   40450:	5d                   	pop    %rbp
   40451:	c3                   	ret    

0000000000040452 <syscall_page_alloc>:

int syscall_page_alloc(uintptr_t addr) {
   40452:	55                   	push   %rbp
   40453:	48 89 e5             	mov    %rsp,%rbp
   40456:	48 83 ec 10          	sub    $0x10,%rsp
   4045a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return process_page_alloc(current, addr);
   4045e:	48 8b 05 9b fa 00 00 	mov    0xfa9b(%rip),%rax        # 4ff00 <current>
   40465:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40469:	48 89 d6             	mov    %rdx,%rsi
   4046c:	48 89 c7             	mov    %rax,%rdi
   4046f:	e8 61 37 00 00       	call   43bd5 <process_page_alloc>
}
   40474:	c9                   	leave  
   40475:	c3                   	ret    

0000000000040476 <sbrk>:


int sbrk(proc * p, intptr_t difference) {
   40476:	55                   	push   %rbp
   40477:	48 89 e5             	mov    %rsp,%rbp
   4047a:	48 83 ec 60          	sub    $0x60,%rsp
   4047e:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   40482:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
    // TODO : Your code here
    uintptr_t new_break = p->program_break + difference;
   40486:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4048a:	48 8b 50 08          	mov    0x8(%rax),%rdx
   4048e:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   40492:	48 01 d0             	add    %rdx,%rax
   40495:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    uintptr_t  old_break = p->program_break;
   40499:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4049d:	48 8b 40 08          	mov    0x8(%rax),%rax
   404a1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(new_break >= MEMSIZE_VIRTUAL - PAGESIZE || new_break < p->original_break) {
   404a5:	48 81 7d f0 ff ef 2f 	cmpq   $0x2fefff,-0x10(%rbp)
   404ac:	00 
   404ad:	77 0e                	ja     404bd <sbrk+0x47>
   404af:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   404b3:	48 8b 40 10          	mov    0x10(%rax),%rax
   404b7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   404bb:	73 0a                	jae    404c7 <sbrk+0x51>
        return -1;
   404bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   404c2:	e9 fb 00 00 00       	jmp    405c2 <sbrk+0x14c>
    }
    // unmap pages if difference is negative
    // decrement ref count, virtual_memory_map (perms = PTE_W | PTE_U) --> page is not present
    if(difference < 0) {
   404c7:	48 83 7d a0 00       	cmpq   $0x0,-0x60(%rbp)
   404cc:	0f 89 e0 00 00 00    	jns    405b2 <sbrk+0x13c>
        for(uintptr_t i = ROUNDUP(old_break, PAGESIZE); i >= ROUNDDOWN(new_break, PAGESIZE); i -= PAGESIZE) {
   404d2:	48 c7 45 e0 00 10 00 	movq   $0x1000,-0x20(%rbp)
   404d9:	00 
   404da:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   404de:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   404e2:	48 01 d0             	add    %rdx,%rax
   404e5:	48 83 e8 01          	sub    $0x1,%rax
   404e9:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   404ed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   404f1:	ba 00 00 00 00       	mov    $0x0,%edx
   404f6:	48 f7 75 e0          	divq   -0x20(%rbp)
   404fa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   404fe:	48 29 d0             	sub    %rdx,%rax
   40501:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   40505:	e9 8c 00 00 00       	jmp    40596 <sbrk+0x120>
            vamapping vmap = virtual_memory_lookup(p->p_pagetable, i);
   4050a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4050e:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40515:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40519:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4051d:	48 89 ce             	mov    %rcx,%rsi
   40520:	48 89 c7             	mov    %rax,%rdi
   40523:	e8 5f 27 00 00       	call   42c87 <virtual_memory_lookup>
            if(vmap.pn != -1) {
   40528:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4052b:	83 f8 ff             	cmp    $0xffffffff,%eax
   4052e:	74 5e                	je     4058e <sbrk+0x118>
                pageinfo[vmap.pn].refcount--;
   40530:	8b 45 b8             	mov    -0x48(%rbp),%eax
   40533:	48 63 d0             	movslq %eax,%rdx
   40536:	0f b6 94 12 21 ff 04 	movzbl 0x4ff21(%rdx,%rdx,1),%edx
   4053d:	00 
   4053e:	83 ea 01             	sub    $0x1,%edx
   40541:	48 98                	cltq   
   40543:	88 94 00 21 ff 04 00 	mov    %dl,0x4ff21(%rax,%rax,1)
                if(pageinfo[vmap.pn].refcount == 0) {
   4054a:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4054d:	48 98                	cltq   
   4054f:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   40556:	00 
   40557:	84 c0                	test   %al,%al
   40559:	75 0d                	jne    40568 <sbrk+0xf2>
                    pageinfo[vmap.pn].owner = PO_FREE;
   4055b:	8b 45 b8             	mov    -0x48(%rbp),%eax
   4055e:	48 98                	cltq   
   40560:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   40567:	00 
                }
                virtual_memory_map(p->p_pagetable, i, vmap.pa, PAGESIZE, PTE_W | PTE_U);
   40568:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   4056c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40570:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40577:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   4057b:	41 b8 06 00 00 00    	mov    $0x6,%r8d
   40581:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40586:	48 89 c7             	mov    %rax,%rdi
   40589:	e8 36 23 00 00       	call   428c4 <virtual_memory_map>
        for(uintptr_t i = ROUNDUP(old_break, PAGESIZE); i >= ROUNDDOWN(new_break, PAGESIZE); i -= PAGESIZE) {
   4058e:	48 81 6d f8 00 10 00 	subq   $0x1000,-0x8(%rbp)
   40595:	00 
   40596:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4059a:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   4059e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   405a2:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   405a8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   405ac:	0f 83 58 ff ff ff    	jae    4050a <sbrk+0x94>
            }
        }
    }

    p->program_break = new_break;
   405b2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   405b6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   405ba:	48 89 50 08          	mov    %rdx,0x8(%rax)
    return old_break;
   405be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   405c2:	c9                   	leave  
   405c3:	c3                   	ret    

00000000000405c4 <brk>:

int brk(proc * p, uintptr_t new_address) {
   405c4:	55                   	push   %rbp
   405c5:	48 89 e5             	mov    %rsp,%rbp
   405c8:	48 83 ec 20          	sub    $0x20,%rsp
   405cc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   405d0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    intptr_t difference = new_address - p->program_break;
   405d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405d8:	48 8b 40 08          	mov    0x8(%rax),%rax
   405dc:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   405e0:	48 29 c2             	sub    %rax,%rdx
   405e3:	48 89 55 f8          	mov    %rdx,-0x8(%rbp)
    if(sbrk(p, difference) == -1) {
   405e7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   405eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   405ef:	48 89 d6             	mov    %rdx,%rsi
   405f2:	48 89 c7             	mov    %rax,%rdi
   405f5:	e8 7c fe ff ff       	call   40476 <sbrk>
   405fa:	83 f8 ff             	cmp    $0xffffffff,%eax
   405fd:	75 07                	jne    40606 <brk+0x42>
        return -1;
   405ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   40604:	eb 05                	jmp    4060b <brk+0x47>
    }
    return 0;
   40606:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4060b:	c9                   	leave  
   4060c:	c3                   	ret    

000000000004060d <syscall_mapping>:


void syscall_mapping(proc* p){
   4060d:	55                   	push   %rbp
   4060e:	48 89 e5             	mov    %rsp,%rbp
   40611:	48 83 ec 70          	sub    $0x70,%rsp
   40615:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   40619:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4061d:	48 8b 40 48          	mov    0x48(%rax),%rax
   40621:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40625:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40629:	48 8b 40 40          	mov    0x40(%rax),%rax
   4062d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    //convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   40631:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40635:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4063c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   40640:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40644:	48 89 ce             	mov    %rcx,%rsi
   40647:	48 89 c7             	mov    %rax,%rdi
   4064a:	e8 38 26 00 00       	call   42c87 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   4064f:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40652:	48 98                	cltq   
   40654:	83 e0 06             	and    $0x6,%eax
   40657:	48 83 f8 06          	cmp    $0x6,%rax
   4065b:	0f 85 89 00 00 00    	jne    406ea <syscall_mapping+0xdd>
        return;
    uintptr_t endaddr = mapping_ptr + sizeof(vamapping) - 1;
   40661:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40665:	48 83 c0 17          	add    $0x17,%rax
   40669:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if (PAGENUMBER(endaddr) != PAGENUMBER(ptr)){
   4066d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40671:	48 c1 e8 0c          	shr    $0xc,%rax
   40675:	89 c2                	mov    %eax,%edx
   40677:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4067b:	48 c1 e8 0c          	shr    $0xc,%rax
   4067f:	39 c2                	cmp    %eax,%edx
   40681:	74 2c                	je     406af <syscall_mapping+0xa2>
        vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   40683:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40687:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4068e:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40692:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40696:	48 89 ce             	mov    %rcx,%rsi
   40699:	48 89 c7             	mov    %rax,%rdi
   4069c:	e8 e6 25 00 00       	call   42c87 <virtual_memory_lookup>
        // check for write access for end address
        if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   406a1:	8b 45 b0             	mov    -0x50(%rbp),%eax
   406a4:	48 98                	cltq   
   406a6:	83 e0 03             	and    $0x3,%eax
   406a9:	48 83 f8 03          	cmp    $0x3,%rax
   406ad:	75 3e                	jne    406ed <syscall_mapping+0xe0>
            return; 
    }
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   406af:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   406b3:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   406ba:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   406be:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   406c2:	48 89 ce             	mov    %rcx,%rsi
   406c5:	48 89 c7             	mov    %rax,%rdi
   406c8:	e8 ba 25 00 00       	call   42c87 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   406cd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   406d1:	48 89 c1             	mov    %rax,%rcx
   406d4:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   406d8:	ba 18 00 00 00       	mov    $0x18,%edx
   406dd:	48 89 c6             	mov    %rax,%rsi
   406e0:	48 89 cf             	mov    %rcx,%rdi
   406e3:	e8 5b 35 00 00       	call   43c43 <memcpy>
   406e8:	eb 04                	jmp    406ee <syscall_mapping+0xe1>
        return;
   406ea:	90                   	nop
   406eb:	eb 01                	jmp    406ee <syscall_mapping+0xe1>
            return; 
   406ed:	90                   	nop
}
   406ee:	c9                   	leave  
   406ef:	c3                   	ret    

00000000000406f0 <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   406f0:	55                   	push   %rbp
   406f1:	48 89 e5             	mov    %rsp,%rbp
   406f4:	48 83 ec 18          	sub    $0x18,%rsp
   406f8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   406fc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40700:	48 8b 40 48          	mov    0x48(%rax),%rax
   40704:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40707:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4070b:	75 14                	jne    40721 <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   4070d:	0f b6 05 ec 58 00 00 	movzbl 0x58ec(%rip),%eax        # 46000 <disp_global>
   40714:	84 c0                	test   %al,%al
   40716:	0f 94 c0             	sete   %al
   40719:	88 05 e1 58 00 00    	mov    %al,0x58e1(%rip)        # 46000 <disp_global>
   4071f:	eb 36                	jmp    40757 <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40721:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40725:	78 2f                	js     40756 <syscall_mem_tog+0x66>
   40727:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4072b:	7f 29                	jg     40756 <syscall_mem_tog+0x66>
   4072d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40731:	8b 00                	mov    (%rax),%eax
   40733:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40736:	75 1e                	jne    40756 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   40738:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4073c:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   40743:	84 c0                	test   %al,%al
   40745:	0f 94 c0             	sete   %al
   40748:	89 c2                	mov    %eax,%edx
   4074a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4074e:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   40754:	eb 01                	jmp    40757 <syscall_mem_tog+0x67>
            return;
   40756:	90                   	nop
    }
}
   40757:	c9                   	leave  
   40758:	c3                   	ret    

0000000000040759 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40759:	55                   	push   %rbp
   4075a:	48 89 e5             	mov    %rsp,%rbp
   4075d:	48 81 ec 10 01 00 00 	sub    $0x110,%rsp
   40764:	48 89 bd f8 fe ff ff 	mov    %rdi,-0x108(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   4076b:	48 8b 05 8e f7 00 00 	mov    0xf78e(%rip),%rax        # 4ff00 <current>
   40772:	48 8b 95 f8 fe ff ff 	mov    -0x108(%rbp),%rdx
   40779:	48 83 c0 18          	add    $0x18,%rax
   4077d:	48 89 d6             	mov    %rdx,%rsi
   40780:	ba 18 00 00 00       	mov    $0x18,%edx
   40785:	48 89 c7             	mov    %rax,%rdi
   40788:	48 89 d1             	mov    %rdx,%rcx
   4078b:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   4078e:	48 8b 05 6b 18 01 00 	mov    0x1186b(%rip),%rax        # 52000 <kernel_pagetable>
   40795:	48 89 c7             	mov    %rax,%rdi
   40798:	e8 f6 1f 00 00       	call   42793 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   4079d:	8b 05 59 88 07 00    	mov    0x78859(%rip),%eax        # b8ffc <cursorpos>
   407a3:	89 c7                	mov    %eax,%edi
   407a5:	e8 17 17 00 00       	call   41ec1 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT
   407aa:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   407b1:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   407b8:	48 83 f8 0e          	cmp    $0xe,%rax
   407bc:	74 14                	je     407d2 <exception+0x79>
	    && reg->reg_intno != INT_GPF)
   407be:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   407c5:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   407cc:	48 83 f8 0d          	cmp    $0xd,%rax
   407d0:	75 16                	jne    407e8 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) {
   407d2:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   407d9:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   407e0:	83 e0 04             	and    $0x4,%eax
   407e3:	48 85 c0             	test   %rax,%rax
   407e6:	74 1a                	je     40802 <exception+0xa9>
        check_virtual_memory();
   407e8:	e8 9d 08 00 00       	call   4108a <check_virtual_memory>
        if(disp_global){
   407ed:	0f b6 05 0c 58 00 00 	movzbl 0x580c(%rip),%eax        # 46000 <disp_global>
   407f4:	84 c0                	test   %al,%al
   407f6:	74 0a                	je     40802 <exception+0xa9>
            memshow_physical();
   407f8:	e8 05 0a 00 00       	call   41202 <memshow_physical>
            memshow_virtual_animate();
   407fd:	e8 2f 0d 00 00       	call   41531 <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   40802:	e8 9d 1b 00 00       	call   423a4 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   40807:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   4080e:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40815:	48 83 e8 0e          	sub    $0xe,%rax
   40819:	48 83 f8 2c          	cmp    $0x2c,%rax
   4081d:	0f 87 8e 03 00 00    	ja     40bb1 <exception+0x458>
   40823:	48 8b 04 c5 d8 4d 04 	mov    0x44dd8(,%rax,8),%rax
   4082a:	00 
   4082b:	ff e0                	jmp    *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   4082d:	48 8b 05 cc f6 00 00 	mov    0xf6cc(%rip),%rax        # 4ff00 <current>
   40834:	48 8b 40 48          	mov    0x48(%rax),%rax
   40838:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                    if((void *)addr == NULL)
   4083c:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   40841:	75 0f                	jne    40852 <exception+0xf9>
                        kernel_panic(NULL);
   40843:	bf 00 00 00 00       	mov    $0x0,%edi
   40848:	b8 00 00 00 00       	mov    $0x0,%eax
   4084d:	e8 93 1c 00 00       	call   424e5 <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40852:	48 8b 05 a7 f6 00 00 	mov    0xf6a7(%rip),%rax        # 4ff00 <current>
   40859:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40860:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40864:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40868:	48 89 ce             	mov    %rcx,%rsi
   4086b:	48 89 c7             	mov    %rax,%rdi
   4086e:	e8 14 24 00 00       	call   42c87 <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   40873:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   40877:	48 89 c1             	mov    %rax,%rcx
   4087a:	48 8d 85 00 ff ff ff 	lea    -0x100(%rbp),%rax
   40881:	ba a0 00 00 00       	mov    $0xa0,%edx
   40886:	48 89 ce             	mov    %rcx,%rsi
   40889:	48 89 c7             	mov    %rax,%rdi
   4088c:	e8 b2 33 00 00       	call   43c43 <memcpy>
                    kernel_panic(msg);
   40891:	48 8d 85 00 ff ff ff 	lea    -0x100(%rbp),%rax
   40898:	48 89 c7             	mov    %rax,%rdi
   4089b:	b8 00 00 00 00       	mov    $0x0,%eax
   408a0:	e8 40 1c 00 00       	call   424e5 <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   408a5:	48 8b 05 54 f6 00 00 	mov    0xf654(%rip),%rax        # 4ff00 <current>
   408ac:	8b 10                	mov    (%rax),%edx
   408ae:	48 8b 05 4b f6 00 00 	mov    0xf64b(%rip),%rax        # 4ff00 <current>
   408b5:	48 63 d2             	movslq %edx,%rdx
   408b8:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   408bc:	e9 02 03 00 00       	jmp    40bc3 <exception+0x46a>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   408c1:	b8 00 00 00 00       	mov    $0x0,%eax
   408c6:	e8 5b fb ff ff       	call   40426 <syscall_fork>
   408cb:	89 c2                	mov    %eax,%edx
   408cd:	48 8b 05 2c f6 00 00 	mov    0xf62c(%rip),%rax        # 4ff00 <current>
   408d4:	48 63 d2             	movslq %edx,%rdx
   408d7:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   408db:	e9 e3 02 00 00       	jmp    40bc3 <exception+0x46a>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   408e0:	48 8b 05 19 f6 00 00 	mov    0xf619(%rip),%rax        # 4ff00 <current>
   408e7:	48 89 c7             	mov    %rax,%rdi
   408ea:	e8 1e fd ff ff       	call   4060d <syscall_mapping>
                break;
   408ef:	e9 cf 02 00 00       	jmp    40bc3 <exception+0x46a>
            }

        case INT_SYS_EXIT:
            {
                syscall_exit();
   408f4:	b8 00 00 00 00       	mov    $0x0,%eax
   408f9:	e8 3d fb ff ff       	call   4043b <syscall_exit>
                schedule();
   408fe:	e8 e9 02 00 00       	call   40bec <schedule>
                break;
   40903:	e9 bb 02 00 00       	jmp    40bc3 <exception+0x46a>
            }

        case INT_SYS_YIELD:
            {
                schedule();
   40908:	e8 df 02 00 00       	call   40bec <schedule>
                break;                  /* will not be reached */
   4090d:	e9 b1 02 00 00       	jmp    40bc3 <exception+0x46a>
            }

        case INT_SYS_BRK:
            {
                // TODO : Your code here
                current->p_registers.reg_rax = brk(current, current->p_registers.reg_rdi);
   40912:	48 8b 05 e7 f5 00 00 	mov    0xf5e7(%rip),%rax        # 4ff00 <current>
   40919:	48 8b 50 48          	mov    0x48(%rax),%rdx
   4091d:	48 8b 05 dc f5 00 00 	mov    0xf5dc(%rip),%rax        # 4ff00 <current>
   40924:	48 89 d6             	mov    %rdx,%rsi
   40927:	48 89 c7             	mov    %rax,%rdi
   4092a:	e8 95 fc ff ff       	call   405c4 <brk>
   4092f:	89 c2                	mov    %eax,%edx
   40931:	48 8b 05 c8 f5 00 00 	mov    0xf5c8(%rip),%rax        # 4ff00 <current>
   40938:	48 63 d2             	movslq %edx,%rdx
   4093b:	48 89 50 18          	mov    %rdx,0x18(%rax)
		break;
   4093f:	e9 7f 02 00 00       	jmp    40bc3 <exception+0x46a>
            }

        case INT_SYS_SBRK:
            {
                // TODO : Your code here
                current->p_registers.reg_rax = sbrk(current, current->p_registers.reg_rdi);
   40944:	48 8b 05 b5 f5 00 00 	mov    0xf5b5(%rip),%rax        # 4ff00 <current>
   4094b:	48 8b 40 48          	mov    0x48(%rax),%rax
   4094f:	48 89 c2             	mov    %rax,%rdx
   40952:	48 8b 05 a7 f5 00 00 	mov    0xf5a7(%rip),%rax        # 4ff00 <current>
   40959:	48 89 d6             	mov    %rdx,%rsi
   4095c:	48 89 c7             	mov    %rax,%rdi
   4095f:	e8 12 fb ff ff       	call   40476 <sbrk>
   40964:	89 c2                	mov    %eax,%edx
   40966:	48 8b 05 93 f5 00 00 	mov    0xf593(%rip),%rax        # 4ff00 <current>
   4096d:	48 63 d2             	movslq %edx,%rdx
   40970:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   40974:	e9 4a 02 00 00       	jmp    40bc3 <exception+0x46a>
            }
	case INT_SYS_PAGE_ALLOC:
	    {
		intptr_t addr = reg->reg_rdi;
   40979:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40980:	48 8b 40 30          	mov    0x30(%rax),%rax
   40984:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
		syscall_page_alloc(addr);
   40988:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4098c:	48 89 c7             	mov    %rax,%rdi
   4098f:	e8 be fa ff ff       	call   40452 <syscall_page_alloc>
		break;
   40994:	e9 2a 02 00 00       	jmp    40bc3 <exception+0x46a>
	    }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   40999:	48 8b 05 60 f5 00 00 	mov    0xf560(%rip),%rax        # 4ff00 <current>
   409a0:	48 89 c7             	mov    %rax,%rdi
   409a3:	e8 48 fd ff ff       	call   406f0 <syscall_mem_tog>
                break;
   409a8:	e9 16 02 00 00       	jmp    40bc3 <exception+0x46a>
            }

        case INT_TIMER:
            {
                ++ticks;
   409ad:	8b 05 6d f9 00 00    	mov    0xf96d(%rip),%eax        # 50320 <ticks>
   409b3:	83 c0 01             	add    $0x1,%eax
   409b6:	89 05 64 f9 00 00    	mov    %eax,0xf964(%rip)        # 50320 <ticks>
                schedule();
   409bc:	e8 2b 02 00 00       	call   40bec <schedule>
                break;                  /* will not be reached */
   409c1:	e9 fd 01 00 00       	jmp    40bc3 <exception+0x46a>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   409c6:	0f 20 d0             	mov    %cr2,%rax
   409c9:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    return val;
   409cd:	48 8b 45 b8          	mov    -0x48(%rbp),%rax

        case INT_PAGEFAULT: 
            {
                // Analyze faulting address and access type.
                // allocate (palloc) and map non-protection pagefaults 
                uintptr_t addr = rcr2();
   409d1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
                if(!(reg->reg_err & PFERR_PRESENT) && addr < current->program_break && addr >= current->original_break) {
   409d5:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   409dc:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   409e3:	83 e0 01             	and    $0x1,%eax
   409e6:	48 85 c0             	test   %rax,%rax
   409e9:	0f 85 cc 00 00 00    	jne    40abb <exception+0x362>
   409ef:	48 8b 05 0a f5 00 00 	mov    0xf50a(%rip),%rax        # 4ff00 <current>
   409f6:	48 8b 40 08          	mov    0x8(%rax),%rax
   409fa:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   409fe:	0f 83 b7 00 00 00    	jae    40abb <exception+0x362>
   40a04:	48 8b 05 f5 f4 00 00 	mov    0xf4f5(%rip),%rax        # 4ff00 <current>
   40a0b:	48 8b 40 10          	mov    0x10(%rax),%rax
   40a0f:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40a13:	0f 82 a2 00 00 00    	jb     40abb <exception+0x362>
                    void * new_physical_address = palloc(current->p_pid);
   40a19:	48 8b 05 e0 f4 00 00 	mov    0xf4e0(%rip),%rax        # 4ff00 <current>
   40a20:	8b 00                	mov    (%rax),%eax
   40a22:	89 c7                	mov    %eax,%edi
   40a24:	e8 e6 26 00 00       	call   4310f <palloc>
   40a29:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
                    if(new_physical_address == NULL) {
   40a2d:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   40a32:	75 20                	jne    40a54 <exception+0x2fb>
                        current->p_state = P_BROKEN;
   40a34:	48 8b 05 c5 f4 00 00 	mov    0xf4c5(%rip),%rax        # 4ff00 <current>
   40a3b:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40a42:	00 00 00 
                        syscall_exit();
   40a45:	b8 00 00 00 00       	mov    $0x0,%eax
   40a4a:	e8 ec f9 ff ff       	call   4043b <syscall_exit>
                        break;
   40a4f:	e9 6f 01 00 00       	jmp    40bc3 <exception+0x46a>
                    }
                    int vmap = virtual_memory_map(current->p_pagetable, ROUNDDOWN(addr, PAGESIZE), (uintptr_t) new_physical_address, PAGESIZE, PTE_W | PTE_P | PTE_U);
   40a54:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40a58:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40a5c:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   40a60:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40a64:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40a6a:	48 89 c6             	mov    %rax,%rsi
   40a6d:	48 8b 05 8c f4 00 00 	mov    0xf48c(%rip),%rax        # 4ff00 <current>
   40a74:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40a7b:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40a81:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40a86:	48 89 c7             	mov    %rax,%rdi
   40a89:	e8 36 1e 00 00       	call   428c4 <virtual_memory_map>
   40a8e:	89 45 d4             	mov    %eax,-0x2c(%rbp)
                    if(vmap == -1) {
   40a91:	83 7d d4 ff          	cmpl   $0xffffffff,-0x2c(%rbp)
   40a95:	0f 85 27 01 00 00    	jne    40bc2 <exception+0x469>
                        current->p_state = P_BROKEN;
   40a9b:	48 8b 05 5e f4 00 00 	mov    0xf45e(%rip),%rax        # 4ff00 <current>
   40aa2:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40aa9:	00 00 00 
                        syscall_exit();
   40aac:	b8 00 00 00 00       	mov    $0x0,%eax
   40ab1:	e8 85 f9 ff ff       	call   4043b <syscall_exit>
                        break;
   40ab6:	e9 08 01 00 00       	jmp    40bc3 <exception+0x46a>
                    }
                    break;
                }
                const char* operation = reg->reg_err & PFERR_WRITE
   40abb:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40ac2:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40ac9:	83 e0 02             	and    $0x2,%eax
                    ? "write" : "read";
   40acc:	48 85 c0             	test   %rax,%rax
   40acf:	74 07                	je     40ad8 <exception+0x37f>
   40ad1:	b8 4b 4d 04 00       	mov    $0x44d4b,%eax
   40ad6:	eb 05                	jmp    40add <exception+0x384>
   40ad8:	b8 51 4d 04 00       	mov    $0x44d51,%eax
                const char* operation = reg->reg_err & PFERR_WRITE
   40add:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
                const char* problem = reg->reg_err & PFERR_PRESENT
   40ae1:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40ae8:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40aef:	83 e0 01             	and    $0x1,%eax
                    ? "protection problem" : "missing page";
   40af2:	48 85 c0             	test   %rax,%rax
   40af5:	74 07                	je     40afe <exception+0x3a5>
   40af7:	b8 56 4d 04 00       	mov    $0x44d56,%eax
   40afc:	eb 05                	jmp    40b03 <exception+0x3aa>
   40afe:	b8 69 4d 04 00       	mov    $0x44d69,%eax
                const char* problem = reg->reg_err & PFERR_PRESENT
   40b03:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

                if (!(reg->reg_err & PFERR_USER)) {
   40b07:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40b0e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   40b15:	83 e0 04             	and    $0x4,%eax
   40b18:	48 85 c0             	test   %rax,%rax
   40b1b:	75 2f                	jne    40b4c <exception+0x3f3>
                    kernel_panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   40b1d:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40b24:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   40b2b:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   40b2f:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40b33:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40b37:	49 89 f0             	mov    %rsi,%r8
   40b3a:	48 89 c6             	mov    %rax,%rsi
   40b3d:	bf 78 4d 04 00       	mov    $0x44d78,%edi
   40b42:	b8 00 00 00 00       	mov    $0x0,%eax
   40b47:	e8 99 19 00 00       	call   424e5 <kernel_panic>
                            addr, operation, problem, reg->reg_rip);
                }
                console_printf(CPOS(24, 0), 0x0C00,
   40b4c:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40b53:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                        "Process %d page fault for %p (%s %s, rip=%p)!\n",
                        current->p_pid, addr, operation, problem, reg->reg_rip);
   40b5a:	48 8b 05 9f f3 00 00 	mov    0xf39f(%rip),%rax        # 4ff00 <current>
                console_printf(CPOS(24, 0), 0x0C00,
   40b61:	8b 00                	mov    (%rax),%eax
   40b63:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
   40b67:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   40b6b:	52                   	push   %rdx
   40b6c:	ff 75 c0             	push   -0x40(%rbp)
   40b6f:	49 89 f1             	mov    %rsi,%r9
   40b72:	49 89 c8             	mov    %rcx,%r8
   40b75:	89 c1                	mov    %eax,%ecx
   40b77:	ba a8 4d 04 00       	mov    $0x44da8,%edx
   40b7c:	be 00 0c 00 00       	mov    $0xc00,%esi
   40b81:	bf 80 07 00 00       	mov    $0x780,%edi
   40b86:	b8 00 00 00 00       	mov    $0x0,%eax
   40b8b:	e8 68 3f 00 00       	call   44af8 <console_printf>
   40b90:	48 83 c4 10          	add    $0x10,%rsp
                current->p_state = P_BROKEN;
   40b94:	48 8b 05 65 f3 00 00 	mov    0xf365(%rip),%rax        # 4ff00 <current>
   40b9b:	c7 80 d8 00 00 00 03 	movl   $0x3,0xd8(%rax)
   40ba2:	00 00 00 
                syscall_exit();
   40ba5:	b8 00 00 00 00       	mov    $0x0,%eax
   40baa:	e8 8c f8 ff ff       	call   4043b <syscall_exit>
                break;
   40baf:	eb 12                	jmp    40bc3 <exception+0x46a>
            }

        default:
            default_exception(current);
   40bb1:	48 8b 05 48 f3 00 00 	mov    0xf348(%rip),%rax        # 4ff00 <current>
   40bb8:	48 89 c7             	mov    %rax,%rdi
   40bbb:	e8 35 1a 00 00       	call   425f5 <default_exception>
            break;                  /* will not be reached */
   40bc0:	eb 01                	jmp    40bc3 <exception+0x46a>
                    break;
   40bc2:	90                   	nop

    }

    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40bc3:	48 8b 05 36 f3 00 00 	mov    0xf336(%rip),%rax        # 4ff00 <current>
   40bca:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40bd0:	83 f8 01             	cmp    $0x1,%eax
   40bd3:	75 0f                	jne    40be4 <exception+0x48b>
        run(current);
   40bd5:	48 8b 05 24 f3 00 00 	mov    0xf324(%rip),%rax        # 4ff00 <current>
   40bdc:	48 89 c7             	mov    %rax,%rdi
   40bdf:	e8 7e 00 00 00       	call   40c62 <run>
    } else {
        schedule();
   40be4:	e8 03 00 00 00       	call   40bec <schedule>
    }
}
   40be9:	90                   	nop
   40bea:	c9                   	leave  
   40beb:	c3                   	ret    

0000000000040bec <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40bec:	55                   	push   %rbp
   40bed:	48 89 e5             	mov    %rsp,%rbp
   40bf0:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40bf4:	48 8b 05 05 f3 00 00 	mov    0xf305(%rip),%rax        # 4ff00 <current>
   40bfb:	8b 00                	mov    (%rax),%eax
   40bfd:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40c00:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c03:	8d 50 01             	lea    0x1(%rax),%edx
   40c06:	89 d0                	mov    %edx,%eax
   40c08:	c1 f8 1f             	sar    $0x1f,%eax
   40c0b:	c1 e8 1c             	shr    $0x1c,%eax
   40c0e:	01 c2                	add    %eax,%edx
   40c10:	83 e2 0f             	and    $0xf,%edx
   40c13:	29 c2                	sub    %eax,%edx
   40c15:	89 55 fc             	mov    %edx,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40c18:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c1b:	48 63 d0             	movslq %eax,%rdx
   40c1e:	48 89 d0             	mov    %rdx,%rax
   40c21:	48 c1 e0 04          	shl    $0x4,%rax
   40c25:	48 29 d0             	sub    %rdx,%rax
   40c28:	48 c1 e0 04          	shl    $0x4,%rax
   40c2c:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   40c32:	8b 00                	mov    (%rax),%eax
   40c34:	83 f8 01             	cmp    $0x1,%eax
   40c37:	75 22                	jne    40c5b <schedule+0x6f>
            run(&processes[pid]);
   40c39:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c3c:	48 63 d0             	movslq %eax,%rdx
   40c3f:	48 89 d0             	mov    %rdx,%rax
   40c42:	48 c1 e0 04          	shl    $0x4,%rax
   40c46:	48 29 d0             	sub    %rdx,%rax
   40c49:	48 c1 e0 04          	shl    $0x4,%rax
   40c4d:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   40c53:	48 89 c7             	mov    %rax,%rdi
   40c56:	e8 07 00 00 00       	call   40c62 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40c5b:	e8 44 17 00 00       	call   423a4 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40c60:	eb 9e                	jmp    40c00 <schedule+0x14>

0000000000040c62 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40c62:	55                   	push   %rbp
   40c63:	48 89 e5             	mov    %rsp,%rbp
   40c66:	48 83 ec 10          	sub    $0x10,%rsp
   40c6a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40c6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c72:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40c78:	83 f8 01             	cmp    $0x1,%eax
   40c7b:	74 14                	je     40c91 <run+0x2f>
   40c7d:	ba 40 4f 04 00       	mov    $0x44f40,%edx
   40c82:	be a9 01 00 00       	mov    $0x1a9,%esi
   40c87:	bf 08 4d 04 00       	mov    $0x44d08,%edi
   40c8c:	e8 34 19 00 00       	call   425c5 <assert_fail>
    current = p;
   40c91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c95:	48 89 05 64 f2 00 00 	mov    %rax,0xf264(%rip)        # 4ff00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40c9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ca0:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40ca2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ca6:	8b 00                	mov    (%rax),%eax
   40ca8:	83 c0 02             	add    $0x2,%eax
   40cab:	48 98                	cltq   
   40cad:	0f b7 84 00 a0 4c 04 	movzwl 0x44ca0(%rax,%rax,1),%eax
   40cb4:	00 
    console_printf(CPOS(24, 79),
   40cb5:	0f b7 c0             	movzwl %ax,%eax
   40cb8:	89 d1                	mov    %edx,%ecx
   40cba:	ba 59 4f 04 00       	mov    $0x44f59,%edx
   40cbf:	89 c6                	mov    %eax,%esi
   40cc1:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40cc6:	b8 00 00 00 00       	mov    $0x0,%eax
   40ccb:	e8 28 3e 00 00       	call   44af8 <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40cd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cd4:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40cdb:	48 89 c7             	mov    %rax,%rdi
   40cde:	e8 b0 1a 00 00       	call   42793 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40ce3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ce7:	48 83 c0 18          	add    $0x18,%rax
   40ceb:	48 89 c7             	mov    %rax,%rdi
   40cee:	e8 d0 f3 ff ff       	call   400c3 <exception_return>

0000000000040cf3 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40cf3:	55                   	push   %rbp
   40cf4:	48 89 e5             	mov    %rsp,%rbp
   40cf7:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40cfb:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40d02:	00 
   40d03:	e9 81 00 00 00       	jmp    40d89 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40d08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d0c:	48 89 c7             	mov    %rax,%rdi
   40d0f:	e8 1e 0f 00 00       	call   41c32 <physical_memory_isreserved>
   40d14:	85 c0                	test   %eax,%eax
   40d16:	74 09                	je     40d21 <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40d18:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40d1f:	eb 2f                	jmp    40d50 <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40d21:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40d28:	00 
   40d29:	76 0b                	jbe    40d36 <pageinfo_init+0x43>
   40d2b:	b8 10 80 05 00       	mov    $0x58010,%eax
   40d30:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40d34:	72 0a                	jb     40d40 <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40d36:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40d3d:	00 
   40d3e:	75 09                	jne    40d49 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40d40:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40d47:	eb 07                	jmp    40d50 <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40d49:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40d50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d54:	48 c1 e8 0c          	shr    $0xc,%rax
   40d58:	89 c1                	mov    %eax,%ecx
   40d5a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40d5d:	89 c2                	mov    %eax,%edx
   40d5f:	48 63 c1             	movslq %ecx,%rax
   40d62:	88 94 00 20 ff 04 00 	mov    %dl,0x4ff20(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40d69:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40d6d:	0f 95 c2             	setne  %dl
   40d70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d74:	48 c1 e8 0c          	shr    $0xc,%rax
   40d78:	48 98                	cltq   
   40d7a:	88 94 00 21 ff 04 00 	mov    %dl,0x4ff21(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40d81:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40d88:	00 
   40d89:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40d90:	00 
   40d91:	0f 86 71 ff ff ff    	jbe    40d08 <pageinfo_init+0x15>
    }
}
   40d97:	90                   	nop
   40d98:	90                   	nop
   40d99:	c9                   	leave  
   40d9a:	c3                   	ret    

0000000000040d9b <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40d9b:	55                   	push   %rbp
   40d9c:	48 89 e5             	mov    %rsp,%rbp
   40d9f:	48 83 ec 50          	sub    $0x50,%rsp
   40da3:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40da7:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40dab:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40db1:	48 89 c2             	mov    %rax,%rdx
   40db4:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40db8:	48 39 c2             	cmp    %rax,%rdx
   40dbb:	74 14                	je     40dd1 <check_page_table_mappings+0x36>
   40dbd:	ba 60 4f 04 00       	mov    $0x44f60,%edx
   40dc2:	be d7 01 00 00       	mov    $0x1d7,%esi
   40dc7:	bf 08 4d 04 00       	mov    $0x44d08,%edi
   40dcc:	e8 f4 17 00 00       	call   425c5 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40dd1:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40dd8:	00 
   40dd9:	e9 9a 00 00 00       	jmp    40e78 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40dde:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40de2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40de6:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40dea:	48 89 ce             	mov    %rcx,%rsi
   40ded:	48 89 c7             	mov    %rax,%rdi
   40df0:	e8 92 1e 00 00       	call   42c87 <virtual_memory_lookup>
        if (vam.pa != va) {
   40df5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40df9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40dfd:	74 27                	je     40e26 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40dff:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40e03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40e07:	49 89 d0             	mov    %rdx,%r8
   40e0a:	48 89 c1             	mov    %rax,%rcx
   40e0d:	ba 7f 4f 04 00       	mov    $0x44f7f,%edx
   40e12:	be 00 c0 00 00       	mov    $0xc000,%esi
   40e17:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40e1c:	b8 00 00 00 00       	mov    $0x0,%eax
   40e21:	e8 d2 3c 00 00       	call   44af8 <console_printf>
        }
        assert(vam.pa == va);
   40e26:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40e2a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e2e:	74 14                	je     40e44 <check_page_table_mappings+0xa9>
   40e30:	ba 89 4f 04 00       	mov    $0x44f89,%edx
   40e35:	be e0 01 00 00       	mov    $0x1e0,%esi
   40e3a:	bf 08 4d 04 00       	mov    $0x44d08,%edi
   40e3f:	e8 81 17 00 00       	call   425c5 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40e44:	b8 00 60 04 00       	mov    $0x46000,%eax
   40e49:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e4d:	72 21                	jb     40e70 <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40e4f:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40e52:	48 98                	cltq   
   40e54:	83 e0 02             	and    $0x2,%eax
   40e57:	48 85 c0             	test   %rax,%rax
   40e5a:	75 14                	jne    40e70 <check_page_table_mappings+0xd5>
   40e5c:	ba 96 4f 04 00       	mov    $0x44f96,%edx
   40e61:	be e2 01 00 00       	mov    $0x1e2,%esi
   40e66:	bf 08 4d 04 00       	mov    $0x44d08,%edi
   40e6b:	e8 55 17 00 00       	call   425c5 <assert_fail>
         va += PAGESIZE) {
   40e70:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e77:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40e78:	b8 10 80 05 00       	mov    $0x58010,%eax
   40e7d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e81:	0f 82 57 ff ff ff    	jb     40dde <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40e87:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40e8e:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40e8f:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40e93:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40e97:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40e9b:	48 89 ce             	mov    %rcx,%rsi
   40e9e:	48 89 c7             	mov    %rax,%rdi
   40ea1:	e8 e1 1d 00 00       	call   42c87 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40ea6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40eaa:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40eae:	74 14                	je     40ec4 <check_page_table_mappings+0x129>
   40eb0:	ba a7 4f 04 00       	mov    $0x44fa7,%edx
   40eb5:	be e9 01 00 00       	mov    $0x1e9,%esi
   40eba:	bf 08 4d 04 00       	mov    $0x44d08,%edi
   40ebf:	e8 01 17 00 00       	call   425c5 <assert_fail>
    assert(vam.perm & PTE_W);
   40ec4:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40ec7:	48 98                	cltq   
   40ec9:	83 e0 02             	and    $0x2,%eax
   40ecc:	48 85 c0             	test   %rax,%rax
   40ecf:	75 14                	jne    40ee5 <check_page_table_mappings+0x14a>
   40ed1:	ba 96 4f 04 00       	mov    $0x44f96,%edx
   40ed6:	be ea 01 00 00       	mov    $0x1ea,%esi
   40edb:	bf 08 4d 04 00       	mov    $0x44d08,%edi
   40ee0:	e8 e0 16 00 00       	call   425c5 <assert_fail>
}
   40ee5:	90                   	nop
   40ee6:	c9                   	leave  
   40ee7:	c3                   	ret    

0000000000040ee8 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40ee8:	55                   	push   %rbp
   40ee9:	48 89 e5             	mov    %rsp,%rbp
   40eec:	48 83 ec 20          	sub    $0x20,%rsp
   40ef0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40ef4:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40ef7:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40efa:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40efd:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40f04:	48 8b 05 f5 10 01 00 	mov    0x110f5(%rip),%rax        # 52000 <kernel_pagetable>
   40f0b:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40f0f:	75 67                	jne    40f78 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40f11:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40f18:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40f1f:	eb 51                	jmp    40f72 <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40f21:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40f24:	48 63 d0             	movslq %eax,%rdx
   40f27:	48 89 d0             	mov    %rdx,%rax
   40f2a:	48 c1 e0 04          	shl    $0x4,%rax
   40f2e:	48 29 d0             	sub    %rdx,%rax
   40f31:	48 c1 e0 04          	shl    $0x4,%rax
   40f35:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   40f3b:	8b 00                	mov    (%rax),%eax
   40f3d:	85 c0                	test   %eax,%eax
   40f3f:	74 2d                	je     40f6e <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40f41:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40f44:	48 63 d0             	movslq %eax,%rdx
   40f47:	48 89 d0             	mov    %rdx,%rax
   40f4a:	48 c1 e0 04          	shl    $0x4,%rax
   40f4e:	48 29 d0             	sub    %rdx,%rax
   40f51:	48 c1 e0 04          	shl    $0x4,%rax
   40f55:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   40f5b:	48 8b 10             	mov    (%rax),%rdx
   40f5e:	48 8b 05 9b 10 01 00 	mov    0x1109b(%rip),%rax        # 52000 <kernel_pagetable>
   40f65:	48 39 c2             	cmp    %rax,%rdx
   40f68:	75 04                	jne    40f6e <check_page_table_ownership+0x86>
                ++expected_refcount;
   40f6a:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40f6e:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40f72:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40f76:	7e a9                	jle    40f21 <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40f78:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40f7b:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f7e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f82:	be 00 00 00 00       	mov    $0x0,%esi
   40f87:	48 89 c7             	mov    %rax,%rdi
   40f8a:	e8 03 00 00 00       	call   40f92 <check_page_table_ownership_level>
}
   40f8f:	90                   	nop
   40f90:	c9                   	leave  
   40f91:	c3                   	ret    

0000000000040f92 <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40f92:	55                   	push   %rbp
   40f93:	48 89 e5             	mov    %rsp,%rbp
   40f96:	48 83 ec 30          	sub    $0x30,%rsp
   40f9a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40f9e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40fa1:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40fa4:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40fa7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fab:	48 c1 e8 0c          	shr    $0xc,%rax
   40faf:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40fb4:	7e 14                	jle    40fca <check_page_table_ownership_level+0x38>
   40fb6:	ba b8 4f 04 00       	mov    $0x44fb8,%edx
   40fbb:	be 07 02 00 00       	mov    $0x207,%esi
   40fc0:	bf 08 4d 04 00       	mov    $0x44d08,%edi
   40fc5:	e8 fb 15 00 00       	call   425c5 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40fca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fce:	48 c1 e8 0c          	shr    $0xc,%rax
   40fd2:	48 98                	cltq   
   40fd4:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   40fdb:	00 
   40fdc:	0f be c0             	movsbl %al,%eax
   40fdf:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40fe2:	74 14                	je     40ff8 <check_page_table_ownership_level+0x66>
   40fe4:	ba d0 4f 04 00       	mov    $0x44fd0,%edx
   40fe9:	be 08 02 00 00       	mov    $0x208,%esi
   40fee:	bf 08 4d 04 00       	mov    $0x44d08,%edi
   40ff3:	e8 cd 15 00 00       	call   425c5 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40ff8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40ffc:	48 c1 e8 0c          	shr    $0xc,%rax
   41000:	48 98                	cltq   
   41002:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   41009:	00 
   4100a:	0f be c0             	movsbl %al,%eax
   4100d:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   41010:	74 14                	je     41026 <check_page_table_ownership_level+0x94>
   41012:	ba f8 4f 04 00       	mov    $0x44ff8,%edx
   41017:	be 09 02 00 00       	mov    $0x209,%esi
   4101c:	bf 08 4d 04 00       	mov    $0x44d08,%edi
   41021:	e8 9f 15 00 00       	call   425c5 <assert_fail>
    if (level < 3) {
   41026:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   4102a:	7f 5b                	jg     41087 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   4102c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41033:	eb 49                	jmp    4107e <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   41035:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41039:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4103c:	48 63 d2             	movslq %edx,%rdx
   4103f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41043:	48 85 c0             	test   %rax,%rax
   41046:	74 32                	je     4107a <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41048:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4104c:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4104f:	48 63 d2             	movslq %edx,%rdx
   41052:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41056:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   4105c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   41060:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41063:	8d 70 01             	lea    0x1(%rax),%esi
   41066:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41069:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4106d:	b9 01 00 00 00       	mov    $0x1,%ecx
   41072:	48 89 c7             	mov    %rax,%rdi
   41075:	e8 18 ff ff ff       	call   40f92 <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   4107a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4107e:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41085:	7e ae                	jle    41035 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   41087:	90                   	nop
   41088:	c9                   	leave  
   41089:	c3                   	ret    

000000000004108a <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   4108a:	55                   	push   %rbp
   4108b:	48 89 e5             	mov    %rsp,%rbp
   4108e:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   41092:	8b 05 40 e0 00 00    	mov    0xe040(%rip),%eax        # 4f0d8 <processes+0xd8>
   41098:	85 c0                	test   %eax,%eax
   4109a:	74 14                	je     410b0 <check_virtual_memory+0x26>
   4109c:	ba 28 50 04 00       	mov    $0x45028,%edx
   410a1:	be 1c 02 00 00       	mov    $0x21c,%esi
   410a6:	bf 08 4d 04 00       	mov    $0x44d08,%edi
   410ab:	e8 15 15 00 00       	call   425c5 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   410b0:	48 8b 05 49 0f 01 00 	mov    0x10f49(%rip),%rax        # 52000 <kernel_pagetable>
   410b7:	48 89 c7             	mov    %rax,%rdi
   410ba:	e8 dc fc ff ff       	call   40d9b <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   410bf:	48 8b 05 3a 0f 01 00 	mov    0x10f3a(%rip),%rax        # 52000 <kernel_pagetable>
   410c6:	be ff ff ff ff       	mov    $0xffffffff,%esi
   410cb:	48 89 c7             	mov    %rax,%rdi
   410ce:	e8 15 fe ff ff       	call   40ee8 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   410d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   410da:	e9 9c 00 00 00       	jmp    4117b <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   410df:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410e2:	48 63 d0             	movslq %eax,%rdx
   410e5:	48 89 d0             	mov    %rdx,%rax
   410e8:	48 c1 e0 04          	shl    $0x4,%rax
   410ec:	48 29 d0             	sub    %rdx,%rax
   410ef:	48 c1 e0 04          	shl    $0x4,%rax
   410f3:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   410f9:	8b 00                	mov    (%rax),%eax
   410fb:	85 c0                	test   %eax,%eax
   410fd:	74 78                	je     41177 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   410ff:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41102:	48 63 d0             	movslq %eax,%rdx
   41105:	48 89 d0             	mov    %rdx,%rax
   41108:	48 c1 e0 04          	shl    $0x4,%rax
   4110c:	48 29 d0             	sub    %rdx,%rax
   4110f:	48 c1 e0 04          	shl    $0x4,%rax
   41113:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   41119:	48 8b 10             	mov    (%rax),%rdx
   4111c:	48 8b 05 dd 0e 01 00 	mov    0x10edd(%rip),%rax        # 52000 <kernel_pagetable>
   41123:	48 39 c2             	cmp    %rax,%rdx
   41126:	74 4f                	je     41177 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   41128:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4112b:	48 63 d0             	movslq %eax,%rdx
   4112e:	48 89 d0             	mov    %rdx,%rax
   41131:	48 c1 e0 04          	shl    $0x4,%rax
   41135:	48 29 d0             	sub    %rdx,%rax
   41138:	48 c1 e0 04          	shl    $0x4,%rax
   4113c:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   41142:	48 8b 00             	mov    (%rax),%rax
   41145:	48 89 c7             	mov    %rax,%rdi
   41148:	e8 4e fc ff ff       	call   40d9b <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   4114d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41150:	48 63 d0             	movslq %eax,%rdx
   41153:	48 89 d0             	mov    %rdx,%rax
   41156:	48 c1 e0 04          	shl    $0x4,%rax
   4115a:	48 29 d0             	sub    %rdx,%rax
   4115d:	48 c1 e0 04          	shl    $0x4,%rax
   41161:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   41167:	48 8b 00             	mov    (%rax),%rax
   4116a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4116d:	89 d6                	mov    %edx,%esi
   4116f:	48 89 c7             	mov    %rax,%rdi
   41172:	e8 71 fd ff ff       	call   40ee8 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41177:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4117b:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4117f:	0f 8e 5a ff ff ff    	jle    410df <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41185:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   4118c:	eb 67                	jmp    411f5 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   4118e:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41191:	48 98                	cltq   
   41193:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   4119a:	00 
   4119b:	84 c0                	test   %al,%al
   4119d:	7e 52                	jle    411f1 <check_virtual_memory+0x167>
   4119f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   411a2:	48 98                	cltq   
   411a4:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   411ab:	00 
   411ac:	84 c0                	test   %al,%al
   411ae:	78 41                	js     411f1 <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   411b0:	8b 45 f8             	mov    -0x8(%rbp),%eax
   411b3:	48 98                	cltq   
   411b5:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   411bc:	00 
   411bd:	0f be c0             	movsbl %al,%eax
   411c0:	48 63 d0             	movslq %eax,%rdx
   411c3:	48 89 d0             	mov    %rdx,%rax
   411c6:	48 c1 e0 04          	shl    $0x4,%rax
   411ca:	48 29 d0             	sub    %rdx,%rax
   411cd:	48 c1 e0 04          	shl    $0x4,%rax
   411d1:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   411d7:	8b 00                	mov    (%rax),%eax
   411d9:	85 c0                	test   %eax,%eax
   411db:	75 14                	jne    411f1 <check_virtual_memory+0x167>
   411dd:	ba 48 50 04 00       	mov    $0x45048,%edx
   411e2:	be 33 02 00 00       	mov    $0x233,%esi
   411e7:	bf 08 4d 04 00       	mov    $0x44d08,%edi
   411ec:	e8 d4 13 00 00       	call   425c5 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   411f1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   411f5:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   411fc:	7e 90                	jle    4118e <check_virtual_memory+0x104>
        }
    }
}
   411fe:	90                   	nop
   411ff:	90                   	nop
   41200:	c9                   	leave  
   41201:	c3                   	ret    

0000000000041202 <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   41202:	55                   	push   %rbp
   41203:	48 89 e5             	mov    %rsp,%rbp
   41206:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   4120a:	ba 78 50 04 00       	mov    $0x45078,%edx
   4120f:	be 00 0f 00 00       	mov    $0xf00,%esi
   41214:	bf 20 00 00 00       	mov    $0x20,%edi
   41219:	b8 00 00 00 00       	mov    $0x0,%eax
   4121e:	e8 d5 38 00 00       	call   44af8 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41223:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4122a:	e9 f8 00 00 00       	jmp    41327 <memshow_physical+0x125>
        if (pn % 64 == 0) {
   4122f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41232:	83 e0 3f             	and    $0x3f,%eax
   41235:	85 c0                	test   %eax,%eax
   41237:	75 3c                	jne    41275 <memshow_physical+0x73>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   41239:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4123c:	c1 e0 0c             	shl    $0xc,%eax
   4123f:	89 c1                	mov    %eax,%ecx
   41241:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41244:	8d 50 3f             	lea    0x3f(%rax),%edx
   41247:	85 c0                	test   %eax,%eax
   41249:	0f 48 c2             	cmovs  %edx,%eax
   4124c:	c1 f8 06             	sar    $0x6,%eax
   4124f:	8d 50 01             	lea    0x1(%rax),%edx
   41252:	89 d0                	mov    %edx,%eax
   41254:	c1 e0 02             	shl    $0x2,%eax
   41257:	01 d0                	add    %edx,%eax
   41259:	c1 e0 04             	shl    $0x4,%eax
   4125c:	83 c0 03             	add    $0x3,%eax
   4125f:	ba 88 50 04 00       	mov    $0x45088,%edx
   41264:	be 00 0f 00 00       	mov    $0xf00,%esi
   41269:	89 c7                	mov    %eax,%edi
   4126b:	b8 00 00 00 00       	mov    $0x0,%eax
   41270:	e8 83 38 00 00       	call   44af8 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41275:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41278:	48 98                	cltq   
   4127a:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   41281:	00 
   41282:	0f be c0             	movsbl %al,%eax
   41285:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41288:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4128b:	48 98                	cltq   
   4128d:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   41294:	00 
   41295:	84 c0                	test   %al,%al
   41297:	75 07                	jne    412a0 <memshow_physical+0x9e>
            owner = PO_FREE;
   41299:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   412a0:	8b 45 f8             	mov    -0x8(%rbp),%eax
   412a3:	83 c0 02             	add    $0x2,%eax
   412a6:	48 98                	cltq   
   412a8:	0f b7 84 00 a0 4c 04 	movzwl 0x44ca0(%rax,%rax,1),%eax
   412af:	00 
   412b0:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   412b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412b7:	48 98                	cltq   
   412b9:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   412c0:	00 
   412c1:	3c 01                	cmp    $0x1,%al
   412c3:	7e 1a                	jle    412df <memshow_physical+0xdd>
   412c5:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   412ca:	48 c1 e8 0c          	shr    $0xc,%rax
   412ce:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   412d1:	74 0c                	je     412df <memshow_physical+0xdd>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   412d3:	b8 53 00 00 00       	mov    $0x53,%eax
   412d8:	80 cc 0f             	or     $0xf,%ah
   412db:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   412df:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412e2:	8d 50 3f             	lea    0x3f(%rax),%edx
   412e5:	85 c0                	test   %eax,%eax
   412e7:	0f 48 c2             	cmovs  %edx,%eax
   412ea:	c1 f8 06             	sar    $0x6,%eax
   412ed:	8d 50 01             	lea    0x1(%rax),%edx
   412f0:	89 d0                	mov    %edx,%eax
   412f2:	c1 e0 02             	shl    $0x2,%eax
   412f5:	01 d0                	add    %edx,%eax
   412f7:	c1 e0 04             	shl    $0x4,%eax
   412fa:	89 c1                	mov    %eax,%ecx
   412fc:	8b 55 fc             	mov    -0x4(%rbp),%edx
   412ff:	89 d0                	mov    %edx,%eax
   41301:	c1 f8 1f             	sar    $0x1f,%eax
   41304:	c1 e8 1a             	shr    $0x1a,%eax
   41307:	01 c2                	add    %eax,%edx
   41309:	83 e2 3f             	and    $0x3f,%edx
   4130c:	29 c2                	sub    %eax,%edx
   4130e:	89 d0                	mov    %edx,%eax
   41310:	83 c0 0c             	add    $0xc,%eax
   41313:	01 c8                	add    %ecx,%eax
   41315:	48 98                	cltq   
   41317:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   4131b:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   41322:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41323:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41327:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   4132e:	0f 8e fb fe ff ff    	jle    4122f <memshow_physical+0x2d>
    }
}
   41334:	90                   	nop
   41335:	90                   	nop
   41336:	c9                   	leave  
   41337:	c3                   	ret    

0000000000041338 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   41338:	55                   	push   %rbp
   41339:	48 89 e5             	mov    %rsp,%rbp
   4133c:	48 83 ec 40          	sub    $0x40,%rsp
   41340:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   41344:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41348:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4134c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   41352:	48 89 c2             	mov    %rax,%rdx
   41355:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41359:	48 39 c2             	cmp    %rax,%rdx
   4135c:	74 14                	je     41372 <memshow_virtual+0x3a>
   4135e:	ba 90 50 04 00       	mov    $0x45090,%edx
   41363:	be 64 02 00 00       	mov    $0x264,%esi
   41368:	bf 08 4d 04 00       	mov    $0x44d08,%edi
   4136d:	e8 53 12 00 00       	call   425c5 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41372:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41376:	48 89 c1             	mov    %rax,%rcx
   41379:	ba bd 50 04 00       	mov    $0x450bd,%edx
   4137e:	be 00 0f 00 00       	mov    $0xf00,%esi
   41383:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41388:	b8 00 00 00 00       	mov    $0x0,%eax
   4138d:	e8 66 37 00 00       	call   44af8 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41392:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41399:	00 
   4139a:	e9 80 01 00 00       	jmp    4151f <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   4139f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   413a3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   413a7:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   413ab:	48 89 ce             	mov    %rcx,%rsi
   413ae:	48 89 c7             	mov    %rax,%rdi
   413b1:	e8 d1 18 00 00       	call   42c87 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   413b6:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413b9:	85 c0                	test   %eax,%eax
   413bb:	79 0b                	jns    413c8 <memshow_virtual+0x90>
            color = ' ';
   413bd:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   413c3:	e9 d7 00 00 00       	jmp    4149f <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   413c8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   413cc:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   413d2:	76 14                	jbe    413e8 <memshow_virtual+0xb0>
   413d4:	ba da 50 04 00       	mov    $0x450da,%edx
   413d9:	be 6d 02 00 00       	mov    $0x26d,%esi
   413de:	bf 08 4d 04 00       	mov    $0x44d08,%edi
   413e3:	e8 dd 11 00 00       	call   425c5 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   413e8:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413eb:	48 98                	cltq   
   413ed:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   413f4:	00 
   413f5:	0f be c0             	movsbl %al,%eax
   413f8:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   413fb:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413fe:	48 98                	cltq   
   41400:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   41407:	00 
   41408:	84 c0                	test   %al,%al
   4140a:	75 07                	jne    41413 <memshow_virtual+0xdb>
                owner = PO_FREE;
   4140c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41413:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41416:	83 c0 02             	add    $0x2,%eax
   41419:	48 98                	cltq   
   4141b:	0f b7 84 00 a0 4c 04 	movzwl 0x44ca0(%rax,%rax,1),%eax
   41422:	00 
   41423:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41427:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4142a:	48 98                	cltq   
   4142c:	83 e0 04             	and    $0x4,%eax
   4142f:	48 85 c0             	test   %rax,%rax
   41432:	74 27                	je     4145b <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41434:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41438:	c1 e0 04             	shl    $0x4,%eax
   4143b:	66 25 00 f0          	and    $0xf000,%ax
   4143f:	89 c2                	mov    %eax,%edx
   41441:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41445:	c1 f8 04             	sar    $0x4,%eax
   41448:	66 25 00 0f          	and    $0xf00,%ax
   4144c:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   4144e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41452:	0f b6 c0             	movzbl %al,%eax
   41455:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41457:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   4145b:	8b 45 d0             	mov    -0x30(%rbp),%eax
   4145e:	48 98                	cltq   
   41460:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   41467:	00 
   41468:	3c 01                	cmp    $0x1,%al
   4146a:	7e 33                	jle    4149f <memshow_virtual+0x167>
   4146c:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41471:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41475:	74 28                	je     4149f <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41477:	b8 53 00 00 00       	mov    $0x53,%eax
   4147c:	89 c2                	mov    %eax,%edx
   4147e:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41482:	66 25 00 f0          	and    $0xf000,%ax
   41486:	09 d0                	or     %edx,%eax
   41488:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   4148c:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4148f:	48 98                	cltq   
   41491:	83 e0 04             	and    $0x4,%eax
   41494:	48 85 c0             	test   %rax,%rax
   41497:	75 06                	jne    4149f <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41499:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   4149f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414a3:	48 c1 e8 0c          	shr    $0xc,%rax
   414a7:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   414aa:	8b 45 ec             	mov    -0x14(%rbp),%eax
   414ad:	83 e0 3f             	and    $0x3f,%eax
   414b0:	85 c0                	test   %eax,%eax
   414b2:	75 34                	jne    414e8 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   414b4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   414b7:	c1 e8 06             	shr    $0x6,%eax
   414ba:	89 c2                	mov    %eax,%edx
   414bc:	89 d0                	mov    %edx,%eax
   414be:	c1 e0 02             	shl    $0x2,%eax
   414c1:	01 d0                	add    %edx,%eax
   414c3:	c1 e0 04             	shl    $0x4,%eax
   414c6:	05 73 03 00 00       	add    $0x373,%eax
   414cb:	89 c7                	mov    %eax,%edi
   414cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414d1:	48 89 c1             	mov    %rax,%rcx
   414d4:	ba 88 50 04 00       	mov    $0x45088,%edx
   414d9:	be 00 0f 00 00       	mov    $0xf00,%esi
   414de:	b8 00 00 00 00       	mov    $0x0,%eax
   414e3:	e8 10 36 00 00       	call   44af8 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   414e8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   414eb:	c1 e8 06             	shr    $0x6,%eax
   414ee:	89 c2                	mov    %eax,%edx
   414f0:	89 d0                	mov    %edx,%eax
   414f2:	c1 e0 02             	shl    $0x2,%eax
   414f5:	01 d0                	add    %edx,%eax
   414f7:	c1 e0 04             	shl    $0x4,%eax
   414fa:	89 c2                	mov    %eax,%edx
   414fc:	8b 45 ec             	mov    -0x14(%rbp),%eax
   414ff:	83 e0 3f             	and    $0x3f,%eax
   41502:	01 d0                	add    %edx,%eax
   41504:	05 7c 03 00 00       	add    $0x37c,%eax
   41509:	89 c2                	mov    %eax,%edx
   4150b:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4150f:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41516:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41517:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4151e:	00 
   4151f:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41526:	00 
   41527:	0f 86 72 fe ff ff    	jbe    4139f <memshow_virtual+0x67>
    }
}
   4152d:	90                   	nop
   4152e:	90                   	nop
   4152f:	c9                   	leave  
   41530:	c3                   	ret    

0000000000041531 <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41531:	55                   	push   %rbp
   41532:	48 89 e5             	mov    %rsp,%rbp
   41535:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41539:	8b 05 e5 ed 00 00    	mov    0xede5(%rip),%eax        # 50324 <last_ticks.1>
   4153f:	85 c0                	test   %eax,%eax
   41541:	74 13                	je     41556 <memshow_virtual_animate+0x25>
   41543:	8b 15 d7 ed 00 00    	mov    0xedd7(%rip),%edx        # 50320 <ticks>
   41549:	8b 05 d5 ed 00 00    	mov    0xedd5(%rip),%eax        # 50324 <last_ticks.1>
   4154f:	29 c2                	sub    %eax,%edx
   41551:	83 fa 31             	cmp    $0x31,%edx
   41554:	76 2c                	jbe    41582 <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   41556:	8b 05 c4 ed 00 00    	mov    0xedc4(%rip),%eax        # 50320 <ticks>
   4155c:	89 05 c2 ed 00 00    	mov    %eax,0xedc2(%rip)        # 50324 <last_ticks.1>
        ++showing;
   41562:	8b 05 9c 4a 00 00    	mov    0x4a9c(%rip),%eax        # 46004 <showing.0>
   41568:	83 c0 01             	add    $0x1,%eax
   4156b:	89 05 93 4a 00 00    	mov    %eax,0x4a93(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41571:	eb 0f                	jmp    41582 <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   41573:	8b 05 8b 4a 00 00    	mov    0x4a8b(%rip),%eax        # 46004 <showing.0>
   41579:	83 c0 01             	add    $0x1,%eax
   4157c:	89 05 82 4a 00 00    	mov    %eax,0x4a82(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   41582:	8b 05 7c 4a 00 00    	mov    0x4a7c(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   41588:	83 f8 20             	cmp    $0x20,%eax
   4158b:	7f 34                	jg     415c1 <memshow_virtual_animate+0x90>
   4158d:	8b 15 71 4a 00 00    	mov    0x4a71(%rip),%edx        # 46004 <showing.0>
   41593:	89 d0                	mov    %edx,%eax
   41595:	c1 f8 1f             	sar    $0x1f,%eax
   41598:	c1 e8 1c             	shr    $0x1c,%eax
   4159b:	01 c2                	add    %eax,%edx
   4159d:	83 e2 0f             	and    $0xf,%edx
   415a0:	29 c2                	sub    %eax,%edx
   415a2:	89 d0                	mov    %edx,%eax
   415a4:	48 63 d0             	movslq %eax,%rdx
   415a7:	48 89 d0             	mov    %rdx,%rax
   415aa:	48 c1 e0 04          	shl    $0x4,%rax
   415ae:	48 29 d0             	sub    %rdx,%rax
   415b1:	48 c1 e0 04          	shl    $0x4,%rax
   415b5:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   415bb:	8b 00                	mov    (%rax),%eax
   415bd:	85 c0                	test   %eax,%eax
   415bf:	74 b2                	je     41573 <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   415c1:	8b 15 3d 4a 00 00    	mov    0x4a3d(%rip),%edx        # 46004 <showing.0>
   415c7:	89 d0                	mov    %edx,%eax
   415c9:	c1 f8 1f             	sar    $0x1f,%eax
   415cc:	c1 e8 1c             	shr    $0x1c,%eax
   415cf:	01 c2                	add    %eax,%edx
   415d1:	83 e2 0f             	and    $0xf,%edx
   415d4:	29 c2                	sub    %eax,%edx
   415d6:	89 d0                	mov    %edx,%eax
   415d8:	89 05 26 4a 00 00    	mov    %eax,0x4a26(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   415de:	8b 05 20 4a 00 00    	mov    0x4a20(%rip),%eax        # 46004 <showing.0>
   415e4:	48 63 d0             	movslq %eax,%rdx
   415e7:	48 89 d0             	mov    %rdx,%rax
   415ea:	48 c1 e0 04          	shl    $0x4,%rax
   415ee:	48 29 d0             	sub    %rdx,%rax
   415f1:	48 c1 e0 04          	shl    $0x4,%rax
   415f5:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   415fb:	8b 00                	mov    (%rax),%eax
   415fd:	85 c0                	test   %eax,%eax
   415ff:	74 76                	je     41677 <memshow_virtual_animate+0x146>
   41601:	8b 05 fd 49 00 00    	mov    0x49fd(%rip),%eax        # 46004 <showing.0>
   41607:	48 63 d0             	movslq %eax,%rdx
   4160a:	48 89 d0             	mov    %rdx,%rax
   4160d:	48 c1 e0 04          	shl    $0x4,%rax
   41611:	48 29 d0             	sub    %rdx,%rax
   41614:	48 c1 e0 04          	shl    $0x4,%rax
   41618:	48 05 e8 f0 04 00    	add    $0x4f0e8,%rax
   4161e:	0f b6 00             	movzbl (%rax),%eax
   41621:	84 c0                	test   %al,%al
   41623:	74 52                	je     41677 <memshow_virtual_animate+0x146>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41625:	8b 15 d9 49 00 00    	mov    0x49d9(%rip),%edx        # 46004 <showing.0>
   4162b:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   4162f:	89 d1                	mov    %edx,%ecx
   41631:	ba f4 50 04 00       	mov    $0x450f4,%edx
   41636:	be 04 00 00 00       	mov    $0x4,%esi
   4163b:	48 89 c7             	mov    %rax,%rdi
   4163e:	b8 00 00 00 00       	mov    $0x0,%eax
   41643:	e8 bc 35 00 00       	call   44c04 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41648:	8b 05 b6 49 00 00    	mov    0x49b6(%rip),%eax        # 46004 <showing.0>
   4164e:	48 63 d0             	movslq %eax,%rdx
   41651:	48 89 d0             	mov    %rdx,%rax
   41654:	48 c1 e0 04          	shl    $0x4,%rax
   41658:	48 29 d0             	sub    %rdx,%rax
   4165b:	48 c1 e0 04          	shl    $0x4,%rax
   4165f:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   41665:	48 8b 00             	mov    (%rax),%rax
   41668:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   4166c:	48 89 d6             	mov    %rdx,%rsi
   4166f:	48 89 c7             	mov    %rax,%rdi
   41672:	e8 c1 fc ff ff       	call   41338 <memshow_virtual>
    }
}
   41677:	90                   	nop
   41678:	c9                   	leave  
   41679:	c3                   	ret    

000000000004167a <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   4167a:	55                   	push   %rbp
   4167b:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   4167e:	e8 4f 01 00 00       	call   417d2 <segments_init>
    interrupt_init();
   41683:	e8 d0 03 00 00       	call   41a58 <interrupt_init>
    virtual_memory_init();
   41688:	e8 f3 0f 00 00       	call   42680 <virtual_memory_init>
}
   4168d:	90                   	nop
   4168e:	5d                   	pop    %rbp
   4168f:	c3                   	ret    

0000000000041690 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41690:	55                   	push   %rbp
   41691:	48 89 e5             	mov    %rsp,%rbp
   41694:	48 83 ec 18          	sub    $0x18,%rsp
   41698:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4169c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   416a0:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   416a3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416a6:	48 98                	cltq   
   416a8:	48 c1 e0 2d          	shl    $0x2d,%rax
   416ac:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   416b0:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   416b7:	90 00 00 
   416ba:	48 09 c2             	or     %rax,%rdx
    *segment = type
   416bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416c1:	48 89 10             	mov    %rdx,(%rax)
}
   416c4:	90                   	nop
   416c5:	c9                   	leave  
   416c6:	c3                   	ret    

00000000000416c7 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   416c7:	55                   	push   %rbp
   416c8:	48 89 e5             	mov    %rsp,%rbp
   416cb:	48 83 ec 28          	sub    $0x28,%rsp
   416cf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   416d3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   416d7:	89 55 ec             	mov    %edx,-0x14(%rbp)
   416da:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   416de:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   416e2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   416e6:	48 c1 e0 10          	shl    $0x10,%rax
   416ea:	48 89 c2             	mov    %rax,%rdx
   416ed:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   416f4:	00 00 00 
   416f7:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   416fa:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   416fe:	48 c1 e0 20          	shl    $0x20,%rax
   41702:	48 89 c1             	mov    %rax,%rcx
   41705:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   4170c:	00 00 ff 
   4170f:	48 21 c8             	and    %rcx,%rax
   41712:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41715:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41719:	48 83 e8 01          	sub    $0x1,%rax
   4171d:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41720:	48 09 d0             	or     %rdx,%rax
        | type
   41723:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41727:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4172a:	48 63 d2             	movslq %edx,%rdx
   4172d:	48 c1 e2 2d          	shl    $0x2d,%rdx
   41731:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41734:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   4173b:	80 00 00 
   4173e:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41741:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41745:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41748:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4174c:	48 83 c0 08          	add    $0x8,%rax
   41750:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41754:	48 c1 ea 20          	shr    $0x20,%rdx
   41758:	48 89 10             	mov    %rdx,(%rax)
}
   4175b:	90                   	nop
   4175c:	c9                   	leave  
   4175d:	c3                   	ret    

000000000004175e <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   4175e:	55                   	push   %rbp
   4175f:	48 89 e5             	mov    %rsp,%rbp
   41762:	48 83 ec 20          	sub    $0x20,%rsp
   41766:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4176a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4176e:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41771:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41775:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41779:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   4177c:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | ((uint64_t) dpl << 45)
   41780:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41783:	48 63 d2             	movslq %edx,%rdx
   41786:	48 c1 e2 2d          	shl    $0x2d,%rdx
   4178a:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   4178d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41791:	48 c1 e0 20          	shl    $0x20,%rax
   41795:	48 89 c1             	mov    %rax,%rcx
   41798:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   4179f:	00 ff ff 
   417a2:	48 21 c8             	and    %rcx,%rax
   417a5:	48 09 c2             	or     %rax,%rdx
   417a8:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   417af:	80 00 00 
   417b2:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   417b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   417b9:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   417bc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   417c0:	48 c1 e8 20          	shr    $0x20,%rax
   417c4:	48 89 c2             	mov    %rax,%rdx
   417c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   417cb:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   417cf:	90                   	nop
   417d0:	c9                   	leave  
   417d1:	c3                   	ret    

00000000000417d2 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   417d2:	55                   	push   %rbp
   417d3:	48 89 e5             	mov    %rsp,%rbp
   417d6:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   417da:	48 c7 05 5b eb 00 00 	movq   $0x0,0xeb5b(%rip)        # 50340 <segments>
   417e1:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   417e5:	ba 00 00 00 00       	mov    $0x0,%edx
   417ea:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   417f1:	08 20 00 
   417f4:	48 89 c6             	mov    %rax,%rsi
   417f7:	bf 48 03 05 00       	mov    $0x50348,%edi
   417fc:	e8 8f fe ff ff       	call   41690 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41801:	ba 03 00 00 00       	mov    $0x3,%edx
   41806:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   4180d:	08 20 00 
   41810:	48 89 c6             	mov    %rax,%rsi
   41813:	bf 50 03 05 00       	mov    $0x50350,%edi
   41818:	e8 73 fe ff ff       	call   41690 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   4181d:	ba 00 00 00 00       	mov    $0x0,%edx
   41822:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41829:	02 00 00 
   4182c:	48 89 c6             	mov    %rax,%rsi
   4182f:	bf 58 03 05 00       	mov    $0x50358,%edi
   41834:	e8 57 fe ff ff       	call   41690 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41839:	ba 03 00 00 00       	mov    $0x3,%edx
   4183e:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41845:	02 00 00 
   41848:	48 89 c6             	mov    %rax,%rsi
   4184b:	bf 60 03 05 00       	mov    $0x50360,%edi
   41850:	e8 3b fe ff ff       	call   41690 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41855:	b8 80 13 05 00       	mov    $0x51380,%eax
   4185a:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41860:	48 89 c1             	mov    %rax,%rcx
   41863:	ba 00 00 00 00       	mov    $0x0,%edx
   41868:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   4186f:	09 00 00 
   41872:	48 89 c6             	mov    %rax,%rsi
   41875:	bf 68 03 05 00       	mov    $0x50368,%edi
   4187a:	e8 48 fe ff ff       	call   416c7 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   4187f:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41885:	b8 40 03 05 00       	mov    $0x50340,%eax
   4188a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   4188e:	ba 60 00 00 00       	mov    $0x60,%edx
   41893:	be 00 00 00 00       	mov    $0x0,%esi
   41898:	bf 80 13 05 00       	mov    $0x51380,%edi
   4189d:	e8 9f 24 00 00       	call   43d41 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   418a2:	48 c7 05 d7 fa 00 00 	movq   $0x80000,0xfad7(%rip)        # 51384 <kernel_task_descriptor+0x4>
   418a9:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   418ad:	ba 00 10 00 00       	mov    $0x1000,%edx
   418b2:	be 00 00 00 00       	mov    $0x0,%esi
   418b7:	bf 80 03 05 00       	mov    $0x50380,%edi
   418bc:	e8 80 24 00 00       	call   43d41 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   418c1:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   418c8:	eb 30                	jmp    418fa <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   418ca:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   418cf:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418d2:	48 c1 e0 04          	shl    $0x4,%rax
   418d6:	48 05 80 03 05 00    	add    $0x50380,%rax
   418dc:	48 89 d1             	mov    %rdx,%rcx
   418df:	ba 00 00 00 00       	mov    $0x0,%edx
   418e4:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   418eb:	0e 00 00 
   418ee:	48 89 c7             	mov    %rax,%rdi
   418f1:	e8 68 fe ff ff       	call   4175e <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   418f6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   418fa:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41901:	76 c7                	jbe    418ca <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41903:	b8 36 00 04 00       	mov    $0x40036,%eax
   41908:	48 89 c1             	mov    %rax,%rcx
   4190b:	ba 00 00 00 00       	mov    $0x0,%edx
   41910:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41917:	0e 00 00 
   4191a:	48 89 c6             	mov    %rax,%rsi
   4191d:	bf 80 05 05 00       	mov    $0x50580,%edi
   41922:	e8 37 fe ff ff       	call   4175e <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41927:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   4192c:	48 89 c1             	mov    %rax,%rcx
   4192f:	ba 00 00 00 00       	mov    $0x0,%edx
   41934:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4193b:	0e 00 00 
   4193e:	48 89 c6             	mov    %rax,%rsi
   41941:	bf 50 04 05 00       	mov    $0x50450,%edi
   41946:	e8 13 fe ff ff       	call   4175e <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   4194b:	b8 32 00 04 00       	mov    $0x40032,%eax
   41950:	48 89 c1             	mov    %rax,%rcx
   41953:	ba 00 00 00 00       	mov    $0x0,%edx
   41958:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   4195f:	0e 00 00 
   41962:	48 89 c6             	mov    %rax,%rsi
   41965:	bf 60 04 05 00       	mov    $0x50460,%edi
   4196a:	e8 ef fd ff ff       	call   4175e <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4196f:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41976:	eb 3e                	jmp    419b6 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41978:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4197b:	83 e8 30             	sub    $0x30,%eax
   4197e:	89 c0                	mov    %eax,%eax
   41980:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41987:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41988:	48 89 c2             	mov    %rax,%rdx
   4198b:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4198e:	48 c1 e0 04          	shl    $0x4,%rax
   41992:	48 05 80 03 05 00    	add    $0x50380,%rax
   41998:	48 89 d1             	mov    %rdx,%rcx
   4199b:	ba 03 00 00 00       	mov    $0x3,%edx
   419a0:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   419a7:	0e 00 00 
   419aa:	48 89 c7             	mov    %rax,%rdi
   419ad:	e8 ac fd ff ff       	call   4175e <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   419b2:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   419b6:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   419ba:	76 bc                	jbe    41978 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   419bc:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   419c2:	b8 80 03 05 00       	mov    $0x50380,%eax
   419c7:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   419cb:	b8 28 00 00 00       	mov    $0x28,%eax
   419d0:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   419d4:	0f 00 d8             	ltr    %ax
   419d7:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   419db:	0f 20 c0             	mov    %cr0,%rax
   419de:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   419e2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   419e6:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   419e9:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   419f0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   419f3:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   419f6:	8b 45 f0             	mov    -0x10(%rbp),%eax
   419f9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   419fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41a01:	0f 22 c0             	mov    %rax,%cr0
}
   41a04:	90                   	nop
    lcr0(cr0);
}
   41a05:	90                   	nop
   41a06:	c9                   	leave  
   41a07:	c3                   	ret    

0000000000041a08 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   41a08:	55                   	push   %rbp
   41a09:	48 89 e5             	mov    %rsp,%rbp
   41a0c:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   41a10:	0f b7 05 c9 f9 00 00 	movzwl 0xf9c9(%rip),%eax        # 513e0 <interrupts_enabled>
   41a17:	f7 d0                	not    %eax
   41a19:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   41a1d:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41a21:	0f b6 c0             	movzbl %al,%eax
   41a24:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   41a2b:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a2e:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   41a32:	8b 55 f0             	mov    -0x10(%rbp),%edx
   41a35:	ee                   	out    %al,(%dx)
}
   41a36:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   41a37:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   41a3b:	66 c1 e8 08          	shr    $0x8,%ax
   41a3f:	0f b6 c0             	movzbl %al,%eax
   41a42:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   41a49:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a4c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41a50:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41a53:	ee                   	out    %al,(%dx)
}
   41a54:	90                   	nop
}
   41a55:	90                   	nop
   41a56:	c9                   	leave  
   41a57:	c3                   	ret    

0000000000041a58 <interrupt_init>:

void interrupt_init(void) {
   41a58:	55                   	push   %rbp
   41a59:	48 89 e5             	mov    %rsp,%rbp
   41a5c:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41a60:	66 c7 05 77 f9 00 00 	movw   $0x0,0xf977(%rip)        # 513e0 <interrupts_enabled>
   41a67:	00 00 
    interrupt_mask();
   41a69:	e8 9a ff ff ff       	call   41a08 <interrupt_mask>
   41a6e:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41a75:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a79:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41a7d:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41a80:	ee                   	out    %al,(%dx)
}
   41a81:	90                   	nop
   41a82:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41a89:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a8d:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41a91:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41a94:	ee                   	out    %al,(%dx)
}
   41a95:	90                   	nop
   41a96:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41a9d:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aa1:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41aa5:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41aa8:	ee                   	out    %al,(%dx)
}
   41aa9:	90                   	nop
   41aaa:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41ab1:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ab5:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41ab9:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41abc:	ee                   	out    %al,(%dx)
}
   41abd:	90                   	nop
   41abe:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41ac5:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ac9:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41acd:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41ad0:	ee                   	out    %al,(%dx)
}
   41ad1:	90                   	nop
   41ad2:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41ad9:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41add:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41ae1:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41ae4:	ee                   	out    %al,(%dx)
}
   41ae5:	90                   	nop
   41ae6:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41aed:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41af1:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41af5:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41af8:	ee                   	out    %al,(%dx)
}
   41af9:	90                   	nop
   41afa:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41b01:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b05:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41b09:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41b0c:	ee                   	out    %al,(%dx)
}
   41b0d:	90                   	nop
   41b0e:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41b15:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b19:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41b1d:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41b20:	ee                   	out    %al,(%dx)
}
   41b21:	90                   	nop
   41b22:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41b29:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b2d:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b31:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b34:	ee                   	out    %al,(%dx)
}
   41b35:	90                   	nop
   41b36:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41b3d:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b41:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41b45:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b48:	ee                   	out    %al,(%dx)
}
   41b49:	90                   	nop
   41b4a:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41b51:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b55:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41b59:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41b5c:	ee                   	out    %al,(%dx)
}
   41b5d:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41b5e:	e8 a5 fe ff ff       	call   41a08 <interrupt_mask>
}
   41b63:	90                   	nop
   41b64:	c9                   	leave  
   41b65:	c3                   	ret    

0000000000041b66 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41b66:	55                   	push   %rbp
   41b67:	48 89 e5             	mov    %rsp,%rbp
   41b6a:	48 83 ec 28          	sub    $0x28,%rsp
   41b6e:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41b71:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41b75:	0f 8e 9e 00 00 00    	jle    41c19 <timer_init+0xb3>
   41b7b:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41b82:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b86:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b8a:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b8d:	ee                   	out    %al,(%dx)
}
   41b8e:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41b8f:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41b92:	89 c2                	mov    %eax,%edx
   41b94:	c1 ea 1f             	shr    $0x1f,%edx
   41b97:	01 d0                	add    %edx,%eax
   41b99:	d1 f8                	sar    %eax
   41b9b:	05 de 34 12 00       	add    $0x1234de,%eax
   41ba0:	99                   	cltd   
   41ba1:	f7 7d dc             	idivl  -0x24(%rbp)
   41ba4:	89 c2                	mov    %eax,%edx
   41ba6:	89 d0                	mov    %edx,%eax
   41ba8:	c1 f8 1f             	sar    $0x1f,%eax
   41bab:	c1 e8 18             	shr    $0x18,%eax
   41bae:	01 c2                	add    %eax,%edx
   41bb0:	0f b6 d2             	movzbl %dl,%edx
   41bb3:	29 c2                	sub    %eax,%edx
   41bb5:	89 d0                	mov    %edx,%eax
   41bb7:	0f b6 c0             	movzbl %al,%eax
   41bba:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41bc1:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bc4:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41bc8:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41bcb:	ee                   	out    %al,(%dx)
}
   41bcc:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41bcd:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41bd0:	89 c2                	mov    %eax,%edx
   41bd2:	c1 ea 1f             	shr    $0x1f,%edx
   41bd5:	01 d0                	add    %edx,%eax
   41bd7:	d1 f8                	sar    %eax
   41bd9:	05 de 34 12 00       	add    $0x1234de,%eax
   41bde:	99                   	cltd   
   41bdf:	f7 7d dc             	idivl  -0x24(%rbp)
   41be2:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41be8:	85 c0                	test   %eax,%eax
   41bea:	0f 48 c2             	cmovs  %edx,%eax
   41bed:	c1 f8 08             	sar    $0x8,%eax
   41bf0:	0f b6 c0             	movzbl %al,%eax
   41bf3:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41bfa:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41bfd:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41c01:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41c04:	ee                   	out    %al,(%dx)
}
   41c05:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41c06:	0f b7 05 d3 f7 00 00 	movzwl 0xf7d3(%rip),%eax        # 513e0 <interrupts_enabled>
   41c0d:	83 c8 01             	or     $0x1,%eax
   41c10:	66 89 05 c9 f7 00 00 	mov    %ax,0xf7c9(%rip)        # 513e0 <interrupts_enabled>
   41c17:	eb 11                	jmp    41c2a <timer_init+0xc4>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41c19:	0f b7 05 c0 f7 00 00 	movzwl 0xf7c0(%rip),%eax        # 513e0 <interrupts_enabled>
   41c20:	83 e0 fe             	and    $0xfffffffe,%eax
   41c23:	66 89 05 b6 f7 00 00 	mov    %ax,0xf7b6(%rip)        # 513e0 <interrupts_enabled>
    }
    interrupt_mask();
   41c2a:	e8 d9 fd ff ff       	call   41a08 <interrupt_mask>
}
   41c2f:	90                   	nop
   41c30:	c9                   	leave  
   41c31:	c3                   	ret    

0000000000041c32 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41c32:	55                   	push   %rbp
   41c33:	48 89 e5             	mov    %rsp,%rbp
   41c36:	48 83 ec 08          	sub    $0x8,%rsp
   41c3a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41c3e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41c43:	74 14                	je     41c59 <physical_memory_isreserved+0x27>
   41c45:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41c4c:	00 
   41c4d:	76 11                	jbe    41c60 <physical_memory_isreserved+0x2e>
   41c4f:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41c56:	00 
   41c57:	77 07                	ja     41c60 <physical_memory_isreserved+0x2e>
   41c59:	b8 01 00 00 00       	mov    $0x1,%eax
   41c5e:	eb 05                	jmp    41c65 <physical_memory_isreserved+0x33>
   41c60:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41c65:	c9                   	leave  
   41c66:	c3                   	ret    

0000000000041c67 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41c67:	55                   	push   %rbp
   41c68:	48 89 e5             	mov    %rsp,%rbp
   41c6b:	48 83 ec 10          	sub    $0x10,%rsp
   41c6f:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41c72:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41c75:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41c78:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c7b:	c1 e0 10             	shl    $0x10,%eax
   41c7e:	89 c2                	mov    %eax,%edx
   41c80:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c83:	c1 e0 0b             	shl    $0xb,%eax
   41c86:	09 c2                	or     %eax,%edx
   41c88:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c8b:	c1 e0 08             	shl    $0x8,%eax
   41c8e:	09 d0                	or     %edx,%eax
}
   41c90:	c9                   	leave  
   41c91:	c3                   	ret    

0000000000041c92 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41c92:	55                   	push   %rbp
   41c93:	48 89 e5             	mov    %rsp,%rbp
   41c96:	48 83 ec 18          	sub    $0x18,%rsp
   41c9a:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41c9d:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41ca0:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41ca3:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41ca6:	09 d0                	or     %edx,%eax
   41ca8:	0d 00 00 00 80       	or     $0x80000000,%eax
   41cad:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41cb4:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41cb7:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41cba:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41cbd:	ef                   	out    %eax,(%dx)
}
   41cbe:	90                   	nop
   41cbf:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41cc6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41cc9:	89 c2                	mov    %eax,%edx
   41ccb:	ed                   	in     (%dx),%eax
   41ccc:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41ccf:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41cd2:	c9                   	leave  
   41cd3:	c3                   	ret    

0000000000041cd4 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41cd4:	55                   	push   %rbp
   41cd5:	48 89 e5             	mov    %rsp,%rbp
   41cd8:	48 83 ec 28          	sub    $0x28,%rsp
   41cdc:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41cdf:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41ce2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41ce9:	eb 73                	jmp    41d5e <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41ceb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41cf2:	eb 60                	jmp    41d54 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41cf4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41cfb:	eb 4a                	jmp    41d47 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41cfd:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d00:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41d03:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d06:	89 ce                	mov    %ecx,%esi
   41d08:	89 c7                	mov    %eax,%edi
   41d0a:	e8 58 ff ff ff       	call   41c67 <pci_make_configaddr>
   41d0f:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41d12:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d15:	be 00 00 00 00       	mov    $0x0,%esi
   41d1a:	89 c7                	mov    %eax,%edi
   41d1c:	e8 71 ff ff ff       	call   41c92 <pci_config_readl>
   41d21:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41d24:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41d27:	c1 e0 10             	shl    $0x10,%eax
   41d2a:	0b 45 dc             	or     -0x24(%rbp),%eax
   41d2d:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41d30:	75 05                	jne    41d37 <pci_find_device+0x63>
                    return configaddr;
   41d32:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41d35:	eb 35                	jmp    41d6c <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41d37:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41d3b:	75 06                	jne    41d43 <pci_find_device+0x6f>
   41d3d:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41d41:	74 0c                	je     41d4f <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41d43:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41d47:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41d4b:	75 b0                	jne    41cfd <pci_find_device+0x29>
   41d4d:	eb 01                	jmp    41d50 <pci_find_device+0x7c>
                    break;
   41d4f:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41d50:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41d54:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41d58:	75 9a                	jne    41cf4 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41d5a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41d5e:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41d65:	75 84                	jne    41ceb <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41d67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41d6c:	c9                   	leave  
   41d6d:	c3                   	ret    

0000000000041d6e <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41d6e:	55                   	push   %rbp
   41d6f:	48 89 e5             	mov    %rsp,%rbp
   41d72:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41d76:	be 13 71 00 00       	mov    $0x7113,%esi
   41d7b:	bf 86 80 00 00       	mov    $0x8086,%edi
   41d80:	e8 4f ff ff ff       	call   41cd4 <pci_find_device>
   41d85:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41d88:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41d8c:	78 30                	js     41dbe <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41d8e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d91:	be 40 00 00 00       	mov    $0x40,%esi
   41d96:	89 c7                	mov    %eax,%edi
   41d98:	e8 f5 fe ff ff       	call   41c92 <pci_config_readl>
   41d9d:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41da2:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41da5:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41da8:	83 c0 04             	add    $0x4,%eax
   41dab:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41dae:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41db4:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41db8:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41dbb:	66 ef                	out    %ax,(%dx)
}
   41dbd:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41dbe:	ba 00 51 04 00       	mov    $0x45100,%edx
   41dc3:	be 00 c0 00 00       	mov    $0xc000,%esi
   41dc8:	bf 80 07 00 00       	mov    $0x780,%edi
   41dcd:	b8 00 00 00 00       	mov    $0x0,%eax
   41dd2:	e8 21 2d 00 00       	call   44af8 <console_printf>
 spinloop: goto spinloop;
   41dd7:	eb fe                	jmp    41dd7 <poweroff+0x69>

0000000000041dd9 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41dd9:	55                   	push   %rbp
   41dda:	48 89 e5             	mov    %rsp,%rbp
   41ddd:	48 83 ec 10          	sub    $0x10,%rsp
   41de1:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41de8:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41dec:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41df0:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41df3:	ee                   	out    %al,(%dx)
}
   41df4:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41df5:	eb fe                	jmp    41df5 <reboot+0x1c>

0000000000041df7 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41df7:	55                   	push   %rbp
   41df8:	48 89 e5             	mov    %rsp,%rbp
   41dfb:	48 83 ec 10          	sub    $0x10,%rsp
   41dff:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41e03:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41e06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e0a:	48 83 c0 18          	add    $0x18,%rax
   41e0e:	ba c0 00 00 00       	mov    $0xc0,%edx
   41e13:	be 00 00 00 00       	mov    $0x0,%esi
   41e18:	48 89 c7             	mov    %rax,%rdi
   41e1b:	e8 21 1f 00 00       	call   43d41 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41e20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e24:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   41e2b:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41e2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e31:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   41e38:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41e3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e40:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   41e47:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41e4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e4f:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   41e56:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41e58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e5c:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   41e63:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41e67:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e6a:	83 e0 01             	and    $0x1,%eax
   41e6d:	85 c0                	test   %eax,%eax
   41e6f:	74 1c                	je     41e8d <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41e71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e75:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41e7c:	80 cc 30             	or     $0x30,%ah
   41e7f:	48 89 c2             	mov    %rax,%rdx
   41e82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e86:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41e8d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e90:	83 e0 02             	and    $0x2,%eax
   41e93:	85 c0                	test   %eax,%eax
   41e95:	74 1c                	je     41eb3 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41e97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e9b:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41ea2:	80 e4 fd             	and    $0xfd,%ah
   41ea5:	48 89 c2             	mov    %rax,%rdx
   41ea8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41eac:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   41eb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41eb7:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   41ebe:	90                   	nop
   41ebf:	c9                   	leave  
   41ec0:	c3                   	ret    

0000000000041ec1 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41ec1:	55                   	push   %rbp
   41ec2:	48 89 e5             	mov    %rsp,%rbp
   41ec5:	48 83 ec 28          	sub    $0x28,%rsp
   41ec9:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41ecc:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41ed0:	78 09                	js     41edb <console_show_cursor+0x1a>
   41ed2:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41ed9:	7e 07                	jle    41ee2 <console_show_cursor+0x21>
        cpos = 0;
   41edb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41ee2:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41ee9:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41eed:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41ef1:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41ef4:	ee                   	out    %al,(%dx)
}
   41ef5:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41ef6:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41ef9:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41eff:	85 c0                	test   %eax,%eax
   41f01:	0f 48 c2             	cmovs  %edx,%eax
   41f04:	c1 f8 08             	sar    $0x8,%eax
   41f07:	0f b6 c0             	movzbl %al,%eax
   41f0a:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41f11:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f14:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41f18:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41f1b:	ee                   	out    %al,(%dx)
}
   41f1c:	90                   	nop
   41f1d:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41f24:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f28:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41f2c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41f2f:	ee                   	out    %al,(%dx)
}
   41f30:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41f31:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41f34:	89 d0                	mov    %edx,%eax
   41f36:	c1 f8 1f             	sar    $0x1f,%eax
   41f39:	c1 e8 18             	shr    $0x18,%eax
   41f3c:	01 c2                	add    %eax,%edx
   41f3e:	0f b6 d2             	movzbl %dl,%edx
   41f41:	29 c2                	sub    %eax,%edx
   41f43:	89 d0                	mov    %edx,%eax
   41f45:	0f b6 c0             	movzbl %al,%eax
   41f48:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41f4f:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41f52:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f56:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41f59:	ee                   	out    %al,(%dx)
}
   41f5a:	90                   	nop
}
   41f5b:	90                   	nop
   41f5c:	c9                   	leave  
   41f5d:	c3                   	ret    

0000000000041f5e <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41f5e:	55                   	push   %rbp
   41f5f:	48 89 e5             	mov    %rsp,%rbp
   41f62:	48 83 ec 20          	sub    $0x20,%rsp
   41f66:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f6d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f70:	89 c2                	mov    %eax,%edx
   41f72:	ec                   	in     (%dx),%al
   41f73:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41f76:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41f7a:	0f b6 c0             	movzbl %al,%eax
   41f7d:	83 e0 01             	and    $0x1,%eax
   41f80:	85 c0                	test   %eax,%eax
   41f82:	75 0a                	jne    41f8e <keyboard_readc+0x30>
        return -1;
   41f84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41f89:	e9 e7 01 00 00       	jmp    42175 <keyboard_readc+0x217>
   41f8e:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f95:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41f98:	89 c2                	mov    %eax,%edx
   41f9a:	ec                   	in     (%dx),%al
   41f9b:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41f9e:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41fa2:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41fa5:	0f b6 05 36 f4 00 00 	movzbl 0xf436(%rip),%eax        # 513e2 <last_escape.2>
   41fac:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41faf:	c6 05 2c f4 00 00 00 	movb   $0x0,0xf42c(%rip)        # 513e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41fb6:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41fba:	75 11                	jne    41fcd <keyboard_readc+0x6f>
        last_escape = 0x80;
   41fbc:	c6 05 1f f4 00 00 80 	movb   $0x80,0xf41f(%rip)        # 513e2 <last_escape.2>
        return 0;
   41fc3:	b8 00 00 00 00       	mov    $0x0,%eax
   41fc8:	e9 a8 01 00 00       	jmp    42175 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41fcd:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fd1:	84 c0                	test   %al,%al
   41fd3:	79 60                	jns    42035 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   41fd5:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fd9:	83 e0 7f             	and    $0x7f,%eax
   41fdc:	89 c2                	mov    %eax,%edx
   41fde:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41fe2:	09 d0                	or     %edx,%eax
   41fe4:	48 98                	cltq   
   41fe6:	0f b6 80 20 51 04 00 	movzbl 0x45120(%rax),%eax
   41fed:	0f b6 c0             	movzbl %al,%eax
   41ff0:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   41ff3:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   41ffa:	7e 2f                	jle    4202b <keyboard_readc+0xcd>
   41ffc:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42003:	7f 26                	jg     4202b <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   42005:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42008:	2d fa 00 00 00       	sub    $0xfa,%eax
   4200d:	ba 01 00 00 00       	mov    $0x1,%edx
   42012:	89 c1                	mov    %eax,%ecx
   42014:	d3 e2                	shl    %cl,%edx
   42016:	89 d0                	mov    %edx,%eax
   42018:	f7 d0                	not    %eax
   4201a:	89 c2                	mov    %eax,%edx
   4201c:	0f b6 05 c0 f3 00 00 	movzbl 0xf3c0(%rip),%eax        # 513e3 <modifiers.1>
   42023:	21 d0                	and    %edx,%eax
   42025:	88 05 b8 f3 00 00    	mov    %al,0xf3b8(%rip)        # 513e3 <modifiers.1>
        }
        return 0;
   4202b:	b8 00 00 00 00       	mov    $0x0,%eax
   42030:	e9 40 01 00 00       	jmp    42175 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   42035:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42039:	0a 45 fa             	or     -0x6(%rbp),%al
   4203c:	0f b6 c0             	movzbl %al,%eax
   4203f:	48 98                	cltq   
   42041:	0f b6 80 20 51 04 00 	movzbl 0x45120(%rax),%eax
   42048:	0f b6 c0             	movzbl %al,%eax
   4204b:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   4204e:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   42052:	7e 57                	jle    420ab <keyboard_readc+0x14d>
   42054:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42058:	7f 51                	jg     420ab <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   4205a:	0f b6 05 82 f3 00 00 	movzbl 0xf382(%rip),%eax        # 513e3 <modifiers.1>
   42061:	0f b6 c0             	movzbl %al,%eax
   42064:	83 e0 02             	and    $0x2,%eax
   42067:	85 c0                	test   %eax,%eax
   42069:	74 09                	je     42074 <keyboard_readc+0x116>
            ch -= 0x60;
   4206b:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4206f:	e9 fd 00 00 00       	jmp    42171 <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42074:	0f b6 05 68 f3 00 00 	movzbl 0xf368(%rip),%eax        # 513e3 <modifiers.1>
   4207b:	0f b6 c0             	movzbl %al,%eax
   4207e:	83 e0 01             	and    $0x1,%eax
   42081:	85 c0                	test   %eax,%eax
   42083:	0f 94 c2             	sete   %dl
   42086:	0f b6 05 56 f3 00 00 	movzbl 0xf356(%rip),%eax        # 513e3 <modifiers.1>
   4208d:	0f b6 c0             	movzbl %al,%eax
   42090:	83 e0 08             	and    $0x8,%eax
   42093:	85 c0                	test   %eax,%eax
   42095:	0f 94 c0             	sete   %al
   42098:	31 d0                	xor    %edx,%eax
   4209a:	84 c0                	test   %al,%al
   4209c:	0f 84 cf 00 00 00    	je     42171 <keyboard_readc+0x213>
            ch -= 0x20;
   420a2:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   420a6:	e9 c6 00 00 00       	jmp    42171 <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   420ab:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   420b2:	7e 30                	jle    420e4 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   420b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420b7:	2d fa 00 00 00       	sub    $0xfa,%eax
   420bc:	ba 01 00 00 00       	mov    $0x1,%edx
   420c1:	89 c1                	mov    %eax,%ecx
   420c3:	d3 e2                	shl    %cl,%edx
   420c5:	89 d0                	mov    %edx,%eax
   420c7:	89 c2                	mov    %eax,%edx
   420c9:	0f b6 05 13 f3 00 00 	movzbl 0xf313(%rip),%eax        # 513e3 <modifiers.1>
   420d0:	31 d0                	xor    %edx,%eax
   420d2:	88 05 0b f3 00 00    	mov    %al,0xf30b(%rip)        # 513e3 <modifiers.1>
        ch = 0;
   420d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   420df:	e9 8e 00 00 00       	jmp    42172 <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   420e4:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   420eb:	7e 2d                	jle    4211a <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   420ed:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420f0:	2d fa 00 00 00       	sub    $0xfa,%eax
   420f5:	ba 01 00 00 00       	mov    $0x1,%edx
   420fa:	89 c1                	mov    %eax,%ecx
   420fc:	d3 e2                	shl    %cl,%edx
   420fe:	89 d0                	mov    %edx,%eax
   42100:	89 c2                	mov    %eax,%edx
   42102:	0f b6 05 da f2 00 00 	movzbl 0xf2da(%rip),%eax        # 513e3 <modifiers.1>
   42109:	09 d0                	or     %edx,%eax
   4210b:	88 05 d2 f2 00 00    	mov    %al,0xf2d2(%rip)        # 513e3 <modifiers.1>
        ch = 0;
   42111:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42118:	eb 58                	jmp    42172 <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   4211a:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4211e:	7e 31                	jle    42151 <keyboard_readc+0x1f3>
   42120:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42127:	7f 28                	jg     42151 <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42129:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4212c:	8d 50 80             	lea    -0x80(%rax),%edx
   4212f:	0f b6 05 ad f2 00 00 	movzbl 0xf2ad(%rip),%eax        # 513e3 <modifiers.1>
   42136:	0f b6 c0             	movzbl %al,%eax
   42139:	83 e0 03             	and    $0x3,%eax
   4213c:	48 98                	cltq   
   4213e:	48 63 d2             	movslq %edx,%rdx
   42141:	0f b6 84 90 20 52 04 	movzbl 0x45220(%rax,%rdx,4),%eax
   42148:	00 
   42149:	0f b6 c0             	movzbl %al,%eax
   4214c:	89 45 fc             	mov    %eax,-0x4(%rbp)
   4214f:	eb 21                	jmp    42172 <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   42151:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42155:	7f 1b                	jg     42172 <keyboard_readc+0x214>
   42157:	0f b6 05 85 f2 00 00 	movzbl 0xf285(%rip),%eax        # 513e3 <modifiers.1>
   4215e:	0f b6 c0             	movzbl %al,%eax
   42161:	83 e0 02             	and    $0x2,%eax
   42164:	85 c0                	test   %eax,%eax
   42166:	74 0a                	je     42172 <keyboard_readc+0x214>
        ch = 0;
   42168:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4216f:	eb 01                	jmp    42172 <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   42171:	90                   	nop
    }

    return ch;
   42172:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42175:	c9                   	leave  
   42176:	c3                   	ret    

0000000000042177 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42177:	55                   	push   %rbp
   42178:	48 89 e5             	mov    %rsp,%rbp
   4217b:	48 83 ec 20          	sub    $0x20,%rsp
   4217f:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42186:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42189:	89 c2                	mov    %eax,%edx
   4218b:	ec                   	in     (%dx),%al
   4218c:	88 45 e3             	mov    %al,-0x1d(%rbp)
   4218f:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42196:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42199:	89 c2                	mov    %eax,%edx
   4219b:	ec                   	in     (%dx),%al
   4219c:	88 45 eb             	mov    %al,-0x15(%rbp)
   4219f:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   421a6:	8b 45 f4             	mov    -0xc(%rbp),%eax
   421a9:	89 c2                	mov    %eax,%edx
   421ab:	ec                   	in     (%dx),%al
   421ac:	88 45 f3             	mov    %al,-0xd(%rbp)
   421af:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   421b6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   421b9:	89 c2                	mov    %eax,%edx
   421bb:	ec                   	in     (%dx),%al
   421bc:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   421bf:	90                   	nop
   421c0:	c9                   	leave  
   421c1:	c3                   	ret    

00000000000421c2 <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   421c2:	55                   	push   %rbp
   421c3:	48 89 e5             	mov    %rsp,%rbp
   421c6:	48 83 ec 40          	sub    $0x40,%rsp
   421ca:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   421ce:	89 f0                	mov    %esi,%eax
   421d0:	89 55 c0             	mov    %edx,-0x40(%rbp)
   421d3:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   421d6:	8b 05 08 f2 00 00    	mov    0xf208(%rip),%eax        # 513e4 <initialized.0>
   421dc:	85 c0                	test   %eax,%eax
   421de:	75 1e                	jne    421fe <parallel_port_putc+0x3c>
   421e0:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   421e7:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421eb:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   421ef:	8b 55 f8             	mov    -0x8(%rbp),%edx
   421f2:	ee                   	out    %al,(%dx)
}
   421f3:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   421f4:	c7 05 e6 f1 00 00 01 	movl   $0x1,0xf1e6(%rip)        # 513e4 <initialized.0>
   421fb:	00 00 00 
    }

    for (int i = 0;
   421fe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42205:	eb 09                	jmp    42210 <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42207:	e8 6b ff ff ff       	call   42177 <delay>
         ++i) {
   4220c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   42210:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42217:	7f 18                	jg     42231 <parallel_port_putc+0x6f>
   42219:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42220:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42223:	89 c2                	mov    %eax,%edx
   42225:	ec                   	in     (%dx),%al
   42226:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42229:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   4222d:	84 c0                	test   %al,%al
   4222f:	79 d6                	jns    42207 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   42231:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   42235:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   4223c:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4223f:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   42243:	8b 55 d8             	mov    -0x28(%rbp),%edx
   42246:	ee                   	out    %al,(%dx)
}
   42247:	90                   	nop
   42248:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   4224f:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42253:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42257:	8b 55 e0             	mov    -0x20(%rbp),%edx
   4225a:	ee                   	out    %al,(%dx)
}
   4225b:	90                   	nop
   4225c:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   42263:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42267:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   4226b:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4226e:	ee                   	out    %al,(%dx)
}
   4226f:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   42270:	90                   	nop
   42271:	c9                   	leave  
   42272:	c3                   	ret    

0000000000042273 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   42273:	55                   	push   %rbp
   42274:	48 89 e5             	mov    %rsp,%rbp
   42277:	48 83 ec 20          	sub    $0x20,%rsp
   4227b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4227f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   42283:	48 c7 45 f8 c2 21 04 	movq   $0x421c2,-0x8(%rbp)
   4228a:	00 
    printer_vprintf(&p, 0, format, val);
   4228b:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   4228f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42293:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42297:	be 00 00 00 00       	mov    $0x0,%esi
   4229c:	48 89 c7             	mov    %rax,%rdi
   4229f:	e8 39 1d 00 00       	call   43fdd <printer_vprintf>
}
   422a4:	90                   	nop
   422a5:	c9                   	leave  
   422a6:	c3                   	ret    

00000000000422a7 <log_printf>:

void log_printf(const char* format, ...) {
   422a7:	55                   	push   %rbp
   422a8:	48 89 e5             	mov    %rsp,%rbp
   422ab:	48 83 ec 60          	sub    $0x60,%rsp
   422af:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   422b3:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   422b7:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   422bb:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   422bf:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   422c3:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   422c7:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   422ce:	48 8d 45 10          	lea    0x10(%rbp),%rax
   422d2:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   422d6:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   422da:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   422de:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   422e2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   422e6:	48 89 d6             	mov    %rdx,%rsi
   422e9:	48 89 c7             	mov    %rax,%rdi
   422ec:	e8 82 ff ff ff       	call   42273 <log_vprintf>
    va_end(val);
}
   422f1:	90                   	nop
   422f2:	c9                   	leave  
   422f3:	c3                   	ret    

00000000000422f4 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   422f4:	55                   	push   %rbp
   422f5:	48 89 e5             	mov    %rsp,%rbp
   422f8:	48 83 ec 40          	sub    $0x40,%rsp
   422fc:	89 7d dc             	mov    %edi,-0x24(%rbp)
   422ff:	89 75 d8             	mov    %esi,-0x28(%rbp)
   42302:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42306:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   4230a:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4230e:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42312:	48 8b 0a             	mov    (%rdx),%rcx
   42315:	48 89 08             	mov    %rcx,(%rax)
   42318:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   4231c:	48 89 48 08          	mov    %rcx,0x8(%rax)
   42320:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42324:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42328:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   4232c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42330:	48 89 d6             	mov    %rdx,%rsi
   42333:	48 89 c7             	mov    %rax,%rdi
   42336:	e8 38 ff ff ff       	call   42273 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   4233b:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   4233f:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42343:	8b 75 d8             	mov    -0x28(%rbp),%esi
   42346:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42349:	89 c7                	mov    %eax,%edi
   4234b:	e8 3c 27 00 00       	call   44a8c <console_vprintf>
}
   42350:	c9                   	leave  
   42351:	c3                   	ret    

0000000000042352 <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   42352:	55                   	push   %rbp
   42353:	48 89 e5             	mov    %rsp,%rbp
   42356:	48 83 ec 60          	sub    $0x60,%rsp
   4235a:	89 7d ac             	mov    %edi,-0x54(%rbp)
   4235d:	89 75 a8             	mov    %esi,-0x58(%rbp)
   42360:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42364:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42368:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4236c:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42370:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42377:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4237b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4237f:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42383:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42387:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   4238b:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4238f:	8b 75 a8             	mov    -0x58(%rbp),%esi
   42392:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42395:	89 c7                	mov    %eax,%edi
   42397:	e8 58 ff ff ff       	call   422f4 <error_vprintf>
   4239c:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4239f:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   423a2:	c9                   	leave  
   423a3:	c3                   	ret    

00000000000423a4 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   423a4:	55                   	push   %rbp
   423a5:	48 89 e5             	mov    %rsp,%rbp
   423a8:	53                   	push   %rbx
   423a9:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   423ad:	e8 ac fb ff ff       	call   41f5e <keyboard_readc>
   423b2:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   423b5:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   423b9:	74 1c                	je     423d7 <check_keyboard+0x33>
   423bb:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   423bf:	74 16                	je     423d7 <check_keyboard+0x33>
   423c1:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   423c5:	74 10                	je     423d7 <check_keyboard+0x33>
   423c7:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   423cb:	74 0a                	je     423d7 <check_keyboard+0x33>
   423cd:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   423d1:	0f 85 e9 00 00 00    	jne    424c0 <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   423d7:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   423de:	00 
        memset(pt, 0, PAGESIZE * 3);
   423df:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423e3:	ba 00 30 00 00       	mov    $0x3000,%edx
   423e8:	be 00 00 00 00       	mov    $0x0,%esi
   423ed:	48 89 c7             	mov    %rax,%rdi
   423f0:	e8 4c 19 00 00       	call   43d41 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   423f5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423f9:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42400:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42404:	48 05 00 10 00 00    	add    $0x1000,%rax
   4240a:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42411:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42415:	48 05 00 20 00 00    	add    $0x2000,%rax
   4241b:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42422:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42426:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   4242a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4242e:	0f 22 d8             	mov    %rax,%cr3
}
   42431:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42432:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   42439:	48 c7 45 e8 78 52 04 	movq   $0x45278,-0x18(%rbp)
   42440:	00 
        if (c == 'a') {
   42441:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42445:	75 0a                	jne    42451 <check_keyboard+0xad>
            argument = "allocator";
   42447:	48 c7 45 e8 7f 52 04 	movq   $0x4527f,-0x18(%rbp)
   4244e:	00 
   4244f:	eb 2e                	jmp    4247f <check_keyboard+0xdb>
        } else if (c == 'c') {
   42451:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42455:	75 0a                	jne    42461 <check_keyboard+0xbd>
            argument = "alloctests";
   42457:	48 c7 45 e8 89 52 04 	movq   $0x45289,-0x18(%rbp)
   4245e:	00 
   4245f:	eb 1e                	jmp    4247f <check_keyboard+0xdb>
        } else if(c == 't'){
   42461:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42465:	75 0a                	jne    42471 <check_keyboard+0xcd>
            argument = "test";
   42467:	48 c7 45 e8 94 52 04 	movq   $0x45294,-0x18(%rbp)
   4246e:	00 
   4246f:	eb 0e                	jmp    4247f <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42471:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42475:	75 08                	jne    4247f <check_keyboard+0xdb>
            argument = "test2";
   42477:	48 c7 45 e8 99 52 04 	movq   $0x45299,-0x18(%rbp)
   4247e:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   4247f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42483:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42487:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4248c:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
   42490:	73 14                	jae    424a6 <check_keyboard+0x102>
   42492:	ba 9f 52 04 00       	mov    $0x4529f,%edx
   42497:	be 5c 02 00 00       	mov    $0x25c,%esi
   4249c:	bf bb 52 04 00       	mov    $0x452bb,%edi
   424a1:	e8 1f 01 00 00       	call   425c5 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   424a6:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   424aa:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   424ad:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   424b1:	48 89 c3             	mov    %rax,%rbx
   424b4:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   424b9:	e9 42 db ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   424be:	eb 11                	jmp    424d1 <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   424c0:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   424c4:	74 06                	je     424cc <check_keyboard+0x128>
   424c6:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   424ca:	75 05                	jne    424d1 <check_keyboard+0x12d>
        poweroff();
   424cc:	e8 9d f8 ff ff       	call   41d6e <poweroff>
    }
    return c;
   424d1:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   424d4:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   424d8:	c9                   	leave  
   424d9:	c3                   	ret    

00000000000424da <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   424da:	55                   	push   %rbp
   424db:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   424de:	e8 c1 fe ff ff       	call   423a4 <check_keyboard>
   424e3:	eb f9                	jmp    424de <fail+0x4>

00000000000424e5 <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   424e5:	55                   	push   %rbp
   424e6:	48 89 e5             	mov    %rsp,%rbp
   424e9:	48 83 ec 60          	sub    $0x60,%rsp
   424ed:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   424f1:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   424f5:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   424f9:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   424fd:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42501:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42505:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   4250c:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42510:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42514:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42518:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   4251c:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42521:	0f 84 80 00 00 00    	je     425a7 <kernel_panic+0xc2>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42527:	ba cf 52 04 00       	mov    $0x452cf,%edx
   4252c:	be 00 c0 00 00       	mov    $0xc000,%esi
   42531:	bf 30 07 00 00       	mov    $0x730,%edi
   42536:	b8 00 00 00 00       	mov    $0x0,%eax
   4253b:	e8 12 fe ff ff       	call   42352 <error_printf>
   42540:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42543:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42547:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   4254b:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4254e:	be 00 c0 00 00       	mov    $0xc000,%esi
   42553:	89 c7                	mov    %eax,%edi
   42555:	e8 9a fd ff ff       	call   422f4 <error_vprintf>
   4255a:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   4255d:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42560:	48 63 c1             	movslq %ecx,%rax
   42563:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   4256a:	48 c1 e8 20          	shr    $0x20,%rax
   4256e:	89 c2                	mov    %eax,%edx
   42570:	c1 fa 05             	sar    $0x5,%edx
   42573:	89 c8                	mov    %ecx,%eax
   42575:	c1 f8 1f             	sar    $0x1f,%eax
   42578:	29 c2                	sub    %eax,%edx
   4257a:	89 d0                	mov    %edx,%eax
   4257c:	c1 e0 02             	shl    $0x2,%eax
   4257f:	01 d0                	add    %edx,%eax
   42581:	c1 e0 04             	shl    $0x4,%eax
   42584:	29 c1                	sub    %eax,%ecx
   42586:	89 ca                	mov    %ecx,%edx
   42588:	85 d2                	test   %edx,%edx
   4258a:	74 34                	je     425c0 <kernel_panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   4258c:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4258f:	ba d7 52 04 00       	mov    $0x452d7,%edx
   42594:	be 00 c0 00 00       	mov    $0xc000,%esi
   42599:	89 c7                	mov    %eax,%edi
   4259b:	b8 00 00 00 00       	mov    $0x0,%eax
   425a0:	e8 ad fd ff ff       	call   42352 <error_printf>
   425a5:	eb 19                	jmp    425c0 <kernel_panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   425a7:	ba d9 52 04 00       	mov    $0x452d9,%edx
   425ac:	be 00 c0 00 00       	mov    $0xc000,%esi
   425b1:	bf 30 07 00 00       	mov    $0x730,%edi
   425b6:	b8 00 00 00 00       	mov    $0x0,%eax
   425bb:	e8 92 fd ff ff       	call   42352 <error_printf>
    }

    va_end(val);
    fail();
   425c0:	e8 15 ff ff ff       	call   424da <fail>

00000000000425c5 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   425c5:	55                   	push   %rbp
   425c6:	48 89 e5             	mov    %rsp,%rbp
   425c9:	48 83 ec 20          	sub    $0x20,%rsp
   425cd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   425d1:	89 75 f4             	mov    %esi,-0xc(%rbp)
   425d4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   425d8:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   425dc:	8b 55 f4             	mov    -0xc(%rbp),%edx
   425df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425e3:	48 89 c6             	mov    %rax,%rsi
   425e6:	bf df 52 04 00       	mov    $0x452df,%edi
   425eb:	b8 00 00 00 00       	mov    $0x0,%eax
   425f0:	e8 f0 fe ff ff       	call   424e5 <kernel_panic>

00000000000425f5 <default_exception>:
}

void default_exception(proc* p){
   425f5:	55                   	push   %rbp
   425f6:	48 89 e5             	mov    %rsp,%rbp
   425f9:	48 83 ec 20          	sub    $0x20,%rsp
   425fd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42601:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42605:	48 83 c0 18          	add    $0x18,%rax
   42609:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   4260d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42611:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42618:	48 89 c6             	mov    %rax,%rsi
   4261b:	bf fd 52 04 00       	mov    $0x452fd,%edi
   42620:	b8 00 00 00 00       	mov    $0x0,%eax
   42625:	e8 bb fe ff ff       	call   424e5 <kernel_panic>

000000000004262a <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   4262a:	55                   	push   %rbp
   4262b:	48 89 e5             	mov    %rsp,%rbp
   4262e:	48 83 ec 10          	sub    $0x10,%rsp
   42632:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42636:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42639:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4263d:	78 06                	js     42645 <pageindex+0x1b>
   4263f:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42643:	7e 14                	jle    42659 <pageindex+0x2f>
   42645:	ba 18 53 04 00       	mov    $0x45318,%edx
   4264a:	be 1e 00 00 00       	mov    $0x1e,%esi
   4264f:	bf 31 53 04 00       	mov    $0x45331,%edi
   42654:	e8 6c ff ff ff       	call   425c5 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42659:	b8 03 00 00 00       	mov    $0x3,%eax
   4265e:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42661:	89 c2                	mov    %eax,%edx
   42663:	89 d0                	mov    %edx,%eax
   42665:	c1 e0 03             	shl    $0x3,%eax
   42668:	01 d0                	add    %edx,%eax
   4266a:	83 c0 0c             	add    $0xc,%eax
   4266d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42671:	89 c1                	mov    %eax,%ecx
   42673:	48 d3 ea             	shr    %cl,%rdx
   42676:	48 89 d0             	mov    %rdx,%rax
   42679:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   4267e:	c9                   	leave  
   4267f:	c3                   	ret    

0000000000042680 <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42680:	55                   	push   %rbp
   42681:	48 89 e5             	mov    %rsp,%rbp
   42684:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42688:	48 c7 05 6d f9 00 00 	movq   $0x53000,0xf96d(%rip)        # 52000 <kernel_pagetable>
   4268f:	00 30 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42693:	ba 00 50 00 00       	mov    $0x5000,%edx
   42698:	be 00 00 00 00       	mov    $0x0,%esi
   4269d:	bf 00 30 05 00       	mov    $0x53000,%edi
   426a2:	e8 9a 16 00 00       	call   43d41 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   426a7:	b8 00 40 05 00       	mov    $0x54000,%eax
   426ac:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   426b0:	48 89 05 49 09 01 00 	mov    %rax,0x10949(%rip)        # 53000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   426b7:	b8 00 50 05 00       	mov    $0x55000,%eax
   426bc:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   426c0:	48 89 05 39 19 01 00 	mov    %rax,0x11939(%rip)        # 54000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   426c7:	b8 00 60 05 00       	mov    $0x56000,%eax
   426cc:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   426d0:	48 89 05 29 29 01 00 	mov    %rax,0x12929(%rip)        # 55000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   426d7:	b8 00 70 05 00       	mov    $0x57000,%eax
   426dc:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   426e0:	48 89 05 21 29 01 00 	mov    %rax,0x12921(%rip)        # 55008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   426e7:	48 8b 05 12 f9 00 00 	mov    0xf912(%rip),%rax        # 52000 <kernel_pagetable>
   426ee:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   426f4:	b9 00 00 20 00       	mov    $0x200000,%ecx
   426f9:	ba 00 00 00 00       	mov    $0x0,%edx
   426fe:	be 00 00 00 00       	mov    $0x0,%esi
   42703:	48 89 c7             	mov    %rax,%rdi
   42706:	e8 b9 01 00 00       	call   428c4 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4270b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42712:	00 
   42713:	eb 62                	jmp    42777 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42715:	48 8b 0d e4 f8 00 00 	mov    0xf8e4(%rip),%rcx        # 52000 <kernel_pagetable>
   4271c:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42720:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42724:	48 89 ce             	mov    %rcx,%rsi
   42727:	48 89 c7             	mov    %rax,%rdi
   4272a:	e8 58 05 00 00       	call   42c87 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   4272f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42733:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42737:	74 14                	je     4274d <virtual_memory_init+0xcd>
   42739:	ba 45 53 04 00       	mov    $0x45345,%edx
   4273e:	be 2d 00 00 00       	mov    $0x2d,%esi
   42743:	bf 55 53 04 00       	mov    $0x45355,%edi
   42748:	e8 78 fe ff ff       	call   425c5 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   4274d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42750:	48 98                	cltq   
   42752:	83 e0 03             	and    $0x3,%eax
   42755:	48 83 f8 03          	cmp    $0x3,%rax
   42759:	74 14                	je     4276f <virtual_memory_init+0xef>
   4275b:	ba 68 53 04 00       	mov    $0x45368,%edx
   42760:	be 2e 00 00 00       	mov    $0x2e,%esi
   42765:	bf 55 53 04 00       	mov    $0x45355,%edi
   4276a:	e8 56 fe ff ff       	call   425c5 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4276f:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42776:	00 
   42777:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4277e:	00 
   4277f:	76 94                	jbe    42715 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42781:	48 8b 05 78 f8 00 00 	mov    0xf878(%rip),%rax        # 52000 <kernel_pagetable>
   42788:	48 89 c7             	mov    %rax,%rdi
   4278b:	e8 03 00 00 00       	call   42793 <set_pagetable>
}
   42790:	90                   	nop
   42791:	c9                   	leave  
   42792:	c3                   	ret    

0000000000042793 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42793:	55                   	push   %rbp
   42794:	48 89 e5             	mov    %rsp,%rbp
   42797:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   4279b:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   4279f:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   427a3:	25 ff 0f 00 00       	and    $0xfff,%eax
   427a8:	48 85 c0             	test   %rax,%rax
   427ab:	74 14                	je     427c1 <set_pagetable+0x2e>
   427ad:	ba 95 53 04 00       	mov    $0x45395,%edx
   427b2:	be 3d 00 00 00       	mov    $0x3d,%esi
   427b7:	bf 55 53 04 00       	mov    $0x45355,%edi
   427bc:	e8 04 fe ff ff       	call   425c5 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   427c1:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   427c6:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   427ca:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   427ce:	48 89 ce             	mov    %rcx,%rsi
   427d1:	48 89 c7             	mov    %rax,%rdi
   427d4:	e8 ae 04 00 00       	call   42c87 <virtual_memory_lookup>
   427d9:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   427dd:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   427e2:	48 39 d0             	cmp    %rdx,%rax
   427e5:	74 14                	je     427fb <set_pagetable+0x68>
   427e7:	ba b0 53 04 00       	mov    $0x453b0,%edx
   427ec:	be 3f 00 00 00       	mov    $0x3f,%esi
   427f1:	bf 55 53 04 00       	mov    $0x45355,%edi
   427f6:	e8 ca fd ff ff       	call   425c5 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   427fb:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   427ff:	48 8b 0d fa f7 00 00 	mov    0xf7fa(%rip),%rcx        # 52000 <kernel_pagetable>
   42806:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   4280a:	48 89 ce             	mov    %rcx,%rsi
   4280d:	48 89 c7             	mov    %rax,%rdi
   42810:	e8 72 04 00 00       	call   42c87 <virtual_memory_lookup>
   42815:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42819:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4281d:	48 39 c2             	cmp    %rax,%rdx
   42820:	74 14                	je     42836 <set_pagetable+0xa3>
   42822:	ba 18 54 04 00       	mov    $0x45418,%edx
   42827:	be 41 00 00 00       	mov    $0x41,%esi
   4282c:	bf 55 53 04 00       	mov    $0x45355,%edi
   42831:	e8 8f fd ff ff       	call   425c5 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42836:	48 8b 05 c3 f7 00 00 	mov    0xf7c3(%rip),%rax        # 52000 <kernel_pagetable>
   4283d:	48 89 c2             	mov    %rax,%rdx
   42840:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42844:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42848:	48 89 ce             	mov    %rcx,%rsi
   4284b:	48 89 c7             	mov    %rax,%rdi
   4284e:	e8 34 04 00 00       	call   42c87 <virtual_memory_lookup>
   42853:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42857:	48 8b 15 a2 f7 00 00 	mov    0xf7a2(%rip),%rdx        # 52000 <kernel_pagetable>
   4285e:	48 39 d0             	cmp    %rdx,%rax
   42861:	74 14                	je     42877 <set_pagetable+0xe4>
   42863:	ba 78 54 04 00       	mov    $0x45478,%edx
   42868:	be 43 00 00 00       	mov    $0x43,%esi
   4286d:	bf 55 53 04 00       	mov    $0x45355,%edi
   42872:	e8 4e fd ff ff       	call   425c5 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42877:	ba c4 28 04 00       	mov    $0x428c4,%edx
   4287c:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42880:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42884:	48 89 ce             	mov    %rcx,%rsi
   42887:	48 89 c7             	mov    %rax,%rdi
   4288a:	e8 f8 03 00 00       	call   42c87 <virtual_memory_lookup>
   4288f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42893:	ba c4 28 04 00       	mov    $0x428c4,%edx
   42898:	48 39 d0             	cmp    %rdx,%rax
   4289b:	74 14                	je     428b1 <set_pagetable+0x11e>
   4289d:	ba e0 54 04 00       	mov    $0x454e0,%edx
   428a2:	be 45 00 00 00       	mov    $0x45,%esi
   428a7:	bf 55 53 04 00       	mov    $0x45355,%edi
   428ac:	e8 14 fd ff ff       	call   425c5 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   428b1:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   428b5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   428b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   428bd:	0f 22 d8             	mov    %rax,%cr3
}
   428c0:	90                   	nop
}
   428c1:	90                   	nop
   428c2:	c9                   	leave  
   428c3:	c3                   	ret    

00000000000428c4 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   428c4:	55                   	push   %rbp
   428c5:	48 89 e5             	mov    %rsp,%rbp
   428c8:	53                   	push   %rbx
   428c9:	48 83 ec 58          	sub    $0x58,%rsp
   428cd:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   428d1:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   428d5:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   428d9:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   428dd:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   428e1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   428e5:	25 ff 0f 00 00       	and    $0xfff,%eax
   428ea:	48 85 c0             	test   %rax,%rax
   428ed:	74 14                	je     42903 <virtual_memory_map+0x3f>
   428ef:	ba 46 55 04 00       	mov    $0x45546,%edx
   428f4:	be 66 00 00 00       	mov    $0x66,%esi
   428f9:	bf 55 53 04 00       	mov    $0x45355,%edi
   428fe:	e8 c2 fc ff ff       	call   425c5 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42903:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42907:	25 ff 0f 00 00       	and    $0xfff,%eax
   4290c:	48 85 c0             	test   %rax,%rax
   4290f:	74 14                	je     42925 <virtual_memory_map+0x61>
   42911:	ba 59 55 04 00       	mov    $0x45559,%edx
   42916:	be 67 00 00 00       	mov    $0x67,%esi
   4291b:	bf 55 53 04 00       	mov    $0x45355,%edi
   42920:	e8 a0 fc ff ff       	call   425c5 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42925:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42929:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4292d:	48 01 d0             	add    %rdx,%rax
   42930:	48 3b 45 c0          	cmp    -0x40(%rbp),%rax
   42934:	73 24                	jae    4295a <virtual_memory_map+0x96>
   42936:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   4293a:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4293e:	48 01 d0             	add    %rdx,%rax
   42941:	48 85 c0             	test   %rax,%rax
   42944:	74 14                	je     4295a <virtual_memory_map+0x96>
   42946:	ba 6c 55 04 00       	mov    $0x4556c,%edx
   4294b:	be 68 00 00 00       	mov    $0x68,%esi
   42950:	bf 55 53 04 00       	mov    $0x45355,%edi
   42955:	e8 6b fc ff ff       	call   425c5 <assert_fail>
    if (perm & PTE_P) {
   4295a:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4295d:	48 98                	cltq   
   4295f:	83 e0 01             	and    $0x1,%eax
   42962:	48 85 c0             	test   %rax,%rax
   42965:	74 6e                	je     429d5 <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42967:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   4296b:	25 ff 0f 00 00       	and    $0xfff,%eax
   42970:	48 85 c0             	test   %rax,%rax
   42973:	74 14                	je     42989 <virtual_memory_map+0xc5>
   42975:	ba 8a 55 04 00       	mov    $0x4558a,%edx
   4297a:	be 6a 00 00 00       	mov    $0x6a,%esi
   4297f:	bf 55 53 04 00       	mov    $0x45355,%edi
   42984:	e8 3c fc ff ff       	call   425c5 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42989:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4298d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42991:	48 01 d0             	add    %rdx,%rax
   42994:	48 3b 45 b8          	cmp    -0x48(%rbp),%rax
   42998:	73 14                	jae    429ae <virtual_memory_map+0xea>
   4299a:	ba 9d 55 04 00       	mov    $0x4559d,%edx
   4299f:	be 6b 00 00 00       	mov    $0x6b,%esi
   429a4:	bf 55 53 04 00       	mov    $0x45355,%edi
   429a9:	e8 17 fc ff ff       	call   425c5 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   429ae:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   429b2:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   429b6:	48 01 d0             	add    %rdx,%rax
   429b9:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   429bf:	76 14                	jbe    429d5 <virtual_memory_map+0x111>
   429c1:	ba ab 55 04 00       	mov    $0x455ab,%edx
   429c6:	be 6c 00 00 00       	mov    $0x6c,%esi
   429cb:	bf 55 53 04 00       	mov    $0x45355,%edi
   429d0:	e8 f0 fb ff ff       	call   425c5 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   429d5:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   429d9:	78 09                	js     429e4 <virtual_memory_map+0x120>
   429db:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   429e2:	7e 14                	jle    429f8 <virtual_memory_map+0x134>
   429e4:	ba c7 55 04 00       	mov    $0x455c7,%edx
   429e9:	be 6e 00 00 00       	mov    $0x6e,%esi
   429ee:	bf 55 53 04 00       	mov    $0x45355,%edi
   429f3:	e8 cd fb ff ff       	call   425c5 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   429f8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   429fc:	25 ff 0f 00 00       	and    $0xfff,%eax
   42a01:	48 85 c0             	test   %rax,%rax
   42a04:	74 14                	je     42a1a <virtual_memory_map+0x156>
   42a06:	ba e8 55 04 00       	mov    $0x455e8,%edx
   42a0b:	be 6f 00 00 00       	mov    $0x6f,%esi
   42a10:	bf 55 53 04 00       	mov    $0x45355,%edi
   42a15:	e8 ab fb ff ff       	call   425c5 <assert_fail>

    int last_index123 = -1;
   42a1a:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   42a21:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   42a28:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42a29:	e9 e1 00 00 00       	jmp    42b0f <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   42a2e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a32:	48 c1 e8 15          	shr    $0x15,%rax
   42a36:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   42a39:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42a3c:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   42a3f:	74 20                	je     42a61 <virtual_memory_map+0x19d>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   42a41:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42a44:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   42a48:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42a4c:	48 89 ce             	mov    %rcx,%rsi
   42a4f:	48 89 c7             	mov    %rax,%rdi
   42a52:	e8 ce 00 00 00       	call   42b25 <lookup_l4pagetable>
   42a57:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   42a5b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42a5e:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   42a61:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a64:	48 98                	cltq   
   42a66:	83 e0 01             	and    $0x1,%eax
   42a69:	48 85 c0             	test   %rax,%rax
   42a6c:	74 34                	je     42aa2 <virtual_memory_map+0x1de>
   42a6e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42a73:	74 2d                	je     42aa2 <virtual_memory_map+0x1de>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   42a75:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a78:	48 63 d8             	movslq %eax,%rbx
   42a7b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a7f:	be 03 00 00 00       	mov    $0x3,%esi
   42a84:	48 89 c7             	mov    %rax,%rdi
   42a87:	e8 9e fb ff ff       	call   4262a <pageindex>
   42a8c:	89 c2                	mov    %eax,%edx
   42a8e:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42a92:	48 89 d9             	mov    %rbx,%rcx
   42a95:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42a99:	48 63 d2             	movslq %edx,%rdx
   42a9c:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42aa0:	eb 55                	jmp    42af7 <virtual_memory_map+0x233>
        } else if (l4pagetable) { // if page is NOT marked present
   42aa2:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42aa7:	74 26                	je     42acf <virtual_memory_map+0x20b>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42aa9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42aad:	be 03 00 00 00       	mov    $0x3,%esi
   42ab2:	48 89 c7             	mov    %rax,%rdi
   42ab5:	e8 70 fb ff ff       	call   4262a <pageindex>
   42aba:	89 c2                	mov    %eax,%edx
   42abc:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42abf:	48 63 c8             	movslq %eax,%rcx
   42ac2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42ac6:	48 63 d2             	movslq %edx,%rdx
   42ac9:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42acd:	eb 28                	jmp    42af7 <virtual_memory_map+0x233>
        } else if (perm & PTE_P) {
   42acf:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42ad2:	48 98                	cltq   
   42ad4:	83 e0 01             	and    $0x1,%eax
   42ad7:	48 85 c0             	test   %rax,%rax
   42ada:	74 1b                	je     42af7 <virtual_memory_map+0x233>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42adc:	be 84 00 00 00       	mov    $0x84,%esi
   42ae1:	bf 10 56 04 00       	mov    $0x45610,%edi
   42ae6:	b8 00 00 00 00       	mov    $0x0,%eax
   42aeb:	e8 b7 f7 ff ff       	call   422a7 <log_printf>
            return -1;
   42af0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42af5:	eb 28                	jmp    42b1f <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42af7:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42afe:	00 
   42aff:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42b06:	00 
   42b07:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42b0e:	00 
   42b0f:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42b14:	0f 85 14 ff ff ff    	jne    42a2e <virtual_memory_map+0x16a>
        }
    }
    return 0;
   42b1a:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42b1f:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42b23:	c9                   	leave  
   42b24:	c3                   	ret    

0000000000042b25 <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42b25:	55                   	push   %rbp
   42b26:	48 89 e5             	mov    %rsp,%rbp
   42b29:	48 83 ec 40          	sub    $0x40,%rsp
   42b2d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42b31:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42b35:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42b38:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42b3c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42b40:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42b47:	e9 2b 01 00 00       	jmp    42c77 <lookup_l4pagetable+0x152>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42b4c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42b4f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42b53:	89 d6                	mov    %edx,%esi
   42b55:	48 89 c7             	mov    %rax,%rdi
   42b58:	e8 cd fa ff ff       	call   4262a <pageindex>
   42b5d:	89 c2                	mov    %eax,%edx
   42b5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42b63:	48 63 d2             	movslq %edx,%rdx
   42b66:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42b6a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42b6e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b72:	83 e0 01             	and    $0x1,%eax
   42b75:	48 85 c0             	test   %rax,%rax
   42b78:	75 63                	jne    42bdd <lookup_l4pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42b7a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42b7d:	8d 48 02             	lea    0x2(%rax),%ecx
   42b80:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b84:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b89:	48 89 c2             	mov    %rax,%rdx
   42b8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b90:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b96:	48 89 c6             	mov    %rax,%rsi
   42b99:	bf 58 56 04 00       	mov    $0x45658,%edi
   42b9e:	b8 00 00 00 00       	mov    $0x0,%eax
   42ba3:	e8 ff f6 ff ff       	call   422a7 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42ba8:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42bab:	48 98                	cltq   
   42bad:	83 e0 01             	and    $0x1,%eax
   42bb0:	48 85 c0             	test   %rax,%rax
   42bb3:	75 0a                	jne    42bbf <lookup_l4pagetable+0x9a>
                return NULL;
   42bb5:	b8 00 00 00 00       	mov    $0x0,%eax
   42bba:	e9 c6 00 00 00       	jmp    42c85 <lookup_l4pagetable+0x160>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42bbf:	be a7 00 00 00       	mov    $0xa7,%esi
   42bc4:	bf c0 56 04 00       	mov    $0x456c0,%edi
   42bc9:	b8 00 00 00 00       	mov    $0x0,%eax
   42bce:	e8 d4 f6 ff ff       	call   422a7 <log_printf>
            return NULL;
   42bd3:	b8 00 00 00 00       	mov    $0x0,%eax
   42bd8:	e9 a8 00 00 00       	jmp    42c85 <lookup_l4pagetable+0x160>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42bdd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42be1:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42be7:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42bed:	76 14                	jbe    42c03 <lookup_l4pagetable+0xde>
   42bef:	ba 08 57 04 00       	mov    $0x45708,%edx
   42bf4:	be ac 00 00 00       	mov    $0xac,%esi
   42bf9:	bf 55 53 04 00       	mov    $0x45355,%edi
   42bfe:	e8 c2 f9 ff ff       	call   425c5 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42c03:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42c06:	48 98                	cltq   
   42c08:	83 e0 02             	and    $0x2,%eax
   42c0b:	48 85 c0             	test   %rax,%rax
   42c0e:	74 20                	je     42c30 <lookup_l4pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42c10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c14:	83 e0 02             	and    $0x2,%eax
   42c17:	48 85 c0             	test   %rax,%rax
   42c1a:	75 14                	jne    42c30 <lookup_l4pagetable+0x10b>
   42c1c:	ba 28 57 04 00       	mov    $0x45728,%edx
   42c21:	be ae 00 00 00       	mov    $0xae,%esi
   42c26:	bf 55 53 04 00       	mov    $0x45355,%edi
   42c2b:	e8 95 f9 ff ff       	call   425c5 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42c30:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42c33:	48 98                	cltq   
   42c35:	83 e0 04             	and    $0x4,%eax
   42c38:	48 85 c0             	test   %rax,%rax
   42c3b:	74 20                	je     42c5d <lookup_l4pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42c3d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c41:	83 e0 04             	and    $0x4,%eax
   42c44:	48 85 c0             	test   %rax,%rax
   42c47:	75 14                	jne    42c5d <lookup_l4pagetable+0x138>
   42c49:	ba 33 57 04 00       	mov    $0x45733,%edx
   42c4e:	be b1 00 00 00       	mov    $0xb1,%esi
   42c53:	bf 55 53 04 00       	mov    $0x45355,%edi
   42c58:	e8 68 f9 ff ff       	call   425c5 <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   42c5d:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42c64:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42c65:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c69:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c6f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42c73:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42c77:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42c7b:	0f 8e cb fe ff ff    	jle    42b4c <lookup_l4pagetable+0x27>
    }
    return pt;
   42c81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42c85:	c9                   	leave  
   42c86:	c3                   	ret    

0000000000042c87 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42c87:	55                   	push   %rbp
   42c88:	48 89 e5             	mov    %rsp,%rbp
   42c8b:	48 83 ec 50          	sub    $0x50,%rsp
   42c8f:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42c93:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42c97:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42c9b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c9f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42ca3:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42caa:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42cab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42cb2:	eb 41                	jmp    42cf5 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42cb4:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42cb7:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42cbb:	89 d6                	mov    %edx,%esi
   42cbd:	48 89 c7             	mov    %rax,%rdi
   42cc0:	e8 65 f9 ff ff       	call   4262a <pageindex>
   42cc5:	89 c2                	mov    %eax,%edx
   42cc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42ccb:	48 63 d2             	movslq %edx,%rdx
   42cce:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42cd2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cd6:	83 e0 06             	and    $0x6,%eax
   42cd9:	48 f7 d0             	not    %rax
   42cdc:	48 21 d0             	and    %rdx,%rax
   42cdf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42ce3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ce7:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42ced:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42cf1:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42cf5:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42cf9:	7f 0c                	jg     42d07 <virtual_memory_lookup+0x80>
   42cfb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cff:	83 e0 01             	and    $0x1,%eax
   42d02:	48 85 c0             	test   %rax,%rax
   42d05:	75 ad                	jne    42cb4 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42d07:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42d0e:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42d15:	ff 
   42d16:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42d1d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d21:	83 e0 01             	and    $0x1,%eax
   42d24:	48 85 c0             	test   %rax,%rax
   42d27:	74 34                	je     42d5d <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42d29:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d2d:	48 c1 e8 0c          	shr    $0xc,%rax
   42d31:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42d34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d38:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42d3e:	48 89 c2             	mov    %rax,%rdx
   42d41:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42d45:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d4a:	48 09 d0             	or     %rdx,%rax
   42d4d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42d51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d55:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d5a:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42d5d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d61:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42d65:	48 89 10             	mov    %rdx,(%rax)
   42d68:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42d6c:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42d70:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42d74:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42d78:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d7c:	c9                   	leave  
   42d7d:	c3                   	ret    

0000000000042d7e <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42d7e:	55                   	push   %rbp
   42d7f:	48 89 e5             	mov    %rsp,%rbp
   42d82:	48 83 ec 40          	sub    $0x40,%rsp
   42d86:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42d8a:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42d8d:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42d91:	c7 45 f8 04 00 00 00 	movl   $0x4,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42d98:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42d9c:	78 08                	js     42da6 <program_load+0x28>
   42d9e:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42da1:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42da4:	7c 14                	jl     42dba <program_load+0x3c>
   42da6:	ba 40 57 04 00       	mov    $0x45740,%edx
   42dab:	be 2e 00 00 00       	mov    $0x2e,%esi
   42db0:	bf 70 57 04 00       	mov    $0x45770,%edi
   42db5:	e8 0b f8 ff ff       	call   425c5 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42dba:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42dbd:	48 98                	cltq   
   42dbf:	48 c1 e0 04          	shl    $0x4,%rax
   42dc3:	48 05 20 60 04 00    	add    $0x46020,%rax
   42dc9:	48 8b 00             	mov    (%rax),%rax
   42dcc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42dd0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42dd4:	8b 00                	mov    (%rax),%eax
   42dd6:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42ddb:	74 14                	je     42df1 <program_load+0x73>
   42ddd:	ba 82 57 04 00       	mov    $0x45782,%edx
   42de2:	be 30 00 00 00       	mov    $0x30,%esi
   42de7:	bf 70 57 04 00       	mov    $0x45770,%edi
   42dec:	e8 d4 f7 ff ff       	call   425c5 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42df1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42df5:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42df9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42dfd:	48 01 d0             	add    %rdx,%rax
   42e00:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42e04:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42e0b:	e9 94 00 00 00       	jmp    42ea4 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42e10:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42e13:	48 63 d0             	movslq %eax,%rdx
   42e16:	48 89 d0             	mov    %rdx,%rax
   42e19:	48 c1 e0 03          	shl    $0x3,%rax
   42e1d:	48 29 d0             	sub    %rdx,%rax
   42e20:	48 c1 e0 03          	shl    $0x3,%rax
   42e24:	48 89 c2             	mov    %rax,%rdx
   42e27:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e2b:	48 01 d0             	add    %rdx,%rax
   42e2e:	8b 00                	mov    (%rax),%eax
   42e30:	83 f8 01             	cmp    $0x1,%eax
   42e33:	75 6b                	jne    42ea0 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42e35:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42e38:	48 63 d0             	movslq %eax,%rdx
   42e3b:	48 89 d0             	mov    %rdx,%rax
   42e3e:	48 c1 e0 03          	shl    $0x3,%rax
   42e42:	48 29 d0             	sub    %rdx,%rax
   42e45:	48 c1 e0 03          	shl    $0x3,%rax
   42e49:	48 89 c2             	mov    %rax,%rdx
   42e4c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e50:	48 01 d0             	add    %rdx,%rax
   42e53:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42e57:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e5b:	48 01 d0             	add    %rdx,%rax
   42e5e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42e62:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42e65:	48 63 d0             	movslq %eax,%rdx
   42e68:	48 89 d0             	mov    %rdx,%rax
   42e6b:	48 c1 e0 03          	shl    $0x3,%rax
   42e6f:	48 29 d0             	sub    %rdx,%rax
   42e72:	48 c1 e0 03          	shl    $0x3,%rax
   42e76:	48 89 c2             	mov    %rax,%rdx
   42e79:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e7d:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42e81:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42e85:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42e89:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e8d:	48 89 c7             	mov    %rax,%rdi
   42e90:	e8 3d 00 00 00       	call   42ed2 <program_load_segment>
   42e95:	85 c0                	test   %eax,%eax
   42e97:	79 07                	jns    42ea0 <program_load+0x122>
                return -1;
   42e99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42e9e:	eb 30                	jmp    42ed0 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42ea0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42ea4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ea8:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42eac:	0f b7 c0             	movzwl %ax,%eax
   42eaf:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42eb2:	0f 8c 58 ff ff ff    	jl     42e10 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42eb8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ebc:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42ec0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42ec4:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   42ecb:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42ed0:	c9                   	leave  
   42ed1:	c3                   	ret    

0000000000042ed2 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42ed2:	55                   	push   %rbp
   42ed3:	48 89 e5             	mov    %rsp,%rbp
   42ed6:	48 81 ec 90 00 00 00 	sub    $0x90,%rsp
   42edd:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
   42ee1:	48 89 75 80          	mov    %rsi,-0x80(%rbp)
   42ee5:	48 89 95 78 ff ff ff 	mov    %rdx,-0x88(%rbp)
   42eec:	48 89 8d 70 ff ff ff 	mov    %rcx,-0x90(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42ef3:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   42ef7:	48 8b 40 10          	mov    0x10(%rax),%rax
   42efb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42eff:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   42f03:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42f07:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f0b:	48 01 d0             	add    %rdx,%rax
   42f0e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   42f12:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   42f16:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42f1a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f1e:	48 01 d0             	add    %rdx,%rax
   42f21:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42f25:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   42f2c:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42f2d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f31:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42f35:	eb 7c                	jmp    42fb3 <program_load_segment+0xe1>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   42f37:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42f3b:	8b 00                	mov    (%rax),%eax
   42f3d:	89 c7                	mov    %eax,%edi
   42f3f:	e8 cb 01 00 00       	call   4310f <palloc>
   42f44:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
        if(pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   42f48:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42f4d:	74 2a                	je     42f79 <program_load_segment+0xa7>
   42f4f:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42f53:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42f5a:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
   42f5e:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42f62:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42f68:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42f6d:	48 89 c7             	mov    %rax,%rdi
   42f70:	e8 4f f9 ff ff       	call   428c4 <virtual_memory_map>
   42f75:	85 c0                	test   %eax,%eax
   42f77:	79 32                	jns    42fab <program_load_segment+0xd9>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   42f79:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42f7d:	8b 00                	mov    (%rax),%eax
   42f7f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42f83:	49 89 d0             	mov    %rdx,%r8
   42f86:	89 c1                	mov    %eax,%ecx
   42f88:	ba a0 57 04 00       	mov    $0x457a0,%edx
   42f8d:	be 00 c0 00 00       	mov    $0xc000,%esi
   42f92:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42f97:	b8 00 00 00 00       	mov    $0x0,%eax
   42f9c:	e8 57 1b 00 00       	call   44af8 <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   42fa1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42fa6:	e9 62 01 00 00       	jmp    4310d <program_load_segment+0x23b>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42fab:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42fb2:	00 
   42fb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42fb7:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   42fbb:	0f 82 76 ff ff ff    	jb     42f37 <program_load_segment+0x65>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42fc1:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42fc5:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42fcc:	48 89 c7             	mov    %rax,%rdi
   42fcf:	e8 bf f7 ff ff       	call   42793 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42fd4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42fd8:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42fdc:	48 89 c2             	mov    %rax,%rdx
   42fdf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fe3:	48 8b 8d 78 ff ff ff 	mov    -0x88(%rbp),%rcx
   42fea:	48 89 ce             	mov    %rcx,%rsi
   42fed:	48 89 c7             	mov    %rax,%rdi
   42ff0:	e8 4e 0c 00 00       	call   43c43 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42ff5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42ff9:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   42ffd:	48 89 c2             	mov    %rax,%rdx
   43000:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43004:	be 00 00 00 00       	mov    $0x0,%esi
   43009:	48 89 c7             	mov    %rax,%rdi
   4300c:	e8 30 0d 00 00       	call   43d41 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   43011:	48 8b 05 e8 ef 00 00 	mov    0xefe8(%rip),%rax        # 52000 <kernel_pagetable>
   43018:	48 89 c7             	mov    %rax,%rdi
   4301b:	e8 73 f7 ff ff       	call   42793 <set_pagetable>


    if((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   43020:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   43024:	8b 40 04             	mov    0x4(%rax),%eax
   43027:	83 e0 02             	and    $0x2,%eax
   4302a:	85 c0                	test   %eax,%eax
   4302c:	75 60                	jne    4308e <program_load_segment+0x1bc>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4302e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43032:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43036:	eb 4c                	jmp    43084 <program_load_segment+0x1b2>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   43038:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4303c:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   43043:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   43047:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   4304b:	48 89 ce             	mov    %rcx,%rsi
   4304e:	48 89 c7             	mov    %rax,%rdi
   43051:	e8 31 fc ff ff       	call   42c87 <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   43056:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4305a:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4305e:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43065:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   43069:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   4306f:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43074:	48 89 c7             	mov    %rax,%rdi
   43077:	e8 48 f8 ff ff       	call   428c4 <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4307c:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43083:	00 
   43084:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43088:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4308c:	72 aa                	jb     43038 <program_load_segment+0x166>
                    PTE_P | PTE_U);
        }
    }
    // TODO : Add code here
    p->original_break = ROUNDUP(end_mem, PAGESIZE);
   4308e:	48 c7 45 d0 00 10 00 	movq   $0x1000,-0x30(%rbp)
   43095:	00 
   43096:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   4309a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4309e:	48 01 d0             	add    %rdx,%rax
   430a1:	48 83 e8 01          	sub    $0x1,%rax
   430a5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   430a9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   430ad:	ba 00 00 00 00       	mov    $0x0,%edx
   430b2:	48 f7 75 d0          	divq   -0x30(%rbp)
   430b6:	48 89 d1             	mov    %rdx,%rcx
   430b9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   430bd:	48 29 c8             	sub    %rcx,%rax
   430c0:	48 89 c2             	mov    %rax,%rdx
   430c3:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   430c7:	48 89 50 10          	mov    %rdx,0x10(%rax)
    p->program_break = ROUNDUP(end_mem, PAGESIZE);
   430cb:	48 c7 45 c0 00 10 00 	movq   $0x1000,-0x40(%rbp)
   430d2:	00 
   430d3:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   430d7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   430db:	48 01 d0             	add    %rdx,%rax
   430de:	48 83 e8 01          	sub    $0x1,%rax
   430e2:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   430e6:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   430ea:	ba 00 00 00 00       	mov    $0x0,%edx
   430ef:	48 f7 75 c0          	divq   -0x40(%rbp)
   430f3:	48 89 d1             	mov    %rdx,%rcx
   430f6:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   430fa:	48 29 c8             	sub    %rcx,%rax
   430fd:	48 89 c2             	mov    %rax,%rdx
   43100:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   43104:	48 89 50 08          	mov    %rdx,0x8(%rax)

    return 0;
   43108:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4310d:	c9                   	leave  
   4310e:	c3                   	ret    

000000000004310f <palloc>:
   4310f:	55                   	push   %rbp
   43110:	48 89 e5             	mov    %rsp,%rbp
   43113:	48 83 ec 20          	sub    $0x20,%rsp
   43117:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4311a:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   43121:	00 
   43122:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43126:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4312a:	e9 95 00 00 00       	jmp    431c4 <palloc+0xb5>
   4312f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43133:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43137:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4313e:	00 
   4313f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43143:	48 c1 e8 0c          	shr    $0xc,%rax
   43147:	48 98                	cltq   
   43149:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   43150:	00 
   43151:	84 c0                	test   %al,%al
   43153:	75 6f                	jne    431c4 <palloc+0xb5>
   43155:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43159:	48 c1 e8 0c          	shr    $0xc,%rax
   4315d:	48 98                	cltq   
   4315f:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43166:	00 
   43167:	84 c0                	test   %al,%al
   43169:	75 59                	jne    431c4 <palloc+0xb5>
   4316b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4316f:	48 c1 e8 0c          	shr    $0xc,%rax
   43173:	89 c2                	mov    %eax,%edx
   43175:	48 63 c2             	movslq %edx,%rax
   43178:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   4317f:	00 
   43180:	83 c0 01             	add    $0x1,%eax
   43183:	89 c1                	mov    %eax,%ecx
   43185:	48 63 c2             	movslq %edx,%rax
   43188:	88 8c 00 21 ff 04 00 	mov    %cl,0x4ff21(%rax,%rax,1)
   4318f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43193:	48 c1 e8 0c          	shr    $0xc,%rax
   43197:	89 c1                	mov    %eax,%ecx
   43199:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4319c:	89 c2                	mov    %eax,%edx
   4319e:	48 63 c1             	movslq %ecx,%rax
   431a1:	88 94 00 20 ff 04 00 	mov    %dl,0x4ff20(%rax,%rax,1)
   431a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431ac:	ba 00 10 00 00       	mov    $0x1000,%edx
   431b1:	be cc 00 00 00       	mov    $0xcc,%esi
   431b6:	48 89 c7             	mov    %rax,%rdi
   431b9:	e8 83 0b 00 00       	call   43d41 <memset>
   431be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   431c2:	eb 2c                	jmp    431f0 <palloc+0xe1>
   431c4:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   431cb:	00 
   431cc:	0f 86 5d ff ff ff    	jbe    4312f <palloc+0x20>
   431d2:	ba d8 57 04 00       	mov    $0x457d8,%edx
   431d7:	be 00 0c 00 00       	mov    $0xc00,%esi
   431dc:	bf 80 07 00 00       	mov    $0x780,%edi
   431e1:	b8 00 00 00 00       	mov    $0x0,%eax
   431e6:	e8 0d 19 00 00       	call   44af8 <console_printf>
   431eb:	b8 00 00 00 00       	mov    $0x0,%eax
   431f0:	c9                   	leave  
   431f1:	c3                   	ret    

00000000000431f2 <palloc_target>:
   431f2:	55                   	push   %rbp
   431f3:	48 89 e5             	mov    %rsp,%rbp
   431f6:	48 8b 05 03 4e 01 00 	mov    0x14e03(%rip),%rax        # 58000 <palloc_target_proc>
   431fd:	48 85 c0             	test   %rax,%rax
   43200:	75 14                	jne    43216 <palloc_target+0x24>
   43202:	ba f1 57 04 00       	mov    $0x457f1,%edx
   43207:	be 27 00 00 00       	mov    $0x27,%esi
   4320c:	bf 0c 58 04 00       	mov    $0x4580c,%edi
   43211:	e8 af f3 ff ff       	call   425c5 <assert_fail>
   43216:	48 8b 05 e3 4d 01 00 	mov    0x14de3(%rip),%rax        # 58000 <palloc_target_proc>
   4321d:	8b 00                	mov    (%rax),%eax
   4321f:	89 c7                	mov    %eax,%edi
   43221:	e8 e9 fe ff ff       	call   4310f <palloc>
   43226:	5d                   	pop    %rbp
   43227:	c3                   	ret    

0000000000043228 <process_free>:
   43228:	55                   	push   %rbp
   43229:	48 89 e5             	mov    %rsp,%rbp
   4322c:	48 83 ec 60          	sub    $0x60,%rsp
   43230:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43233:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43236:	48 63 d0             	movslq %eax,%rdx
   43239:	48 89 d0             	mov    %rdx,%rax
   4323c:	48 c1 e0 04          	shl    $0x4,%rax
   43240:	48 29 d0             	sub    %rdx,%rax
   43243:	48 c1 e0 04          	shl    $0x4,%rax
   43247:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   4324d:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   43253:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   4325a:	00 
   4325b:	e9 ad 00 00 00       	jmp    4330d <process_free+0xe5>
   43260:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43263:	48 63 d0             	movslq %eax,%rdx
   43266:	48 89 d0             	mov    %rdx,%rax
   43269:	48 c1 e0 04          	shl    $0x4,%rax
   4326d:	48 29 d0             	sub    %rdx,%rax
   43270:	48 c1 e0 04          	shl    $0x4,%rax
   43274:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   4327a:	48 8b 08             	mov    (%rax),%rcx
   4327d:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   43281:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43285:	48 89 ce             	mov    %rcx,%rsi
   43288:	48 89 c7             	mov    %rax,%rdi
   4328b:	e8 f7 f9 ff ff       	call   42c87 <virtual_memory_lookup>
   43290:	8b 45 c8             	mov    -0x38(%rbp),%eax
   43293:	48 98                	cltq   
   43295:	83 e0 01             	and    $0x1,%eax
   43298:	48 85 c0             	test   %rax,%rax
   4329b:	74 68                	je     43305 <process_free+0xdd>
   4329d:	8b 45 b8             	mov    -0x48(%rbp),%eax
   432a0:	48 63 d0             	movslq %eax,%rdx
   432a3:	0f b6 94 12 21 ff 04 	movzbl 0x4ff21(%rdx,%rdx,1),%edx
   432aa:	00 
   432ab:	83 ea 01             	sub    $0x1,%edx
   432ae:	48 98                	cltq   
   432b0:	88 94 00 21 ff 04 00 	mov    %dl,0x4ff21(%rax,%rax,1)
   432b7:	8b 45 b8             	mov    -0x48(%rbp),%eax
   432ba:	48 98                	cltq   
   432bc:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   432c3:	00 
   432c4:	84 c0                	test   %al,%al
   432c6:	75 0f                	jne    432d7 <process_free+0xaf>
   432c8:	8b 45 b8             	mov    -0x48(%rbp),%eax
   432cb:	48 98                	cltq   
   432cd:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   432d4:	00 
   432d5:	eb 2e                	jmp    43305 <process_free+0xdd>
   432d7:	8b 45 b8             	mov    -0x48(%rbp),%eax
   432da:	48 98                	cltq   
   432dc:	0f b6 84 00 20 ff 04 	movzbl 0x4ff20(%rax,%rax,1),%eax
   432e3:	00 
   432e4:	0f be c0             	movsbl %al,%eax
   432e7:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   432ea:	75 19                	jne    43305 <process_free+0xdd>
   432ec:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   432f0:	8b 55 ac             	mov    -0x54(%rbp),%edx
   432f3:	48 89 c6             	mov    %rax,%rsi
   432f6:	bf 18 58 04 00       	mov    $0x45818,%edi
   432fb:	b8 00 00 00 00       	mov    $0x0,%eax
   43300:	e8 a2 ef ff ff       	call   422a7 <log_printf>
   43305:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4330c:	00 
   4330d:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43314:	00 
   43315:	0f 86 45 ff ff ff    	jbe    43260 <process_free+0x38>
   4331b:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4331e:	48 63 d0             	movslq %eax,%rdx
   43321:	48 89 d0             	mov    %rdx,%rax
   43324:	48 c1 e0 04          	shl    $0x4,%rax
   43328:	48 29 d0             	sub    %rdx,%rax
   4332b:	48 c1 e0 04          	shl    $0x4,%rax
   4332f:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43335:	48 8b 00             	mov    (%rax),%rax
   43338:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   4333c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43340:	48 8b 00             	mov    (%rax),%rax
   43343:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43349:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4334d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43351:	48 8b 00             	mov    (%rax),%rax
   43354:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4335a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4335e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43362:	48 8b 00             	mov    (%rax),%rax
   43365:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4336b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   4336f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43373:	48 8b 40 08          	mov    0x8(%rax),%rax
   43377:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4337d:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   43381:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43385:	48 c1 e8 0c          	shr    $0xc,%rax
   43389:	48 98                	cltq   
   4338b:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43392:	00 
   43393:	3c 01                	cmp    $0x1,%al
   43395:	74 14                	je     433ab <process_free+0x183>
   43397:	ba 50 58 04 00       	mov    $0x45850,%edx
   4339c:	be 4f 00 00 00       	mov    $0x4f,%esi
   433a1:	bf 0c 58 04 00       	mov    $0x4580c,%edi
   433a6:	e8 1a f2 ff ff       	call   425c5 <assert_fail>
   433ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433af:	48 c1 e8 0c          	shr    $0xc,%rax
   433b3:	48 98                	cltq   
   433b5:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   433bc:	00 
   433bd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433c1:	48 c1 e8 0c          	shr    $0xc,%rax
   433c5:	48 98                	cltq   
   433c7:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   433ce:	00 
   433cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433d3:	48 c1 e8 0c          	shr    $0xc,%rax
   433d7:	48 98                	cltq   
   433d9:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   433e0:	00 
   433e1:	3c 01                	cmp    $0x1,%al
   433e3:	74 14                	je     433f9 <process_free+0x1d1>
   433e5:	ba 78 58 04 00       	mov    $0x45878,%edx
   433ea:	be 52 00 00 00       	mov    $0x52,%esi
   433ef:	bf 0c 58 04 00       	mov    $0x4580c,%edi
   433f4:	e8 cc f1 ff ff       	call   425c5 <assert_fail>
   433f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   433fd:	48 c1 e8 0c          	shr    $0xc,%rax
   43401:	48 98                	cltq   
   43403:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4340a:	00 
   4340b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4340f:	48 c1 e8 0c          	shr    $0xc,%rax
   43413:	48 98                	cltq   
   43415:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4341c:	00 
   4341d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43421:	48 c1 e8 0c          	shr    $0xc,%rax
   43425:	48 98                	cltq   
   43427:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   4342e:	00 
   4342f:	3c 01                	cmp    $0x1,%al
   43431:	74 14                	je     43447 <process_free+0x21f>
   43433:	ba a0 58 04 00       	mov    $0x458a0,%edx
   43438:	be 55 00 00 00       	mov    $0x55,%esi
   4343d:	bf 0c 58 04 00       	mov    $0x4580c,%edi
   43442:	e8 7e f1 ff ff       	call   425c5 <assert_fail>
   43447:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4344b:	48 c1 e8 0c          	shr    $0xc,%rax
   4344f:	48 98                	cltq   
   43451:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43458:	00 
   43459:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4345d:	48 c1 e8 0c          	shr    $0xc,%rax
   43461:	48 98                	cltq   
   43463:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4346a:	00 
   4346b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4346f:	48 c1 e8 0c          	shr    $0xc,%rax
   43473:	48 98                	cltq   
   43475:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   4347c:	00 
   4347d:	3c 01                	cmp    $0x1,%al
   4347f:	74 14                	je     43495 <process_free+0x26d>
   43481:	ba c8 58 04 00       	mov    $0x458c8,%edx
   43486:	be 58 00 00 00       	mov    $0x58,%esi
   4348b:	bf 0c 58 04 00       	mov    $0x4580c,%edi
   43490:	e8 30 f1 ff ff       	call   425c5 <assert_fail>
   43495:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43499:	48 c1 e8 0c          	shr    $0xc,%rax
   4349d:	48 98                	cltq   
   4349f:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   434a6:	00 
   434a7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   434ab:	48 c1 e8 0c          	shr    $0xc,%rax
   434af:	48 98                	cltq   
   434b1:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   434b8:	00 
   434b9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   434bd:	48 c1 e8 0c          	shr    $0xc,%rax
   434c1:	48 98                	cltq   
   434c3:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   434ca:	00 
   434cb:	3c 01                	cmp    $0x1,%al
   434cd:	74 14                	je     434e3 <process_free+0x2bb>
   434cf:	ba f0 58 04 00       	mov    $0x458f0,%edx
   434d4:	be 5b 00 00 00       	mov    $0x5b,%esi
   434d9:	bf 0c 58 04 00       	mov    $0x4580c,%edi
   434de:	e8 e2 f0 ff ff       	call   425c5 <assert_fail>
   434e3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   434e7:	48 c1 e8 0c          	shr    $0xc,%rax
   434eb:	48 98                	cltq   
   434ed:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   434f4:	00 
   434f5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   434f9:	48 c1 e8 0c          	shr    $0xc,%rax
   434fd:	48 98                	cltq   
   434ff:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43506:	00 
   43507:	90                   	nop
   43508:	c9                   	leave  
   43509:	c3                   	ret    

000000000004350a <process_config_tables>:
   4350a:	55                   	push   %rbp
   4350b:	48 89 e5             	mov    %rsp,%rbp
   4350e:	48 83 ec 40          	sub    $0x40,%rsp
   43512:	89 7d cc             	mov    %edi,-0x34(%rbp)
   43515:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43518:	89 c7                	mov    %eax,%edi
   4351a:	e8 f0 fb ff ff       	call   4310f <palloc>
   4351f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43523:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43526:	89 c7                	mov    %eax,%edi
   43528:	e8 e2 fb ff ff       	call   4310f <palloc>
   4352d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43531:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43534:	89 c7                	mov    %eax,%edi
   43536:	e8 d4 fb ff ff       	call   4310f <palloc>
   4353b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4353f:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43542:	89 c7                	mov    %eax,%edi
   43544:	e8 c6 fb ff ff       	call   4310f <palloc>
   43549:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4354d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43550:	89 c7                	mov    %eax,%edi
   43552:	e8 b8 fb ff ff       	call   4310f <palloc>
   43557:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   4355b:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43560:	74 20                	je     43582 <process_config_tables+0x78>
   43562:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43567:	74 19                	je     43582 <process_config_tables+0x78>
   43569:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   4356e:	74 12                	je     43582 <process_config_tables+0x78>
   43570:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43575:	74 0b                	je     43582 <process_config_tables+0x78>
   43577:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4357c:	0f 85 e1 00 00 00    	jne    43663 <process_config_tables+0x159>
   43582:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43587:	74 24                	je     435ad <process_config_tables+0xa3>
   43589:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4358d:	48 c1 e8 0c          	shr    $0xc,%rax
   43591:	48 98                	cltq   
   43593:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4359a:	00 
   4359b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4359f:	48 c1 e8 0c          	shr    $0xc,%rax
   435a3:	48 98                	cltq   
   435a5:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   435ac:	00 
   435ad:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   435b2:	74 24                	je     435d8 <process_config_tables+0xce>
   435b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435b8:	48 c1 e8 0c          	shr    $0xc,%rax
   435bc:	48 98                	cltq   
   435be:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   435c5:	00 
   435c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   435ca:	48 c1 e8 0c          	shr    $0xc,%rax
   435ce:	48 98                	cltq   
   435d0:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   435d7:	00 
   435d8:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   435dd:	74 24                	je     43603 <process_config_tables+0xf9>
   435df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435e3:	48 c1 e8 0c          	shr    $0xc,%rax
   435e7:	48 98                	cltq   
   435e9:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   435f0:	00 
   435f1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   435f5:	48 c1 e8 0c          	shr    $0xc,%rax
   435f9:	48 98                	cltq   
   435fb:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43602:	00 
   43603:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43608:	74 24                	je     4362e <process_config_tables+0x124>
   4360a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4360e:	48 c1 e8 0c          	shr    $0xc,%rax
   43612:	48 98                	cltq   
   43614:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   4361b:	00 
   4361c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43620:	48 c1 e8 0c          	shr    $0xc,%rax
   43624:	48 98                	cltq   
   43626:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   4362d:	00 
   4362e:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43633:	74 24                	je     43659 <process_config_tables+0x14f>
   43635:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43639:	48 c1 e8 0c          	shr    $0xc,%rax
   4363d:	48 98                	cltq   
   4363f:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43646:	00 
   43647:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4364b:	48 c1 e8 0c          	shr    $0xc,%rax
   4364f:	48 98                	cltq   
   43651:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43658:	00 
   43659:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4365e:	e9 f3 01 00 00       	jmp    43856 <process_config_tables+0x34c>
   43663:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43667:	ba 00 10 00 00       	mov    $0x1000,%edx
   4366c:	be 00 00 00 00       	mov    $0x0,%esi
   43671:	48 89 c7             	mov    %rax,%rdi
   43674:	e8 c8 06 00 00       	call   43d41 <memset>
   43679:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4367d:	ba 00 10 00 00       	mov    $0x1000,%edx
   43682:	be 00 00 00 00       	mov    $0x0,%esi
   43687:	48 89 c7             	mov    %rax,%rdi
   4368a:	e8 b2 06 00 00       	call   43d41 <memset>
   4368f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43693:	ba 00 10 00 00       	mov    $0x1000,%edx
   43698:	be 00 00 00 00       	mov    $0x0,%esi
   4369d:	48 89 c7             	mov    %rax,%rdi
   436a0:	e8 9c 06 00 00       	call   43d41 <memset>
   436a5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   436a9:	ba 00 10 00 00       	mov    $0x1000,%edx
   436ae:	be 00 00 00 00       	mov    $0x0,%esi
   436b3:	48 89 c7             	mov    %rax,%rdi
   436b6:	e8 86 06 00 00       	call   43d41 <memset>
   436bb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   436bf:	ba 00 10 00 00       	mov    $0x1000,%edx
   436c4:	be 00 00 00 00       	mov    $0x0,%esi
   436c9:	48 89 c7             	mov    %rax,%rdi
   436cc:	e8 70 06 00 00       	call   43d41 <memset>
   436d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436d5:	48 83 c8 07          	or     $0x7,%rax
   436d9:	48 89 c2             	mov    %rax,%rdx
   436dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   436e0:	48 89 10             	mov    %rdx,(%rax)
   436e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436e7:	48 83 c8 07          	or     $0x7,%rax
   436eb:	48 89 c2             	mov    %rax,%rdx
   436ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   436f2:	48 89 10             	mov    %rdx,(%rax)
   436f5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   436f9:	48 83 c8 07          	or     $0x7,%rax
   436fd:	48 89 c2             	mov    %rax,%rdx
   43700:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43704:	48 89 10             	mov    %rdx,(%rax)
   43707:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4370b:	48 83 c8 07          	or     $0x7,%rax
   4370f:	48 89 c2             	mov    %rax,%rdx
   43712:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43716:	48 89 50 08          	mov    %rdx,0x8(%rax)
   4371a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4371e:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43724:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   4372a:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4372f:	ba 00 00 00 00       	mov    $0x0,%edx
   43734:	be 00 00 00 00       	mov    $0x0,%esi
   43739:	48 89 c7             	mov    %rax,%rdi
   4373c:	e8 83 f1 ff ff       	call   428c4 <virtual_memory_map>
   43741:	85 c0                	test   %eax,%eax
   43743:	75 2f                	jne    43774 <process_config_tables+0x26a>
   43745:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   4374a:	be 00 80 0b 00       	mov    $0xb8000,%esi
   4374f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43753:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43759:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4375f:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43764:	48 89 c7             	mov    %rax,%rdi
   43767:	e8 58 f1 ff ff       	call   428c4 <virtual_memory_map>
   4376c:	85 c0                	test   %eax,%eax
   4376e:	0f 84 bb 00 00 00    	je     4382f <process_config_tables+0x325>
   43774:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43778:	48 c1 e8 0c          	shr    $0xc,%rax
   4377c:	48 98                	cltq   
   4377e:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43785:	00 
   43786:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4378a:	48 c1 e8 0c          	shr    $0xc,%rax
   4378e:	48 98                	cltq   
   43790:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43797:	00 
   43798:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4379c:	48 c1 e8 0c          	shr    $0xc,%rax
   437a0:	48 98                	cltq   
   437a2:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   437a9:	00 
   437aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   437ae:	48 c1 e8 0c          	shr    $0xc,%rax
   437b2:	48 98                	cltq   
   437b4:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   437bb:	00 
   437bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437c0:	48 c1 e8 0c          	shr    $0xc,%rax
   437c4:	48 98                	cltq   
   437c6:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   437cd:	00 
   437ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   437d2:	48 c1 e8 0c          	shr    $0xc,%rax
   437d6:	48 98                	cltq   
   437d8:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   437df:	00 
   437e0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   437e4:	48 c1 e8 0c          	shr    $0xc,%rax
   437e8:	48 98                	cltq   
   437ea:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   437f1:	00 
   437f2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   437f6:	48 c1 e8 0c          	shr    $0xc,%rax
   437fa:	48 98                	cltq   
   437fc:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43803:	00 
   43804:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43808:	48 c1 e8 0c          	shr    $0xc,%rax
   4380c:	48 98                	cltq   
   4380e:	c6 84 00 20 ff 04 00 	movb   $0x0,0x4ff20(%rax,%rax,1)
   43815:	00 
   43816:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4381a:	48 c1 e8 0c          	shr    $0xc,%rax
   4381e:	48 98                	cltq   
   43820:	c6 84 00 21 ff 04 00 	movb   $0x0,0x4ff21(%rax,%rax,1)
   43827:	00 
   43828:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4382d:	eb 27                	jmp    43856 <process_config_tables+0x34c>
   4382f:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43832:	48 63 d0             	movslq %eax,%rdx
   43835:	48 89 d0             	mov    %rdx,%rax
   43838:	48 c1 e0 04          	shl    $0x4,%rax
   4383c:	48 29 d0             	sub    %rdx,%rax
   4383f:	48 c1 e0 04          	shl    $0x4,%rax
   43843:	48 8d 90 e0 f0 04 00 	lea    0x4f0e0(%rax),%rdx
   4384a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4384e:	48 89 02             	mov    %rax,(%rdx)
   43851:	b8 00 00 00 00       	mov    $0x0,%eax
   43856:	c9                   	leave  
   43857:	c3                   	ret    

0000000000043858 <process_load>:
   43858:	55                   	push   %rbp
   43859:	48 89 e5             	mov    %rsp,%rbp
   4385c:	48 83 ec 20          	sub    $0x20,%rsp
   43860:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43864:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43867:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4386b:	48 89 05 8e 47 01 00 	mov    %rax,0x1478e(%rip)        # 58000 <palloc_target_proc>
   43872:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   43875:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43879:	ba f2 31 04 00       	mov    $0x431f2,%edx
   4387e:	89 ce                	mov    %ecx,%esi
   43880:	48 89 c7             	mov    %rax,%rdi
   43883:	e8 f6 f4 ff ff       	call   42d7e <program_load>
   43888:	89 45 fc             	mov    %eax,-0x4(%rbp)
   4388b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4388e:	c9                   	leave  
   4388f:	c3                   	ret    

0000000000043890 <process_setup_stack>:
   43890:	55                   	push   %rbp
   43891:	48 89 e5             	mov    %rsp,%rbp
   43894:	48 83 ec 20          	sub    $0x20,%rsp
   43898:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4389c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438a0:	8b 00                	mov    (%rax),%eax
   438a2:	89 c7                	mov    %eax,%edi
   438a4:	e8 66 f8 ff ff       	call   4310f <palloc>
   438a9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   438ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438b1:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   438b8:	00 00 30 00 
   438bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   438c0:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   438c7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   438cb:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   438d1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   438d7:	b9 00 10 00 00       	mov    $0x1000,%ecx
   438dc:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   438e1:	48 89 c7             	mov    %rax,%rdi
   438e4:	e8 db ef ff ff       	call   428c4 <virtual_memory_map>
   438e9:	90                   	nop
   438ea:	c9                   	leave  
   438eb:	c3                   	ret    

00000000000438ec <find_free_pid>:
   438ec:	55                   	push   %rbp
   438ed:	48 89 e5             	mov    %rsp,%rbp
   438f0:	48 83 ec 10          	sub    $0x10,%rsp
   438f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   438fb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   43902:	eb 24                	jmp    43928 <find_free_pid+0x3c>
   43904:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43907:	48 63 d0             	movslq %eax,%rdx
   4390a:	48 89 d0             	mov    %rdx,%rax
   4390d:	48 c1 e0 04          	shl    $0x4,%rax
   43911:	48 29 d0             	sub    %rdx,%rax
   43914:	48 c1 e0 04          	shl    $0x4,%rax
   43918:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   4391e:	8b 00                	mov    (%rax),%eax
   43920:	85 c0                	test   %eax,%eax
   43922:	74 0c                	je     43930 <find_free_pid+0x44>
   43924:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43928:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4392c:	7e d6                	jle    43904 <find_free_pid+0x18>
   4392e:	eb 01                	jmp    43931 <find_free_pid+0x45>
   43930:	90                   	nop
   43931:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   43935:	74 05                	je     4393c <find_free_pid+0x50>
   43937:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4393a:	eb 05                	jmp    43941 <find_free_pid+0x55>
   4393c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43941:	c9                   	leave  
   43942:	c3                   	ret    

0000000000043943 <process_fork>:
   43943:	55                   	push   %rbp
   43944:	48 89 e5             	mov    %rsp,%rbp
   43947:	48 83 ec 40          	sub    $0x40,%rsp
   4394b:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4394f:	b8 00 00 00 00       	mov    $0x0,%eax
   43954:	e8 93 ff ff ff       	call   438ec <find_free_pid>
   43959:	89 45 f4             	mov    %eax,-0xc(%rbp)
   4395c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   43960:	75 0a                	jne    4396c <process_fork+0x29>
   43962:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43967:	e9 67 02 00 00       	jmp    43bd3 <process_fork+0x290>
   4396c:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4396f:	48 63 d0             	movslq %eax,%rdx
   43972:	48 89 d0             	mov    %rdx,%rax
   43975:	48 c1 e0 04          	shl    $0x4,%rax
   43979:	48 29 d0             	sub    %rdx,%rax
   4397c:	48 c1 e0 04          	shl    $0x4,%rax
   43980:	48 05 00 f0 04 00    	add    $0x4f000,%rax
   43986:	be 00 00 00 00       	mov    $0x0,%esi
   4398b:	48 89 c7             	mov    %rax,%rdi
   4398e:	e8 64 e4 ff ff       	call   41df7 <process_init>
   43993:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43996:	89 c7                	mov    %eax,%edi
   43998:	e8 6d fb ff ff       	call   4350a <process_config_tables>
   4399d:	83 f8 ff             	cmp    $0xffffffff,%eax
   439a0:	75 0a                	jne    439ac <process_fork+0x69>
   439a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   439a7:	e9 27 02 00 00       	jmp    43bd3 <process_fork+0x290>
   439ac:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   439b3:	00 
   439b4:	e9 79 01 00 00       	jmp    43b32 <process_fork+0x1ef>
   439b9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   439bd:	8b 00                	mov    (%rax),%eax
   439bf:	48 63 d0             	movslq %eax,%rdx
   439c2:	48 89 d0             	mov    %rdx,%rax
   439c5:	48 c1 e0 04          	shl    $0x4,%rax
   439c9:	48 29 d0             	sub    %rdx,%rax
   439cc:	48 c1 e0 04          	shl    $0x4,%rax
   439d0:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   439d6:	48 8b 08             	mov    (%rax),%rcx
   439d9:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   439dd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   439e1:	48 89 ce             	mov    %rcx,%rsi
   439e4:	48 89 c7             	mov    %rax,%rdi
   439e7:	e8 9b f2 ff ff       	call   42c87 <virtual_memory_lookup>
   439ec:	8b 45 e0             	mov    -0x20(%rbp),%eax
   439ef:	48 98                	cltq   
   439f1:	83 e0 07             	and    $0x7,%eax
   439f4:	48 83 f8 07          	cmp    $0x7,%rax
   439f8:	0f 85 a1 00 00 00    	jne    43a9f <process_fork+0x15c>
   439fe:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a01:	89 c7                	mov    %eax,%edi
   43a03:	e8 07 f7 ff ff       	call   4310f <palloc>
   43a08:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43a0c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43a11:	75 14                	jne    43a27 <process_fork+0xe4>
   43a13:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a16:	89 c7                	mov    %eax,%edi
   43a18:	e8 0b f8 ff ff       	call   43228 <process_free>
   43a1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a22:	e9 ac 01 00 00       	jmp    43bd3 <process_fork+0x290>
   43a27:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43a2b:	48 89 c1             	mov    %rax,%rcx
   43a2e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43a32:	ba 00 10 00 00       	mov    $0x1000,%edx
   43a37:	48 89 ce             	mov    %rcx,%rsi
   43a3a:	48 89 c7             	mov    %rax,%rdi
   43a3d:	e8 01 02 00 00       	call   43c43 <memcpy>
   43a42:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   43a46:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a49:	48 63 d0             	movslq %eax,%rdx
   43a4c:	48 89 d0             	mov    %rdx,%rax
   43a4f:	48 c1 e0 04          	shl    $0x4,%rax
   43a53:	48 29 d0             	sub    %rdx,%rax
   43a56:	48 c1 e0 04          	shl    $0x4,%rax
   43a5a:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43a60:	48 8b 00             	mov    (%rax),%rax
   43a63:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43a67:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43a6d:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43a73:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43a78:	48 89 fa             	mov    %rdi,%rdx
   43a7b:	48 89 c7             	mov    %rax,%rdi
   43a7e:	e8 41 ee ff ff       	call   428c4 <virtual_memory_map>
   43a83:	85 c0                	test   %eax,%eax
   43a85:	0f 84 9f 00 00 00    	je     43b2a <process_fork+0x1e7>
   43a8b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43a8e:	89 c7                	mov    %eax,%edi
   43a90:	e8 93 f7 ff ff       	call   43228 <process_free>
   43a95:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43a9a:	e9 34 01 00 00       	jmp    43bd3 <process_fork+0x290>
   43a9f:	8b 45 e0             	mov    -0x20(%rbp),%eax
   43aa2:	48 98                	cltq   
   43aa4:	83 e0 05             	and    $0x5,%eax
   43aa7:	48 83 f8 05          	cmp    $0x5,%rax
   43aab:	75 7d                	jne    43b2a <process_fork+0x1e7>
   43aad:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   43ab1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43ab4:	48 63 d0             	movslq %eax,%rdx
   43ab7:	48 89 d0             	mov    %rdx,%rax
   43aba:	48 c1 e0 04          	shl    $0x4,%rax
   43abe:	48 29 d0             	sub    %rdx,%rax
   43ac1:	48 c1 e0 04          	shl    $0x4,%rax
   43ac5:	48 05 e0 f0 04 00    	add    $0x4f0e0,%rax
   43acb:	48 8b 00             	mov    (%rax),%rax
   43ace:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   43ad2:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43ad8:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43ade:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43ae3:	48 89 fa             	mov    %rdi,%rdx
   43ae6:	48 89 c7             	mov    %rax,%rdi
   43ae9:	e8 d6 ed ff ff       	call   428c4 <virtual_memory_map>
   43aee:	85 c0                	test   %eax,%eax
   43af0:	74 14                	je     43b06 <process_fork+0x1c3>
   43af2:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43af5:	89 c7                	mov    %eax,%edi
   43af7:	e8 2c f7 ff ff       	call   43228 <process_free>
   43afc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43b01:	e9 cd 00 00 00       	jmp    43bd3 <process_fork+0x290>
   43b06:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43b0a:	48 c1 e8 0c          	shr    $0xc,%rax
   43b0e:	89 c2                	mov    %eax,%edx
   43b10:	48 63 c2             	movslq %edx,%rax
   43b13:	0f b6 84 00 21 ff 04 	movzbl 0x4ff21(%rax,%rax,1),%eax
   43b1a:	00 
   43b1b:	83 c0 01             	add    $0x1,%eax
   43b1e:	89 c1                	mov    %eax,%ecx
   43b20:	48 63 c2             	movslq %edx,%rax
   43b23:	88 8c 00 21 ff 04 00 	mov    %cl,0x4ff21(%rax,%rax,1)
   43b2a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43b31:	00 
   43b32:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43b39:	00 
   43b3a:	0f 86 79 fe ff ff    	jbe    439b9 <process_fork+0x76>
   43b40:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43b44:	8b 08                	mov    (%rax),%ecx
   43b46:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b49:	48 63 d0             	movslq %eax,%rdx
   43b4c:	48 89 d0             	mov    %rdx,%rax
   43b4f:	48 c1 e0 04          	shl    $0x4,%rax
   43b53:	48 29 d0             	sub    %rdx,%rax
   43b56:	48 c1 e0 04          	shl    $0x4,%rax
   43b5a:	48 8d b0 10 f0 04 00 	lea    0x4f010(%rax),%rsi
   43b61:	48 63 d1             	movslq %ecx,%rdx
   43b64:	48 89 d0             	mov    %rdx,%rax
   43b67:	48 c1 e0 04          	shl    $0x4,%rax
   43b6b:	48 29 d0             	sub    %rdx,%rax
   43b6e:	48 c1 e0 04          	shl    $0x4,%rax
   43b72:	48 8d 90 10 f0 04 00 	lea    0x4f010(%rax),%rdx
   43b79:	48 8d 46 08          	lea    0x8(%rsi),%rax
   43b7d:	48 83 c2 08          	add    $0x8,%rdx
   43b81:	b9 18 00 00 00       	mov    $0x18,%ecx
   43b86:	48 89 c7             	mov    %rax,%rdi
   43b89:	48 89 d6             	mov    %rdx,%rsi
   43b8c:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   43b8f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43b92:	48 63 d0             	movslq %eax,%rdx
   43b95:	48 89 d0             	mov    %rdx,%rax
   43b98:	48 c1 e0 04          	shl    $0x4,%rax
   43b9c:	48 29 d0             	sub    %rdx,%rax
   43b9f:	48 c1 e0 04          	shl    $0x4,%rax
   43ba3:	48 05 18 f0 04 00    	add    $0x4f018,%rax
   43ba9:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   43bb0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43bb3:	48 63 d0             	movslq %eax,%rdx
   43bb6:	48 89 d0             	mov    %rdx,%rax
   43bb9:	48 c1 e0 04          	shl    $0x4,%rax
   43bbd:	48 29 d0             	sub    %rdx,%rax
   43bc0:	48 c1 e0 04          	shl    $0x4,%rax
   43bc4:	48 05 d8 f0 04 00    	add    $0x4f0d8,%rax
   43bca:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   43bd0:	8b 45 f4             	mov    -0xc(%rbp),%eax
   43bd3:	c9                   	leave  
   43bd4:	c3                   	ret    

0000000000043bd5 <process_page_alloc>:
   43bd5:	55                   	push   %rbp
   43bd6:	48 89 e5             	mov    %rsp,%rbp
   43bd9:	48 83 ec 20          	sub    $0x20,%rsp
   43bdd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43be1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43be5:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   43bec:	00 
   43bed:	77 07                	ja     43bf6 <process_page_alloc+0x21>
   43bef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43bf4:	eb 4b                	jmp    43c41 <process_page_alloc+0x6c>
   43bf6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43bfa:	8b 00                	mov    (%rax),%eax
   43bfc:	89 c7                	mov    %eax,%edi
   43bfe:	e8 0c f5 ff ff       	call   4310f <palloc>
   43c03:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43c07:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43c0c:	74 2e                	je     43c3c <process_page_alloc+0x67>
   43c0e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43c12:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c16:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43c1d:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   43c21:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   43c27:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43c2d:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43c32:	48 89 c7             	mov    %rax,%rdi
   43c35:	e8 8a ec ff ff       	call   428c4 <virtual_memory_map>
   43c3a:	eb 05                	jmp    43c41 <process_page_alloc+0x6c>
   43c3c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43c41:	c9                   	leave  
   43c42:	c3                   	ret    

0000000000043c43 <memcpy>:


// memcpy, memmove, memset, strcmp, strlen, strnlen
//    We must provide our own implementations.

void* memcpy(void* dst, const void* src, size_t n) {
   43c43:	55                   	push   %rbp
   43c44:	48 89 e5             	mov    %rsp,%rbp
   43c47:	48 83 ec 28          	sub    $0x28,%rsp
   43c4b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c4f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43c53:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43c57:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43c5b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43c5f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43c63:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43c67:	eb 1c                	jmp    43c85 <memcpy+0x42>
        *d = *s;
   43c69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43c6d:	0f b6 10             	movzbl (%rax),%edx
   43c70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43c74:	88 10                	mov    %dl,(%rax)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   43c76:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43c7b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43c80:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
   43c85:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43c8a:	75 dd                	jne    43c69 <memcpy+0x26>
    }
    return dst;
   43c8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43c90:	c9                   	leave  
   43c91:	c3                   	ret    

0000000000043c92 <memmove>:

void* memmove(void* dst, const void* src, size_t n) {
   43c92:	55                   	push   %rbp
   43c93:	48 89 e5             	mov    %rsp,%rbp
   43c96:	48 83 ec 28          	sub    $0x28,%rsp
   43c9a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43c9e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43ca2:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    const char* s = (const char*) src;
   43ca6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43caa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    char* d = (char*) dst;
   43cae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cb2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (s < d && s + n > d) {
   43cb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cba:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
   43cbe:	73 6a                	jae    43d2a <memmove+0x98>
   43cc0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43cc4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43cc8:	48 01 d0             	add    %rdx,%rax
   43ccb:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   43ccf:	73 59                	jae    43d2a <memmove+0x98>
        s += n, d += n;
   43cd1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43cd5:	48 01 45 f8          	add    %rax,-0x8(%rbp)
   43cd9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43cdd:	48 01 45 f0          	add    %rax,-0x10(%rbp)
        while (n-- > 0) {
   43ce1:	eb 17                	jmp    43cfa <memmove+0x68>
            *--d = *--s;
   43ce3:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
   43ce8:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
   43ced:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43cf1:	0f b6 10             	movzbl (%rax),%edx
   43cf4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43cf8:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43cfa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43cfe:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43d02:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43d06:	48 85 c0             	test   %rax,%rax
   43d09:	75 d8                	jne    43ce3 <memmove+0x51>
    if (s < d && s + n > d) {
   43d0b:	eb 2e                	jmp    43d3b <memmove+0xa9>
        }
    } else {
        while (n-- > 0) {
            *d++ = *s++;
   43d0d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43d11:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43d15:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43d19:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d1d:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43d21:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
   43d25:	0f b6 12             	movzbl (%rdx),%edx
   43d28:	88 10                	mov    %dl,(%rax)
        while (n-- > 0) {
   43d2a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43d2e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   43d32:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
   43d36:	48 85 c0             	test   %rax,%rax
   43d39:	75 d2                	jne    43d0d <memmove+0x7b>
        }
    }
    return dst;
   43d3b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43d3f:	c9                   	leave  
   43d40:	c3                   	ret    

0000000000043d41 <memset>:

void* memset(void* v, int c, size_t n) {
   43d41:	55                   	push   %rbp
   43d42:	48 89 e5             	mov    %rsp,%rbp
   43d45:	48 83 ec 28          	sub    $0x28,%rsp
   43d49:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43d4d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   43d50:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43d54:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d58:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43d5c:	eb 15                	jmp    43d73 <memset+0x32>
        *p = c;
   43d5e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   43d61:	89 c2                	mov    %eax,%edx
   43d63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43d67:	88 10                	mov    %dl,(%rax)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43d69:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43d6e:	48 83 6d d8 01       	subq   $0x1,-0x28(%rbp)
   43d73:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43d78:	75 e4                	jne    43d5e <memset+0x1d>
    }
    return v;
   43d7a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43d7e:	c9                   	leave  
   43d7f:	c3                   	ret    

0000000000043d80 <strlen>:

size_t strlen(const char* s) {
   43d80:	55                   	push   %rbp
   43d81:	48 89 e5             	mov    %rsp,%rbp
   43d84:	48 83 ec 18          	sub    $0x18,%rsp
   43d88:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    size_t n;
    for (n = 0; *s != '\0'; ++s) {
   43d8c:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43d93:	00 
   43d94:	eb 0a                	jmp    43da0 <strlen+0x20>
        ++n;
   43d96:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; *s != '\0'; ++s) {
   43d9b:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43da0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43da4:	0f b6 00             	movzbl (%rax),%eax
   43da7:	84 c0                	test   %al,%al
   43da9:	75 eb                	jne    43d96 <strlen+0x16>
    }
    return n;
   43dab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43daf:	c9                   	leave  
   43db0:	c3                   	ret    

0000000000043db1 <strnlen>:

size_t strnlen(const char* s, size_t maxlen) {
   43db1:	55                   	push   %rbp
   43db2:	48 89 e5             	mov    %rsp,%rbp
   43db5:	48 83 ec 20          	sub    $0x20,%rsp
   43db9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43dbd:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    size_t n;
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43dc1:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   43dc8:	00 
   43dc9:	eb 0a                	jmp    43dd5 <strnlen+0x24>
        ++n;
   43dcb:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43dd0:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
   43dd5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43dd9:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
   43ddd:	74 0b                	je     43dea <strnlen+0x39>
   43ddf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43de3:	0f b6 00             	movzbl (%rax),%eax
   43de6:	84 c0                	test   %al,%al
   43de8:	75 e1                	jne    43dcb <strnlen+0x1a>
    }
    return n;
   43dea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   43dee:	c9                   	leave  
   43def:	c3                   	ret    

0000000000043df0 <strcpy>:

char* strcpy(char* dst, const char* src) {
   43df0:	55                   	push   %rbp
   43df1:	48 89 e5             	mov    %rsp,%rbp
   43df4:	48 83 ec 20          	sub    $0x20,%rsp
   43df8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43dfc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    char* d = dst;
   43e00:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43e04:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    do {
        *d++ = *src++;
   43e08:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   43e0c:	48 8d 42 01          	lea    0x1(%rdx),%rax
   43e10:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43e14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e18:	48 8d 48 01          	lea    0x1(%rax),%rcx
   43e1c:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
   43e20:	0f b6 12             	movzbl (%rdx),%edx
   43e23:	88 10                	mov    %dl,(%rax)
    } while (d[-1]);
   43e25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e29:	48 83 e8 01          	sub    $0x1,%rax
   43e2d:	0f b6 00             	movzbl (%rax),%eax
   43e30:	84 c0                	test   %al,%al
   43e32:	75 d4                	jne    43e08 <strcpy+0x18>
    return dst;
   43e34:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43e38:	c9                   	leave  
   43e39:	c3                   	ret    

0000000000043e3a <strcmp>:

int strcmp(const char* a, const char* b) {
   43e3a:	55                   	push   %rbp
   43e3b:	48 89 e5             	mov    %rsp,%rbp
   43e3e:	48 83 ec 10          	sub    $0x10,%rsp
   43e42:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43e46:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43e4a:	eb 0a                	jmp    43e56 <strcmp+0x1c>
        ++a, ++b;
   43e4c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   43e51:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
    while (*a && *b && *a == *b) {
   43e56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e5a:	0f b6 00             	movzbl (%rax),%eax
   43e5d:	84 c0                	test   %al,%al
   43e5f:	74 1d                	je     43e7e <strcmp+0x44>
   43e61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e65:	0f b6 00             	movzbl (%rax),%eax
   43e68:	84 c0                	test   %al,%al
   43e6a:	74 12                	je     43e7e <strcmp+0x44>
   43e6c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e70:	0f b6 10             	movzbl (%rax),%edx
   43e73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e77:	0f b6 00             	movzbl (%rax),%eax
   43e7a:	38 c2                	cmp    %al,%dl
   43e7c:	74 ce                	je     43e4c <strcmp+0x12>
    }
    return ((unsigned char) *a > (unsigned char) *b)
   43e7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e82:	0f b6 00             	movzbl (%rax),%eax
   43e85:	89 c2                	mov    %eax,%edx
   43e87:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43e8b:	0f b6 00             	movzbl (%rax),%eax
   43e8e:	38 d0                	cmp    %dl,%al
   43e90:	0f 92 c0             	setb   %al
   43e93:	0f b6 d0             	movzbl %al,%edx
        - ((unsigned char) *a < (unsigned char) *b);
   43e96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43e9a:	0f b6 00             	movzbl (%rax),%eax
   43e9d:	89 c1                	mov    %eax,%ecx
   43e9f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ea3:	0f b6 00             	movzbl (%rax),%eax
   43ea6:	38 c1                	cmp    %al,%cl
   43ea8:	0f 92 c0             	setb   %al
   43eab:	0f b6 c0             	movzbl %al,%eax
   43eae:	29 c2                	sub    %eax,%edx
   43eb0:	89 d0                	mov    %edx,%eax
}
   43eb2:	c9                   	leave  
   43eb3:	c3                   	ret    

0000000000043eb4 <strchr>:

char* strchr(const char* s, int c) {
   43eb4:	55                   	push   %rbp
   43eb5:	48 89 e5             	mov    %rsp,%rbp
   43eb8:	48 83 ec 10          	sub    $0x10,%rsp
   43ebc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   43ec0:	89 75 f4             	mov    %esi,-0xc(%rbp)
    while (*s && *s != (char) c) {
   43ec3:	eb 05                	jmp    43eca <strchr+0x16>
        ++s;
   43ec5:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    while (*s && *s != (char) c) {
   43eca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ece:	0f b6 00             	movzbl (%rax),%eax
   43ed1:	84 c0                	test   %al,%al
   43ed3:	74 0e                	je     43ee3 <strchr+0x2f>
   43ed5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ed9:	0f b6 00             	movzbl (%rax),%eax
   43edc:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43edf:	38 d0                	cmp    %dl,%al
   43ee1:	75 e2                	jne    43ec5 <strchr+0x11>
    }
    if (*s == (char) c) {
   43ee3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ee7:	0f b6 00             	movzbl (%rax),%eax
   43eea:	8b 55 f4             	mov    -0xc(%rbp),%edx
   43eed:	38 d0                	cmp    %dl,%al
   43eef:	75 06                	jne    43ef7 <strchr+0x43>
        return (char*) s;
   43ef1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43ef5:	eb 05                	jmp    43efc <strchr+0x48>
    } else {
        return NULL;
   43ef7:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   43efc:	c9                   	leave  
   43efd:	c3                   	ret    

0000000000043efe <rand>:
// rand, srand

static int rand_seed_set;
static unsigned rand_seed;

int rand(void) {
   43efe:	55                   	push   %rbp
   43eff:	48 89 e5             	mov    %rsp,%rbp
    if (!rand_seed_set) {
   43f02:	8b 05 00 41 01 00    	mov    0x14100(%rip),%eax        # 58008 <rand_seed_set>
   43f08:	85 c0                	test   %eax,%eax
   43f0a:	75 0a                	jne    43f16 <rand+0x18>
        srand(819234718U);
   43f0c:	bf 9e 87 d4 30       	mov    $0x30d4879e,%edi
   43f11:	e8 24 00 00 00       	call   43f3a <srand>
    }
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43f16:	8b 05 f0 40 01 00    	mov    0x140f0(%rip),%eax        # 5800c <rand_seed>
   43f1c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
   43f22:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43f27:	89 05 df 40 01 00    	mov    %eax,0x140df(%rip)        # 5800c <rand_seed>
    return rand_seed & RAND_MAX;
   43f2d:	8b 05 d9 40 01 00    	mov    0x140d9(%rip),%eax        # 5800c <rand_seed>
   43f33:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   43f38:	5d                   	pop    %rbp
   43f39:	c3                   	ret    

0000000000043f3a <srand>:

void srand(unsigned seed) {
   43f3a:	55                   	push   %rbp
   43f3b:	48 89 e5             	mov    %rsp,%rbp
   43f3e:	48 83 ec 08          	sub    $0x8,%rsp
   43f42:	89 7d fc             	mov    %edi,-0x4(%rbp)
    rand_seed = seed;
   43f45:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43f48:	89 05 be 40 01 00    	mov    %eax,0x140be(%rip)        # 5800c <rand_seed>
    rand_seed_set = 1;
   43f4e:	c7 05 b0 40 01 00 01 	movl   $0x1,0x140b0(%rip)        # 58008 <rand_seed_set>
   43f55:	00 00 00 
}
   43f58:	90                   	nop
   43f59:	c9                   	leave  
   43f5a:	c3                   	ret    

0000000000043f5b <fill_numbuf>:
//    Print a message onto the console, starting at the given cursor position.

// snprintf, vsnprintf
//    Format a string into a buffer.

static char* fill_numbuf(char* numbuf_end, unsigned long val, int base) {
   43f5b:	55                   	push   %rbp
   43f5c:	48 89 e5             	mov    %rsp,%rbp
   43f5f:	48 83 ec 28          	sub    $0x28,%rsp
   43f63:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   43f67:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   43f6b:	89 55 dc             	mov    %edx,-0x24(%rbp)
    static const char upper_digits[] = "0123456789ABCDEF";
    static const char lower_digits[] = "0123456789abcdef";

    const char* digits = upper_digits;
   43f6e:	48 c7 45 f8 00 5b 04 	movq   $0x45b00,-0x8(%rbp)
   43f75:	00 
    if (base < 0) {
   43f76:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   43f7a:	79 0b                	jns    43f87 <fill_numbuf+0x2c>
        digits = lower_digits;
   43f7c:	48 c7 45 f8 20 5b 04 	movq   $0x45b20,-0x8(%rbp)
   43f83:	00 
        base = -base;
   43f84:	f7 5d dc             	negl   -0x24(%rbp)
    }

    *--numbuf_end = '\0';
   43f87:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43f8c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f90:	c6 00 00             	movb   $0x0,(%rax)
    do {
        *--numbuf_end = digits[val % base];
   43f93:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43f96:	48 63 c8             	movslq %eax,%rcx
   43f99:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f9d:	ba 00 00 00 00       	mov    $0x0,%edx
   43fa2:	48 f7 f1             	div    %rcx
   43fa5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43fa9:	48 01 d0             	add    %rdx,%rax
   43fac:	48 83 6d e8 01       	subq   $0x1,-0x18(%rbp)
   43fb1:	0f b6 10             	movzbl (%rax),%edx
   43fb4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43fb8:	88 10                	mov    %dl,(%rax)
        val /= base;
   43fba:	8b 45 dc             	mov    -0x24(%rbp),%eax
   43fbd:	48 63 f0             	movslq %eax,%rsi
   43fc0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43fc4:	ba 00 00 00 00       	mov    $0x0,%edx
   43fc9:	48 f7 f6             	div    %rsi
   43fcc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    } while (val != 0);
   43fd0:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43fd5:	75 bc                	jne    43f93 <fill_numbuf+0x38>
    return numbuf_end;
   43fd7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
   43fdb:	c9                   	leave  
   43fdc:	c3                   	ret    

0000000000043fdd <printer_vprintf>:
#define FLAG_NUMERIC            (1<<5)
#define FLAG_SIGNED             (1<<6)
#define FLAG_NEGATIVE           (1<<7)
#define FLAG_ALT2               (1<<8)

void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43fdd:	55                   	push   %rbp
   43fde:	48 89 e5             	mov    %rsp,%rbp
   43fe1:	53                   	push   %rbx
   43fe2:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   43fe9:	48 89 bd 78 ff ff ff 	mov    %rdi,-0x88(%rbp)
   43ff0:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%rbp)
   43ff6:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   43ffd:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
#define NUMBUFSIZ 24
    char numbuf[NUMBUFSIZ];

    for (; *format; ++format) {
   44004:	e9 8a 09 00 00       	jmp    44993 <printer_vprintf+0x9b6>
        if (*format != '%') {
   44009:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44010:	0f b6 00             	movzbl (%rax),%eax
   44013:	3c 25                	cmp    $0x25,%al
   44015:	74 31                	je     44048 <printer_vprintf+0x6b>
            p->putc(p, *format, color);
   44017:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4401e:	4c 8b 00             	mov    (%rax),%r8
   44021:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44028:	0f b6 00             	movzbl (%rax),%eax
   4402b:	0f b6 c8             	movzbl %al,%ecx
   4402e:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44034:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4403b:	89 ce                	mov    %ecx,%esi
   4403d:	48 89 c7             	mov    %rax,%rdi
   44040:	41 ff d0             	call   *%r8
            continue;
   44043:	e9 43 09 00 00       	jmp    4498b <printer_vprintf+0x9ae>
        }

        // process flags
        int flags = 0;
   44048:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
        for (++format; *format; ++format) {
   4404f:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44056:	01 
   44057:	eb 44                	jmp    4409d <printer_vprintf+0xc0>
            const char* flagc = strchr(flag_chars, *format);
   44059:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44060:	0f b6 00             	movzbl (%rax),%eax
   44063:	0f be c0             	movsbl %al,%eax
   44066:	89 c6                	mov    %eax,%esi
   44068:	bf 20 59 04 00       	mov    $0x45920,%edi
   4406d:	e8 42 fe ff ff       	call   43eb4 <strchr>
   44072:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
            if (flagc) {
   44076:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   4407b:	74 30                	je     440ad <printer_vprintf+0xd0>
                flags |= 1 << (flagc - flag_chars);
   4407d:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   44081:	48 2d 20 59 04 00    	sub    $0x45920,%rax
   44087:	ba 01 00 00 00       	mov    $0x1,%edx
   4408c:	89 c1                	mov    %eax,%ecx
   4408e:	d3 e2                	shl    %cl,%edx
   44090:	89 d0                	mov    %edx,%eax
   44092:	09 45 ec             	or     %eax,-0x14(%rbp)
        for (++format; *format; ++format) {
   44095:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4409c:	01 
   4409d:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440a4:	0f b6 00             	movzbl (%rax),%eax
   440a7:	84 c0                	test   %al,%al
   440a9:	75 ae                	jne    44059 <printer_vprintf+0x7c>
   440ab:	eb 01                	jmp    440ae <printer_vprintf+0xd1>
            } else {
                break;
   440ad:	90                   	nop
            }
        }

        // process width
        int width = -1;
   440ae:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%rbp)
        if (*format >= '1' && *format <= '9') {
   440b5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440bc:	0f b6 00             	movzbl (%rax),%eax
   440bf:	3c 30                	cmp    $0x30,%al
   440c1:	7e 67                	jle    4412a <printer_vprintf+0x14d>
   440c3:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440ca:	0f b6 00             	movzbl (%rax),%eax
   440cd:	3c 39                	cmp    $0x39,%al
   440cf:	7f 59                	jg     4412a <printer_vprintf+0x14d>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   440d1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%rbp)
   440d8:	eb 2e                	jmp    44108 <printer_vprintf+0x12b>
                width = 10 * width + *format++ - '0';
   440da:	8b 55 e8             	mov    -0x18(%rbp),%edx
   440dd:	89 d0                	mov    %edx,%eax
   440df:	c1 e0 02             	shl    $0x2,%eax
   440e2:	01 d0                	add    %edx,%eax
   440e4:	01 c0                	add    %eax,%eax
   440e6:	89 c1                	mov    %eax,%ecx
   440e8:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   440ef:	48 8d 50 01          	lea    0x1(%rax),%rdx
   440f3:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   440fa:	0f b6 00             	movzbl (%rax),%eax
   440fd:	0f be c0             	movsbl %al,%eax
   44100:	01 c8                	add    %ecx,%eax
   44102:	83 e8 30             	sub    $0x30,%eax
   44105:	89 45 e8             	mov    %eax,-0x18(%rbp)
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   44108:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4410f:	0f b6 00             	movzbl (%rax),%eax
   44112:	3c 2f                	cmp    $0x2f,%al
   44114:	0f 8e 85 00 00 00    	jle    4419f <printer_vprintf+0x1c2>
   4411a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44121:	0f b6 00             	movzbl (%rax),%eax
   44124:	3c 39                	cmp    $0x39,%al
   44126:	7e b2                	jle    440da <printer_vprintf+0xfd>
        if (*format >= '1' && *format <= '9') {
   44128:	eb 75                	jmp    4419f <printer_vprintf+0x1c2>
            }
        } else if (*format == '*') {
   4412a:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   44131:	0f b6 00             	movzbl (%rax),%eax
   44134:	3c 2a                	cmp    $0x2a,%al
   44136:	75 68                	jne    441a0 <printer_vprintf+0x1c3>
            width = va_arg(val, int);
   44138:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4413f:	8b 00                	mov    (%rax),%eax
   44141:	83 f8 2f             	cmp    $0x2f,%eax
   44144:	77 30                	ja     44176 <printer_vprintf+0x199>
   44146:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4414d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44151:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44158:	8b 00                	mov    (%rax),%eax
   4415a:	89 c0                	mov    %eax,%eax
   4415c:	48 01 d0             	add    %rdx,%rax
   4415f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44166:	8b 12                	mov    (%rdx),%edx
   44168:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4416b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44172:	89 0a                	mov    %ecx,(%rdx)
   44174:	eb 1a                	jmp    44190 <printer_vprintf+0x1b3>
   44176:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4417d:	48 8b 40 08          	mov    0x8(%rax),%rax
   44181:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44185:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4418c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44190:	8b 00                	mov    (%rax),%eax
   44192:	89 45 e8             	mov    %eax,-0x18(%rbp)
            ++format;
   44195:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4419c:	01 
   4419d:	eb 01                	jmp    441a0 <printer_vprintf+0x1c3>
        if (*format >= '1' && *format <= '9') {
   4419f:	90                   	nop
        }

        // process precision
        int precision = -1;
   441a0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%rbp)
        if (*format == '.') {
   441a7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441ae:	0f b6 00             	movzbl (%rax),%eax
   441b1:	3c 2e                	cmp    $0x2e,%al
   441b3:	0f 85 00 01 00 00    	jne    442b9 <printer_vprintf+0x2dc>
            ++format;
   441b9:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   441c0:	01 
            if (*format >= '0' && *format <= '9') {
   441c1:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441c8:	0f b6 00             	movzbl (%rax),%eax
   441cb:	3c 2f                	cmp    $0x2f,%al
   441cd:	7e 67                	jle    44236 <printer_vprintf+0x259>
   441cf:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441d6:	0f b6 00             	movzbl (%rax),%eax
   441d9:	3c 39                	cmp    $0x39,%al
   441db:	7f 59                	jg     44236 <printer_vprintf+0x259>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   441dd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
   441e4:	eb 2e                	jmp    44214 <printer_vprintf+0x237>
                    precision = 10 * precision + *format++ - '0';
   441e6:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   441e9:	89 d0                	mov    %edx,%eax
   441eb:	c1 e0 02             	shl    $0x2,%eax
   441ee:	01 d0                	add    %edx,%eax
   441f0:	01 c0                	add    %eax,%eax
   441f2:	89 c1                	mov    %eax,%ecx
   441f4:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   441fb:	48 8d 50 01          	lea    0x1(%rax),%rdx
   441ff:	48 89 95 68 ff ff ff 	mov    %rdx,-0x98(%rbp)
   44206:	0f b6 00             	movzbl (%rax),%eax
   44209:	0f be c0             	movsbl %al,%eax
   4420c:	01 c8                	add    %ecx,%eax
   4420e:	83 e8 30             	sub    $0x30,%eax
   44211:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   44214:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4421b:	0f b6 00             	movzbl (%rax),%eax
   4421e:	3c 2f                	cmp    $0x2f,%al
   44220:	0f 8e 85 00 00 00    	jle    442ab <printer_vprintf+0x2ce>
   44226:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4422d:	0f b6 00             	movzbl (%rax),%eax
   44230:	3c 39                	cmp    $0x39,%al
   44232:	7e b2                	jle    441e6 <printer_vprintf+0x209>
            if (*format >= '0' && *format <= '9') {
   44234:	eb 75                	jmp    442ab <printer_vprintf+0x2ce>
                }
            } else if (*format == '*') {
   44236:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4423d:	0f b6 00             	movzbl (%rax),%eax
   44240:	3c 2a                	cmp    $0x2a,%al
   44242:	75 68                	jne    442ac <printer_vprintf+0x2cf>
                precision = va_arg(val, int);
   44244:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4424b:	8b 00                	mov    (%rax),%eax
   4424d:	83 f8 2f             	cmp    $0x2f,%eax
   44250:	77 30                	ja     44282 <printer_vprintf+0x2a5>
   44252:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44259:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4425d:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44264:	8b 00                	mov    (%rax),%eax
   44266:	89 c0                	mov    %eax,%eax
   44268:	48 01 d0             	add    %rdx,%rax
   4426b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44272:	8b 12                	mov    (%rdx),%edx
   44274:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44277:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4427e:	89 0a                	mov    %ecx,(%rdx)
   44280:	eb 1a                	jmp    4429c <printer_vprintf+0x2bf>
   44282:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44289:	48 8b 40 08          	mov    0x8(%rax),%rax
   4428d:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44291:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44298:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4429c:	8b 00                	mov    (%rax),%eax
   4429e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
                ++format;
   442a1:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   442a8:	01 
   442a9:	eb 01                	jmp    442ac <printer_vprintf+0x2cf>
            if (*format >= '0' && *format <= '9') {
   442ab:	90                   	nop
            }
            if (precision < 0) {
   442ac:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   442b0:	79 07                	jns    442b9 <printer_vprintf+0x2dc>
                precision = 0;
   442b2:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%rbp)
            }
        }

        // process main conversion character
        int base = 10;
   442b9:	c7 45 e0 0a 00 00 00 	movl   $0xa,-0x20(%rbp)
        unsigned long num = 0;
   442c0:	48 c7 45 d8 00 00 00 	movq   $0x0,-0x28(%rbp)
   442c7:	00 
        int length = 0;
   442c8:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%rbp)
        char* data = "";
   442cf:	48 c7 45 c8 26 59 04 	movq   $0x45926,-0x38(%rbp)
   442d6:	00 
    again:
        switch (*format) {
   442d7:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   442de:	0f b6 00             	movzbl (%rax),%eax
   442e1:	0f be c0             	movsbl %al,%eax
   442e4:	83 e8 43             	sub    $0x43,%eax
   442e7:	83 f8 37             	cmp    $0x37,%eax
   442ea:	0f 87 9f 03 00 00    	ja     4468f <printer_vprintf+0x6b2>
   442f0:	89 c0                	mov    %eax,%eax
   442f2:	48 8b 04 c5 38 59 04 	mov    0x45938(,%rax,8),%rax
   442f9:	00 
   442fa:	ff e0                	jmp    *%rax
        case 'l':
        case 'z':
            length = 1;
   442fc:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%rbp)
            ++format;
   44303:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   4430a:	01 
            goto again;
   4430b:	eb ca                	jmp    442d7 <printer_vprintf+0x2fa>
        case 'd':
        case 'i': {
            long x = length ? va_arg(val, long) : va_arg(val, int);
   4430d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44311:	74 5d                	je     44370 <printer_vprintf+0x393>
   44313:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4431a:	8b 00                	mov    (%rax),%eax
   4431c:	83 f8 2f             	cmp    $0x2f,%eax
   4431f:	77 30                	ja     44351 <printer_vprintf+0x374>
   44321:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44328:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4432c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44333:	8b 00                	mov    (%rax),%eax
   44335:	89 c0                	mov    %eax,%eax
   44337:	48 01 d0             	add    %rdx,%rax
   4433a:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44341:	8b 12                	mov    (%rdx),%edx
   44343:	8d 4a 08             	lea    0x8(%rdx),%ecx
   44346:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4434d:	89 0a                	mov    %ecx,(%rdx)
   4434f:	eb 1a                	jmp    4436b <printer_vprintf+0x38e>
   44351:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44358:	48 8b 40 08          	mov    0x8(%rax),%rax
   4435c:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44360:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44367:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   4436b:	48 8b 00             	mov    (%rax),%rax
   4436e:	eb 5c                	jmp    443cc <printer_vprintf+0x3ef>
   44370:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44377:	8b 00                	mov    (%rax),%eax
   44379:	83 f8 2f             	cmp    $0x2f,%eax
   4437c:	77 30                	ja     443ae <printer_vprintf+0x3d1>
   4437e:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44385:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44389:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44390:	8b 00                	mov    (%rax),%eax
   44392:	89 c0                	mov    %eax,%eax
   44394:	48 01 d0             	add    %rdx,%rax
   44397:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4439e:	8b 12                	mov    (%rdx),%edx
   443a0:	8d 4a 08             	lea    0x8(%rdx),%ecx
   443a3:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443aa:	89 0a                	mov    %ecx,(%rdx)
   443ac:	eb 1a                	jmp    443c8 <printer_vprintf+0x3eb>
   443ae:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   443b5:	48 8b 40 08          	mov    0x8(%rax),%rax
   443b9:	48 8d 48 08          	lea    0x8(%rax),%rcx
   443bd:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   443c4:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   443c8:	8b 00                	mov    (%rax),%eax
   443ca:	48 98                	cltq   
   443cc:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   443d0:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   443d4:	48 c1 f8 38          	sar    $0x38,%rax
   443d8:	25 80 00 00 00       	and    $0x80,%eax
   443dd:	89 45 a4             	mov    %eax,-0x5c(%rbp)
            num = negative ? -x : x;
   443e0:	83 7d a4 00          	cmpl   $0x0,-0x5c(%rbp)
   443e4:	74 09                	je     443ef <printer_vprintf+0x412>
   443e6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   443ea:	48 f7 d8             	neg    %rax
   443ed:	eb 04                	jmp    443f3 <printer_vprintf+0x416>
   443ef:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   443f3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   443f7:	8b 45 a4             	mov    -0x5c(%rbp),%eax
   443fa:	83 c8 60             	or     $0x60,%eax
   443fd:	09 45 ec             	or     %eax,-0x14(%rbp)
            break;
   44400:	e9 cf 02 00 00       	jmp    446d4 <printer_vprintf+0x6f7>
        }
        case 'u':
        format_unsigned:
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   44405:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   44409:	74 5d                	je     44468 <printer_vprintf+0x48b>
   4440b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44412:	8b 00                	mov    (%rax),%eax
   44414:	83 f8 2f             	cmp    $0x2f,%eax
   44417:	77 30                	ja     44449 <printer_vprintf+0x46c>
   44419:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44420:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44424:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4442b:	8b 00                	mov    (%rax),%eax
   4442d:	89 c0                	mov    %eax,%eax
   4442f:	48 01 d0             	add    %rdx,%rax
   44432:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44439:	8b 12                	mov    (%rdx),%edx
   4443b:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4443e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44445:	89 0a                	mov    %ecx,(%rdx)
   44447:	eb 1a                	jmp    44463 <printer_vprintf+0x486>
   44449:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44450:	48 8b 40 08          	mov    0x8(%rax),%rax
   44454:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44458:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4445f:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44463:	48 8b 00             	mov    (%rax),%rax
   44466:	eb 5c                	jmp    444c4 <printer_vprintf+0x4e7>
   44468:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4446f:	8b 00                	mov    (%rax),%eax
   44471:	83 f8 2f             	cmp    $0x2f,%eax
   44474:	77 30                	ja     444a6 <printer_vprintf+0x4c9>
   44476:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4447d:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44481:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44488:	8b 00                	mov    (%rax),%eax
   4448a:	89 c0                	mov    %eax,%eax
   4448c:	48 01 d0             	add    %rdx,%rax
   4448f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44496:	8b 12                	mov    (%rdx),%edx
   44498:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4449b:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444a2:	89 0a                	mov    %ecx,(%rdx)
   444a4:	eb 1a                	jmp    444c0 <printer_vprintf+0x4e3>
   444a6:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444ad:	48 8b 40 08          	mov    0x8(%rax),%rax
   444b1:	48 8d 48 08          	lea    0x8(%rax),%rcx
   444b5:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   444bc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   444c0:	8b 00                	mov    (%rax),%eax
   444c2:	89 c0                	mov    %eax,%eax
   444c4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            flags |= FLAG_NUMERIC;
   444c8:	83 4d ec 20          	orl    $0x20,-0x14(%rbp)
            break;
   444cc:	e9 03 02 00 00       	jmp    446d4 <printer_vprintf+0x6f7>
        case 'x':
            base = -16;
   444d1:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            goto format_unsigned;
   444d8:	e9 28 ff ff ff       	jmp    44405 <printer_vprintf+0x428>
        case 'X':
            base = 16;
   444dd:	c7 45 e0 10 00 00 00 	movl   $0x10,-0x20(%rbp)
            goto format_unsigned;
   444e4:	e9 1c ff ff ff       	jmp    44405 <printer_vprintf+0x428>
        case 'p':
            num = (uintptr_t) va_arg(val, void*);
   444e9:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444f0:	8b 00                	mov    (%rax),%eax
   444f2:	83 f8 2f             	cmp    $0x2f,%eax
   444f5:	77 30                	ja     44527 <printer_vprintf+0x54a>
   444f7:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   444fe:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44502:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44509:	8b 00                	mov    (%rax),%eax
   4450b:	89 c0                	mov    %eax,%eax
   4450d:	48 01 d0             	add    %rdx,%rax
   44510:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44517:	8b 12                	mov    (%rdx),%edx
   44519:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4451c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44523:	89 0a                	mov    %ecx,(%rdx)
   44525:	eb 1a                	jmp    44541 <printer_vprintf+0x564>
   44527:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4452e:	48 8b 40 08          	mov    0x8(%rax),%rax
   44532:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44536:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4453d:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44541:	48 8b 00             	mov    (%rax),%rax
   44544:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
            base = -16;
   44548:	c7 45 e0 f0 ff ff ff 	movl   $0xfffffff0,-0x20(%rbp)
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   4454f:	81 4d ec 21 01 00 00 	orl    $0x121,-0x14(%rbp)
            break;
   44556:	e9 79 01 00 00       	jmp    446d4 <printer_vprintf+0x6f7>
        case 's':
            data = va_arg(val, char*);
   4455b:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44562:	8b 00                	mov    (%rax),%eax
   44564:	83 f8 2f             	cmp    $0x2f,%eax
   44567:	77 30                	ja     44599 <printer_vprintf+0x5bc>
   44569:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44570:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44574:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4457b:	8b 00                	mov    (%rax),%eax
   4457d:	89 c0                	mov    %eax,%eax
   4457f:	48 01 d0             	add    %rdx,%rax
   44582:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44589:	8b 12                	mov    (%rdx),%edx
   4458b:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4458e:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44595:	89 0a                	mov    %ecx,(%rdx)
   44597:	eb 1a                	jmp    445b3 <printer_vprintf+0x5d6>
   44599:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445a0:	48 8b 40 08          	mov    0x8(%rax),%rax
   445a4:	48 8d 48 08          	lea    0x8(%rax),%rcx
   445a8:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445af:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   445b3:	48 8b 00             	mov    (%rax),%rax
   445b6:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            break;
   445ba:	e9 15 01 00 00       	jmp    446d4 <printer_vprintf+0x6f7>
        case 'C':
            color = va_arg(val, int);
   445bf:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445c6:	8b 00                	mov    (%rax),%eax
   445c8:	83 f8 2f             	cmp    $0x2f,%eax
   445cb:	77 30                	ja     445fd <printer_vprintf+0x620>
   445cd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445d4:	48 8b 50 10          	mov    0x10(%rax),%rdx
   445d8:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   445df:	8b 00                	mov    (%rax),%eax
   445e1:	89 c0                	mov    %eax,%eax
   445e3:	48 01 d0             	add    %rdx,%rax
   445e6:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445ed:	8b 12                	mov    (%rdx),%edx
   445ef:	8d 4a 08             	lea    0x8(%rdx),%ecx
   445f2:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   445f9:	89 0a                	mov    %ecx,(%rdx)
   445fb:	eb 1a                	jmp    44617 <printer_vprintf+0x63a>
   445fd:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44604:	48 8b 40 08          	mov    0x8(%rax),%rax
   44608:	48 8d 48 08          	lea    0x8(%rax),%rcx
   4460c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44613:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44617:	8b 00                	mov    (%rax),%eax
   44619:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%rbp)
            goto done;
   4461f:	e9 67 03 00 00       	jmp    4498b <printer_vprintf+0x9ae>
        case 'c':
            data = numbuf;
   44624:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44628:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = va_arg(val, int);
   4462c:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44633:	8b 00                	mov    (%rax),%eax
   44635:	83 f8 2f             	cmp    $0x2f,%eax
   44638:	77 30                	ja     4466a <printer_vprintf+0x68d>
   4463a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44641:	48 8b 50 10          	mov    0x10(%rax),%rdx
   44645:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   4464c:	8b 00                	mov    (%rax),%eax
   4464e:	89 c0                	mov    %eax,%eax
   44650:	48 01 d0             	add    %rdx,%rax
   44653:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   4465a:	8b 12                	mov    (%rdx),%edx
   4465c:	8d 4a 08             	lea    0x8(%rdx),%ecx
   4465f:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44666:	89 0a                	mov    %ecx,(%rdx)
   44668:	eb 1a                	jmp    44684 <printer_vprintf+0x6a7>
   4466a:	48 8b 85 60 ff ff ff 	mov    -0xa0(%rbp),%rax
   44671:	48 8b 40 08          	mov    0x8(%rax),%rax
   44675:	48 8d 48 08          	lea    0x8(%rax),%rcx
   44679:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
   44680:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44684:	8b 00                	mov    (%rax),%eax
   44686:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   44689:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            break;
   4468d:	eb 45                	jmp    446d4 <printer_vprintf+0x6f7>
        default:
            data = numbuf;
   4468f:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   44693:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
            numbuf[0] = (*format ? *format : '%');
   44697:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4469e:	0f b6 00             	movzbl (%rax),%eax
   446a1:	84 c0                	test   %al,%al
   446a3:	74 0c                	je     446b1 <printer_vprintf+0x6d4>
   446a5:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   446ac:	0f b6 00             	movzbl (%rax),%eax
   446af:	eb 05                	jmp    446b6 <printer_vprintf+0x6d9>
   446b1:	b8 25 00 00 00       	mov    $0x25,%eax
   446b6:	88 45 8c             	mov    %al,-0x74(%rbp)
            numbuf[1] = '\0';
   446b9:	c6 45 8d 00          	movb   $0x0,-0x73(%rbp)
            if (!*format) {
   446bd:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   446c4:	0f b6 00             	movzbl (%rax),%eax
   446c7:	84 c0                	test   %al,%al
   446c9:	75 08                	jne    446d3 <printer_vprintf+0x6f6>
                format--;
   446cb:	48 83 ad 68 ff ff ff 	subq   $0x1,-0x98(%rbp)
   446d2:	01 
            }
            break;
   446d3:	90                   	nop
        }

        if (flags & FLAG_NUMERIC) {
   446d4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   446d7:	83 e0 20             	and    $0x20,%eax
   446da:	85 c0                	test   %eax,%eax
   446dc:	74 1e                	je     446fc <printer_vprintf+0x71f>
            data = fill_numbuf(numbuf + NUMBUFSIZ, num, base);
   446de:	48 8d 45 8c          	lea    -0x74(%rbp),%rax
   446e2:	48 83 c0 18          	add    $0x18,%rax
   446e6:	8b 55 e0             	mov    -0x20(%rbp),%edx
   446e9:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   446ed:	48 89 ce             	mov    %rcx,%rsi
   446f0:	48 89 c7             	mov    %rax,%rdi
   446f3:	e8 63 f8 ff ff       	call   43f5b <fill_numbuf>
   446f8:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        }

        const char* prefix = "";
   446fc:	48 c7 45 c0 26 59 04 	movq   $0x45926,-0x40(%rbp)
   44703:	00 
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   44704:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44707:	83 e0 20             	and    $0x20,%eax
   4470a:	85 c0                	test   %eax,%eax
   4470c:	74 48                	je     44756 <printer_vprintf+0x779>
   4470e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44711:	83 e0 40             	and    $0x40,%eax
   44714:	85 c0                	test   %eax,%eax
   44716:	74 3e                	je     44756 <printer_vprintf+0x779>
            if (flags & FLAG_NEGATIVE) {
   44718:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4471b:	25 80 00 00 00       	and    $0x80,%eax
   44720:	85 c0                	test   %eax,%eax
   44722:	74 0a                	je     4472e <printer_vprintf+0x751>
                prefix = "-";
   44724:	48 c7 45 c0 27 59 04 	movq   $0x45927,-0x40(%rbp)
   4472b:	00 
            if (flags & FLAG_NEGATIVE) {
   4472c:	eb 73                	jmp    447a1 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_PLUSPOSITIVE) {
   4472e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44731:	83 e0 10             	and    $0x10,%eax
   44734:	85 c0                	test   %eax,%eax
   44736:	74 0a                	je     44742 <printer_vprintf+0x765>
                prefix = "+";
   44738:	48 c7 45 c0 29 59 04 	movq   $0x45929,-0x40(%rbp)
   4473f:	00 
            if (flags & FLAG_NEGATIVE) {
   44740:	eb 5f                	jmp    447a1 <printer_vprintf+0x7c4>
            } else if (flags & FLAG_SPACEPOSITIVE) {
   44742:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44745:	83 e0 08             	and    $0x8,%eax
   44748:	85 c0                	test   %eax,%eax
   4474a:	74 55                	je     447a1 <printer_vprintf+0x7c4>
                prefix = " ";
   4474c:	48 c7 45 c0 2b 59 04 	movq   $0x4592b,-0x40(%rbp)
   44753:	00 
            if (flags & FLAG_NEGATIVE) {
   44754:	eb 4b                	jmp    447a1 <printer_vprintf+0x7c4>
            }
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   44756:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44759:	83 e0 20             	and    $0x20,%eax
   4475c:	85 c0                	test   %eax,%eax
   4475e:	74 42                	je     447a2 <printer_vprintf+0x7c5>
   44760:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44763:	83 e0 01             	and    $0x1,%eax
   44766:	85 c0                	test   %eax,%eax
   44768:	74 38                	je     447a2 <printer_vprintf+0x7c5>
                   && (base == 16 || base == -16)
   4476a:	83 7d e0 10          	cmpl   $0x10,-0x20(%rbp)
   4476e:	74 06                	je     44776 <printer_vprintf+0x799>
   44770:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   44774:	75 2c                	jne    447a2 <printer_vprintf+0x7c5>
                   && (num || (flags & FLAG_ALT2))) {
   44776:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   4477b:	75 0c                	jne    44789 <printer_vprintf+0x7ac>
   4477d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44780:	25 00 01 00 00       	and    $0x100,%eax
   44785:	85 c0                	test   %eax,%eax
   44787:	74 19                	je     447a2 <printer_vprintf+0x7c5>
            prefix = (base == -16 ? "0x" : "0X");
   44789:	83 7d e0 f0          	cmpl   $0xfffffff0,-0x20(%rbp)
   4478d:	75 07                	jne    44796 <printer_vprintf+0x7b9>
   4478f:	b8 2d 59 04 00       	mov    $0x4592d,%eax
   44794:	eb 05                	jmp    4479b <printer_vprintf+0x7be>
   44796:	b8 30 59 04 00       	mov    $0x45930,%eax
   4479b:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4479f:	eb 01                	jmp    447a2 <printer_vprintf+0x7c5>
            if (flags & FLAG_NEGATIVE) {
   447a1:	90                   	nop
        }

        int len;
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   447a2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   447a6:	78 24                	js     447cc <printer_vprintf+0x7ef>
   447a8:	8b 45 ec             	mov    -0x14(%rbp),%eax
   447ab:	83 e0 20             	and    $0x20,%eax
   447ae:	85 c0                	test   %eax,%eax
   447b0:	75 1a                	jne    447cc <printer_vprintf+0x7ef>
            len = strnlen(data, precision);
   447b2:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   447b5:	48 63 d0             	movslq %eax,%rdx
   447b8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   447bc:	48 89 d6             	mov    %rdx,%rsi
   447bf:	48 89 c7             	mov    %rax,%rdi
   447c2:	e8 ea f5 ff ff       	call   43db1 <strnlen>
   447c7:	89 45 bc             	mov    %eax,-0x44(%rbp)
   447ca:	eb 0f                	jmp    447db <printer_vprintf+0x7fe>
        } else {
            len = strlen(data);
   447cc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   447d0:	48 89 c7             	mov    %rax,%rdi
   447d3:	e8 a8 f5 ff ff       	call   43d80 <strlen>
   447d8:	89 45 bc             	mov    %eax,-0x44(%rbp)
        }
        int zeros;
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   447db:	8b 45 ec             	mov    -0x14(%rbp),%eax
   447de:	83 e0 20             	and    $0x20,%eax
   447e1:	85 c0                	test   %eax,%eax
   447e3:	74 20                	je     44805 <printer_vprintf+0x828>
   447e5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
   447e9:	78 1a                	js     44805 <printer_vprintf+0x828>
            zeros = precision > len ? precision - len : 0;
   447eb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   447ee:	3b 45 bc             	cmp    -0x44(%rbp),%eax
   447f1:	7e 08                	jle    447fb <printer_vprintf+0x81e>
   447f3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   447f6:	2b 45 bc             	sub    -0x44(%rbp),%eax
   447f9:	eb 05                	jmp    44800 <printer_vprintf+0x823>
   447fb:	b8 00 00 00 00       	mov    $0x0,%eax
   44800:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44803:	eb 5c                	jmp    44861 <printer_vprintf+0x884>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   44805:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44808:	83 e0 20             	and    $0x20,%eax
   4480b:	85 c0                	test   %eax,%eax
   4480d:	74 4b                	je     4485a <printer_vprintf+0x87d>
   4480f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44812:	83 e0 02             	and    $0x2,%eax
   44815:	85 c0                	test   %eax,%eax
   44817:	74 41                	je     4485a <printer_vprintf+0x87d>
                   && !(flags & FLAG_LEFTJUSTIFY)
   44819:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4481c:	83 e0 04             	and    $0x4,%eax
   4481f:	85 c0                	test   %eax,%eax
   44821:	75 37                	jne    4485a <printer_vprintf+0x87d>
                   && len + (int) strlen(prefix) < width) {
   44823:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44827:	48 89 c7             	mov    %rax,%rdi
   4482a:	e8 51 f5 ff ff       	call   43d80 <strlen>
   4482f:	89 c2                	mov    %eax,%edx
   44831:	8b 45 bc             	mov    -0x44(%rbp),%eax
   44834:	01 d0                	add    %edx,%eax
   44836:	39 45 e8             	cmp    %eax,-0x18(%rbp)
   44839:	7e 1f                	jle    4485a <printer_vprintf+0x87d>
            zeros = width - len - strlen(prefix);
   4483b:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4483e:	2b 45 bc             	sub    -0x44(%rbp),%eax
   44841:	89 c3                	mov    %eax,%ebx
   44843:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44847:	48 89 c7             	mov    %rax,%rdi
   4484a:	e8 31 f5 ff ff       	call   43d80 <strlen>
   4484f:	89 c2                	mov    %eax,%edx
   44851:	89 d8                	mov    %ebx,%eax
   44853:	29 d0                	sub    %edx,%eax
   44855:	89 45 b8             	mov    %eax,-0x48(%rbp)
   44858:	eb 07                	jmp    44861 <printer_vprintf+0x884>
        } else {
            zeros = 0;
   4485a:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%rbp)
        }
        width -= len + zeros + strlen(prefix);
   44861:	8b 55 bc             	mov    -0x44(%rbp),%edx
   44864:	8b 45 b8             	mov    -0x48(%rbp),%eax
   44867:	01 d0                	add    %edx,%eax
   44869:	48 63 d8             	movslq %eax,%rbx
   4486c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   44870:	48 89 c7             	mov    %rax,%rdi
   44873:	e8 08 f5 ff ff       	call   43d80 <strlen>
   44878:	48 8d 14 03          	lea    (%rbx,%rax,1),%rdx
   4487c:	8b 45 e8             	mov    -0x18(%rbp),%eax
   4487f:	29 d0                	sub    %edx,%eax
   44881:	89 45 e8             	mov    %eax,-0x18(%rbp)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   44884:	eb 25                	jmp    448ab <printer_vprintf+0x8ce>
            p->putc(p, ' ', color);
   44886:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4488d:	48 8b 08             	mov    (%rax),%rcx
   44890:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44896:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4489d:	be 20 00 00 00       	mov    $0x20,%esi
   448a2:	48 89 c7             	mov    %rax,%rdi
   448a5:	ff d1                	call   *%rcx
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   448a7:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   448ab:	8b 45 ec             	mov    -0x14(%rbp),%eax
   448ae:	83 e0 04             	and    $0x4,%eax
   448b1:	85 c0                	test   %eax,%eax
   448b3:	75 36                	jne    448eb <printer_vprintf+0x90e>
   448b5:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   448b9:	7f cb                	jg     44886 <printer_vprintf+0x8a9>
        }
        for (; *prefix; ++prefix) {
   448bb:	eb 2e                	jmp    448eb <printer_vprintf+0x90e>
            p->putc(p, *prefix, color);
   448bd:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448c4:	4c 8b 00             	mov    (%rax),%r8
   448c7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   448cb:	0f b6 00             	movzbl (%rax),%eax
   448ce:	0f b6 c8             	movzbl %al,%ecx
   448d1:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   448d7:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448de:	89 ce                	mov    %ecx,%esi
   448e0:	48 89 c7             	mov    %rax,%rdi
   448e3:	41 ff d0             	call   *%r8
        for (; *prefix; ++prefix) {
   448e6:	48 83 45 c0 01       	addq   $0x1,-0x40(%rbp)
   448eb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   448ef:	0f b6 00             	movzbl (%rax),%eax
   448f2:	84 c0                	test   %al,%al
   448f4:	75 c7                	jne    448bd <printer_vprintf+0x8e0>
        }
        for (; zeros > 0; --zeros) {
   448f6:	eb 25                	jmp    4491d <printer_vprintf+0x940>
            p->putc(p, '0', color);
   448f8:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   448ff:	48 8b 08             	mov    (%rax),%rcx
   44902:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   44908:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4490f:	be 30 00 00 00       	mov    $0x30,%esi
   44914:	48 89 c7             	mov    %rax,%rdi
   44917:	ff d1                	call   *%rcx
        for (; zeros > 0; --zeros) {
   44919:	83 6d b8 01          	subl   $0x1,-0x48(%rbp)
   4491d:	83 7d b8 00          	cmpl   $0x0,-0x48(%rbp)
   44921:	7f d5                	jg     448f8 <printer_vprintf+0x91b>
        }
        for (; len > 0; ++data, --len) {
   44923:	eb 32                	jmp    44957 <printer_vprintf+0x97a>
            p->putc(p, *data, color);
   44925:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   4492c:	4c 8b 00             	mov    (%rax),%r8
   4492f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   44933:	0f b6 00             	movzbl (%rax),%eax
   44936:	0f b6 c8             	movzbl %al,%ecx
   44939:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4493f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44946:	89 ce                	mov    %ecx,%esi
   44948:	48 89 c7             	mov    %rax,%rdi
   4494b:	41 ff d0             	call   *%r8
        for (; len > 0; ++data, --len) {
   4494e:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
   44953:	83 6d bc 01          	subl   $0x1,-0x44(%rbp)
   44957:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
   4495b:	7f c8                	jg     44925 <printer_vprintf+0x948>
        }
        for (; width > 0; --width) {
   4495d:	eb 25                	jmp    44984 <printer_vprintf+0x9a7>
            p->putc(p, ' ', color);
   4495f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44966:	48 8b 08             	mov    (%rax),%rcx
   44969:	8b 95 74 ff ff ff    	mov    -0x8c(%rbp),%edx
   4496f:	48 8b 85 78 ff ff ff 	mov    -0x88(%rbp),%rax
   44976:	be 20 00 00 00       	mov    $0x20,%esi
   4497b:	48 89 c7             	mov    %rax,%rdi
   4497e:	ff d1                	call   *%rcx
        for (; width > 0; --width) {
   44980:	83 6d e8 01          	subl   $0x1,-0x18(%rbp)
   44984:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
   44988:	7f d5                	jg     4495f <printer_vprintf+0x982>
        }
    done: ;
   4498a:	90                   	nop
    for (; *format; ++format) {
   4498b:	48 83 85 68 ff ff ff 	addq   $0x1,-0x98(%rbp)
   44992:	01 
   44993:	48 8b 85 68 ff ff ff 	mov    -0x98(%rbp),%rax
   4499a:	0f b6 00             	movzbl (%rax),%eax
   4499d:	84 c0                	test   %al,%al
   4499f:	0f 85 64 f6 ff ff    	jne    44009 <printer_vprintf+0x2c>
    }
}
   449a5:	90                   	nop
   449a6:	90                   	nop
   449a7:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   449ab:	c9                   	leave  
   449ac:	c3                   	ret    

00000000000449ad <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   449ad:	55                   	push   %rbp
   449ae:	48 89 e5             	mov    %rsp,%rbp
   449b1:	48 83 ec 20          	sub    $0x20,%rsp
   449b5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   449b9:	89 f0                	mov    %esi,%eax
   449bb:	89 55 e0             	mov    %edx,-0x20(%rbp)
   449be:	88 45 e4             	mov    %al,-0x1c(%rbp)
    console_printer* cp = (console_printer*) p;
   449c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   449c5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   449c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449cd:	48 8b 40 08          	mov    0x8(%rax),%rax
   449d1:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
   449d6:	48 39 d0             	cmp    %rdx,%rax
   449d9:	72 0c                	jb     449e7 <console_putc+0x3a>
        cp->cursor = console;
   449db:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449df:	48 c7 40 08 00 80 0b 	movq   $0xb8000,0x8(%rax)
   449e6:	00 
    }
    if (c == '\n') {
   449e7:	80 7d e4 0a          	cmpb   $0xa,-0x1c(%rbp)
   449eb:	75 78                	jne    44a65 <console_putc+0xb8>
        int pos = (cp->cursor - console) % 80;
   449ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   449f1:	48 8b 40 08          	mov    0x8(%rax),%rax
   449f5:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   449fb:	48 d1 f8             	sar    %rax
   449fe:	48 89 c1             	mov    %rax,%rcx
   44a01:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   44a08:	66 66 66 
   44a0b:	48 89 c8             	mov    %rcx,%rax
   44a0e:	48 f7 ea             	imul   %rdx
   44a11:	48 c1 fa 05          	sar    $0x5,%rdx
   44a15:	48 89 c8             	mov    %rcx,%rax
   44a18:	48 c1 f8 3f          	sar    $0x3f,%rax
   44a1c:	48 29 c2             	sub    %rax,%rdx
   44a1f:	48 89 d0             	mov    %rdx,%rax
   44a22:	48 c1 e0 02          	shl    $0x2,%rax
   44a26:	48 01 d0             	add    %rdx,%rax
   44a29:	48 c1 e0 04          	shl    $0x4,%rax
   44a2d:	48 29 c1             	sub    %rax,%rcx
   44a30:	48 89 ca             	mov    %rcx,%rdx
   44a33:	89 55 fc             	mov    %edx,-0x4(%rbp)
        for (; pos != 80; pos++) {
   44a36:	eb 25                	jmp    44a5d <console_putc+0xb0>
            *cp->cursor++ = ' ' | color;
   44a38:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44a3b:	83 c8 20             	or     $0x20,%eax
   44a3e:	89 c6                	mov    %eax,%esi
   44a40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44a44:	48 8b 40 08          	mov    0x8(%rax),%rax
   44a48:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44a4c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44a50:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44a54:	89 f2                	mov    %esi,%edx
   44a56:	66 89 10             	mov    %dx,(%rax)
        for (; pos != 80; pos++) {
   44a59:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44a5d:	83 7d fc 50          	cmpl   $0x50,-0x4(%rbp)
   44a61:	75 d5                	jne    44a38 <console_putc+0x8b>
        }
    } else {
        *cp->cursor++ = c | color;
    }
}
   44a63:	eb 24                	jmp    44a89 <console_putc+0xdc>
        *cp->cursor++ = c | color;
   44a65:	0f b6 45 e4          	movzbl -0x1c(%rbp),%eax
   44a69:	8b 55 e0             	mov    -0x20(%rbp),%edx
   44a6c:	09 d0                	or     %edx,%eax
   44a6e:	89 c6                	mov    %eax,%esi
   44a70:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44a74:	48 8b 40 08          	mov    0x8(%rax),%rax
   44a78:	48 8d 48 02          	lea    0x2(%rax),%rcx
   44a7c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   44a80:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44a84:	89 f2                	mov    %esi,%edx
   44a86:	66 89 10             	mov    %dx,(%rax)
}
   44a89:	90                   	nop
   44a8a:	c9                   	leave  
   44a8b:	c3                   	ret    

0000000000044a8c <console_vprintf>:

int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44a8c:	55                   	push   %rbp
   44a8d:	48 89 e5             	mov    %rsp,%rbp
   44a90:	48 83 ec 30          	sub    $0x30,%rsp
   44a94:	89 7d ec             	mov    %edi,-0x14(%rbp)
   44a97:	89 75 e8             	mov    %esi,-0x18(%rbp)
   44a9a:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   44a9e:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
    struct console_printer cp;
    cp.p.putc = console_putc;
   44aa2:	48 c7 45 f0 ad 49 04 	movq   $0x449ad,-0x10(%rbp)
   44aa9:	00 
    if (cpos < 0 || cpos >= CONSOLE_ROWS * CONSOLE_COLUMNS) {
   44aaa:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
   44aae:	78 09                	js     44ab9 <console_vprintf+0x2d>
   44ab0:	81 7d ec cf 07 00 00 	cmpl   $0x7cf,-0x14(%rbp)
   44ab7:	7e 07                	jle    44ac0 <console_vprintf+0x34>
        cpos = 0;
   44ab9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    }
    cp.cursor = console + cpos;
   44ac0:	8b 45 ec             	mov    -0x14(%rbp),%eax
   44ac3:	48 98                	cltq   
   44ac5:	48 01 c0             	add    %rax,%rax
   44ac8:	48 05 00 80 0b 00    	add    $0xb8000,%rax
   44ace:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44ad2:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
   44ad6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   44ada:	8b 75 e8             	mov    -0x18(%rbp),%esi
   44add:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
   44ae1:	48 89 c7             	mov    %rax,%rdi
   44ae4:	e8 f4 f4 ff ff       	call   43fdd <printer_vprintf>
    return cp.cursor - console;
   44ae9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44aed:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44af3:	48 d1 f8             	sar    %rax
}
   44af6:	c9                   	leave  
   44af7:	c3                   	ret    

0000000000044af8 <console_printf>:

int console_printf(int cpos, int color, const char* format, ...) {
   44af8:	55                   	push   %rbp
   44af9:	48 89 e5             	mov    %rsp,%rbp
   44afc:	48 83 ec 60          	sub    $0x60,%rsp
   44b00:	89 7d ac             	mov    %edi,-0x54(%rbp)
   44b03:	89 75 a8             	mov    %esi,-0x58(%rbp)
   44b06:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   44b0a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44b0e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44b12:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44b16:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44b1d:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44b21:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44b25:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44b29:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44b2d:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44b31:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   44b35:	8b 75 a8             	mov    -0x58(%rbp),%esi
   44b38:	8b 45 ac             	mov    -0x54(%rbp),%eax
   44b3b:	89 c7                	mov    %eax,%edi
   44b3d:	e8 4a ff ff ff       	call   44a8c <console_vprintf>
   44b42:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   44b45:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   44b48:	c9                   	leave  
   44b49:	c3                   	ret    

0000000000044b4a <string_putc>:
    printer p;
    char* s;
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
   44b4a:	55                   	push   %rbp
   44b4b:	48 89 e5             	mov    %rsp,%rbp
   44b4e:	48 83 ec 20          	sub    $0x20,%rsp
   44b52:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44b56:	89 f0                	mov    %esi,%eax
   44b58:	89 55 e0             	mov    %edx,-0x20(%rbp)
   44b5b:	88 45 e4             	mov    %al,-0x1c(%rbp)
    string_printer* sp = (string_printer*) p;
   44b5e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44b62:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if (sp->s < sp->end) {
   44b66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44b6a:	48 8b 50 08          	mov    0x8(%rax),%rdx
   44b6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44b72:	48 8b 40 10          	mov    0x10(%rax),%rax
   44b76:	48 39 c2             	cmp    %rax,%rdx
   44b79:	73 1a                	jae    44b95 <string_putc+0x4b>
        *sp->s++ = c;
   44b7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   44b7f:	48 8b 40 08          	mov    0x8(%rax),%rax
   44b83:	48 8d 48 01          	lea    0x1(%rax),%rcx
   44b87:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44b8b:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
   44b8f:	0f b6 55 e4          	movzbl -0x1c(%rbp),%edx
   44b93:	88 10                	mov    %dl,(%rax)
    }
    (void) color;
}
   44b95:	90                   	nop
   44b96:	c9                   	leave  
   44b97:	c3                   	ret    

0000000000044b98 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   44b98:	55                   	push   %rbp
   44b99:	48 89 e5             	mov    %rsp,%rbp
   44b9c:	48 83 ec 40          	sub    $0x40,%rsp
   44ba0:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   44ba4:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   44ba8:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
   44bac:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
    string_printer sp;
    sp.p.putc = string_putc;
   44bb0:	48 c7 45 e8 4a 4b 04 	movq   $0x44b4a,-0x18(%rbp)
   44bb7:	00 
    sp.s = s;
   44bb8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44bbc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if (size) {
   44bc0:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   44bc5:	74 33                	je     44bfa <vsnprintf+0x62>
        sp.end = s + size - 1;
   44bc7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   44bcb:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
   44bcf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44bd3:	48 01 d0             	add    %rdx,%rax
   44bd6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   44bda:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   44bde:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   44be2:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   44be6:	be 00 00 00 00       	mov    $0x0,%esi
   44beb:	48 89 c7             	mov    %rax,%rdi
   44bee:	e8 ea f3 ff ff       	call   43fdd <printer_vprintf>
        *sp.s = 0;
   44bf3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44bf7:	c6 00 00             	movb   $0x0,(%rax)
    }
    return sp.s - s;
   44bfa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44bfe:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
}
   44c02:	c9                   	leave  
   44c03:	c3                   	ret    

0000000000044c04 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   44c04:	55                   	push   %rbp
   44c05:	48 89 e5             	mov    %rsp,%rbp
   44c08:	48 83 ec 70          	sub    $0x70,%rsp
   44c0c:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   44c10:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   44c14:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   44c18:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44c1c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44c20:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   44c24:	c7 45 b0 18 00 00 00 	movl   $0x18,-0x50(%rbp)
   44c2b:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44c2f:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   44c33:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   44c37:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    int n = vsnprintf(s, size, format, val);
   44c3b:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   44c3f:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   44c43:	48 8b 75 a0          	mov    -0x60(%rbp),%rsi
   44c47:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   44c4b:	48 89 c7             	mov    %rax,%rdi
   44c4e:	e8 45 ff ff ff       	call   44b98 <vsnprintf>
   44c53:	89 45 cc             	mov    %eax,-0x34(%rbp)
    va_end(val);
    return n;
   44c56:	8b 45 cc             	mov    -0x34(%rbp),%eax
}
   44c59:	c9                   	leave  
   44c5a:	c3                   	ret    

0000000000044c5b <console_clear>:


// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
   44c5b:	55                   	push   %rbp
   44c5c:	48 89 e5             	mov    %rsp,%rbp
   44c5f:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44c63:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   44c6a:	eb 13                	jmp    44c7f <console_clear+0x24>
        console[i] = ' ' | 0x0700;
   44c6c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44c6f:	48 98                	cltq   
   44c71:	66 c7 84 00 00 80 0b 	movw   $0x720,0xb8000(%rax,%rax,1)
   44c78:	00 20 07 
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   44c7b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44c7f:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
   44c86:	7e e4                	jle    44c6c <console_clear+0x11>
    }
    cursorpos = 0;
   44c88:	c7 05 6a 43 07 00 00 	movl   $0x0,0x7436a(%rip)        # b8ffc <cursorpos>
   44c8f:	00 00 00 
}
   44c92:	90                   	nop
   44c93:	c9                   	leave  
   44c94:	c3                   	ret    
