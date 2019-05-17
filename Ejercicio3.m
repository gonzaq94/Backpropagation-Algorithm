%clear all;
close all;
commandwindow


IteracionesMax=3000;  
iteraciones=0;
Nentradas=3;
Nprimeracapa=20;
Nsegundacapa=1;
W1=randn(Nprimeracapa,Nentradas+1);
W2=randn(Nsegundacapa,Nprimeracapa+1);
K=10; %Constante de aprendizaje
beta=0.05;
ErrorPermitido=0.1; % con 1 se obtienen mejores resultados pero es lento.
                  % con 2 se obtiene resultados un poco peores pero es mas
                  % rapido.

Nmuestras= 10; 
X=linspace(0,2*pi,Nmuestras);
Y=linspace(0,2*pi,Nmuestras);
Z=linspace(-1,1,Nmuestras);

tabla=zeros(Nmuestras^3,4);
fila=1;
for i=1:length(X)
    for j=1:length(Y)
        for k=1:length(Z)
            tabla(fila,1)=X(i);
            tabla(fila,2)=Y(j);
            tabla(fila,3)=Z(k);
            tabla(fila,4)=(sin(X(i))+cos(Y(j))+Z(k))/3;
            fila=fila+1;
        end
    end
end


Error=ECMfuncionBis(tabla,W1,W2,Nmuestras,beta);

while  Error>ErrorPermitido && iteraciones<IteracionesMax 
   
   indice=randperm(Nmuestras^3);
   
   for i=1:length(indice)
               
                SalidaDeseada=tabla(indice(i),4); 
                Entrada1=[ tabla(indice(i),1), tabla(indice(i),2), tabla(indice(i),3), 1]';
                hPrimeraCapa=W1*Entrada1;
                Entrada2=[tanh(beta*hPrimeraCapa); 1];
                hSegundaCapa=W2*Entrada2;
                Salida=tanh(beta*hSegundaCapa);
        
                DeltaSegundaCapa=(1-tanh(beta*hSegundaCapa)^2)*beta*(SalidaDeseada-Salida);
                DeltaW2=(K*Entrada2*DeltaSegundaCapa)';
                W2=W2+DeltaW2;
       
                DeltaPrimeraCapa=DeltaSegundaCapa*(1-tanh(beta*hPrimeraCapa).^2)*beta.*[W2(1,1:Nprimeracapa)]';
                DeltaW1=(K*Entrada1*DeltaPrimeraCapa')';
                W1=W1+DeltaW1;
        
   end
   
Error=ECMfuncionBis(tabla,W1,W2,Nmuestras,beta);
iteraciones=iteraciones+1;
    
end
Error

Ngrafico=100;
Xgrafico=linspace(0,2*pi,Ngrafico);
SalidaReal=zeros(1,Ngrafico);
for i=1:length(Xgrafico)
   
    SalidaReal(i)=SalidaRedFuncion([Xgrafico(i); pi/2 ; 0],W1,W2,beta);
    
end

figure (1)
SalidaIdeal=sin(Xgrafico)/3;
plot(Xgrafico,SalidaReal);
hold on;
plot(Xgrafico,SalidaIdeal);
xlabel('x');
ylabel('sin(x)/3');
legend('Salida aprendida','Salida deseada');
grid on;
title('Corte en y=\pi/2, z=0');
print('Ej3a.png','-dpng');

Zgrafico=linspace(-1,1,Ngrafico);
SalidaReal=zeros(1,Ngrafico);
for i=1:length(Zgrafico)
   
    SalidaReal(i)=SalidaRedFuncion([0; pi/2 ; Zgrafico(i)],W1,W2,beta);
    
end

figure (2)
SalidaIdeal=Zgrafico/3;
plot(Zgrafico,SalidaReal);
hold on;
plot(Zgrafico,SalidaIdeal);
xlabel('z');
ylabel('z/3');
legend('Salida aprendida','Salida deseada');
grid on;
title('Corte en x=0, y=\pi/2');
print('Ej3b.png','-dpng');

Ygrafico=linspace(0,2*pi,Ngrafico);
SalidaReal=zeros(1,Ngrafico);
for i=1:length(Ygrafico)
   
    SalidaReal(i)=SalidaRedFuncion([0; Ygrafico(i) ; 0],W1,W2,beta);
    
end

figure (3)
SalidaIdeal=cos(Ygrafico)/3;
plot(Ygrafico,SalidaReal);
hold on;
plot(Ygrafico,SalidaIdeal);
xlabel('y');
ylabel('cos(y)/3');
legend('Salida aprendida','Salida deseada');
grid on;
title('Corte en x=0, z=0');
print('Ej3c.png','-dpng');