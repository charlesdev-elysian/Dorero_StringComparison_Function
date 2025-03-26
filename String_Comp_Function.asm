; String Comparison Program for emu8086
; Compares two strings with case sensitivity option

org 100h

jmp start

; Data section
msg1 db 'Enter first string: $'
msg2 db 'Enter second string: $'
msg3 db 'Case sensitive? (1=Yes, 0=No): $'
result_eq db 'Strings are equal. Result: 1$'
result_neq db 'Strings are not equal. Result: 0$'
buffer1 db 50, ?, 50 dup('$') ; Buffer for first string
buffer2 db 50, ?, 50 dup('$') ; Buffer for second string
case_flag db 0 ; 0=case insensitive, 1=case sensitive

start:
    ; Print prompt for first string
    mov ah, 9
    mov dx, offset msg1
    int 21h
    
    ; Read first string
    mov ah, 0Ah
    mov dx, offset buffer1
    int 21h
    
    ; Print newline
    call newline
    
    ; Print prompt for second string
    mov ah, 9
    mov dx, offset msg2
    int 21h
    
    ; Read second string
    mov ah, 0Ah
    mov dx, offset buffer2
    int 21h
    
    ; Print newline
    call newline
    
    ; Ask for case sensitivity
    mov ah, 9
    mov dx, offset msg3
    int 21h
    
    ; Read case sensitivity flag
    mov ah, 1
    int 21h
    sub al, '0' ; Convert from ASCII to number
    mov [case_flag], al
    
    ; Print newline
    call newline
    
    ; Compare strings
    mov si, offset buffer1 + 2 ; Point to start of first string
    mov di, offset buffer2 + 2 ; Point to start of second string
    mov cl, [buffer1 + 1]     ; Length of first string
    mov ch, [buffer2 + 1]     ; Length of second string
    
    ; First check if lengths are equal
    cmp cl, ch
    jne not_equal
    
    ; Prepare for comparison
    xor cx, cx
    mov cl, [buffer1 + 1] ; Get length
    
compare_loop:
    mov al, [si]
    mov bl, [di]
    
    ; Check case sensitivity
    cmp [case_flag], 1
    je case_sensitive
    
    ; Case insensitive comparison - convert both to uppercase
    ; Convert al to uppercase if it's lowercase
    cmp al, 'a'
    jb next_char1
    cmp al, 'z'
    ja next_char1
    sub al, 32 ; Convert to uppercase
    
next_char1:
    ; Convert bl to uppercase if it's lowercase
    cmp bl, 'a'
    jb compare_chars
    cmp bl, 'z'
    ja compare_chars
    sub bl, 32 ; Convert to uppercase
    jmp compare_chars
    
case_sensitive:
    ; Direct comparison
    cmp al, bl
    jne not_equal
    
compare_chars:
    cmp al, bl
    jne not_equal
    
    ; Move to next characters
    inc si
    inc di
    loop compare_loop
    
    ; If we get here, strings are equal
    mov ah, 9
    mov dx, offset result_eq
    int 21h
    jmp exit
    
not_equal:
    mov ah, 9
    mov dx, offset result_neq
    int 21h
    
exit:
    ; Wait for any key press
    mov ah, 0
    int 16h
    
    ; Return to DOS
    mov ah, 4Ch
    int 21h
    
; Helper function to print newline
newline proc
    mov ah, 2
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h
    ret
newline endp