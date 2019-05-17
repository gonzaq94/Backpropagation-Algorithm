close all;

XOR=[ -1, -1, -1;
      1 , -1, 1;
      -1, 1, 1;
      1, 1, -1;];
  
IteracionesMax=10000;  
iteraciones=0;
commandwindow
Nentradas=2;
Nprimeracapa=2;
Nsegundacapa=1;
W1=randn(Nprimeracapa,Nentradas+1);
W2=randn(Nsegundacapa,Nprimeracapa+1);
K=1; %Constante de aprendizaje
beta=0.1;

Error=ECM2capasBETA(XOR,W1,W2,Nentradas,beta);

while Error>0.00001 && iteraciones<IteracionesMax
    
   indice=randperm(4);
   for i=1:length(indice)
       
        SalidaDeseada=XOR(indice(i),Nentradas+1); 
        Entrada1=[XOR(indice(i),1:Nentradas), 1]';
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
   
Error=ECM2capasBETA(XOR,W1,W2,Nentradas,beta);
iteraciones=iteraciones+1;
    
end
Error

m1=-W1(1,1)/W1(1,2);
b1=-W1(1,3)/W1(1,2);

m2=-W1(2,1)/W1(2,2);
b2=-W1(2,3)/W1(2,2);

Linea1=@(x)m1*x+b1;
Linea2=@(x)m2*x+b2;

if Nprimeracapa==3

    m3=-W1(3,1)/W1(3,2);
    b3=-W1(3,3)/W1(3,2);
    Linea3=@(x)m3*x+b3;
end

figure (1)
fplot(Linea1,[ -1.1,1.1],'k');
hold on;
fplot(Linea2,[ -1.1,1.1],'k');
if Nprimeracapa==3
    hold on;
    fplot(Linea3,[ -1.1,1.1],'k');
end
xlim([ -1.1,1.1]);
ylim([ -1.1,1.1]);
grid on;
for i=1:length(XOR)
    if XOR(i,3)==1
        color='or';
    else 
        color='ob';
    end
    hold on;
    plot(XOR(i,1),XOR(i,2),color);
end
title('XOR de 2 entradas');
print('ejercicio2a.png','-dpng');