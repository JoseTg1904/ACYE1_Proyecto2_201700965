crearReporte macro
    local ciclo

    createFile pathSalida
    abrirArchivoSinValidacion pathSalida, handle

    ;datos personales
    writeFile handle, nombre, sizeof nombre - 1
    writeFile handle, info4, sizeof info4 - 1
    writeFile handle, salto, sizeof salto - 1
    writeFile handle, carnet, sizeof carnet - 1
    writeFile handle, info5, sizeof info5 - 1
    writeFile handle, salto, sizeof salto - 1

    writeFile handle, salto, sizeof salto - 1

    ;fecha y hora
    writeFile handle, fecha, sizeof fecha - 1

    ;interrupcion para obtener fecha actual
    mov ah, 2ah
    int 21h
    mov dia, dl
    mov mes, dh
    mov anio, cx

    mov al, dia
    conversionAString bufferVideo
    modificarBuffer bufferVideo
    writeFile handle, bufferVideo[1], 1d
    writeFile handle, bufferVideo[2], 1d
    writeFile handle, diagonal, sizeof diagonal - 1
    mov al, mes
    conversionAString bufferVideo
    modificarBuffer bufferVideo
    writeFile handle, bufferVideo[1], 1d
    writeFile handle, bufferVideo[2], 1d
    writeFile handle, diagonal, sizeof diagonal - 1
    mov ax, anio
    conversionAString bufferAcumulador
    writeFile handle, bufferAcumulador, sizeof bufferAcumulador - 7
    writeFile handle, salto, sizeof salto - 1

    ;interrupcion para obtener hora actual
    mov ah, 2ch
    int 21h             
    mov horas, ch
    mov minutos, cl

    writeFile handle, hora, sizeof hora - 1
    mov al, horas
    conversionAString bufferVideo
    modificarBuffer bufferVideo
    writeFile handle, bufferVideo[1], 1d
    writeFile handle, bufferVideo[2], 1d
    writeFile handle, dosPuntos, sizeof dosPuntos - 1
    mov al, minutos
    conversionAString bufferVideo
    modificarBuffer bufferVideo
    writeFile handle, bufferVideo[1], 1d
    writeFile handle, bufferVideo[2], 1d
    writeFile handle, salto, sizeof salto - 1

    writeFile handle, salto, sizeof salto - 1

    ;mediana
    writeFile handle, mediana, sizeof mediana - 1
    obtenerMediana
    mov ax, varAux
    conversionAString bufferVideo
    modificarBuffer bufferVideo
    writeFile handle, bufferVideo, sizeof bufferVideo - 1
    writeFile handle, punto, sizeof punto - 1
    mov ax, numeroAux
    conversionAString bufferVideo
    modificarBuffer bufferVideo
    writeFile handle, bufferVideo, sizeof bufferVideo - 1

    writeFile handle, salto, sizeof salto - 1

    ;promedio
    writeFile handle, promedio, sizeof promedio - 1
    obtenerPromedio
    mov ax, varAux
    conversionAString bufferVideo
    modificarBuffer bufferVideo
    writeFile handle, bufferVideo, sizeof bufferVideo - 1
    writeFile handle, punto, sizeof punto - 1
    mov ax, numeroAux
    conversionAString bufferVideo
    modificarBuffer bufferVideo
    writeFile handle, bufferVideo, sizeof bufferVideo - 1

    writeFile handle, salto, sizeof salto - 1

    ;moda
    writeFile handle, moda, sizeof moda - 1
    mov ax, modaValor
    conversionAString bufferVideo
    modificarBuffer bufferVideo
    writeFile handle, bufferVideo, sizeof bufferVideo - 1

    writeFile handle, salto, sizeof salto - 1

    ;maximo
    writeFile handle, maximoReporte, sizeof maximoReporte - 1
    obtenerMaximo
    mov ax, numeroAux
    conversionAString bufferVideo
    modificarBuffer bufferVideo
    writeFile handle, bufferVideo, sizeof bufferVideo - 1

    writeFile handle, salto, sizeof salto - 1

    ;Minimo
    writeFile handle, minimoReporte, sizeof minimoReporte - 1
    obtenerMinimo
    mov ax, numeroAux
    conversionAString bufferVideo
    modificarBuffer bufferVideo
    writeFile handle, bufferVideo, sizeof bufferVideo - 1

    writeFile handle, salto, sizeof salto - 1
    writeFile handle, salto, sizeof salto - 1
    
    ;encabezado tabla
    escribirSeparador
    writeFile handle, salto, sizeof salto - 1
    writeFile handle, divisor, sizeof divisor - 1
    writeFile handle, espacio, sizeof espacio - 1
    writeFile handle, numeroReporte, sizeof numeroReporte - 1
    writeFile handle, espacio, sizeof espacio - 1
    writeFile handle, divisor, sizeof divisor - 1
    writeFile handle, espacio, sizeof espacio - 1
    writeFile handle, frecuenciaReporte, sizeof frecuenciaReporte - 1
    writeFile handle, espacio, sizeof espacio - 1
    writeFile handle, divisor, sizeof divisor - 1
    writeFile handle, salto, sizeof salto - 1
    escribirSeparador

    writeFile handle, salto, sizeof salto - 1
    
    bubbleSort numeros, frecuencias

    mov iteradorI, 0d
    ciclo:
        writeFile handle, divisor, sizeof divisor - 1

        escribirEspacios 2d

        mov bx, iteradorI
        shl bx, 1d
        mov ax, numeros[bx]
        conversionAString bufferVideo
        modificarBuffer bufferVideo
        writeFile handle, bufferVideo, sizeof bufferVideo - 1

        escribirEspacios 3d

        writeFile handle, divisor, sizeof divisor - 1

        escribirEspacios 4d

        mov bx, iteradorI
        shl bx, 1d
        mov ax, frecuencias[bx]
        conversionAString bufferVideo
        modificarBuffer bufferVideo
        writeFile handle, bufferVideo, sizeof bufferVideo - 1

        escribirEspacios 5d

        writeFile handle, divisor, sizeof divisor - 1

        writeFile handle, salto, sizeof salto - 1

        inc iteradorI
        mov ax, iteradorI
        cmp ax, tamanioTabla
        jnz ciclo

    escribirSeparador

    closeFile handle
endm

escribirEspacios macro veces
    local ciclo

    mov iteradorJ, 0d
    ciclo:
        writeFile handle, espacio, sizeof espacio - 1
        inc iteradorJ
        mov ax, iteradorJ
        cmp ax, veces
        jnz ciclo
endm

escribirSeparador macro
    local ciclo, ciclo2

    writeFile handle, mas, sizeof mas - 1

    mov iteradorI, 0d
    ciclo:
        writeFile handle, tope, sizeof tope - 1
        inc iteradorI
        cmp iteradorI, 8d
        jnz ciclo

    writeFile handle, mas, sizeof mas - 1

    mov iteradorI, 0d
    ciclo2:
        writeFile handle, tope, sizeof tope - 1
        inc iteradorI
        cmp iteradorI, 12d
        jnz ciclo2

    writeFile handle, mas, sizeof mas - 1
endm