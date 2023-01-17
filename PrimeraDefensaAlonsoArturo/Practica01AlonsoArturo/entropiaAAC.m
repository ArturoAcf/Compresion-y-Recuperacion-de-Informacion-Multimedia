% Función para calcular la entropía a partir de un histograma

function entropiaAAC = entropiaAAC(histograma)
    prob=histograma./sum(histograma)
    entropiaAAC=-sum(prob(find(prob)).*log2(prob(find(prob))))
end