include macros.asm ;macros de uso general
include archivo.asm ;macros de manejo de archivos
include analisis.asm ;macros de analisis de xml
include estadi.asm ;macros de estadistica
include video.asm ;macros para mostrar las graficas
include reporte.asm ;macros para la creacion del reporte

.model small
.stack 100h
.data
    ;mensaje informativo
    info db "Arquitectura de computadores y ensambladores 1$"
    info2 db "Seccion A$"
    info3 db "Primer semestre 2021$"
    info4 db "Jose Carlos I Alonzo Colocho$"
    info5 db "201700965$"
    info6 db "Proyecto 2 assembler", "$"

    ;mensajes comando
    ingrese db "Ingrese un comando: $"
    bufferTeclado db 50 dup("$"), "$"
    comandoInvalido db "Comando invalido$"
    salidaConsola db "Salida> $"
    entradaConsola db "Entrada> $"
    cargarArchivo db "Debe cargar un archivo previamente$"

    ;uso general
    enterContinue db "Presione enter para continuar$"
    salto db 0ah, "$"
    espacio db " $"
    punto db ".$"
    varAux dw ?
    varAux2 dw 0
    varAux3 dw 0
    stringNumero db 5 dup("$"), "$"
    stringAuxiliar db "$", "$"

    ;archivo
    pathEntrada db 50 dup(00h), "$"
    extension db ".xml$"
    verificadorExtension db 4 dup("$"), "$"
    errorArchivo db 0
    mensajeExtension db "La extension del archivo no es la correcta :c$"
    mensajeError db "Error en la apertura del archivo :c$"
    mensajeErrorLectura db "Error en la lectura del archivo :c$"
    mensajeExitoArchivo db "Datos cargados exitosamente c:$"
    handle dw ?
    bufferArchivo db 30000 dup("$"), "$"
    banderaCargado db 0

    ;analisis
    numeroInicio db "numero$"
    numerosInicio db "numeros$"
    numeroFin db "/numero$"
    numerosFin db "/numeros$"
    bufferAcumulador db 10 dup("$"), "$"
    respaldoSI dw ?
    posicionArreglo dw ?
    numeroAux dw ?
    incremento dw ?

    ;arreglos
    arregloOriginal dw 1000 dup(-1), "$" ;arreglo de entrada
    arregloAuxiliar dw 1000 dup(-1), "$" ;arreglo de entrada para hacerle modificaciones
    numeros dw 100 dup(-1), "$" ; numeros de tabla de frecuencia
    frecuencias dw 100 dup(-1), "$" ;frecuencias de tabla de frecuencias

    ;estadisitca
    iteradorI dw 0
    iteradorJ dw 0
    tamanioTabla dw 0
    posicionAux dw 0
    banderaNuevo db 0
    modaMensaje db "Numero: $"
    noVeces db "No. veces: $"

    ;comandos validos
    cpromComando db "cprom$"
    cmedianaComando db "cmediana$"
    cmodaComando db "cmoda$"
    cmaxComando db "cmax$"
    cminComando db "cmin$"
    gbarraAscComando db "gbarra_asc$"
    gbarraDescComando db "gbarra_desc$"
    ghistComando db "ghist$"
    glineaComando db "glinea$"
    abrirComando db "abrir_$"
    limpiarComando db "limpiar$"
    reporteComando db "reporte$"
    infoComando db "info$"
    salirComando db "salir$"
    tamanioComando dw 0

    ;graficos
    ancho dw 0 ;ancho de la barra
    inicioBarra dw 0 ;posicion inicial de la barra
    finBarra dw 0 ;posicion final de la barra
    espacioBarra dw 0 ;espacio entre barras
    altoBarra dw 0 ;altura de la barra
    inicioNumero dw 0 ;posicion del numero perteneciente a la barra
    pasoNumero dw 0 ;espacio entre numeros
    maximo dw 0 ;fi maxima de la tabla de frecuencias
    bufferVideo db 3 dup("$"), "$" ;buffer para mostrar los numeros
    bufferIndividual db 1 dup("$"), "$" ;buffer para mostrar caracter por caracter
    inicioDot dw 0
    finDot dw 0
    alturaDotIn dw 0
    alturaDotFin dw 0

    ;reporte
    mediana db "Mediana: $"
    promedio db "Promedio: $"
    moda db "Moda: $"
    maximoReporte db "Maximo: $"
    minimoReporte db "Minimo: $"
    numeroReporte db "Numero$"
    frecuenciaReporte db "Frecuencia$"
    divisor db "|$"
    tope db "-$"
    mas db "+$"
    diagonal db "/$"
    dosPuntos db ":$"
    fecha db "Fecha: $"
    hora db "Hora: $"
    nombre db "Nombre: $"
    carnet db "Carnet: $"
    pathSalida db "01700965.txt", 00h
    creadoExito db "Reporte creado exitosamente c:$"
    dia db 0
    mes db 0
    anio dw 0
    horas db 0
    minutos db 0

.code
    start:
        main proc            
            imprimir entradaConsola, 15d
            leerHastaEnter bufferTeclado
            call analizarComando
            jmp start
        main endp

        analizarComando proc
            toLowerCase bufferTeclado
            call obtenerTamanio ;retorna el tamanio del comando ingresado

            compararCadenas salirComando, bufferTeclado, tamanioComando
            jz salirEtiqueta

            compararCadenas infoComando, bufferTeclado, tamanioComando
            jz infoEtiqueta

            compararCadenas limpiarComando, bufferTeclado, tamanioComando
            jz limpiarEtiqueta

            mov ax, lengthof abrirComando - 1
            compararCadenas abrirComando, bufferTeclado, ax
            jz abrirEtiqueta

            compararCadenas cmaxComando, bufferTeclado, tamanioComando
            jz cmaxEtiqueta

            compararCadenas cminComando, bufferTeclado, tamanioComando
            jz cminEtiqueta

            compararCadenas cmodaComando, bufferTeclado, tamanioComando
            jz cmodaEtiqueta

            compararCadenas cmedianaComando, bufferTeclado, tamanioComando
            jz cmedianaEtiqueta

            compararCadenas cpromComando, bufferTeclado, tamanioComando
            jz cpromEtiqueta

            compararCadenas gbarraAscComando, bufferTeclado, tamanioComando
            jz gbarraAscEtiqueta

            compararCadenas gbarraDescComando, bufferTeclado, tamanioComando
            jz gbarraDescEtiqueta

            compararCadenas glineaComando, bufferTeclado, tamanioComando
            jz glineaEtiqueta

            compararCadenas reporteComando, bufferTeclado, tamanioComando
            jz reporteEtiqueta

            compararCadenas ghistComando, bufferTeclado, tamanioComando
            jz ghistEtiqueta

            errorComando:
                imprimir salto, 0d
                imprimir salidaConsola, 12d
                imprimir comandoInvalido, 7d
                imprimir salto, 0d
                imprimir salto, 0d

                jmp finAnalizar

            noCargadoEtiqueta:
                imprimir salto, 0d
                imprimir salidaConsola, 12d
                imprimir cargarArchivo, 7d
                imprimir salto, 0d
                imprimir salto, 0d

                jmp finAnalizar

            sobrepasoCantidadNumeros:
                jmp finAnalizar

            sobrepasoFi:
                jmp finAnalizar

            ghistEtiqueta:
                cmp banderaCargado, 0d
                jz noCargadoEtiqueta

                graficarHistograma

                jmp finAnalizar

            reporteEtiqueta:
                cmp banderaCargado, 0d
                jz noCargadoEtiqueta

                crearReporte

                imprimir salto, 0d
                imprimir salidaConsola, 10d
                imprimir creadoExito, 7d
                imprimir salto, 0d
                imprimir salto, 0d
                jmp finAnalizar

                jmp finAnalizar

            glineaEtiqueta:
                cmp banderaCargado, 0d
                jz noCargadoEtiqueta

                graficaLinea

                jmp finAnalizar

            gbarraDescEtiqueta:
                cmp banderaCargado, 0d
                jz noCargadoEtiqueta

                graficarBarrasDesc

                bubbleSort numeros, frecuencias
                jmp finAnalizar

            gbarraAscEtiqueta:
                cmp banderaCargado, 0d
                jz noCargadoEtiqueta

                graficarBarrasAsc

                bubbleSort numeros, frecuencias
                jmp finAnalizar

            cpromEtiqueta:
                cmp banderaCargado, 0d
                jz noCargadoEtiqueta

                obtenerPromedio

                imprimir salto, 0d
                imprimir salidaConsola, 10d
                Print16 varAux
                imprimir punto, 7d
                Print16 numeroAux
                imprimir salto, 0d
                imprimir salto, 0d

                jmp finAnalizar

            cmedianaEtiqueta:
                cmp banderaCargado, 0d
                jz noCargadoEtiqueta

                obtenerMediana

                imprimir salto, 0d
                imprimir salidaConsola, 10d
                Print16 varAux
                imprimir punto, 7d
                Print16 numeroAux
                ;mov ax, numeroAux
                ;conversionAString bufferVideo
                ;imprimir bufferVideo, 7d
                imprimir salto, 0d
                imprimir salto, 0d

                jmp finAnalizar

            cmodaEtiqueta:
                cmp banderaCargado, 0d
                jz noCargadoEtiqueta

                obtenerModa

                imprimir salto, 0d
                imprimir salidaConsola, 10d
                imprimir modaMensaje, 7d
                Print16 numeroAux ;moda
                imprimir espacio, 0d
                imprimir noVeces, 7d
                Print16 varAux ;numeroVeces
                imprimir salto, 0d
                imprimir salto, 0d

                bubbleSort numeros, frecuencias
                jmp finAnalizar

            cmaxEtiqueta:
                cmp banderaCargado, 0d
                jz noCargadoEtiqueta

                obtenerMaximo

                imprimir salto, 0d
                imprimir salidaConsola, 10d
                Print16 numeroAux, 10d
                imprimir salto, 0d
                imprimir salto, 0d

                jmp finAnalizar

            cminEtiqueta:
                cmp banderaCargado, 0d
                jz noCargadoEtiqueta

                obtenerMinimo

                imprimir salto, 0d
                imprimir salidaConsola, 10d
                Print16 numeroAux, 10d
                imprimir salto, 0d
                imprimir salto, 0d

                jmp finAnalizar

            abrirEtiqueta:
                mov banderaCargado, 0d
                limpiarBuffer pathEntrada, 00h
                limpiarBuffer bufferArchivo, "$"

                call obtenerPath
                abrirArchivo pathEntrada, handle
                cmp errorArchivo, 1d
                jz finAnalizar

                mov errorArchivo, 0d
                leerArchivo handle, sizeof bufferArchivo, bufferArchivo
                cmp errorArchivo, 1d
                jz finAnalizar

                closeFile handle
                mov banderaCargado, 1d
                analizadorLexico bufferArchivo

                obtenerTablaDeFrecuencias

                obtenerFrecuenciaMaxima

                imprimir salto, 0d
                imprimir salidaConsola, 10d
                imprimir mensajeExitoArchivo, 7d
                imprimir salto, 0d
                imprimir salto, 0d

                jmp finAnalizar

            limpiarEtiqueta:
                call limpiarTerminal
                jmp finAnalizar

            salirEtiqueta:
                .exit

            infoEtiqueta:
                imprimir salto, 0d
                imprimir info, 15d
                imprimir salto, 0d
                imprimir info2, 15d
                imprimir salto, 0d
                imprimir info3, 15d
                imprimir salto, 0d
                imprimir info4, 15d
                imprimir salto, 0d
                imprimir info5, 15d
                imprimir salto, 0d
                imprimir info6, 15d
                imprimir salto, 0d
                imprimir salto, 0d

            finAnalizar:
                limpiarBuffer bufferTeclado, "$"
                ret
        analizarComando endp

        limpiarTerminal proc
            mov ax, 03h 
            int 10h
            ret
        limpiarTerminal endp

        obtenerPath proc
            xor bx, bx
            xor si, si
            mov bx, 6d

            cicloPath:
                cmp bufferTeclado[bx], "$"
                jz finObtenerPath
                mov cl, bufferTeclado[bx]
                mov pathEntrada[si], cl
                inc bx
                inc si
                jmp cicloPath

            finObtenerPath:
                ret
        obtenerPath endp

        obtenerTamanio proc
            xor bx, bx
            mov tamanioComando, 0d

            cicloTamanio:
                cmp bufferTeclado[bx], "$"
                jz finObtenerTamanio
                inc bx
                jmp cicloTamanio

            finObtenerTamanio:
                mov tamanioComando, bx
                ret
        obtenerTamanio  endp
    end start