close all;
clear all;

%Compuerta AND
AND=[ 1, 1, 1;
      1 , -1, -1;
      -1, 1, -1;
      -1, -1, -1;];
Nentradas=2;
  
W=EvolucionPesos(AND,Nentradas);
  
m=-W(:,1)./W(:,2);
b=-W(:,3)./W(:,2);
    
figure (1)
title('Compuerta AND');
grey=[0.5 0.5 0.5];
color='m';
for i=1:length(m)
    if i==length(m)
        color='k';
    end
    fplot(@(x)m(i)*x+b(i), [-1.1 1.1],color);
    hold on;
end
grid on;
for i=1:length(AND)
    if AND(i,3)==1
        color='or';
    else 
        color='ob';
    end
    hold on;
    plot(AND(i,1),AND(i,2),color);
end
title('Compuerta AND');
xlim([ -1.1,1.1]);
ylim([ -1.1,1.1]);
print('Ej1AND4e.png','-dpng');

%Compuerta OR
OR=[ 1, 1, 1;
      1 , -1, 1;
      -1, 1, 1;
      -1, -1, -1;];
Nentradas=2; 
W=EvolucionPesos(OR,Nentradas);
  
m=-W(:,1)./W(:,2);
b=-W(:,3)./W(:,2);
    
figure (2)
title('Compuerta OR');
color='m';
for i=1:length(m)
    if i==length(m)
        color='k';
    end
    fplot(@(x)m(i)*x+b(i), [-1.1 1.1],color);
    hold on;
end
grid on;
for i=1:length(OR)
    if OR(i,3)==1
        color='or';
    else 
        color='ob';
    end
    hold on;
    plot(OR(i,1),OR(i,2),color);
end
title('Compuerta OR');
xlim([ -1.1,1.1]);
ylim([ -1.1,1.1]);
print('Ej1OR4e.png','-dpng');

%Compuerta AND 16 entradas
VectorAux=linspace(0,15,16);
Vector=de2bi(VectorAux);
c1=Vector(:,1);
c2=Vector(:,2);
c3=Vector(:,3);
c4=Vector(:,4);

AND4entradas=[Vector,and(and(c1,c2),and(c3,c4))];
AND4entradas=2*AND4entradas-1;

Nentradas=4;
[W,ECM]=EvolucionPesos(AND4entradas,Nentradas);

figure(3)
plot(ECM);
grid on;
title('Error cuadrático medio AND 4 entradas');
print('Ej1AND4e.png','-dpng');

%Compuerta AND 16 entradas
VectorAux=linspace(0,15,16);
Vector=de2bi(VectorAux);
c1=Vector(:,1);
c2=Vector(:,2);
c3=Vector(:,3);
c4=Vector(:,4);

AND4entradas=[Vector,or(or(c1,c2),or(c3,c4))];
AND4entradas=2*AND4entradas-1;

Nentradas=4;
[W,ECM]=EvolucionPesos(AND4entradas,Nentradas);

figure(4)
plot(ECM);
grid on;
title('Error cuadrático medio OR 4 entradas');
print('Ej1OR4e.png','-dpng');
