# -*- coding: utf-8 -*-
"""pseudocodigo.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1q30uvOD7OwCm8Lyq7ITCpGzAC1dZBd-G
"""

unidades=int(0)
decimales1=int(0);
decimales2=int(0);
numerador=int(2)
denominador=int(9)
if numerador<denominador:
  numerador=numerador*10
  while(numerador >= denominador):
    decimales1=decimales1+1;
    numerador=numerador-denominador;
  decimales1=decimales1*10;
  if numerador>0:
    numerador=numerador*10
    while(numerador >= denominador):
      decimales1=decimales1+1;
      numerador=numerador-denominador;
else:
  while(numerador>=denominador):
    unidades=unidades+1;
    numerador=numerador-denominador;
  if numerador>0:
    numerador=numerador*10
    while(numerador >= denominador):
      decimales1=decimales1+1;
      numerador=numerador-denominador;
  if numerador>0:
    numerador=numerador*10
    while(numerador >= denominador):
      decimales2=decimales2+1;
      numerador=numerador-denominador;
print(str(unidades) + "." + str(decimales1) + str(decimales2))

final=0
inicio=1
datoy=[10,20,21]
datot=[32,1,23]
numdata=int(3)
resta=int(0)
cuadrado=int(0)
sumatoria=int(0)
if inicio==1:
  for i in range(0,numdata):
    resta=datoy[i]-datot[i]
    cuadrado=resta*resta
    sumatoria=sumatoria+cuadrado

print(str(sumatoria))