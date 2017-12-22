
; The following information is correct for a 1.44M floppy.
; Yes, I'm hard coding this.
SECTORS_PER_TRACK equ 18
HEADS equ 2
CYLINDERS equ 80

; Make the AMD bios happy ... make the available space smaller :(
BUFFERSEG equ 0x9020

%ifndef __LOWLEVEL__
%define __LOWLEVEL__
%macro message 1
	push es
	mov ax,ds
	mov es,ax
	mov bp,%1
	call BiosDisplay
	pop es
%endmacro
%endif

; here do come all low-level functions that are host-specific, like sectors
; reading, messages display, etc.

BiosRow db 10

BiosClearSreen:
	pusha
	mov ax,0x0600	; clear the "window"
	mov cx,0x0000	; from (0,0)
	mov dx,0x184f	; to (24,79)
	mov bh,0x07	; keep light grey display
	int 0x10
	popa
	ret


BiosDisplay:
;; Displays a $-terminated string on the screen. A row counter is incremented.
;; Takes its string from es:bp as required by the bios.
;; we will assume ds == es 
	pusha
	mov ax,0x1300	; write a string without attributes
	mov bx,0x0007	; page=0, attributes is lgrey/black.
	mov dl,1	; first colum (forced)
	mov dh,[cs:BiosRow]
	inc byte [cs:BiosRow]

	mov si,bp
	xor cx,cx
.computelength:
	cmp byte [si],'$'
	jz .found
	inc cx
	inc si
	jmp .computelength
.found:
	int 0x10
	popa
	ret




; These are used by ReadSector
head: dw 0
track: dw 0
sec: dw 0
num_retries: db 0

; Used for loops reading sectors from floppy
sec_count: dw 0


; Read a sector from the floppy drive.
;
; Parameters:
;     - "logical" sector number   [bp+8]
;     - destination segment       [bp+6]
;     - destination offset        [bp+4]
ReadSector:
	push	bp			; set up stack frame
	mov	bp, sp			; "
	pusha				; save all registers

	; Sector = log_sec % SECTORS_PER_TRACK
	; Head = (log_sec / SECTORS_PER_TRACK) % HEADS
	mov	ax, [bp+8]		; get logical sector number from stack
	xor	dx, dx			; dx is high part of dividend (== 0)
	mov	bx, SECTORS_PER_TRACK	; divisor
	div	bx			; do the division
	mov	[cs:sec], dx		; sector is the remainder
	and	ax, 1			; same as mod by HEADS==2 (slight hack)
	mov	[cs:head], ax

	; Track = log_sec / (SECTORS_PER_TRACK*HEADS)
	mov	ax, [bp+8]		; get logical sector number again
	xor	dx, dx			; dx is high part of dividend
	mov	bx, SECTORS_PER_TRACK*2 ; divisor
	div	bx			; do the division
	mov	[cs:track], ax		; track is quotient


	; Now, try to actually read the sector from the floppy,
	; retrying up to 3 times.

	mov	[cs:num_retries], byte 0
	push es
	push 0xb800
	pop es
	mov word [es:0],'- '
	pop es

.again:
	mov	ax, [bp+6]		; dest segment...
	mov	es, ax			;   goes in es
	mov	ax, (0x02 << 8) | 1	; function = 02h in ah,
					;   # secs = 1 in al
	mov	bx, [cs:track]		; track number...
	mov	ch, bl			;   goes in ch
	mov	bx, [cs:sec]		; sector number...
	mov	cl, bl			;   goes in cl...
	inc	cl			;   but it must be 1-based, not 0-based
	mov	bx, [cs:head]		; head number...
	mov	dh, bl			;   goes in dh
	xor	dl, dl			; hard code drive=0
	mov	bx, [bp+4]		; offset goes in bx
					;   (es:bx points to buffer)

	; Call the BIOS Read Diskette Sectors service
	int	0x13
	push es
	push 0xb800
	pop es
	inc word [es:0]
	pop es

	; If the carry flag is NOT set, then there was no error
	; and we're done.
	jnc	.done

	; Error - code stored in ah
	mov	dx, ax
	call PrintHex
	inc	byte [cs:num_retries]
	cmp	byte [cs:num_retries], 3
	jne	.again

	; If we got here, we failed thrice, so we give up
	mov	dx, 0xdead
	call	PrintHex
.here:	jmp	.here

.done:
	popa				; restore all regisiters
	pop	bp			; leave stack frame
	ret

	;; read2buffer(logical_sector)
%macro read2buffer 1	


       push word %1
	push word BUFFERSEG
	push word 0

	push es
	push 0xb800
	pop es
	mov word [es:0],'/ '
	pop es
	call ReadSector
	add esp,6
	push es
	push 0xb800
	pop es
	mov word [es:0],'\ '
	pop es

%endmacro

;; read (logical_sector, seg target, off target)
%macro read 3
	push word %1
	push word %2
	push word %3
	call ReadSector
	add esp,6
%endmacro	

;; buffer2mem(size, off src,off target)
;; assume segment is DS.
%macro buffer2mem 3
	pusha
	mov cx,%1	
	mov di,%3
	mov si,%2

	call _buff2mem
	popa
%endmacro




_buff2mem:
	push ds
	push es

	mov ax,ds
	mov bx,BUFFERSEG
	mov es,ax
	mov ds,bx

	cld
	push es
	push 0xb800
	pop es
	mov word [es:0],'| '
	pop es
	rep movsb

	pop es
	pop ds
	ret
	

; Print the word contained in the dx register to the screen.
PrintHex:
	pusha
	mov   cx, 4		; 4 hex digits
.PrintDigit:
	rol   dx, 4		; rotate so that lowest 4 bits are used
	mov   ax, 0E0Fh 	; ah = request, al = mask for nybble
	and   al, dl
	add   al, 90h		; convert al to ascii hex (four instructions)
	daa			; I've spent 1 hour to understand how it works..
	adc   al, 40h
	daa
	int   10h
	loop  .PrintDigit
	popa
	ret

; Print a newline.
PrintNL:			; print CR and NL
	push	ax
	mov	ax, 0E0Dh	; CR
	int	10h
	mov	al, 0Ah 	; LF
	int	10h
	pop	ax
	ret

	
