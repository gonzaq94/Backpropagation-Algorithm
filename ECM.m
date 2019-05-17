function [Error] = ECM (TablaVerdad,W,Nentradas)
    
    Entrada=[TablaVerdad(:,1:Nentradas), ones(Nentradas^2,1)];
    
    SalidaDeseada=TablaVerdad(:,Nentradas+1);
    Salida=SignoGonzalo(Entrada*W);
    
    VectorError=(SalidaDeseada-Salida).^2;
    Error=sum(VectorError);
    
end