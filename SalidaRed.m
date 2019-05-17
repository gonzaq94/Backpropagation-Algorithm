function [Salida] = SalidaRed (TablaVerdad,W1,W2,Nentradas)

    Entrada1=[TablaVerdad(:,1:Nentradas), ones(Nentradas^2,1)]';
    
    SalidaDeseada=TablaVerdad(:,Nentradas+1);

    hPrimeraCapa=W1*Entrada1;
    Entrada2=[tanh(hPrimeraCapa); ones(1,Nentradas^2)];
    hSegundaCapa=W2*Entrada2;
    Salida=tanh(hSegundaCapa);

end