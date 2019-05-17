function [Error] = ECM2capasBETA (TablaVerdad,W1,W2,Nentradas,beta)
    
    Entrada1=[TablaVerdad(:,1:Nentradas), ones(Nentradas^2,1)]';
    
    SalidaDeseada=TablaVerdad(:,Nentradas+1);

    hPrimeraCapa=W1*Entrada1;
    Entrada2=[tanh(beta*hPrimeraCapa); ones(1,Nentradas^2)];
    hSegundaCapa=W2*Entrada2;
    Salida=tanh(beta*hSegundaCapa);
    
    VectorError=(SalidaDeseada'-Salida).^2;
    Error=sum(VectorError);
    
end