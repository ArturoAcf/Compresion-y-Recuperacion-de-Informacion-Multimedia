%% Practica04AlonsoArturo
% Cambia el nombre del gui�n a Practica04tuapellidonombre

% Arturo Alonso Carbonero
% Tiempo: Incluye aqu� el tiempo dedicado a realizar el guion

%% Paso 1. Entregar discusi�n en pdf

% Al observar las curvas anteriores surge una pregunta, �es posible que 
% las l�neas roja y verde de la segunda figura y la roja de la primera �
% no sean c�ncavas?. �Si es posible, qu� indican?. Escribe y justifica 
% tu respuesta en el paso 1 de Practica04ApellidoNombre.pdf.

%% Paso 2. Escribir c�digo aqu�

% En el paso 2 de Practica04ApellidoNombre.m escribe c�digo Matlab para:
% �	leer la imagen sin comprimir bird.pgm, 

clear all; close all; clc;
A=imread('bird.pgm');
fidO=fopen('bird.pgm','r');
seqO=fread(fidO,'*uint8');
fclose(fidO);

% �	salvar la imagen bird.pgm  usando JPEG variando el factor de calidad 
%   desde 5 a 100 en pasos de 5 (ver manual de imwrite). Llama a las im�genes
%   comprimidas birdx.jpeg con x=5,10,15,20,� 100.
% �	mostrar en una ventana las 20 im�genes obtenidas.

figure
for x=5:5:100
    filename=sprintf('bird%d.jpeg',x);
    imwrite(A,filename,"Quality",x);
    i=imread(filename);
    subplot(5,4,x/5); imshow(i)
end

%% Paso 3. Respuesta en pdf

% Incluye en el paso 3 de Practica04ApellidoNombre.pdf la ventana que 
% contiene las 20 im�genes. Exam�nalas con detenimiento y comenta 
% brevemente su calidad.

%% Paso 4. Incluye c�digo en Matlab

close all; clc;

%En el paso 4 de Practica04ApellidoNombre.m escribe c�digo Matlab para:

%1)	calcular el espacio que ocupa en bits cada 8 bits del fichero original 
%   para cada fichero comprimido birdx.jpeg con x? {5,10,15,�,100}. 
%   Es decir, calcula la tasa.

distorsion_jpeg=zeros(1,20,"double");
tasa_jpeg=zeros(1,10,"double");
% entropia=zeros(1,20,"double");

for x=5:5:100 
    filename=sprintf('bird%d.jpeg',x);
    fid=fopen(filename,'r');
    seq=fread(fid,'*uint8');
    i=imread(filename);
    fclose(fid);
    seq=reshape(seq,1,length(seq));
    tasa_jpeg(x/5)=numel(seq)*8/numel(A);
    error=double(A)-double(i);
    error2=error.*error;
    suma=sum(error2(:));
    distorsion_jpeg(x/5)=(suma/numel(A));
    
    % k=2^(x/5);
    % iq=uint8(floor(double(i)/k));
    % [histograma,bin]=hist(i(:),[0:255]);
    % prob=histograma/sum(histograma(:));
    % positivos=prob(histograma>0.0);
    % entropia(x/5)=-sum(positivos.*log2(positivos));
    
    fprintf('Tama�o de %s: %d\n',filename,numel(seq))
    fprintf('Tasa de %s: %d\n',filename,tasa_jpeg(x/5))
    fprintf('Distorsi�n de %s: %d\n',filename,distorsion_jpeg(x/5))
    fprintf('\n\n')
end
    
%2) calcular la distorsi�n como error cuadr�tico medio entre las im�genes 
%   en bird.pgm y birdx.jpeg, x=5, 10, 15, 20,�,100.
%3) representar los puntos tasa/distorsi�n obtenidos.

figure; 
plot(distorsion_jpeg,tasa_jpeg,'*'); hold on;
% plot(distorsion,entropia,'+'); legend('Uniforme','Entropia')
xlabel('Distorsion','FontSize',15);
ylabel('Tasa','FontSize',15);
set(gca,'LineWidth',2,'box','off');

% Te ser� de utilidad la funci�n dir.


%% Paso 5. Incluye respuesta en pdf

%   Completa en el paso 5 de Practica04ApellidoNombre.pdf la siguiente tabla e
%   incluye la curva tasa/distorsi�n que has obtenido en el
%   paso anterior.


%% Paso 6. Incluye c�digo Matlab

close all; clc;
A=imread('bird.pgm');
fidO=fopen('bird.pgm','r');
seqO=fread(fidO,'*uint8');
fclose(fidO);

figure
for x=2:2:40
    filename=sprintf('bird%d.jp2',x);
    imwrite(A,filename,'CompressionRatio',x);
    i=imread(filename);
    subplot(5,4,x/2); imshow(i)
end

% En el paso 6 de Practica04ApellidoNombre.m escribe c�digo Matlab para:
%1) salvar la imagen bird.pgm  usando JPEG2000 variando el factor de 
%   compresi�n �CompressionRatio� en x? {40, 38, 36, 34, �, 6, 4 ,2}. 
%   Llama a las im�genes comprimidas birdx.jp2 con x? {40, 38, 36, 34, �, 6, 4 ,2}.
%2) mostrar en una ventana las 20 im�genes obtenidas.

 
%% Paso 7. Incluye respuesta en fichero pdf

% Incluye en el paso 7 de Practica04ApellidoNombre.pdf la ventana que 
% contiene las 20 im�genes. Exam�nalas con detenimiento y comenta 
% brevemente su calidad.

%% Paso 8. Incluye c�digo Matlab

close all; clc;

distorsion_jp2=zeros(1,20,"double");
tasa_jp2=zeros(1,10,"double");
% entropia=zeros(1,20,"double");

for x=2:2:40 
    filename=sprintf('bird%d.jp2',x);
    fid=fopen(filename,'r');
    seq=fread(fid,'*uint8');
    i=imread(filename);
    fclose(fid);
    seq=reshape(seq,1,length(seq));
    tasa_jp2(x/2)=numel(seq)*8/numel(A);
    error=double(A)-double(i);
    error2=error.*error;
    suma=sum(error2(:));
    distorsion_jp2(x/2)=(suma/numel(A));
    
    % k=2^(x/5);
    % iq=uint8(floor(double(i)/k));
    % [histograma,bin]=hist(i(:),[0:255]);
    % prob=histograma/sum(histograma(:));
    % positivos=prob(histograma>0.0);
    % entropia(x/5)=-sum(positivos.*log2(positivos));
    
    fprintf('Tama�o de %s: %d\n',filename,numel(seq))
    fprintf('Tasa de %s: %d\n',filename,tasa_jp2(x/2))
    fprintf('Distorsi�n de %s: %d\n',filename,distorsion_jp2(x/2))
    fprintf('\n\n')
end

figure; 
plot(distorsion_jp2,tasa_jp2,'*'); hold on;
% plot(distorsion,entropia,'+'); legend('Uniforme','Entropia')
xlabel('Distorsion','FontSize',15);
ylabel('Tasa','FontSize',15);
set(gca,'LineWidth',2,'box','off');

% En el paso 8 de Practica04ApellidoNombre.m escribe c�digo Matlab para:

%1) calcular el espacio que ocupa en bits cada 8 bits del fichero original 
%   para cada fichero comprimido birdx.jp2 con x? {40, 38, 36, 34, �, 6, 4 ,2}. 
%   Es decir, calcula la tasa.
%2) calcular la distorsi�n como error cuadr�tico medio entre las im�genes en 
%   bird.pgm y birdx.jp2, x? {40, 38, 36, 34, �, 6, 4 ,2}.
%3) representar los puntos tasa/distorsi�n obtenidos.

% Te ser� de utilidad la funci�n dir.

%% Paso 9. Incluye respuesta en pdf

%   Completa en el paso 9 de Practica04ApellidoNombre.pdf la siguiente tabla 
%   e incluye la curva tasa/distorsi�n que has obtenido en el paso
%   anterior.

%% Paso 10. Incluye respuesta en pdf

%   En el paso 10 de Practica04ApellidoNombre.pdf, representa en un mismo 
%   gr�fico las dos curvas obtenidas en los pasos 5 y 9 y anal�zalas. Completa 
%   la tabla adjunta

figure; 
plot(distorsion_jp2,tasa_jp2,'*'); hold on;
plot(distorsion_jpeg,tasa_jpeg,'+'); hold on;
legend({'Jpeg2000','Jpeg'},'Location','northeast')
% grid on;
% plot(distorsion,entropia,'+'); legend('Uniforme','Entropia')
xlabel('Distorsion','FontSize',15);
ylabel('Tasa','FontSize',15);
set(gca,'LineWidth',2,'box','off');

%% Paso 11. Incluye tus respuestas en pdf

% En el paso 11 de Practica04ApellidoNombre.pdf:
%�	muestra las figuras bird10.jpeg y bird34.jp2,
%�	incluye sus tasas y distorsiones,
%�	comenta y compara la calidad de ambas im�genes.

close all; clear all; clc;
A=imread('bird.pgm');

% bird10.jpeg

i0=imread('bird10.jpeg');
fid0=fopen('bird10.jpeg','r');
seq0=fread(fid0,'*uint8');
fclose(fid0);

tasa_jpeg=numel(seq0)*8/numel(A);
error=double(A)-double(i0);
error2=error.*error;
suma=sum(error2(:));
distorsion_jpeg=(suma/numel(A));

filename='bird10.jpeg';
fprintf('Tasa de %s: %d\n',filename,tasa_jpeg)
fprintf('Distorsi�n de %s: %d\n',filename,distorsion_jpeg)
fprintf('\n\n')

% bird34.jp2

i1=imread('bird34.jp2');
fid1=fopen('bird34.jp2','r');
seq1=fread(fid1,'*uint8');
fclose(fid1);

tasa_jp2=numel(seq1)*8/numel(A);
error=double(A)-double(i1);
error2=error.*error;
suma=sum(error2(:));
distorsion_jp2=(suma/numel(A));

filename='bird34.jp2';
fprintf('Tasa de %s: %d\n',filename,tasa_jp2)
fprintf('Distorsi�n de %s: %d\n',filename,distorsion_jp2)
fprintf('\n\n')

figure;
subplot(1,3,1); imshow(A); title('Imagen original');
subplot(1,3,2); imshow(i0); title('bird10.jpeg');
subplot(1,3,3); imshow(i1); title('bird34.jp2');

%% Paso 12

% En el paso 12 de Practica04ApellidoNombre.pdf:
%�	muestra las figuras bird90.jpeg y bird6.jp2,
%�	incluye sus tasas y distorsiones,
%�	comenta y compara la calidad de ambas im�genes.

close all; clear all; clc;
A=imread('bird.pgm');

% bird90.jpeg

i0=imread('bird90.jpeg');
fid0=fopen('bird90.jpeg','r');
seq0=fread(fid0,'*uint8');
fclose(fid0);

tasa_jpeg=numel(seq0)*8/numel(A);
error=double(A)-double(i0);
error2=error.*error;
suma=sum(error2(:));
distorsion_jpeg=(suma/numel(A));

filename='bird90.jpeg';
fprintf('Tasa de %s: %d\n',filename,tasa_jpeg)
fprintf('Distorsi�n de %s: %d\n',filename,distorsion_jpeg)
fprintf('\n\n')

% bird6.jp2

i1=imread('bird6.jp2');
fid1=fopen('bird6.jp2','r');
seq1=fread(fid1,'*uint8');
fclose(fid1);

tasa_jp2=numel(seq1)*8/numel(A);
error=double(A)-double(i1);
error2=error.*error;
suma=sum(error2(:));
distorsion_jp2=(suma/numel(A));

filename='bird6.jp2';
fprintf('Tasa de %s: %d\n',filename,tasa_jp2)
fprintf('Distorsi�n de %s: %d\n',filename,distorsion_jp2)
fprintf('\n\n')

figure;
subplot(1,3,1); imshow(A); title('Imagen original');
subplot(1,3,2); imshow(i0); title('bird90.jpeg');
subplot(1,3,3); imshow(i1); title('bird6.jp2');





