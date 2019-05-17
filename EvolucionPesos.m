function [W,ErrorVector] = EvolucionPesos (TablaVerdad,Nentradas)

W=randn(1,Nentradas+1);
K=1;

Error=ECM(TablaVerdad,W',Nentradas);
ErrorVector=Error;
Waux=W;
 
while Error~=0
   
   indice=randperm(Nentradas^2);
   for i=1:length(indice)
       
        Entrada=[TablaVerdad(indice(i),1:Nentradas), 1];
        SalidaDeseada=TablaVerdad(indice(i),Nentradas+1); 
        Salida=SignoGonzalo(Entrada*Waux');
    
        DeltaW=K*(SalidaDeseada-Salida)*Entrada;
        Waux=Waux+DeltaW;
        
   end
   W=[W ; Waux];
   Error=ECM(TablaVerdad,Waux',Nentradas);
   ErrorVector=[ErrorVector,Error];
    
end

end