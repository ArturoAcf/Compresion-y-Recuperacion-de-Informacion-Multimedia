%% Practica03MolinaRafael
% Cambia el nombre del guión a Practica03tuapellidonombre

% Arturo Alonso Carbonero
% Tiempo: Incluye aquí el tiempo dedicado a realizar el guion
%% Paso 1

close all; clear all; clc;
alf=['x' 'y' 'z'];
seqob=['y' 'z' 'x' 'z' 'z'];

%% Paso 2

indseqob=[2 3 1 3 3];

%% Paso 3

indseqob=zeros(1,numel(seqob),'uint16');

%% Paso 4
% A REALIZAR POR LOS ESTUDIANTES. INCLUIR CÓDIGO AQUÍ

% Incluye en el paso 4 del fichero Practica03ApellidoNombre.m el código 
% para convertir la secuencia seqob en índices del rango [1:numel(alf)]. 
% Dichos índices los almacenarás en indseqob. Comprueba que  indseqob 
% contiene [2 3 1 3 3].
clc;

for i=1:numel(seqob)
    letra=seqob(i);
    indseqob(i)=find(ismember(alf, letra)); % Devuelve el índice deseado
end

fprintf('Letras: [%s]\n', join(string(seqob), ', '));
fprintf('Índices: [%s]\n', join(string(indseqob), ', '));

%% Paso 5

counts=[29 48 100];
code=arithenco(indseqob,counts)

%% Paso 6

indseqdec=arithdeco(code,counts,numel(indseqob));
seqdecf=alf(indseqdec);
fprintf('¿Coinciden original y comprimido 1(S) 0 (N)?, %d\n',...
    isequal(seqob,seqdecf))

%% Paso 7

close all; clear all;
seqob=[1 1];
counts=[1 1];
code=arithenco(seqob,counts);
fprintf('Longitud de la secuencia codificada %d\n',...
    numel(code))

%% Paso 8

% A REALIZAR POR LOS ESTUDIANTES. ENTREGA DE DISCUSION EN 
% Practica03ApellidoNombre.pdf 

% Compara en el paso 8 del fichero Practica03ApellidoNombre.pdf esta 
% longitud con la que la teoría nos dice que es una cota superior al 
% número de bits necesarios.



%% Paso 9 

close all; clear all;
seqob=[1 1];
counts=[50 50];
code=arithenco(seqob,counts);
fprintf('Longitud de la secuencia codificada %d\n',...
    numel(code))

%% Paso 10

% A REALIZAR POR LOS ESTUDIANTES. ENTREGA DE DISCUSION EN 
% Practica03ApellidoNombre.pdf 


% ¿Por qué crees que ahora la longitud de la secuencia es 11 cuando las 
% frecuencias [1 1] y [50 50] producen las mismas probabilidades?

%Incluye la discusión en el paso 8 del fichero Practica03ApellidoNombre.pdf 

%% Paso 11

clear all;close all; clc;
maximo= 0.0;
minimo=0.0;
rng(0);
while maximo==minimo
    seq=randsrc(1,100000,[1 2; 0.01 0.99]);
    maximo=max(seq(:));
    minimo=min(seq(:));
end
histo=histc(seq,[1 2]);
bar([1 2],histo);

%% Paso 12

code=arithenco(seq,histo);
fprintf('Longitud de la secuencia codificada %d\n',numel(code));
indseqdec=arithdeco(code,histo,numel(seq));
fprintf('¿Coinciden original y comprimido 1(S) 0 (N)?, %d\n',...
    isequal(seq,indseqdec))

%% Paso 13

% A REALIZAR POR LOS ESTUDIANTES. Entregar código Matlab y discusión

% Realiza un estudio de cómo evoluciona el número de bits por símbolo 
% cuando generamos 10^i, i=1,2,3,4,5,6 símbolos siguiendo el proceso del 
% paso 11 con probabilidades pr(1)=0.1 y pr(2)=0.9.  Para cada uno de los 
% 6 casos,  realiza 5 simulaciones distintas y calcula el número medio de 
% bits por símbolo como una media de las 5 simulaciones. Dibuja los 30 
% valores obtenidos así como las medias de los 5 valores para las 10,100,
% 1000,10000, 100000 y 1000000 simulaciones. Dibuja también una línea con el valor
% de la entropía de la fuente. ¿Obtienes algún resultado que en principio
% parezca incorrecto entre la entropía de la fuente y los bits por símbolo?.
% ¿Cuál sería la explicación?

% Incluye el código en el paso 13 del fichero Practica03ApellidoNombre.m 
% y la discusión en el paso 13 de  Practica03ApellidoNombre.pdf.

clear all; close all; clc;

entropias=zeros(1,5,"double");
nbits=zeros(1,5,"double");
medias=zeros(1,6,"double");
leyenda={};
leyenda_ent={};
leyenda_m={};
   
for i=1:6
    nelem=10^i;
    media=0;
    fprintf("Número de elementos: %d\n",nelem);
    
    for j=1:5
        fprintf('\n');
        
        maximo= 0.0;
        minimo=0.0;
        % rng(0); -> La semilla hace que cada iteración sea idéntica
        %            ya que se generan los mismos números aleatorios
    
        while maximo==minimo
            seq=randsrc(1,nelem,[1 2; 0.1 0.9]);
            maximo=max(seq(:));
            minimo=min(seq(:));
        end
        
        % figure;
        histo=histc(seq,[1 2]);
        % bar([1 2],histo);
        code=arithenco(seq,histo);
        fprintf('Longitud de la secuencia codificada para %d elementos: %s\n',nelem,string(numel(code)));

        entropia=entropiaAAC(histo);
        entropias(j)=entropia;
        fprintf('Entropía: %d\n',entropia);

        bits=numel(code)/nelem;
        nbits(j)=bits;
        media=media+bits;
        fprintf('Bits: %d\n',bits);
        fprintf('\n');
    end
    
    media=media/5;
    medias(i)=media;
    
    fprintf('Entropías: [%s]\n',join(string(entropias), ', '));
    fprintf('Media de bits: %d\n',media);
    fprintf('\n\n');
    
    figure(1);
    plot(nbits); hold on; % Para los cinco casos de cada iteración
    leyenda{i}=sprintf('nelem = %d',nelem);  
    legend(leyenda(1:i));         
    drawnow();                 
    ylabel('Número de bits','FontSize',15);
    xlabel('Casos','FontSize',15);
    
    figure(2);
    plot(entropias); hold on; % Para los cinco casos de cada iteración
    leyenda_ent{i}=sprintf('nelem = %d',nelem);  
    legend(leyenda_ent(1:i));         
    drawnow();
    ylabel('Entropías','FontSize',15);
    xlabel('Número de elementos = ' + string(nelem),'FontSize',15);
end

figure(3);
plot(medias,'*'); hold on;
ylabel('Número medio de bits','FontSize',15);
xlabel('Número de elementos','FontSize',15); % i


%% Paso 14 

% A REALIZAR POR LOS ESTUDIANTES. Entregar código Matlab y discusión

%Como habrás podido comprobar empíricamente, la codificación aritmética es 
%más eficiente cuanto mayor sea la longitud de la secuencia a codificar, 
%es decir, el número medio de bits necesarios para representar cada símbolo 
%se acerca más a la entropía cuantos más caracteres codificamos. 
%Comprobaremos de nuevo empíricamente este hecho usando los ficheros de 
%texto contenidos en el fichero textobinario.zip. 

% Los ficheros de texto en textobinario.zip contienen sólo dos caracteres, 
% el carácter '0' y el carácter '1'. El nombre de cada fichero es textoX.txt 
% donde X representa el número de caracteres en el fichero. Observa que 
% los caracteres ‘0’ y ‘1’ vas a tener que codificarlos como 1 y 2.

%Incluye en el paso 14 de Practica03ApellidoNombre.m el código para 
%   1.	codificar y decodificar cada uno de estos ficheros, 
%   2.	comprobar que la secuencia original y decodificada coinciden,
%   3.	dibujar los histograma de los símbolos en cada fichero. 

% Incluye los histograma, la tabla que contiene el número de bits por símbolo 
% para cada fichero y las conclusiones que puedas extraer en el paso 14 de
% Practica03ApellidoNombre.pdf.

clear all; close all; clc;

for i=1:6
    fprintf('\n');
    
    nelem=10^i;
    filename=sprintf('texto%d.txt',nelem);
    fid=fopen(filename,'r');
    seq=fread(fid,'*uint8');
    fclose(fid);
    seq=reshape(seq,1,length(seq));

    for i=1:numel(seq) 
        seq(i)=str2num(char(seq(i))); % Pasar de ASCII a 0's y 1's
        if seq(i)==0  % Sustituyo los 0's por 2's para arithenco, ya que
            seq(i)=2; % únicamente acepta enteros finitos positivos
        end
    end
    
    % Histograma
    figure;
    histo=histc(seq,[1 2]);
    bar([1 0],histo); 
    title(filename);
    
    % Codificación
    code=arithenco(seq,histo);
    fprintf('Longitud de la secuencia codificada: %d\n',numel(code))
    
    % Número de bits por símbolo
    bits=numel(code)/numel(seq);
    fprintf('Media de bits por símbolo: %d\n',bits);
    
    % Decodificación y comprobación
    indseqdec=arithdeco(code,histo,numel(seq));
    fprintf('¿Coinciden original y comprimido 1(S) 0 (N)?, %d\n',isequal(seq,indseqdec))

    fprintf('\n');
end

%% Paso 15

% A REALIZAR POR LOS ESTUDIANTES. Entregar código Matlab y discusión

% Utiliza codificación aritmética para codificar cada uno de ficheros de 
%texto constitucion española.txt, Fundacion e Imperio - Isaac Asimov.txt 
% y Cinco semanas en globo - Julio Verne.txt 
% (dentro de Prácticas -  Datos - texto.zip). 

%Incluye en el paso 14 de Practica03ApellidoNombre.m el código para 
%1.	codificar y decodificar cada uno de estos ficheros, 
%2.	comprobar que la secuencia original y decodificada coinciden,
%3.	dibujar los histogramas de los símbolos en cada fichero,
%4.	calcular el factor de compresión obtenida para cada uno de los ficheros,
%5.	calcular el número de bits por símbolo para cada fichero.

%En el paso 15 de  Practica03ApellidoNombre.pdf incluye 
%1.	los histogramas, 
%2.	completa las tablas adjuntas, para la codificación Huffman no incluyas 
%   el tamaño de la cabecera y
%3.	realiza una comparación crítica de los resultados obtenidos usando 
%   codificación Huffman y aritmética

clear all; close all; clc;

% constitucion española.txt
fichero='constitucion española.txt';
codificarFicheroAritHuff(fichero);

% Cinco semanas en globo - Julio Verne.txt
fichero='Cinco semanas en globo - Julio Verne.txt';
codificarFicheroAritHuff(fichero);

% FUNDACION E IMPERIO - Isaac Asimov.txt
fichero='FUNDACION E IMPERIO - Isaac Asimov.txt';
codificarFicheroAritHuff(fichero);

%% Paso 16

% A REALIZAR POR LOS ESTUDIANTES. Entregar código Matlab y discusión

% Utiliza codificación aritmética sobre los ficheros de imágenes  
% ptt1.pbm, ptt4.pbm, ptt8.pbm (dentro de material complementario 
% - Datos para prácticas - imgs_binarias.zip) y camera.pgm, bird.pgm y 
% bridge.pgm (dentro de Prácticas -  Datos - imgs_grises.zip).  

%Incluye en el paso 16 de Practica03ApellidoNombre.m el código para 
%1.	codificar y decodificar cada uno de estos ficheros, 
%2.	comprobar que la secuencia original y decodificada coinciden,
%3.	dibujar los histogramas de los símbolos en cada fichero,
%4.	calcular el factor de compresión obtenida para cada uno de los ficheros,
%5.	calcular el número de bits por símbolo para cada fichero.%

%En el paso 16 de  Practica03ApellidoNombre.pdf incluye 
%1.	los histogramas, 
%2.	completa las tablas adjuntas, para la codificación Huffman no incluyas el tamaño de la cabecera y
%3.	realiza una comparación crítica de los resultados obtenidos  usando codificación Huffman y aritmética

clear all; close all; clc;

% ptt1.pbm
fichero='ptt1.pbm';
codificarFicheroAritHuff(fichero);

% ptt4.pbm
fichero='ptt4.pbm';
codificarFicheroAritHuff(fichero);

% ptt8.pbm
fichero='ptt8.pbm';
codificarFicheroAritHuff(fichero);

% camera.pgm
fichero='camera.pgm';
codificarFicheroAritHuff(fichero);

% bird.pgm
fichero='bird.pgm';
codificarFicheroAritHuff(fichero);

% bridge.pgm
fichero='bridge.pgm';
codificarFicheroAritHuff(fichero);

%% Paso 17

% A REALIZAR POR LOS ESTUDIANTES. Discusión en pdf

% No hemos discutido en clase qué cabecera debemos incluir en el fichero 
% codificado para que el decodificador sea capaz de reconstruir el fichero
% original. Suponiendo que, como mucho, las letras del alfabeto son 256,  
% ¿que cabecera incluirías?. No olvides incluir las frecuencias o 
% probabilidades si lo consideras necesario. Podemos incluir la longitud 
% de la secuencia a decodificar, ¿habría alguna forma de no tener que 
% incluir el número de símbolos a decodificar?.

% Incluye la discusión en el paso 17 de  Practica03ApellidoNombre.pdf.


