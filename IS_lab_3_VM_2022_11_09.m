%Studentas:	Valdas Mikenas		
%Kryptis (grupė):	Dirbtinio intelekto sistemos (DISfm-22)		

clear all;
close all;

%struktura:
%vienas iejimas
%vienas isejimas
%2 neuronai

%% 0 Pradiniai duomenys apsirasome sigma 1 ir sigma 2
x=0.1:1/22:1;    % reiksmiu
n=length(x);     %20 reiksmiu

d=(1+0.6*sin(2*pi*x/0.7)+0.3*sin(2*pi*x))/2;
figure(1);
plot(x, d,'r');
xlabel('x');
ylabel('d');
title('Pradiniai duomenys');
grid on;
hold on;

%pikiniai taskai
C1=0.1909;  %is grafiko kreives 1 dalies ant x asies
C2=0.9181;  %is grafiko kreives 2 dalies ant x asies

%Plociai
R1=0.1721;     %sigma1
R2=0.1531;     %sigma2

%plot(R1,C1,'ko',R2,C2,'ko')   %pasirinkti taskai 

w1=rand(1);  %atsakingas kiek ausktai Phi1
w2=rand(1);  %atsakingas kiek aukstai Phi2
b0 =rand(1); %iejimas i aktyvavimo f-cija - tsa pats kaip w0

mok_zings = 0.01;  %mokymo zingsnis

%% 1 Skaičiuojame SBF atsakus (aproksimatorius)
for indx_of_epoch = 1:10000
    for n = 1:length(x)
        Phi1 = exp(-((x(n) - C1)^2)/(2*R1^2));
        Phi2 = exp(-((x(n) - C2)^2)/(2*R2^2));
        %% Skaiciuojame tinklo atsaka (pasverta suma) +aktyvavimo f-cija O(atsaka) ir gauname tinklo atsaka y (prognoze)   (1 - klase ar 0 - 2 klase) 
        % sigmoides arba S-shap, vienas apribojimas intervale nuo 0...1.
        v = Phi1*w1 + Phi2*w2 + b0;
        y = v;
        %% Palyginame atsaka su teisingu atsakymu
        %e(index)=d(index)-y(index)
        %e(x)= atstumas tarp pradiniu reiksmiu ir gautu
        e = d(n) - y  ;
        %% Atnaujinkime rysiu svorius (apmokome)
        w1 = w1 + mok_zings*e*Phi1;
        w2 = w2 + mok_zings*e*Phi2;
        b0 = b0 + mok_zings*e;
    end
end

%% 2 Tikrinimas
hold on
    for n = 1:length(x)
        Phi1 = exp(-((x(n) - C1)^2)/(2*(R1)^2));
        Phi2 = exp(-((x(n) - C2)^2)/(2*(R2)^2));
        %% Skaiciuojame tinklo atsaka
        v = Phi1*w1 + Phi2*w2 + b0;
        y = v;

        plot(x(n), y, 'bx');
    end


%veikia praktiskai kaip LMS algoritmas

%% 3 Kitas algoritmas pagetu buti pvz. Gaussian-based RBF (nepadaryta)



