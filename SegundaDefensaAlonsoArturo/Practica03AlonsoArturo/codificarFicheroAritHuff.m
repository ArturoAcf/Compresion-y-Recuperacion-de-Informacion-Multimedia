function codificarFicheroAritHuff(fichero)
    fprintf('\n');
    fprintf(fichero);
    fprintf('\n');
    fprintf('ARITMÉTICA\n');
    
    fid=fopen(fichero,'r');
    seq=fread(fid,'*uint8');
    fclose(fid);
    seq=reshape(seq,1,length(seq));
    
    % Histograma
    figure;
    letras=[0:255];
    histo=histc(seq,letras);
    bar(letras,histo);
    title(fichero);
    letras_usadas=find(histo>0)-1;
    histo=histo(letras_usadas+1);

    % Codificación
    iseq=zeros(1,numel(seq),'uint16');
    for i=1:numel(seq)
        letra=seq(i);
        iseq(i)=find(ismember(letras_usadas, letra));
    end

    code=arithenco(iseq,histo);
    fprintf('Longitud de la secuencia codificada: %d\n',numel(code))

    % Número de bits por símbolo
    bits=numel(code)/numel(seq);
    fprintf('Media de bits por símbolo: %d\n',bits);
    
    % Factor de compresión
    factor=8*numel(seq)/numel(code);
    fprintf('Factor de compresión: %d\n',factor);

    % Decodificación y comprobación
    indseqdec=arithdeco(code,histo,numel(seq));
    fprintf('¿Coinciden original y comprimido 1(S) 0 (N)?, %d\n',isequal(iseq,indseqdec))
    fprintf('\n');
    
    % Huffman
    fprintf('\n');
    fprintf('HUFFMAN\n');
    
    figure;
    tamCompr(seq,255);
end