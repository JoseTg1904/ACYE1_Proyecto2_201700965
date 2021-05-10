obtenerTablaDeFrecuencias macro
    local ciclo, ciclo2, condicion, condicion2, condicion3, condicion4, continue

    limpiarArreglo numeros
    limpiarArreglo frecuencias

    mov iteradorI, 0d ; i
    mov varAux, -1 ; posicion
    mov numeroAux, 0d ;variable auxiliar
    mov banderaNuevo, 1d ; nuevo
    mov tamanioTabla, 0d ; tamanio de la tabla de frecuencias

    xor bx, bx ; ciclo de afuera = i
    xor si, si ; ciclo de adentro = j

    ciclo:
        mov bx, iteradorI
        shl bx, 1d
        mov ax, arregloAuxiliar[bx]
        mov numeroAux, ax
        mov banderaNuevo, 1

        mov iteradorJ, 0
        ciclo2:
            mov si, iteradorJ
            shl si, 1d

            condicion:
                xor cx, cx
                mov cx, arregloAuxiliar[si]
                cmp numeroAux, cx 
                jz condicion2
                jmp continue

            condicion2:
                cmp arregloAuxiliar[si], -1
                jz continue

            mov arregloAuxiliar[si], -1
            cmp banderaNuevo, 1d
            jz condicion3
            jmp condicion4

            condicion3:
                mov banderaNuevo, 0d
                inc varAux
                xor di, di
                mov di, varAux
                shl di, 1d
                xor cx, cx
                mov cx, numeroAux
                inc tamanioTabla
                mov numeros[di], cx
                mov frecuencias[di], 1d
                jmp continue

            condicion4:
                xor di, di
                mov di, varAux
                shl di, 1
                inc frecuencias[di]

            continue:
                inc iteradorJ
                mov si, iteradorJ
                cmp posicionArreglo, si
                jnz ciclo2

        inc iteradorI
        mov bx, iteradorI
        cmp posicionArreglo, bx
        jnz ciclo
endm

bubbleSort macro arreglo, arreglo1
    local externo, interno, mayor, validacionInterno, validacionExterno

    mov iteradorI, -1
    mov numeroAux, 0d

    externo:
        inc iteradorI
        mov iteradorJ, -1
    
    interno:
        inc iteradorJ
        xor si, si
        xor di, di
        xor ax, ax
        mov si, iteradorJ ; j
        shl si, 1d
        mov di, iteradorJ ; j + 1
        inc di
        shl di, 1d

        mov ax, arreglo[si]
        cmp ax, arreglo[di]
        ja mayor
        jmp validacionInterno

    mayor:
        ; aux = arreglo[j]
        xor ax, ax
        xor bx, bx
        mov ax, arreglo[si]
        mov bx, arreglo1[si] ;frecuencia
        mov numeroAux, ax ; numero

        ;arreglo[j] = arreglo[j+1]
        xor ax, ax
        mov ax, arreglo[di] ; numero
        mov arreglo[si], ax
        xor ax, ax
        mov ax, arreglo1[di] ; frecuencia
        mov arreglo1[si], ax

        ;arreglo[j+1] = aux
        xor ax, ax
        mov ax, numeroAux
        mov arreglo[di], ax
        mov arreglo1[di], bx

    validacionInterno:
        mov ax, tamanioTabla
        dec ax        
        cmp iteradorJ, ax
        jnz interno

    validacionExterno:
        mov ax, tamanioTabla
        dec ax
        cmp iteradorI, ax
        jnz externo
endm

bubbleSort2 macro arreglo
    local externo, interno, mayor, validacionInterno, validacionExterno

    mov iteradorI, -1
    mov numeroAux, 0d

    externo:
        inc iteradorI
        mov iteradorJ, -1
    
    interno:
        inc iteradorJ
        xor si, si
        xor di, di
        xor ax, ax
        mov si, iteradorJ ; j
        shl si, 1d
        mov di, iteradorJ ; j + 1
        inc di
        shl di, 1d

        mov ax, arreglo[si]
        cmp ax, arreglo[di]
        ja mayor
        jmp validacionInterno

    mayor:
        ; aux = arreglo[j]
        xor ax, ax
        xor bx, bx
        mov ax, arreglo[si]
        mov numeroAux, ax ; numero

        ;arreglo[j] = arreglo[j+1]
        xor ax, ax
        mov ax, arreglo[di] ; numero
        mov arreglo[si], ax

        ;arreglo[j+1] = aux
        xor ax, ax
        mov ax, numeroAux
        mov arreglo[di], ax

    validacionInterno:
        mov ax, posicionArreglo
        dec ax        
        cmp iteradorJ, ax
        jnz interno

    validacionExterno:
        mov ax, posicionArreglo
        dec ax
        cmp iteradorI, ax
        jnz externo
endm

obtenerMediana macro
    local par, impar, fin

    bubbleSort2 arregloOriginal
    dividir16 posicionArreglo, 2d

    cmp numeroAux, 0d
    jz par
    jmp impar

    par:
        xor bx, bx
        xor si, si
        mov bx, varAux ;pos
        dec bx
        mov si, varAux ; pos + 1
        
        shl si, 1d
        shl bx, 1d

        xor ax, ax
        mov ax, arregloOriginal[si]
        add ax, arregloOriginal[bx] ; ar[pos] + ar[pos + 1] = res

        dividir16 ax, 2d

        jmp fin
    impar:
        xor bx, bx
        mov bx, varAux
        shl bx, 1d

        xor ax, ax
        mov ax, arregloOriginal[bx]
        mov varAux, ax
        mov numeroAux, 0d

    fin:
endm

obtenerPromedio macro
    local suma

    mov iteradorI, 0d
    mov ax, 0d
    suma:
        mov si, iteradorI
        shl si, 1d

        add ax, arregloOriginal[si]

        inc iteradorI
        mov bx, iteradorI
        cmp bx, posicionArreglo
        jnz suma

    dividir16 ax, posicionArreglo
endm

obtenerMaximo macro
    bubbleSort numeros, frecuencias

    mov bx, tamanioTabla
    dec bx
    shl bx, 1d

    mov ax, numeros[bx]
    mov numeroAux, ax
endm

obtenerMinimo macro
    bubbleSort numeros, frecuencias

    mov ax, numeros[0]
    mov numeroAux, ax
endm

obtenerModa macro
    bubbleSort frecuencias, numeros

    mov bx, tamanioTabla
    dec bx
    shl bx, 1d
    
    mov ax, numeros[bx]
    mov numeroAux, ax ;moda 
    mov ax, frecuencias[bx]
    mov varAux, ax ;cantidad de veces que se repite
endm