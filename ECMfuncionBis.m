function [Error] = ECMfuncionBis (tabla,W1,W2,Nmuestras,beta)

   Error=0;
   
   for i=1:length(tabla)
               
            SalidaDeseada=tabla(i,4); 
            Entrada1=[ tabla(i,1), tabla(i,2), tabla(i,3), 1]';
            hPrimeraCapa=W1*Entrada1;
            Entrada2=[tanh(beta*hPrimeraCapa); 1];
            hSegundaCapa=W2*Entrada2;
            Salida=tanh(beta*hSegundaCapa);
            
            Error=Error+(SalidaDeseada-Salida)^2;

   end
    
end