%% Practica01AlonsoArturo
% Cambia el nombre del guión a Practica01tuapellidoNombre

% Arturo Alonso Carbonero


%% Paso 1

clear all; close all;
fichero='constitucion española.txt';
fid=fopen(fichero, 'r')
[words count]=fread(fid,inf,'*uint8');
fclose(fid)
histograma= histc(words,[0:255]);
subplot(1,2,1);
plot([0:255],histograma); axis('tight')
% si prefieres puedes usar la función bar
subplot(1,2,2); bar([0:255],histograma)


%% Paso 2

% A REALIZAR POR LOS ESTUDIANTES

% Crea la función entropiaTUSINICIALES(histograma)

% entropiaAAC(histograma)

%% Paso 3

H=entropiaAAC(histograma)

% Debe salirte 4.4880. 

%% Paso 4 

% A REALIZAR POR LOS ESTUDIANTES. RESPUESTA EN FICHERO PDF

% ¿Qué significa el valor de la entropía que has obtenido?. 
% ¿Cuál sería el factor de compresión que obtendríamos si usamos un modelo
% de codificación que alcanzase la entropía?. 
% ¿Podremos, a lo largo del curso, ganar a la entropía?

%% Paso 5

clear all; close all;
A=imread('camera.pgm');
% Mostramos la imagen camera.pgm
subplot(1,2,1); imshow(A);



%% Paso 6


histograma=histc(A(:),[0:255]);
bar([0:255],histograma)
entropiaAAC(histograma)

%% Paso 7

% A REALIZAR POR LOS ESTUDIANTES. RESPUESTA EN FICHERO PDF

% ¿Qué significa el valor de la entropía que has obtenido?. 
% ¿Cuál sería el factor de compresión que obtendríamos si usamos un modelo
% de codificación que alcanzase la entropía?. 


%% Paso 8

clear all; close all; 
A=uint8(zeros(256));
A(1:128,:)=uint8(180);
subplot(1,2,1); imshow(A)
histograma= histc(A(:),[0:255]);
subplot(1,2,2); bar([0:255],histograma)
H=entropiaAAC(histograma)

%% Paso 9

% A REALIZAR POR LOS ESTUDIANTES. RESPUESTA EN FICHERO PDF

% ¿Qué significa el valor de la entropía que has obtenido?. 
% ¿Cuál sería el factor de compresión que obtendríamos si usamos un modelo
% de codificación que alcanzase la entropía?. 
% ¿Podremos, a lo largo del curso, ganar a la entropía?



%% Paso 10

% A REALIZAR POR LOS ESTUDIANTES. RESPUESTA EN FICHERO PDF

% Si hicieras más grande (y luego más chico) el cuadrado blanco, 
% ¿qué le pasaría  a la entropía?
% ¿Cuánto valdría la entropía si toda la imagen fuera blanca o negra? 
% ¿Qué significaría el valor de la entropía obtenido en este caso?. 




%% Paso 11


clear all; close all;
fichero='camera.pgm'
fid=fopen(fichero, 'r')
words=fread(fid,inf,'*uint16');
fclose(fid)
histograma= histc(words,[0:256*256-1]);
bar([0:256*256-1],histograma), axis('tight')
H=entropiaAAC(histograma)




%% Paso 12

% A REALIZAR POR LOS ESTUDIANTES. INCLUYE TUS RESPUESTAS EN EL FICHERO PDF

% ¿Cuál es la entropía de esta fuente que codifica los símbolos de 
% camera.pgm de dos en dos?. 
% ¿Qué significa el valor de la entropía que has obtenido?. 

%% Paso 13

clear all; close all;
fichero='camera.pgm'
fid=fopen(fichero, 'r')
words=fread(fid,inf,'*uint8');
fclose(fid)
histograma= histc(words,[0:255]);
H=entropiaAAC(histograma)

%% Paso 14

% A REALIZAR POR LOS ESTUDIANTES. INCLUYE TUS RESPUESTAS EN EL FICHERO PDF

% Compara los valores de la entropía que has obtenido en los pasos 11 y 13. 
% ¿Qué está pasando? 


%% Paso 15

% A REALIZAR POR LOS ESTUDIANTES. INCLUYE TUS RESPUESTAS EN EL FICHERO PDF
% Y CÓDIGO AQUÍ

% Para los ficheros bird.pgm, ptt1.pbm, texto10000.txt, Cinco 
% semanas en globo - Julio Verne.txt crea una tabla con los nombres de los
% ficheros (filas) completa la siguiente tabla. ¿Qué significan los valores
% que obtienes?. Escribe el código correspondiente en el Paso 15 del fichero 
% Practica01ApellidoNombre (aqui).

clc; clear all;
clear all; close all;

N=9;
Fichero=cell(N);
Fichero{1}='bird.pgm';
Fichero{2}='ptt1.pbm';
Fichero{3}='texto10000.txt'
Fichero{4}='Cinco semanas en globo - Julio Verne.txt';

for i=1:4
    % Primer orden
    A=Fichero{i}; 
    fid=fopen(A, 'r');
    words=fread(fid,inf,'*uint8');
    fclose(fid);
    histograma= histc(words,[0:255]);
    H=entropiaAAC(histograma)
end

for i=1:4
    % Segundo orden
    fichero=Fichero{i};
    fid=fopen(fichero, 'r');
    words=fread(fid,inf,'*uint16');
    fclose(fid);
    histograma= histc(words,[0:256*256-1]);
    bar([0:256*256-1],histograma), axis('tight');
    H=entropiaAAC(histograma)
end


%% Paso 16 

clear all; close all;
A=imread('bird.pgm');

%% Paso 17

% A REALIZAR POR LOS ESTUDIANTES. INCLUYE CÓDIGO AQUÍ

%En el paso 17 del fichero Practica01ApellidoNombre.m escribe código para
%1.	Calcular  la entropía de la matriz que contiene la imagen. 
%2.	Calcular la diferencia de cada píxel con el anterior por filas.  
%    Es decir, vamos a calcular A(i,j)-A(i,j-1). No debes usar bucles y además
%    tienes que tener mucho cuidado con las diferencias ya que la diferencia 
%    de dos caracteres sin signo da un carácter sin signo y esto no es lo 
%    que queremos hacer. Para calcular la diferencia de la primera columna 
%    considera que la columna anterior es cero. 
%3.	Calcula también las diferencias módulo 256, es decir, 
%    (diferencias+256) módulo 256
%4.	Dibujar en una misma ventana la imagen de diferencias y su histograma. 
%5.	Dibujar también la imagen de (diferencias +256) módulo 256 y su histograma
%6.	Calcular la entropía de primer orden sobre la imagen de diferencias y 
%    sobre la imagen (diferencias +256) módulo 256 

%Nota 1: Ten cuidado con los tipos de datos cuando hagas diferencias 

%Nota 2: ¡Cuidado al calcular las diferencias! Para una imagen en escala de
%grises, las diferencias pueden estar en el intervalo [-255, 255] y por 
%tanto necesitamos al menos 9 bits para representarlas.  Esto no es 
%necesario en la imagen (diferencias +256) módulo 256

% Calcular el histograma de 0 a 255.
histograma=histc(A(:),[0:255]);
% bar([0:255],histograma);
entropiaAAC(histograma)

% Para calcular la diferencia de cada píxel con el anterior de la misma
% fila, se le resta al actual el de la columna anterior.
A2=zeros(size(A));
A2(1:end,2:end)=int16(A(1:end,2:end))-int16(A(1:end,1:end-1));
figure
subplot(1,2,1); imshow(A2, [-255,255])
histograma2=histc(A2(:),(-255:255));
subplot(1,2,2); bar([-255:255],histograma2);
entA2=entropiaAAC(histograma2)

% El módulo se aplica a A2, es decir, la matriz de diferencias.
Amod=zeros(size(A2));
Amod=mod((A2+256),256);
figure
subplot(1,2,1); imshow(Amod, [0,255])
histogramamod=histc(Amod(:),(0:255));
subplot(1,2,2); bar([0:255],histogramamod);
entMod=entropiaAAC(histogramamod)


%% Paso 18

% A REALIZAR POR LOS ESTUDIANTES. INCLUYE TUS RESPUESTAS EN EL FICHERO PDF

% 1.	Incluye los gráficos del paso 17 aquí
% 2.	¿Cuál son las entropías de la imagen original, de la imagen de 
%       diferencias y de la imagen (diferencias+256) módulo 256 ? 
% 3.	Compáralas y explica el resultado 
% 4.	Si hubiese codificado las diferencias usando 
%       (diferencias+256) módulo 256, ¿podrías con esta codificación de
%       las diferencias reconstruir la señal original?


%% Paso 19

% A REALIZAR POR LOS ESTUDIANTES. INCLUYE TUS RESPUESTAS EN EL FICHERO PDF

% Supongamos que tenemos una fuente que obtiene palabras de cuatro letras. 
% Supongamos además que las letras son generadas aleatoriamente suponiendo 
% una distribución uniforme sobre las 27 letras del abecedario. 
% ¿Cuántos bits necesitaríamos en media para representar cada palabra de 
% cuatro letras?.  





