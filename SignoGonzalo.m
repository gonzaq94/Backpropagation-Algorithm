function [ signo ] = SignoGonzalo ( numero )

if numero==0
    signo=1;
else 
    signo=sign(numero);
end

end