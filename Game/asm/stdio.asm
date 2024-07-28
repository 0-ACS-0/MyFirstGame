global print
global scan




section .text
    ; Macro expression writeByte | Macro expresión writeByte
    %macro writeByte 1
        mov eax, 4              ; System call number for sys_write      | Llamada al sistema a sys_write
        mov ebx, 1              ; File descriptor 1 (stdout)            | Descriptor de archivo 1 (stdout)
        mov ecx, %1             ; Pointer to the character to print     | Puntero al carácter a imprimir
        mov edx, 1              ; Number of bytes to write              | Número de bytes a escribir
        int 0x80                ; Call to kernel (performs system call) | Llamada al kernel (realiza la llamada al sistema)
    %endmacro

    ;Macro expression readBytes | Macro expresión readBytes
    %macro readBytes 2
        mov eax, 3              ; System call number for sys_read       | Llamada al sistema a sys_read
        mov ebx, 0              ; File descriptor 0 (stdin)             | Descriptor de archivo 0 (stdin)
        mov ecx, %1             ; Buffer where the input will be stored | Memoria donde la entrada será almacenada  
        mov edx, %2             ; Maximum number of bytes to read       | Máximo número de bytes a leer
        int 0x80
    %endmacro


    ;
    ; _PRINT FUNCTION | FUNCIÓN _PRINT
    ;
    ;   1. Pointer to string | Puntero a cadena
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    print:
        ; Preamble  | Preámbulo
        push ebp
        mov ebp, esp
        push ebx
        push esi                    ; Saved esi status for restoring it     | Guardado el estado del registro es para restaurarlo

        ; Body of the function | Cuerpo de la función
        mov esi, [ebp + 8]          ; First argument passed to esi          | Primer argumento copiado a esi
        
    ; Loop to print the string | Bucle para imprimir la cadena
    string_continues:    
        ; Comparation of the current byte with the end of string value | Comparación del valor del byte actual con el valor final de cadena    
        cmp byte [esi], 0           
        je string_ends

        ; Macro to print the byte | Macro para imprimir el byte
        writeByte esi

        ; Increments string pointer & continues loop | Incrementa el puntero de la cadena y continua en el bucle
        inc esi
        jmp string_continues

    ; End of the loop | Fin del bucle
    string_ends:

        mov eax, 0

        ; Epiloge | Epílogo
        pop esi                     ; Restore the state of esi      | Restauro el estado del registro esi
        pop ebx
        mov esp, ebp
        pop ebp
        ret

    
    ;
    ; _SCAN FUNCTION | FUNCIÓN _SCAN
    ;
    ;   2. Number of bytes to read  | Número de bytes a leer
    ;
    ;   ret Pointer to readBuffer
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    scan:
        ; Preamble  | Preámbulo
        push ebp
        mov ebp, esp
        push ebx
        push esi
        push edi

        ; Body of the function | Cuerpo de la función
        mov esi, [ebp + 8]          ; First argument passed to edi          | Primer argumento copiado a edi
        mov edi, [ebp + 12]         ; Second argument passed to esi         | Segundo argumento copiado a esi

        ; Lecture of user imput with macro readBytes | Lectura de la entrada de usuario con la macra readBytes
        readBytes esi, edi      ; User input read                       | Lectura de la entrada del usuario        
        mov byte [esi + edi], 0

        mov eax, 0

        ; Epiloge | Epílogo
        pop edi
        pop esi
        pop ebx
        mov esp, ebp
        pop ebp
        ret