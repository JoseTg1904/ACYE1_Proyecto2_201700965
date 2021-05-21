analizadorLexico macro buffer
    local estado0, estado1, estado2, fin, auxiliar, restaurar, obtenerNumero, intermedio, conversion

    limpiarArreglo arregloOriginal
    limpiarArreglo arregloAuxiliar

    xor si, si
    mov posicionArreglo, 0d
    mov si, -1

    estado0:
        obtenerCaracter buffer

        cmp bl, "$"
        jz fin

        cmp bl, "<"
        jz auxiliar

        cmp bl, ">"
        jz estado0 

        jmp estado0

    auxiliar:
        limpiarBuffer bufferAcumulador, "$"
        xor di, di

    estado1:
        obtenerCaracter buffer

        cmp bl, ">"
        jz estado2

        mov bufferAcumulador[di], bl
        inc di

        jmp estado1

    estado2:
        mov respaldoSI, si
        
        toLowerCase bufferAcumulador

        mov ax, lengthof numerosInicio - 1
        compararCadenas numerosInicio, bufferAcumulador, ax
        je restaurar

        mov ax, lengthof numeroFin - 1
        compararCadenas numeroFin, bufferAcumulador, ax
        je restaurar

        mov ax, lengthof numerosFin - 1
        compararCadenas numerosFin, bufferAcumulador, ax
        je restaurar

        mov ax, lengthof numeroInicio - 1
        compararCadenas numeroInicio, bufferAcumulador, ax
        je intermedio

    restaurar:
        mov si, respaldoSI
        dec si
        jmp estado0

    intermedio:
        limpiarBuffer bufferAcumulador, "$"
        mov si, respaldoSI
        xor di, di

    obtenerNumero:
        obtenerCaracter buffer

        cmp bl, "<"
        jz conversion

        mov bufferAcumulador[di], bl
        inc di
        jmp obtenerNumero

    conversion:
        mov respaldoSI, si

        convertirANum bufferAcumulador
        mov cx, numeroAux

        mov si, posicionArreglo

        shl si, 1d
        mov arregloOriginal[si], cx
        mov arregloAuxiliar[si], cx

        inc posicionArreglo

        mov si, respaldoSI
        dec si
        jmp estado0

    fin:
endm

obtenerCaracter macro buffer
    inc si
    mov bl, buffer[si]
endm

convertirANum macro buffer
    local fin, decena, unidad, centena

    xor ax, ax
    xor bx, bx
    xor dx, dx
    xor cx, cx

    mov dl, 48d ;aqui se resta 48 para obtener el numero como tal

    mov cl, buffer[bx]
    inc bx
    sub cl, dl
    mov numeroAux, cx

    cmp buffer[bx], "$"
    jz fin

    cmp buffer[bx + 1], "$"
    jz decena
    jnz centena

    decena:
        xor cx, cx
        mov cl, buffer[bx]
        sub cl, dl

        mov dx, 10d
        mov ax, numeroAux
        mul dx
        add ax, cx
        mov numeroAux, ax

        jmp fin

    centena:
        mov dx, 100d ;centena
        mov ax, numeroAux
        mul dx
        mov numeroAux, ax

        mov dl, 48d

        xor cx, cx ;decena
        mov cl, buffer[bx]
        inc bx
        sub cl, dl

        xor ax, ax
        mov dx, 10d
        mov ax, cx
        mul dx
        mov cx, numeroAux
        add ax, cx
        mov numeroAux, ax

        mov dl, 48d

        xor cx, cx ;unidad
        mov cl, buffer[bx]
        sub cl, dl

        mov ax, numeroAux
        add ax, cx
        mov numeroAux, ax

    fin:
endm
