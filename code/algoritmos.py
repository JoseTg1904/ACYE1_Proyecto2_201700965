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
    print(tamanio)
    print(frecuencia)
    print(numero)

def bubbleSort(arreglo):
    aux = 0
    for i in range(0, len(arreglo)-1):
        for j in range(0, len(arreglo)-1):
            if arreglo[j] > arreglo[j + 1]:
                aux = arreglo[j]
                arreglo[j] = arreglo[j + 1]
                arreglo[j + 1] = aux
    print(arreglo)


ini = 35
d = 0
mini = 7
espacio = 1
barra = "pintarBarra "# 32d, 40d, 18d, 0111b 

while d <= 79:
    print(f"pintarBarra {ini}d, {ini+14}d, 18d, 0111b")
    ini += 15
    d += 1
#print(d)

d = 4
s = 0
while d <= 79:
    print(f"pintarTexto prueba6, 27d, {d}d")
    d += 2
    s += 1
#print(d)
#d = 4  
#numero.append(d)
#while d <= 79:
#    d += 8
#    numero.append(d)

#print(numero)
#print(len(numero))

#b = 1000000000000000000
#print(f"hola esto es la prueba de las comas {b:,}")
#for i in range(1, 77):
#    for j in range (0, 4):
#        print(f"<numero>{i}</numero>")
#import re


#a = "hola\nadios\n\r\tpero como te va \t"
#print(a)
#print(re.sub("\n|\t|\r", "", a))
#print(a)
e = 0
f = 0
g = 0
for i in range(1, e):
    f += g

print(f)