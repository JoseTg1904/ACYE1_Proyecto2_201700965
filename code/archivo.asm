abrirArchivo macro buffer, handler
    local error, fin, busquedaInicioExtension, obtenerExtension, verificarExtension, invalida

    mov ah, 3dh
    mov al, 10b ;Abriendo el archivo en lectura/escritura
    lea dx, buffer
    int 21h
    mov handler, ax
    jc error ;mover hacia la etiqueta si se diera un error en la apertura
    
    xor si, si
    xor bx, bx

    ;busca hasta que el caracter nulo que delimita el final de la ruta
    busquedaInicioExtension: 
        cmp buffer[si], "."
        jz obtenerExtension
        inc si
        jnz busquedaInicioExtension

    ;obtiene la extension del archivo, tomando en cuenta que solo es de tres caracteres mas el punto
    obtenerExtension: 
        cmp buffer[si], 00h
        jz verificarExtension
        mov cl, buffer[si]
        mov verificadorExtension[bx], cl ;creando el string auxiliar para verificar la extension
        inc si
        inc bx
        jnz obtenerExtension

    verificarExtension: ;comparacion de strings
        mov ax, lengthof verificadorExtension - 1
        compararCadenas verificadorExtension, extension, ax
        jne invalida

    mov errorArchivo, 0
    jmp fin

    invalida:
        imprimir salto, 0d
        imprimir salidaConsola, 12d
        imprimir mensajeExtension, 7d
        imprimir salto, 0d
        imprimir salto, 0d
        mov errorArchivo, 1
        jmp fin
    error:
        imprimir salto, 0d
        imprimir salidaConsola, 12d
        imprimir mensajeError, 7d
        imprimir salto, 0d
        imprimir salto, 0d
        mov errorArchivo, 1
        mov ax, 1
    fin:
endm

leerArchivo macro handler, numBytes, buffer
    local error, fin

    mov ah, 3fh
    mov bx, handler ;Manejador del archivo
    mov cx, numbytes ;Numero maximo de bytes a leer 
    lea dx, buffer ;Arreglo que almacena el contenido del archivo
    int 21h
    jc error
    mov errorArchivo, 0
    jmp fin

    error:
        imprimir salto, 0d
        imprimir salidaConsola, 12d
        imprimir mensajeErrorLectura, 7d
        imprimir salto, 0d
        imprimir salto, 0d
        mov errorArchivo, 1
    fin:
endm