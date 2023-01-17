%% Practica05MolinaRafael
% Cambia el nombre del gui�n a Practica05tuapellidonombre

% Arturo Alonso Carbonero
% Tiempo: Incluye aqu� el tiempo dedicado a realizar el gui�n

%% Paso 1


X=[0:255];
for i=0:8
  factor=2^i;
  Q_X=uint8(floor(factor*(floor(X/factor)+0.5)));          
  subplot(3,3,i+1)
  plot(X,Q_X); axis('tight');
  title(['factor de cuantificaci�n ',num2str(factor)])
end




%% Paso 2

% A REALIZAR POR LOS ESTUDIANTES. C�digo de Matlab aqu�

% A continuaci�n aplicaremos estos cuantificadores a la imagen bridge.pgm. 
% Escribe en el paso 2 de Practica05ApellidoNombre.m c�digo de Matlab que:
%1.	lea la imagen bridge.pgm en la matriz a, la convierta a double y la 
%   almacene en adouble

clear all; close all; clc;
A=imread('bridge.pgm');
Adouble=double(A);

%2.	calcule y guarde en un vector de 9 componentes la entrop�a de las 
%   im�genes cuantificadas utilizando 
%           uint8(floor(factor*(floor(adouble(:)/factor)+0.5)));
%   con los 9 factores, factor=2^i,  i=0:8.
%3.	calcule y guarde, en un vector de 9 componentes, el error cuadr�tico 
%   medio de cuantificaci�n entre la imagen original y la cuantificada 
%   para los 9 factores y 
%4.	dibuje en una gr�fica con dos figuras las entrop�as obtenidas y la 
%   curva  (factor, error cuadr�tico medio de cuantificaci�n).

entropias=zeros(1,9,"double");
errores=zeros(1,9,"double");   
factores=zeros(1,9,"double");

for i=0:8
      factor=2^i;
      factores(i+1)=factor;

      Q_A=uint8(floor(factor*(floor(Adouble/factor)+0.5)));  
      histograma=histc(Q_A(:),[0:255]);
      entropias(i+1)=entropiaAAC(histograma);
      error=Adouble-double(Q_A);
      error2=error.*error;
      suma=sum(error2(:));
      errores(i+1)=(suma/numel(Adouble));
end

clc;
fprintf('Entrop�as: [%s]\n', join(string(entropias), ', '));
fprintf('Errores: [%s]\n', join(string(errores), ', '));

figure;
subplot(1,2,1); 
plot([0:i],entropias,'*');
xlabel('i','FontSize',15);
ylabel('Entrop�a','FontSize',15);

subplot(1,2,2);
plot(errores,factores,'*'); hold on;
xlabel('Error cuadr�tico medio','FontSize',15);
ylabel('Factor','FontSize',15);


%% Paso 3

% A REALIZAR POR LOS ESTUDIANTES. Discusi�n en pdf

% En el paso 3 de Practica05ApellidoNombre.pdf

%1.	incluye las entrop�as y los errores cuadr�ticos medios calculados en 
%   la tabla adjunta. Explica el contenido de la tabla
%2.	incluye las gr�ficas de la entrop�a y la curva 
%   (factor, error cuadr�tico medio de cuantificaci�n).




%% Paso 4

clear all;close all,clc;
A=imread('camera.pgm');
imhist(A)

%% Paso 5

dA=double(A);
frontera_particion =[127];
valores_cuantizados=[63 , 192];
[index,quants]=quantiz(dA(:),frontera_particion,valores_cuantizados); 
dqA=reshape(quants,size(dA));
qA=uint8(dqA);
subplot(1,2,1), imshow(A); title('Imagen Original')
subplot(1,2,2), imshow(qA); title('Cuantificaci�n uniforme con dos niveles')
error=(dA-dqA).*(dA-dqA);
qerror=sum(error(:))/numel(error);
fprintf('Error cuadr�tico medio de cuantificaci�n %e\n',qerror);



%% Paso 6

[particion, vcuantizada,qerror] = lloyds(dA(:),2);
[index,quants]=quantiz(dA(:),particion,vcuantizada); 
qA=uint8(reshape(quants,size(A)));
subplot(1,2,1), imshow(A); title('Imagen Original')
subplot(1,2,2), imshow(qA); title('Cuantificaci�n Max-Lloyd con dos niveles')
formatspc='Partici�n= %4.2f; V. cuantizadas =%4.2f, %4.2f; Error =%4.2f.\n';
fprintf(formatspc,particion,vcuantizada(1),vcuantizada(2),qerror)


%% Paso 7

close all; clear all, clc;
rng('default')
X=2*rand(1000,1)-1; %entiende este paso
hist(X); title('Histograma 1000 realizaciones U(-1,1)')

%% Paso 8

var=sum((X-mean(X)).*(X-mean(X)))/numel(X)

%% Paso 9

clc;

% A REALIZAR POR LOS ESTUDIANTES. c�digo de Matlab.

% Volvamos al histograma. �ste nos indica que nuestras observaciones son 
% candidatas a ser cuantificadas utilizando un cuantificador uniforme. 
% Escribe en el paso 9 de Practica05ApellidoNombre.m  c�digo Matlab para:
%1.	Construir un cuantificador uniforme con 2n valores cuantificados con 
%   n=1,2,3,4,5,6,7,8.
%2.	Calcular en funci�n de n, el error cuadr�tico medio de cuantificaci�n 
%   sobre los datos en X y tambi�n su error cuadr�tico medio de cuantificaci�n te�rico. 
%3.	Dibujar, en funci�n de n, las dos curvas de errores obtenidas. Dos subfiguras
%   distintas en una misma figura.
%
%La funci�n linspace de Matlab, con valor inicial -1 y final 1,  
%puede ser �til para este ejercicio.

N=zeros(1,8,"double");
errores=zeros(1,8,"double");
errores_teoricos=zeros(1,8,"double");

for i=1:8
    N(i)=2^i;
    particion=linspace(-1,1,1+N(i));
    % vcuantizados=linspace(-1,1,2+N(i));
    X_max=particion(end);
    
    for j=1:numel(particion)-1
        vcuantizados(j)=(particion(j)+particion(j+1))/2;
    end
    
    particion(1)=[];
    particion(end)=[];
    [index,quants]=quantiz(X,particion,vcuantizados);
    qX=reshape(quants,size(X));
    
    % Error cuadr�tico medio
    error=(X-qX).*(X-qX);
    qerror=sum(error(:))/numel(X);
    errores(i)=qerror;
    
    % Error te�rico
    delta=2*X_max/numel(vcuantizados);
    error_teorico=delta*delta/12;
    errores_teoricos(i)=error_teorico;
end

clc;
fprintf('Errores te�ricos: [%s]\n', join(string(errores_teoricos), ', '));
fprintf('Errores: [%s]\n', join(string(errores), ', '));

figure;
subplot(1,2,1); 
plot(N,errores_teoricos); hold on;
ylabel('Error te�rico','FontSize',15);
xlabel('N','FontSize',15);

subplot(1,2,2);
plot(N,errores); hold on;
ylabel('Error cuadr�tico medio','FontSize',15);
xlabel('N','FontSize',15);

%% Paso 10

% A REALIZAR POR LOS ESTUDIANTES. incluye discusi�n en pdf

% En el paso 10 de Practica05ApellidoNombre.pdf:
%1.	Completa la tabla adjunta que contiene el error cuadr�tico medio 
%   calculado y el te�rico. Utiliza 5 decimales.
%2.	Incluye las dos curvas obtenidas correspondientes al error cuadr�tico 
%   medio calculado y al te�rico.
%3.	Discute y explica adem�s qu� ocurre cuando aumentamos n en el paso anterior. 
%4.	Por �ltimo, indica c�mo deber�amos codificar los �ndices de 
%   cuantificaci�n: Huffman, aritm�tica o longitud fija.


%% Paso 11

close all; clear all; clc; rng('default');
X=laprnd(1000,1,0,sqrt(1/30));
X=X(X>=-1 & X<=1);
hist(X); title('Histograma 2000 realizaciones Laplace(0,1/30)')



%% Paso 12

% A REALIZAR POR LOS ESTUDIANTES. c�digo de Matlab.

% Como puedes observar el histograma no es muy uniforme. Esto nos indica 
% que nuestras observaciones no son candidatas a ser cuantificadas utilizando
% un cuantificador uniforme. No obstante, escribe en el paso 12 de 
% Practica05ApellidoNombre.m c�digo Matlab para:
%1.	construir un cuantificador uniforme con 2n , n=1,2,3,4,5,6,7,8, niveles
%   de cuantificaci�n en el intervalo (-1,1) y aplicarselo a estos datos en X, 
%2.	calcular, en funci�n de n, el error cuadr�tico medio de cuantificaci�n 
%   sobre los datos en X,
%3.	dibujar, en funci�n de n, la curva de errores obtenida. 

N=zeros(1,8,"double");
errores=zeros(1,8,"double");

for i=1:8
    N(i)=2^i;
    particion=linspace(-1,1,1+N(i));
    % vcuantizados=linspace(-1,1,2+N(i+1));
    
    for j=1:length(particion)-1
        vcuantizados(j)=(particion(j)+particion(j+1))/2;
    end
    
    particion(1)=[];
    particion(end)=[];
    [index,quants]=quantiz(X,particion,vcuantizados);
    qX=reshape(quants,size(X));
    
    % Error cuadr�tico medio
    error=(X-qX).*(X-qX);
    qerror=sum(error(:))/numel(X);
    errores(i)=qerror;
end

clc;
fprintf('Errores: [%s]\n', join(string(errores), ', '));
figure;
plot(N,errores); hold on;
ylabel('Error cuadr�tico medio','FontSize',15);
xlabel('N','FontSize',15);


%% Paso 13

% A REALIZAR POR LOS ESTUDIANTES. Entrega discusi�n en pdf.

% En el paso 13 de Practica05ApellidoNombre.pdf 
%1.	Completa la tabla de errores cuadr�ticos medios. Utiliza cinco decimales 
%2.	Incluye la curva de errores cuadr�ticos medios obtenidos
%3.	Por �ltimo indica c�mo deber�amos codificar los �ndices de 
%   cuantificaci�n: Huffman, aritm�tica o longitud fija.


%% Paso 14

%Discute y compara las tablas que has incluido en los pasos 10 y 13.

%% Paso 15

% A REALIZAR POR LOS ESTUDIANTES. Entrega c�digo Matlab.

% Escribe en el paso 15 de Practica05ApellidoNombre.m c�digo de Matlab para:
%1.	Construir a partir de los datos observados en X un cuantificador de 
%   Max-Lloyd con: 2n niveles de cuantificaci�n usando la funci�n Lloyd de 
%   Matlab   para n=1,2,3,4,5,6,7,8,
%2.	Calcular los errores de cuantificaci�n
%3.	Dibujar la curva de errores en funci�n de n.
%4.	Incluir en una figura con 8 subfiguras los l�mites de las particiones 
%   y los valores de cuantificaci�n asignados a cada partici�n

close all; clc;
N=zeros(1,8,"double");
errores=zeros(1,8,"double");
figure;

for i=1:8
    N(i)=2^i;
    [particion,vcuantizados,qerror]=lloyds(X(:),N(i));
    [index,quants]=quantiz(X(:),particion,vcuantizados);
    errores(i)=qerror;
    
    fprintf('Particiones: [%s]\n', join(string(particion), ', '));
    y=linspace(-1,1,length(particion));
    y2=linspace(-1,1,length(vcuantizados));
    subplot(2,4,i)
    plot(particion,y,'+'); hold on;
    plot(vcuantizados,y2,'*'); 
    legend('Particiones','Valores cuantizados');
end

fprintf('Errores: [%s]\n', join(string(errores), ', '));
figure;
plot(N,errores); hold on;
title('Max-Lloyd');
ylabel('Error cuadr�tico medio','FontSize',15);
xlabel('N','FontSize',15);
    
%% Paso 16
 
% A REALIZAR POR LOS ESTUDIANTES. Entrega discusi�n en pdf.

%  En el paso 16 de Practica05ApellidoNombre.pdf
%1.	Completa la tabla de errores cuadr�ticos medios. Utiliza 5 decimales.
%2.	Incluye la curva de errores cuadr�ticos medios obtenidos.
%3.	Incluye la figura con 8 subfiguras que dibuja los l�mites de las 
%   particiones con los valores de cuantificaci�n asignados a cada partici�n.
%4.	�Qu� conclusiones extraes de la figura?
%5.	Por �ltimo, indica c�mo deber�amos codificar los �ndices de 
%   cuantificaci�n: Huffman, aritm�tica o longitud fija.




%% Paso 17

% A REALIZAR POR LOS ESTUDIANTES. Entrega discusi�n en pdf.

%  Discute y compara las tablas que has incluido en los pasos 10 , 13 y 16.

%% Paso 18

% A REALIZAR POR LOS ESTUDIANTES. Entrega discusi�n en pdf.

%Por �ltimo, �Por qu� crees que hemos utilizado la distribuci�n de Laplace?





