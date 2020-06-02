%% Program to take an audio file and use it
clc;
clearvars;
%% Add path where audio file is located
addpath('D:\AudioRead\Data\NoiseFiles\chirp_noise');
%% Read the audio files and store it in a variable
path = 'D:\AudioRead\Data\NoiseFiles\chirp_noise\';
filename = 'chirp-1.wav';
inputfilename = char(strcat(path,filename));
[ipSound,Fs]=audioread(inputfilename,'native');
%% Plot the audio file
L=length(ipSound);

figure(1);
tvac = (0:L-1)/Fs;
plot(tvac,ipSound(:,1));
xlabel('time(sec)');
ylabel('magnitude');

figure(2);
stem(ipSound(:,2));
xlabel('Sample Number');
ylabel('Magnitude');
%% FFt of audio signal
X= ipSound;
Y=fft(X);
T=1/Fs;
p2=abs(Y/L);
p1=p2(1:L/2+1);
p1(2:end-1)=2*p1(2:end-1);
t=(0:L-1)*T;
f=Fs*(0:L/2)/L;

figure(3);
plot(f,p1);
title('Single Sided Amplitude Spectrum of X(t)');
xlabel('frequency(Hz)');
ylabel('|P1(f)|');
which downsample
%% Downsampling the signal
sampling_factor=4;
Fs_new=Fs/4;
ipSound_downsampled(1)=ipSound(1);
sum=1;
for k=2:(length(ipSound)/4)
    sum=sum+4;
    ipSound_downsampled(k)=ipSound(sum);
end
%% Using the new vector to observe the plot
L=length(ipSound_downsampled);
tvac=(0:L-1)*(1/Fs_new);

figure(4);
plot(tvac,ipSound_downsampled);
xlabel('Time(s)');
ylabel('Magnitude');

figure(5);
stem(ipSound_downsampled);
xlabel('Sample_number');
ylabel('Magnitude');
%% Calculating the fft of downsampled signal
T_new=1/Fs_new;
X_new=ipSound_downsampled;
Y_new=fft(X_new,66536);
t_new=(1:length(X_new)-1)*T_new;
L=65536;
f_new =Fs_new*(1:L/2+1)/L;
p2=abs(Y_new/L);
p1=p2(1:L/2+1);
p1(2:end-1) = 2*p1(2:end-1);

figure(6);
plot(f_new,p1);
title('Single Amplitude Spectrum Of X(t) with downsampling');
xlabel('Frequency');
ylabel('|P(f)|');
%% Reducing the feature vector size
bin_width = 512;
bins=floor(length(p1)/512);
st =1;
en=st+(bin_width-1);

for i=1:1:bins
    sum=0;
    for k=st:en
        sum=sum+p1(k);
    end
    avg_bin = sum/bin_width;
    FV(1,i)= avg_bin;
    st=en+1;
    en = st+(bin_width-1);
end
figure(7);
stem(FV);
xlabel('Sample Number');
ylabel('|P(f)|');