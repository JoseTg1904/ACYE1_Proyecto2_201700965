graficarBarrasAsc macro
    local ciclo

    iniciarVideo
    obtenerFrecuenciaMaxima

    mov inicioBarra, 32d
    obtenerAnchoBarra

    pintarNumeroEjeIzquierdo 100d, 1d, 0d
    pintarNumeroEjeIzquierdo 75d, 7d, 0d
    pintarNumeroEjeIzquierdo 50d, 13d, 0d
    pintarNumeroEjeIzquierdo 25d, 20d, 0d
    pintarNumeroEjeIzquierdo 0d, 26d, 0d
    pintarEjes 28d, 640d, 18d, 425d

    mov iteradorI, 0d
    ciclo:
        mov bx, iteradorI
        shl bx, 1d
        mov ax, frecuencias[bx]
        
        ;barra
        mov varAux, ax
        obtenerAltura varAux
        mov ax, inicioBarra
        add ax, ancho
        mov finBarra, ax
        pintarBarra inicioBarra, finBarra, altoBarra, 1011b
        mov ax, finBarra
        inc ax
        mov inicioBarra, ax

        ;digito
        mov bx, iteradorI
        shl bx, 1d
        mov ax, numeros[bx]
        limpiarBuffer bufferVideo, "$"
        conversionAString bufferVideo
        modificarBuffer bufferVideo
        mov cl, bufferVideo[0]
        mov bufferIndividual[0], cl
        xor cx, cx
        mov cx, inicioNumero
        pintarTexto bufferIndividual, 27d, cl
        mov cl, bufferVideo[1]
        mov bufferIndividual[0], cl
        xor cx, cx
        mov cx, inicioNumero
        pintarTexto bufferIndividual, 28d, cl
        mov cl, bufferVideo[2]
        mov bufferIndividual[0], cl
        xor cx, cx
        mov cx, inicioNumero
        pintarTexto bufferIndividual, 29d, cl

        mov ax, inicioNumero
        add ax, espacioBarra
        mov inicioNumero, ax

        inc iteradorI
        mov ax, iteradorI
        cmp ax, tamanioTabla
        jnz ciclo

    leerHastaEnter bufferTeclado
    call limpiarTerminal 
endm

graficarBarrasDesc macro
    local ciclo

    iniciarVideo
    obtenerFrecuenciaMaxima
    mov inicioBarra, 32d
    obtenerAnchoBarra

    ;numeros del eje izquierdo
    pintarNumeroEjeIzquierdo 100d, 1d, 0d
    pintarNumeroEjeIzquierdo 75d, 7d, 0d
    pintarNumeroEjeIzquierdo 50d, 13d, 0d
    pintarNumeroEjeIzquierdo 25d, 20d, 0d
    pintarNumeroEjeIzquierdo 0d, 26d, 0d

    pintarEjes 28d, 640d, 18d, 425d ;izquierda, derecha, arriba, abajo
    
    mov ax, tamanioTabla
    mov iteradorI, ax
    dec iteradorI
    ciclo:
        mov bx, iteradorI
        shl bx, 1d
        mov ax, frecuencias[bx]
        
        ;barra
        mov varAux, ax
        obtenerAltura varAux
        mov ax, inicioBarra
        add ax, ancho
        mov finBarra, ax
        pintarBarra inicioBarra, finBarra, altoBarra, 1011b
        mov ax, finBarra
        inc ax
        mov inicioBarra, ax

        ;digito
        mov ax, numeros[bx]
        limpiarBuffer bufferVideo, "$"
        conversionAString bufferVideo
        modificarBuffer bufferVideo
        mov cl, bufferVideo[0]
        mov bufferIndividual[0], cl
        xor cx, cx
        mov cx, inicioNumero
        pintarTexto bufferIndividual, 27d, cl
        mov cl, bufferVideo[1]
        mov bufferIndividual[0], cl

        xor cx, cx
        mov cx, inicioNumero
        pintarTexto bufferIndividual, 28d, cl
        mov cl, bufferVideo[2]
        mov bufferIndividual[0], cl
        xor cx, cx
        mov cx, inicioNumero
        pintarTexto bufferIndividual, 29d, cl

        mov ax, inicioNumero
        add ax, espacioBarra
        mov inicioNumero, ax

        dec iteradorI
        mov ax, iteradorI
        cmp ax, -1
        jnz ciclo

    leerHastaEnter bufferTeclado
    call limpiarTerminal 
endm

graficarHistograma macro
    local ciclo

    iniciarVideo
    obtenerFrecuenciaMaxima
    mov inicioBarra, 32d
    obtenerAnchoBarra

    bubbleSort numeros, frecuencias

    pintarNumeroEjeIzquierdo 100d, 1d, 0d
    pintarNumeroEjeIzquierdo 75d, 7d, 0d
    pintarNumeroEjeIzquierdo 50d, 13d, 0d
    pintarNumeroEjeIzquierdo 25d, 20d, 0d
    pintarNumeroEjeIzquierdo 0d, 26d, 0d
    pintarEjes 28d, 640d, 18d, 425d ;izquierda, derecha, arriba, abajo

    mov iteradorI, 0d
    ciclo:
        mov bx, iteradorI
        shl bx, 1d
        mov ax, frecuencias[bx]
        
        ;barra
        mov varAux, ax
        obtenerAltura varAux
        mov ax, inicioBarra
        add ax, ancho
        mov finBarra, ax
        pintarBarra inicioBarra, finBarra, altoBarra, 1011b
        mov ax, finBarra
        inc ax
        mov inicioBarra, ax

        ;digito
        mov bx, iteradorI
        shl bx, 1d
        mov ax, numeros[bx]
        limpiarBuffer bufferVideo, "$"
        conversionAString bufferVideo
        modificarBuffer bufferVideo
        mov cl, bufferVideo[0]
        mov bufferIndividual[0], cl
        xor cx, cx
        mov cx, inicioNumero
        pintarTexto bufferIndividual, 27d, cl
        mov cl, bufferVideo[1]
        mov bufferIndividual[0], cl
        xor cx, cx
        mov cx, inicioNumero
        pintarTexto bufferIndividual, 28d, cl
        mov cl, bufferVideo[2]
        mov bufferIndividual[0], cl
        xor cx, cx
        mov cx, inicioNumero
        pintarTexto bufferIndividual, 29d, cl

        mov ax, inicioNumero
        add ax, espacioBarra
        mov inicioNumero, ax

        inc iteradorI
        mov ax, iteradorI
        cmp ax, tamanioTabla
        jnz ciclo

    leerHastaEnter bufferTeclado
    call limpiarTerminal 
endm

obtenerFrecuenciaMaxima macro
    bubbleSort frecuencias, numeros

    mov bx, tamanioTabla
    dec bx
    shl bx, 1d

    mov ax, frecuencias[bx]
    mov maximo, ax
endm

pintarNumeroEjeIzquierdo macro porcentaje, fila, columna
    obtenerNumeroEjeIzquierdo porcentaje
    limpiarBuffer bufferVideo, "$"
    mov ax, varAux
    conversionAString bufferVideo
    modificarBuffer bufferVideo
    pintarTexto bufferVideo, fila, columna
endm

graficaLinea macro
    local ciclo, final, normal

    obtenerFrecuenciaMaxima

    bubbleSort numeros, frecuencias
    iniciarVideo
    mov inicioBarra, 35d
    mov inicioNumero, 4d
    obtenerEspaciadoLinea

    pintarNumeroEjeIzquierdo 100d, 1d, 0d
    pintarNumeroEjeIzquierdo 75d, 7d, 0d
    pintarNumeroEjeIzquierdo 50d, 13d, 0d
    pintarNumeroEjeIzquierdo 25d, 20d, 0d
    pintarNumeroEjeIzquierdo 0d, 26d, 0d
    pintarEjes 28d, 640d, 18d, 425d ;izquierda, derecha, arriba, abajo

    mov iteradorI, 0d
    ciclo:
        mov bx, iteradorI
        mov iteradorJ, bx
        inc iteradorJ
        shl bx, 1d
        mov ax, frecuencias[bx]

        mov varAux, ax
        obtenerAltura varAux
        mov ax, altoBarra
        mov alturaDotIn, ax

        mov ax, inicioBarra
        mov inicioDot, ax
        add ax, 1d
        mov finBarra, ax

        pintarBarra inicioBarra, finBarra, altoBarra, 0111b

        push bx
        mov bx, iteradorJ
        shl bx, 1d
        mov ax, frecuencias[bx]
        mov varAux, ax
        obtenerAltura varAux
        mov ax, altoBarra
        mov alturaDotFin, ax
        pop bx

        mov ax, inicioBarra
        add ax, ancho
        mov inicioBarra, ax
        mov finDot, ax

        mov ax, tamanioTabla
        dec ax
        cmp iteradorI, ax
        jz final
        jmp normal

        final:
            mov alturaDotFin, 425d
            mov ax, inicioDot
            inc ax
            mov finDot, ax

        normal:
            pintarLinea alturaDotIn, alturaDotFin, inicioDot, finDot, 1011b

        ;digito
        mov ax, numeros[bx]
        limpiarBuffer bufferVideo, "$"
        conversionAString bufferVideo
        modificarBuffer bufferVideo
        mov cl, bufferVideo[0]
        mov bufferIndividual[0], cl
        xor cx, cx
        mov cx, inicioNumero
        pintarTexto bufferIndividual, 27d, cl
        mov cl, bufferVideo[1]
        mov bufferIndividual[0], cl

        xor cx, cx
        mov cx, inicioNumero
        pintarTexto bufferIndividual, 28d, cl
        mov cl, bufferVideo[2]
        mov bufferIndividual[0], cl
        xor cx, cx
        mov cx, inicioNumero
        pintarTexto bufferIndividual, 29d, cl

        mov ax, inicioNumero
        add ax, pasoNumero
        mov inicioNumero, ax

        inc iteradorI
        mov ax, iteradorI
        cmp ax, tamanioTabla
        jnz ciclo

    leerHastaEnter bufferTeclado
    call limpiarTerminal 
endm

pintarBarra macro posIn, posFin, posAlto, colorPixel
    local ciclo, ciclo2

    push di
    push si

    xor si, si
    mov si, posIn

    ciclo:
        xor di, di
        mov di, posAlto
        ciclo2:
            pintarPixel di, si, colorPixel
            inc di
            cmp di, 425d
            jnz ciclo2
        inc si
        cmp si, posFin
        jne ciclo

    pop si
    pop di
endm

pintarTexto macro texto, fila, columna
    push ax
    push bx
    push dx

    xor ax, ax
    xor bx, bx
    xor dx, dx

    mov ah, 02h
    mov bh, 00h
    mov dh, fila
    mov dl, columna
    int 10h
    imprimir texto, 0110b

    pop dx
    pop bx
    pop ax
endm

pintarEjes macro izq, der, arr, aba
    local ciclo, ciclo2

    push si
    push cx
    
    xor cx, cx
    xor si, si
    mov si, izq

    ciclo:
        pintarPixel aba, si, 0fh
        inc si
        cmp si, der
        jne ciclo

    xor si, si
    mov si, arr

    ciclo2:
        pintarPixel si, izq, 0fh
        inc si
        cmp si, aba
        jne ciclo2

    pop cx
    pop si
endm

pintarLinea macro alturaIni, alturaFin, columnaIni, columnaFin, color
    local mayor, menor, igual, ciclo, ciclo2, ciclo3, ciclo4, ciclo5, fin

    push ax
    push cx
    push bx
    push si
    push di

    mov ax, alturaIni
    cmp ax, alturaFin
    jz igual

    mov ax, alturaIni
    cmp ax, alturaFin
    ja mayor

    mov ax, alturaIni
    cmp ax, alturaFin
    jb menor

    igual:
        mov si, columnaIni
        ciclo:
            pintarPixel alturaIni, si, color
            inc si
            cmp si, columnaFin
            jnz ciclo

        jmp fin

    menor:
        mov si, columnaIni
        mov di, alturaIni
        mov ax, columnaFin
        sub ax, 2d
        ciclo2:
            pintarPixel di, si, color
            inc di
            inc si
            cmp si, ax
            jb ciclo2

        mov respaldoSi, si
        mov numeroAux, di
        
        mov si, columnaIni
        mov ax, columnaFin
        sub ax, si
        mov varAux, ax ;delta columna

        mov di, alturaIni
        mov ax, alturaFin
        sub ax, di ;delta fila
        
        cmp ax, varAux
        jz fin

        mov si, respaldoSi
        mov di, numeroAux

        dec si
        dec di
        
        mov ax, alturaFin
        sub ax, 2d
        ciclo3:
            pintarPixel di, si, color
            inc di
            cmp di, ax
            jb ciclo3

        inc si
        inc di
        pintarPixel di, si, color

        inc si
        inc di
        pintarPixel di, si, color

        jmp fin

    mayor:
        mov si, columnaIni
        mov di, alturaIni
        mov ax, columnaFin
        sub ax, 2d
        ciclo4:
            pintarPixel di, si, color
            dec di
            inc si
            cmp si, ax
            jb ciclo4

        mov respaldoSi, si
        mov numeroAux, di

        mov si, columnaIni
        mov ax, columnaFin
        sub ax, si
        mov varAux, ax ;delta columna

        mov di, alturaIni
        mov ax, alturaFin
        sub ax, di ;delta fila
        
        cmp ax, varAux
        jz fin

        mov si, respaldoSi
        mov di, numeroAux

        dec si
        inc di

        mov ax, alturaFin
        sub ax, 2d
        ciclo5:
            pintarPixel di, si, color
            dec di
            cmp di, ax
            ja ciclo5

        inc si
        inc di
        pintarPixel di, si, color

        inc si
        inc di
        pintarPixel di, si, color

    fin:
        pop di
        pop si
        pop bx
        pop cx
        pop ax
endm

pintarPixel macro posY, posX, colorPixel
    push ax
    push bx
    push cx
    push dx

    mov ah, 0ch
    mov al, colorPixel
    mov bh, 00h
    mov cx, posX
    mov dx, posY
    int 10h

    pop dx
    pop cx
    pop bx
    pop ax
endm

iniciarVideo macro
    push ax
    mov ax, 0012h
    int 10h
    pop ax
endm

obtenerAnchoBarra macro
    local min, min2, min3, min4, min5, min6, min7, min8, min9, min10, min11, min13, fin

    push ax
    push bx

    mov ax, 7d ;ancho minimo de la barra

    ;aqui un error de que son muchos numeros

    cmp tamanioTabla, 76d
    jbe min

    min:
        cmp tamanioTabla, 38d
        jbe min2

        ;ancho = min , espacio = 1, espacioBarra = 1
        mov ancho, ax
        mov pasoNumero, 1d
        mov inicioNumero, 4d
        mov espacioBarra, 1d
        jmp fin

    min2:
        cmp tamanioTabla, 25d
        jbe min3

        ;ancho = (2 * min + 1), espacio = 2, espacioBarra = 2
        mov bx, 2d
        mul bx
        inc ax
        mov ancho, ax
        mov pasoNumero, 2d
        mov inicioNumero, 4d
        mov espacioBarra, 2d
        jmp fin

    min3:
        cmp tamanioTabla, 19d
        jbe min4

        ;ancho = (3 * min + 2), espacio = 3, espacioBarra = 3
        mov bx, 3d
        mul bx
        add ax, 2d
        mov ancho, ax
        mov pasoNumero, 3d
        mov inicioNumero, 5d
        mov espacioBarra, 3d
        jmp fin

    min4:
        cmp tamanioTabla, 15d
        jbe min5

        ;ancho = (4 * min + 3), espacio = 4, espacioBarra = 4
        mov bx, 4d
        mul bx
        add ax, 3d
        mov ancho, ax
        mov pasoNumero, 4d
        mov inicioNumero, 5d
        mov espacioBarra, 4d
        jmp fin

    min5:
        cmp tamanioTabla, 12d
        jbe min6

        ;ancho = (5 * min + 4), espacio = 5, espacioBarra = 5
        mov bx, 5d
        mul bx
        add ax, 4d
        mov ancho, ax
        mov pasoNumero, 5d
        mov inicioNumero, 6d
        mov espacioBarra, 5d
        jmp fin

    min6:
        cmp tamanioTabla, 10d
        jbe min7

        ;ancho = (6 * min + 5), espacio = 6, espacioBarra = 6
        mov bx, 6d
        mul bx
        add ax, 5d
        mov ancho, ax
        mov pasoNumero, 6d
        mov inicioNumero, 6d
        mov espacioBarra, 6d
        jmp fin
    
    min7:
        cmp tamanioTabla, 9d
        jbe min8

        ;ancho = (7 * min + 6), espacio = 7, espacioBarra = 7
        mov bx, 7d
        mul bx
        add ax, 6d
        mov ancho, ax
        mov pasoNumero, 7d
        mov inicioNumero, 7d
        mov espacioBarra, 7d
        jmp fin

    min8:
        cmp tamanioTabla, 8d
        jbe min9

        ;ancho = (8 * min + 7), espacio = 8, espacioBarra = 8
        mov bx, 8d
        mul bx
        add ax, 7d
        mov ancho, ax
        mov pasoNumero, 8d
        mov inicioNumero, 7d
        mov espacioBarra, 8d
        jmp fin

    min9:
        cmp tamanioTabla, 7d
        jbe min10

        ;ancho = (9 * min + 8), espacio = 9, espacioBarra = 9
        mov bx, 9d
        mul bx
        add ax, 8d
        mov ancho, ax
        mov pasoNumero, 9d
        mov espacioBarra, 9d
        mov inicioNumero, 8d
        jmp fin

    min10:
        cmp tamanioTabla, 6d
        jbe min11

        ;ancho = (10 * min + 9), espacio = 10, espacioBarra = 10
        mov bx, 10d
        mul bx
        add ax, 9d
        mov ancho, ax
        mov pasoNumero, 10d
        mov espacioBarra, 10d
        mov inicioNumero, 8d
        jmp fin

    min11:
        cmp tamanioTabla, 5d
        jbe min13

        ;ancho = (11 * min + 10), espacio = 11, espacioBarra = 11
        mov bx, 11d
        mul bx
        add ax, 10d
        mov ancho, ax
        mov pasoNumero, 11d
        mov espacioBarra, 11d
        mov inicioNumero, 9d
        jmp fin

    min13:
        ;ancho = (15 * min + 14), espacio = 15, espacioBarra = 15
        mov bx, 15d
        mul bx
        add ax, 14d
        mov ancho, ax
        mov pasoNumero, 15d
        mov espacioBarra, 15d
        mov inicioNumero, 11d

    fin:
        pop bx
        pop ax
endm

obtenerEspaciadoLinea macro
    local min, min2, min3, min4, min5, min6, min7, min8, min9, min10, min11, min13, fin

    push ax
    push bx

    mov ax, 8d ;ancho minimo de la barra

    cmp tamanioTabla, 76d
    jbe min

    min:
        cmp tamanioTabla, 38d
        jbe min2

        ;ancho = min , espacio = 1, espacioBarra = 1
        mov ancho, ax
        mov pasoNumero, 1d
        jmp fin

    min2:
        cmp tamanioTabla, 25d
        jbe min3

        ;ancho = (2 * min)
        mov bx, 2d
        mul bx
        mov ancho, ax
        mov pasoNumero, 2d
        jmp fin

    min3:
        cmp tamanioTabla, 19d
        jbe min4

        ;ancho = (3 * min)
        mov bx, 3d
        mul bx
        mov ancho, ax
        mov pasoNumero, 3d
        jmp fin

    min4:
        cmp tamanioTabla, 15d
        jbe min5

        ;ancho = (4 * min)
        mov bx, 4d
        mul bx
        mov ancho, ax
        mov pasoNumero, 4d
        jmp fin

    min5:
        cmp tamanioTabla, 12d
        jbe min6

        ;ancho = (5 * min)
        mov bx, 5d
        mul bx
        mov ancho, ax
        mov pasoNumero, 5d
        jmp fin

    min6:
        cmp tamanioTabla, 10d
        jbe min7

        ;ancho = (6 * min)
        mov bx, 6d
        mul bx
        mov ancho, ax
        mov pasoNumero, 6d
        jmp fin
    
    min7:
        cmp tamanioTabla, 9d
        jbe min8

        ;ancho = (7 * min)
        mov bx, 7d
        mul bx
        mov ancho, ax
        mov pasoNumero, 7d
        jmp fin

    min8:
        cmp tamanioTabla, 8d
        jbe min9

        ;ancho = (8 * min)
        mov bx, 8d
        mul bx
        mov ancho, ax
        mov pasoNumero, 8d
        jmp fin

    min9:
        cmp tamanioTabla, 7d
        jbe min10

        ;ancho = (9 * min)
        mov bx, 9d
        mul bx
        mov ancho, ax
        mov pasoNumero, 9d
        jmp fin

    min10:
        cmp tamanioTabla, 6d
        jbe min11

        ;ancho = (10 * min)
        mov bx, 10d
        mul bx
        mov ancho, ax
        mov pasoNumero, 10d
        jmp fin

    min11:
        cmp tamanioTabla, 5d
        jbe min13

        ;ancho = (11 * min)
        mov bx, 11d
        mul bx
        mov ancho, ax
        mov pasoNumero, 11d
        jmp fin

    min13:
        ;ancho = (15 * min)
        mov bx, 15d
        mul bx
        mov ancho, ax
        mov pasoNumero, 15d

    fin:
        pop bx
        pop ax
endm

obtenerAltura macro buscar
    local mayor, continue

    push ax
    push bx

    ;(fi a buscar * 100) / fi Maxima = res, porcentaje respecto al numero maximo
    mov ax, 100d
    mov bx, buscar
    mul bx   
    dividir16 ax, maximo

    ;porcentaje respecto a la cantidad maxima de pixeles
    mov ax, 425d
    mov bx, varAux
    mul bx
    dividir16 ax, 100d

    ;425 - res = res2
    mov ax, varAux
    mov bx, 425d ;este es el tope inferior de mis "ejes"
    sub bx, ax

    ;alturaBarra = res2 + 18
    mov ax, 18d ;este es el tope superior de mis "ejes"
    add ax, bx
    mov altoBarra, ax

    cmp ax, 425d ;validacion para la altura de grafica de barras
    jae mayor
    jmp continue

    mayor:
        mov altoBarra, 424d

    continue:
        pop bx
        pop ax
endm

modificarBuffer macro buffer
    local uno, dos, fin

    push ax

    cmp buffer[1], "$"
    jz uno

    cmp buffer[2], "$"
    jz dos

    jmp fin

    uno:
        mov al, buffer[0]
        mov buffer[0], "0"
        mov buffer[1], "0"
        mov buffer[2], al
        jmp fin

    dos:
        mov al, buffer[0]
        mov ah, buffer[1]
        mov buffer[0], "0"
        mov buffer[1], al
        mov buffer[2], ah
        jmp fin

    fin:
        pop ax
endm

obtenerNumeroEjeIzquierdo macro porcentaje
    push ax
    push bx

    mov ax, porcentaje
    mov bx, maximo
    mul bx

    dividir16 ax, 100d

    pop bx
    pop ax
endm

;el 12h tiene (0 - 29) 30 filas y (0 - 79) 80 columnas
;fi maximo entre (4 - 655), (4 - 79) 76 numeros diferentes max