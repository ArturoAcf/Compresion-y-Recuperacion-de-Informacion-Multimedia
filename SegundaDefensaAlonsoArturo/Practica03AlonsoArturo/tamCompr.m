function histograma = histograma(seq, long)
    % Histograma
    letras=[0:long];
    histo=histc(seq,letras); %calculamos histograma e indices
    bar(letras,histo);
    axis('tight');
    xlabel('letras [0:255]');
    ylabel('Frecuencias');
    title('Histograma');
    xlabel('letras [0:255]');
    ylabel('Frecuencias');
    title('Histograma');
    
    % Símbolos utilizados y probabilidades
    letras_usadas=find(histo>0);
    prob_letras_usadas=histo(letras_usadas)/numel(seq);
    
    % Huffman
    [dict,avglen] = huffmandict(letras_usadas-1,prob_letras_usadas) ; %construimos el diccionario
    seq_codificada = huffmanenco(seq,dict); %codificamos la señal
    fprintf('Número de símbolos usados: %d\n',numel(letras_usadas));
    fprintf('Longitud de la secuencia codificada: %d\n',length(seq_codificada));
    
    % Tamaño comprimido
    tamagno_comprimido=(length(letras_usadas)+1)*1+ ...
    (length(letras_usadas)+1)*8+ ...
    ceil(length(seq_codificada)/8);
    fprintf('Tamaño fichero comprimido en bytes: %d\n',tamagno_comprimido)
    
    % Número de bits por símbolo
    bits=numel(seq_codificada)/numel(seq);
    fprintf('Media de bits por símbolo: %d\n',bits);
    
    % Factor de compresión
    factor_compresion=numel(seq)/tamagno_comprimido;
    fprintf('Factor de compresión: %d\n',factor_compresion)
    
    % Original = Deco (?)
    deco=huffmandeco(seq_codificada,dict);
    fprintf('¿Coinciden original y comprimido 1(S) 0 (N)?, %d\n',...
     isequal(seq,uint16(deco)))
end