graficarBarrasAsc macro
    local ciclo

    iniciarVideo
    bubbleSort frecuencias, numeros

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

        pintarBarraIndependiente frecuencias[bx]
        pintarNumeroEjeInferior numeros[bx]

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
    bubbleSort frecuencias, numeros
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

        pintarBarraIndependiente frecuencias[bx]
        pintarNumeroEjeInferior numeros[bx]

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
    bubbleSort numeros, frecuencias
    mov inicioBarra, 32d
    obtenerAnchoBarra

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

        pintarBarraIndependiente frecuencias[bx]
        pintarNumeroEjeInferior numeros[bx]

        inc iteradorI
        mov ax, iteradorI
        cmp ax, tamanioTabla
        jnz ciclo

    leerHastaEnter bufferTeclado
    call limpiarTerminal 
endm

graficaLinea macro
    local ciclo, final, normal

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
            mov ax, alturaDotIn
            mov alturaDotFin, ax
            mov ax, inicioDot
            inc ax
            mov finDot, ax

        normal:
            pintarLinea alturaDotIn, alturaDotFin, inicioDot, finDot, 1011b

        pintarNumeroEjeInferior numeros[bx]

        inc iteradorI
        mov ax, iteradorI
        cmp ax, tamanioTabla
        jnz ciclo

    leerHastaEnter bufferTeclado
    call limpiarTerminal 
endm

pintarBarraIndependiente macro frecuencia
    push ax
    push bx

    mov ax, frecuencia
    mov varAux, ax
    obtenerAltura varAux
    mov ax, inicioBarra
    add ax, ancho
    mov finBarra, ax
    pintarBarra inicioBarra, finBarra, altoBarra, 1011b
    mov ax, finBarra
    inc ax
    mov inicioBarra, ax

    pop bx
    pop ax
endm

pintarNumeroEjeInferior macro numero
    local ciclo

    mov ax, numero
    limpiarBuffer bufferVideo, "$"
    conversionAString bufferVideo
    modificarBuffer bufferVideo

    xor bx, bx
    xor dx, dx
    mov dx, 27d
    ciclo:
        mov al, bufferVideo[bx]
        mov bufferIndividual[0], al
        mov cx, inicioNumero
        mov ch, dl
        pintarTexto bufferIndividual, ch, cl
        inc dx
        inc bx
        cmp bx, 3d
        jnz ciclo

    mov ax, inicioNumero
    add ax, pasoNumero
    mov inicioNumero, ax
endm

; Este macro tambien devuelve la moda, ya que al obtener la frecuencia maxima
; quiere decir que es la que mas se repite por lo tanto es la moda
obtenerFrecuenciaMaxima macro
    bubbleSort frecuencias, numeros

    mov bx, tamanioTabla
    dec bx
    shl bx, 1d

    mov ax, frecuencias[bx]
    mov maximo, ax
    mov ax, numeros[bx]
    mov modaValor, ax
endm

pintarNumeroEjeIzquierdo macro porcentaje, fila, columna
    obtenerNumeroEjeIzquierdo porcentaje
    limpiarBuffer bufferVideo, "$"
    mov ax, varAux
    conversionAString bufferVideo
    modificarBuffer bufferVideo
    pintarTexto bufferVideo, fila, columna
endm

pintarBarra macro posIn, posFin, posAlto, colorPixel
    local ciclo, ciclo2

    push di
    push si

    mov si, posIn
    ciclo:
        mov di, posAlto
        ciclo2:
            pintarPixel di, si, colorPixel
            inc di
            cmp di, 425d
            jnz ciclo2
        inc si
        cmp si, posFin
        jnz ciclo

    pop si
    pop di
endm

pintarTexto macro texto, fila, columna
    push ax
    push bx
    push dx

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

    mov si, izq
    ciclo:
        pintarPixel aba, si, 0fh
        inc si
        cmp si, der
        jne ciclo

    mov si, arr
    ciclo2:
        pintarPixel si, izq, 0fh
        inc si
        cmp si, aba
        jne ciclo2

    pop si
endm

pintarLinea macro alturaIni, alturaFin, columnaIni, columnaFin, color
    local mayor, menor, igual, ciclo, ciclo2, ciclo3, ciclo4, ciclo5, ciclo6, ciclo7, fin

    push si
    push di

    mov si, alturaIni
    cmp si, alturaFin
    ja mayor

    cmp si, alturaFin
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
        ciclo2:
            pintarPixel di, si, color
            inc di
            inc si
            cmp si, columnaFin
            jnz ciclo2

        pintarPixel di, si, color

        cmp di, alturaFin
        jz fin
        jb ciclo3
        ja ciclo4

    mayor:
        mov si, columnaIni
        mov di, alturaIni
        ciclo5:
            pintarPixel di, si, color
            dec di
            inc si
            cmp si, columnaFin
            jnz ciclo5

        pintarPixel di, si, color

        cmp di, alturaFin
        jz fin
        ja ciclo4

    ciclo3:
        pintarPixel di, si, color
        inc di
        cmp di, alturaFin
        jbe ciclo3

    jmp fin

    ciclo4:
        pintarPixel di, si, color
        dec di
        cmp di, alturaFin
        jae ciclo4

    fin:
        pop di
        pop si
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

    cmp tamanioTabla, 76d
    jbe min

    min:
        cmp tamanioTabla, 38d
        jbe min2

        ;ancho = min , espacio = 1, espacioBarra = 1
        mov bx, 1d
        mov inicioNumero, 4d
        jmp fin

    min2:
        cmp tamanioTabla, 25d
        jbe min3

        ;ancho = (2 * min + 1), espacio = 2, espacioBarra = 2
        mov bx, 2d
        mov inicioNumero, 4d
        jmp fin

    min3:
        cmp tamanioTabla, 19d
        jbe min4

        ;ancho = (3 * min + 2), espacio = 3, espacioBarra = 3
        mov bx, 3d
        mov inicioNumero, 5d
        jmp fin

    min4:
        cmp tamanioTabla, 15d
        jbe min5

        ;ancho = (4 * min + 3), espacio = 4, espacioBarra = 4
        mov bx, 4d
        mov inicioNumero, 5d
        jmp fin

    min5:
        cmp tamanioTabla, 12d
        jbe min6

        ;ancho = (5 * min + 4), espacio = 5, espacioBarra = 5
        mov bx, 5d
        mov inicioNumero, 6d
        jmp fin

    min6:
        cmp tamanioTabla, 10d
        jbe min7

        ;ancho = (6 * min + 5), espacio = 6, espacioBarra = 6
        mov bx, 6d
        mov inicioNumero, 6d
        jmp fin
    
    min7:
        cmp tamanioTabla, 9d
        jbe min8

        ;ancho = (7 * min + 6), espacio = 7, espacioBarra = 7
        mov bx, 7d
        mov inicioNumero, 7d
        jmp fin

    min8:
        cmp tamanioTabla, 8d
        jbe min9

        ;ancho = (8 * min + 7), espacio = 8, espacioBarra = 8
        mov bx, 8d
        mov inicioNumero, 7d
        jmp fin

    min9:
        cmp tamanioTabla, 7d
        jbe min10

        ;ancho = (9 * min + 8), espacio = 9, espacioBarra = 9
        mov bx, 9d
        mov inicioNumero, 8d
        jmp fin

    min10:
        cmp tamanioTabla, 6d
        jbe min11

        ;ancho = (10 * min + 9), espacio = 10, espacioBarra = 10
        mov bx, 10d
        mov inicioNumero, 8d
        jmp fin

    min11:
        cmp tamanioTabla, 5d
        jbe min13

        ;ancho = (11 * min + 10), espacio = 11, espacioBarra = 11
        mov bx, 11d
        mov inicioNumero, 9d
        jmp fin

    min13:
        ;ancho = (15 * min + 14), espacio = 15, espacioBarra = 15
        mov bx, 15d
        mov inicioNumero, 11d

    fin:
        mov pasoNumero, bx
        mul bx
        dec bx
        add ax, bx
        mov ancho, ax

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
        mov bx, 1d
        jmp fin

    min2:
        cmp tamanioTabla, 25d
        jbe min3

        ;ancho = (2 * min)
        mov bx, 2d
        jmp fin

    min3:
        cmp tamanioTabla, 19d
        jbe min4

        ;ancho = (3 * min)
        mov bx, 3d
        jmp fin

    min4:
        cmp tamanioTabla, 15d
        jbe min5

        ;ancho = (4 * min)
        mov bx, 4d
        jmp fin

    min5:
        cmp tamanioTabla, 12d
        jbe min6

        ;ancho = (5 * min)
        mov bx, 5d
        jmp fin

    min6:
        cmp tamanioTabla, 10d
        jbe min7

        ;ancho = (6 * min)
        mov bx, 6d
        jmp fin
    
    min7:
        cmp tamanioTabla, 9d
        jbe min8

        ;ancho = (7 * min)
        mov bx, 7d
        jmp fin

    min8:
        cmp tamanioTabla, 8d
        jbe min9

        ;ancho = (8 * min)
        mov bx, 8d
        jmp fin

    min9:
        cmp tamanioTabla, 7d
        jbe min10

        ;ancho = (9 * min)
        mov bx, 9d
        jmp fin

    min10:
        cmp tamanioTabla, 6d
        jbe min11

        ;ancho = (10 * min)
        mov bx, 10d
        jmp fin

    min11:
        cmp tamanioTabla, 5d
        jbe min13

        ;ancho = (11 * min)
        mov bx, 11d
        jmp fin

    min13:
        ;ancho = (15 * min)
        mov bx, 15d

    fin:
        mul bx
        mov ancho, ax
        mov pasoNumero, bx
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

    ;(topPixel * porcentajeNumero) / 100 = res, porcentaje respecto a la cantidad maxima de pixeles
    mov ax, 425d
    mov bx, varAux
    mul bx
    dividir16 ax, 100d

    ;res - 425 = res2
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