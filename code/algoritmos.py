a = [14, 22, 99, 51, 55, 6, 1, 22, 999, 9, 10, 11, 13, 33, 16, 61, 17, 18, 19, 19, 19, 19, 19]
numero = []
frecuencia = []

def obtenerFrecuencias(arreglo):
    global numero, frecuencia
    nuevo = True
    pos = -1
    tamanio = 0

    for i in range(0, len(arreglo)):
        aux = arreglo[i]
        nuevo = True
        if aux != -1:
            for j in range(0, len(arreglo)):
                if aux == arreglo[j] and arreglo[j] != -1:
                    arreglo[j] = -1
                    if nuevo:
                        nuevo = False
                        numero.append(aux)
                        tamanio += 1
                        pos += 1
                        frecuencia.append(1)
                    else:
                        frecuencia[pos] += 1

def bubbleSort(arreglo):
    aux = 0
    for i in range(0, len(arreglo)-1):
        for j in range(0, len(arreglo)-1):
            if arreglo[j] > arreglo[j + 1]:
                aux = arreglo[j]
                arreglo[j] = arreglo[j + 1]
                arreglo[j + 1] = aux
    return arreglo