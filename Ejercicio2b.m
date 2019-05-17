close all;
clear all;
format short;

%Compuerta AND 16 entradas
VectorAux=linspace(0,15,16);
Vector=de2bi(VectorAux);
c1=Vector(:,1);
c2=Vector(:,2);
c3=Vector(:,3);
c4=Vector(:,4);

XOR4entradas=[Vector,xor(xor(c1,c2),xor(c3,c4))];
XOR4entradas=2*XOR4entradas-1;

  
IteracionesMax=10000;  
iteraciones=0;
Nentradas=4;
Nprimeracapa=5; %se comprueba experimentalmente que con este valor en 4 la red no aprende la XOR bien. 5 es el valor minimo para el cual aprende bien la XOR.
Nsegundacapa=1;
W1=randn(Nprimeracapa,Nentradas+1);
W2=randn(Nsegundacapa,Nprimeracapa+1);
K=0.5; %Constante de aprendizaje
beta=0.5;
ErrorTolerable=0.01;


Error=ECM2capasBETA(XOR4entradas,W1,W2,Nentradas,beta);
ECMvec=Error;

while Error>ErrorTolerable && iteraciones<IteracionesMax
    
   indice=randperm(Nentradas^2);
   for i=1:length(indice)
       
        SalidaDeseada=XOR4entradas(indice(i),Nentradas+1); 
        Entrada1=[XOR4entradas(indice(i),1:Nentradas), 1]';
        hPrimeraCapa=W1*Entrada1;
        Entrada2=[tanh(beta*hPrimeraCapa); 1];
        hSegundaCapa=W2*Entrada2;
        Salida=tanh(beta*hSegundaCapa);
        
        DeltaSegundaCapa=(1-tanh(beta*hSegundaCapa)^2)*beta*(SalidaDeseada-Salida);
        DeltaW2=(K*Entrada2*DeltaSegundaCapa)';
        W2=W2+DeltaW2;
        

        DeltaPrimeraCapa=DeltaSegundaCapa*(1-tanh(beta*hPrimeraCapa).^2)*beta.*(W2(1,1:Nprimeracapa))';
        DeltaW1=(K*Entrada1*DeltaPrimeraCapa')';
        W1=W1+DeltaW1;
        
   end
   
Error=ECM2capasBETA(XOR4entradas,W1,W2,Nentradas,beta);
ECMvec=[ECMvec,Error];
iteraciones=iteraciones+1;
    
end

figure (1)
plot(ECMvec);
title('Variación del ECM para una XOR de 4 entradas');
xlabel('iteraciones');
grid on;
ylabel('ECM (suma de las diferencias cuadrática)');
print('ejercicio2b.png','-dpng');

XOR4entradas=[XOR4entradas,zeros(Nentradas^2,1)];
for i=1:Nentradas^2
    XOR4entradas(i,Nentradas+2)=SalidaRedFuncion(XOR4entradas(i,1:Nentradas)',W1,W2,beta);
end

tabla=table(XOR4entradas(:,1),XOR4entradas(:,2),XOR4entradas(:,3),XOR4entradas(:,4),XOR4entradas(:,5),...
    XOR4entradas(:,6),'VariableNames', {'E1' 'E2' 'E3' 'E4' 'Salida' 'Aprendido'})
writetable(tabla,'xor4e.txt');