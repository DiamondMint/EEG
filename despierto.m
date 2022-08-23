% Código desarrollado por Paola Briseño García 21/08/2022.
% Contacto: brisenop42@gmail.com
clc; clear; close all;
%% load ecg
load('despierto.mat')
%Separar caanales en vectores:
data1 = data(1:43580,1);
data2 = data(2:43580,2);
data3 = data(3:43580,3);
data4 = data(4:43580,4);
Fs = 200;
G = 2000;

eeg1 = data1/G;
eeg2 = data2/G;
eeg3 = data3/G;
eeg4 = data4/G;

eeg1 = (eeg1 - mean(eeg1))/std(eeg1);
t1 = (1:1:length(eeg1))*(1/Fs);
eeg2 = (eeg2 - mean(eeg2))/std(eeg2);
t2 = (1:1:length(eeg2))*(1/Fs);
eeg3 = (eeg3 - mean(eeg3))/std(eeg3);
t3 = (1:1:length(eeg3))*(1/Fs);
eeg4 = (eeg4 - mean(eeg4))/std(eeg4);
t4 = (1:1:length(eeg4))*(1/Fs);

subplot(2,1,1)
plot(t1,eeg1)
xlim([70 80])
xlabel('Tiempo (s)')
ylabel('Amplitud (mV)')
title('FP1 Dominio del Tiempo')

subplot(2,1,2)
plot(t2,eeg2)
xlim([70 80])
xlabel('Tiempo (s)')
ylabel('Amplitud (mV)')
title('FP2 Dominio del Tiempo')
%%
figure;
subplot(2,1,1)
plot(t3,eeg3)
xlim([70 80])
xlabel('Tiempo (s)')
ylabel('Amplitud (mV)')
title('01 del Tiempo')

subplot(2,1,2)
plot(t4,eeg4)
xlim([70 80])
xlabel('Tiempo (s)')
ylabel('Amplitud (mV)')
title('02 Dominio del Tiempo')

%% FFT
%F1
F1 = fft(eeg1);
F1 = abs(F1);
F1 = F1(1:ceil(end/2));
F1 = F1/max(F1);

L1 = length(F1);

f1 = (1:1:L1)*((Fs/2)/L1);
figure;
subplot(2,2,1)
plot(f1,F1)
xlabel('Frecuencia (Hz)');
ylabel('Mgnitud Normalizada');
title('FP1 en Frecuencia');
%F2
F2 = fft(eeg2);
F2 = abs(F2);
F2 = F2(1:ceil(end/2));
F2 = F2/max(F2);
L2 = length(F2);

f2 = (1:1:L2)*((Fs/2)/L2);
subplot(2,2,2)
plot(f2,F2)
xlabel('Frecuencia (Hz)');
ylabel('Mgnitud Normalizada');
title('FP2 en Frecuencia');
%F3
F3 = fft(eeg3);
F3 = abs(F3);
F3 = F3(1:ceil(end/2));
F3 = F3/max(F3);

L3 = length(F3);

f3 = (1:1:L3)*((Fs/2)/L3);
subplot(2,2,3)
plot(f3,F3)
xlabel('Frecuencia (Hz)');
ylabel('Mgnitud Normalizada');
title('01 en Frecuencia');
%F4
F4 = fft(eeg4); 

F4 = abs(F4);
F4 = F4(1:ceil(end/2));
F4 = F4/max(F4);

L4 = length(F4);
f4 = (1:1:L4)*((Fs/2)/L4);
subplot(2,2,4)
plot(f4,F4)
xlabel('Frecuencia (Hz)');
ylabel('Mgnitud Normalizada');
title('02 en Frecuencia');

%% Filtrado FIR

% Caracteristicas del filtro
orden = 8000;
limi = 31;
lims = 91;
% Normalizar
limi_n = limi/(Fs/2);
lims_n = lims/(Fs/2);
% Crear filtro
a = 1;
b = fir1(orden,[limi_n lims_n],'stop');
% Filtrar señal
eeg_limpio1 = filtfilt(b,a,eeg1);
eeg_limpio2 = filtfilt(b,a,eeg2);
eeg_limpio3 = filtfilt(b,a,eeg3);
eeg_limpio4 = filtfilt(b,a,eeg4);

%% FP1 GRAFICAS
figure;
% Graficar FP1 en Dominio del tiempo --------------------------

% Graficar el FP1 sin filtrar
subplot(2,1,1);
plot(t1,eeg1);
xlim([70 80])
xlabel('Tiempo (s)')
ylabel('Amplitud (mV)')
title('FP1 SIN filtro')
% Graficar el FP1 filtrado
subplot(2,1,2);
plot(t1,eeg_limpio1);
xlim([70 80])
xlabel('Tiempo (s)')
ylabel('Amplitud (mV)')
title('FP1 CON filtro FIR')

%% Deriv FP2 GRÁFICAS
figure;
% Graficar FP2 en Dominio del tiempo --------------------------

% Graficar el FP2 sin filtrar
subplot(2,1,1);
plot(t2,eeg2);
xlim([70 80])
xlabel('Tiempo (s)')
ylabel('Amplitud (mV)')
title('FP2 SIN filtro')

% Graficar el FP2 filtrado
subplot(2,1,2);
plot(t2,eeg_limpio2);
xlim([70 80])
xlabel('Tiempo (s)')
ylabel('Amplitud (mV)')
title('FP2 CON filtro FIR')

%% 01 GRAFICAS
figure;
% Graficar Dominio del tiempo --------------------------

% Graficar el 01 sin filtrar
subplot(2,1,1);
plot(t3,eeg3);
xlim([70 80])
xlabel('Tiempo (s)')
ylabel('Amplitud (mV)')
title('01 SIN filtro')
% Graficar el Deriv V1 filtrado
subplot(2,1,2);
plot(t3,eeg_limpio3);
xlim([70 80])
xlabel('Tiempo (s)')
ylabel('Amplitud (mV)')
title('01 CON filtro FIR')

%% 02 GRÁFICAS
figure;
% Graficar 02 en Dominio del tiempo --------------------------

% Graficar el 02 sin filtrar
subplot(2,1,1);
plot(t4,eeg4);
xlim([70 80])
xlabel('Tiempo (s)')
ylabel('Amplitud (mV)')
title('02 SIN filtro')

% Graficar el 02 filtrado
subplot(2,1,2);
plot(t4,eeg_limpio4);
xlim([70 80])
xlabel('Tiempo (s)')
ylabel('Amplitud (mV)')
title('02 CON filtro FIR')
