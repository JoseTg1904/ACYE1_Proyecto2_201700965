imprimir macro cadena, color
    mov ax, @data ;Moviendo el segmento de data al registro de proposito general
    mov ds, ax

    mov ah, 09h;Tipo de operacion de 21h muestra caracteres, basicamente print
    mov bl, color ;color del texto de salida
    mov cx, lengthof cadena - 1 ;pintar el texto en su totalidad
    int 10h ;interrupcion para dar color
    lea dx, cadena ; mostrando la cadena
    int 21h ;interrupcion para mostrar
endm

leerHastaEnter macro entrada
    local salto, fin

    xor bx, bx ; limpiando el registro

    salto:
        mov ah, 01h
        int 21h
        cmp al, 0dh ;verificar si es un salto de linea lo que se esta leyendo
        je fin
        mov entrada[bx], al
        inc bx
        jmp salto
    fin:
        mov al, 24h ;agregando un signo de dolar para eliminar el salto de linea
        mov entrada[bx], al
endm

compararCadenas macro string, string2, tamanioString2 ;string = original, string2 = leido
    local fin

    mov ax, lengthof string - 1
    cmp tamanioString2, ax
    jnz fin

    push es
    mov ax, ds
    mov es, ax
    mov cx, lengthof string
    lea si, string
    lea di, string2
    repe cmpsb
    cmp cx, 0
    pop es

    fin:
endm

toLowerCase	macro string 
	local iterar, siguiente, fin

	xor si, si
	mov cx, lengthof string

	iterar:
		cmp string[si], 36
		je fin				
		cmp string[si], 65
		jb siguiente
		cmp string[si], 90
		ja siguiente

		add string[si], 32
		inc si

		loop iterar
	
    jmp fin

	siguiente:
		inc si
		jmp iterar

	fin:
endm

limpiarBuffer macro buffer, character
    local limpiarOp

    mov cx, lengthof buffer
    xor bx, bx

    limpiarOp:
        mov buffer[bx], character
        inc bx
        loop limpiarOp
endm

limpiarArreglo macro arreglo
    local limpiarAr

    mov cx, lengthof arreglo
    xor bx, bx
    mov iteradorI, 0

    limpiarAr:
        mov bx, iteradorI
        shl bx, 1 ; esto es igual que multiplicar el registro por 2
        mov arreglo[bx], -1
        inc iteradorI
        cmp cx, iteradorI
        jnz limpiarAr
endm

imprimirArreglo macro arreglo
    local ciclo

    xor si, si
    mov iteradorI, 0d

    ciclo:
        mov si, iteradorI
        shl si, 1d

        mov ax, arreglo[si]
        mov varAux, ax
        Print16 varAux
        leerHastaEnter bufferTeclado

        inc iteradorI
        mov ax, tamanioTabla
        cmp iteradorI, ax
        jnz ciclo
endm

copiarArreglo macro origen, destino
    local ciclo

    mov cx, lengthof origen
    xor bx, bx
    mov iteradorI, 0

    ciclo:
        mov bx, iteradorI
        shl bx, 1d
        mov ax, origen[bx]
        mov destino[bx], ax
        inc iteradorI
        cmp cx, iteradorI
        jnz ciclo
endm

conversionAString macro convertido
    local split, split2, negativo, fin, fin2

    push si
    push cx
    push bx
    push dx

    xor si, si
    xor cx, cx
    xor bx, bx
    xor dx, dx
    mov dl, 0ah
    test ax, 1000000000000000b
    jnz negativo
    jmp split2

    negativo:
        neg ax
        mov convertido[si], 45d
        inc si
        jmp split2
    
    split:
        xor ah, ah

    split2:
        div dl
        inc cx
        push ax
        cmp al, 00h
        je fin2
        jmp split

    fin2:
        pop ax
        add ah, 30h
        mov convertido[si], ah
        inc si
        loop fin2
        mov ah, 24h
        mov convertido[si], ah
        inc si
    fin:
        pop dx
        pop bx
        pop cx
        pop si
endm

;division que genera cuatro decimales
dividir16 macro numerador, denominador
    local ciclo

    xor dx, dx
    mov ax, numerador
    mov bx, denominador
    div bx ; num / den
    mov varAux, ax ;parte entera

    xor cx, cx
    mov numeroAux, 0d
    ciclo:
        mov ax, dx
        xor dx, dx
        push bx
        mov bx, 10d
        mul bx
        pop bx

        xor dx, dx
        div bx

        push ax
        push dx
        push bx

        xor dx, dx
        mov ax, numeroAux ;residuo
        mov bx, 10d
        mul bx
        mov numeroAux, ax

        pop bx
        pop dx
        pop ax

        add numeroAux, ax

        inc cx
        cmp cx, 3d
        jnz ciclo
endm

Print16 macro Regis, color
    local zero, noz
    
    mov bx, 4
    xor ax, ax
    mov ax, Regis
    mov cx, 10
    zero:
        xor dx, dx
        div cx;NUMERO / 10
        push dx
        dec bx
        jnz zero
        xor bx, 4
    noz:
        pop dx
        PrintN dl, color
        dec bx
        jnz noz
endm

Print8 macro Regis, color
    local zero, noz
    
    mov bx, 2
    xor ax, ax
    mov ax, Regis
    mov cx, 10
    zero:
        xor dx, dx
        div cx;NUMERO / 10
        push dx
        dec bx
        jnz zero
        xor bx, 2
    noz:
        pop dx
        PrintN dl, color
        dec bx
        jnz noz
endm

PrintN macro Num, color
    push bx
    push cx
    xor ax, ax
    mov dl, Num
    add dl, 48d
    mov ah, 02h
    int 21h
    pop cx
    pop bx
endm

closeFile macro handler
    mov ax, @data
    mov ds, ax
    mov ah, 3eh
    mov bx, handler
    int 21h
endm