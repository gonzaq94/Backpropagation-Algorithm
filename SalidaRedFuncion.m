function [Salida] = SalidaRedFuncion (Entrada,W1,W2,beta)

   Entrada1=[Entrada; 1];
   hPrimeraCapa=W1*Entrada1;
   Entrada2=[tanh(beta*hPrimeraCapa); 1];
   hSegundaCapa=W2*Entrada2;
   Salida=tanh(beta*hSegundaCapa);

end