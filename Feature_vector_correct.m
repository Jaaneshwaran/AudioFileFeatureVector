%% Matlab script to generate feature vector
clc;
clearvars;
%% adding the path of the file which contains the audio samples
addpath('D:\AudioRead\Data\NoiseFiles\wind_noise');
%% Analyzing the audio sample
path='D:\AudioRead\Data\NoiseFiles\wind_noise\';
filename= 'wind-1.wav';
file=char(strcat(path,filename));
[ipSound,Fs]=audioread(file,'native');
%% Plotting the initial data collected
L=length(ipSound);
tvac=(0:L-1)*(1/Fs);

figure(1);
plot(tvac,ipSound);
xlabel('Time(s)');
ylabel('Magnitude of x(t) sampled');
%% Taking the fft of the initial collected data
X=ipSound;
Y=fft(X);
p2=abs(Y/L);
p1=p2(1:L/2+1);
p1(2:end-1)=2*p1(2:end-1);
f=Fs*(0:L/2)/L;

figure(2);
plot(f,p1);
title('Single amplitude spectrum of X(t)');
xlabel('Frequency(Hz)');
ylabel('|P(f)|');
%% sampling the data
sampling_factor=16;
Fs_new=floor(Fs/sampling_factor);
sum=1;
ipSound_downsampled(1)=ipSound(1);
for i=1:size(ipSound,2)
    sum=1;
  for k=2:size(ipSound,1)/sampling_factor
    sum=sum+sampling_factor;
    ipSound_downsampled(k,i)=ipSound(sum);
  end
end
%% plotting the downsampled audio vector
L_new=length(ipSound_downsampled);
tvac=(0:L_new-1)*(1/Fs_new);

figure(3);
plot(tvac,ipSound_downsampled);
xlabel('Time(s)');
ylabel('Magnitude');
%% fft of downsampled signal
X_new=ipSound_downsampled;
Y_new=fft(X_new,L_new);
p2=abs(Y_new/L_new);
p1=p2(1:L_new/2+1);
f=Fs_new*(0:L_new/2)/L_new;

figure(4);
plot(f,p1);
title('Single Amplitude Spectrum of downsampled Audio Signal');
xlabel('Frequency(Hz)');
ylabel('|P(f)|');
%% reducing sixze of feature vector
bin_width=256;
bins = floor(length(ipSound_downsampled)/bin_width);
st=1;
en=st+bin_width-1;

for i=1:bins
    sum=0;
     for k=st:en
         sum=sum+ipSound_downsampled(k);
     end
     avg_bin=sum/bin_width;
     FV(1,i)=avg_bin;
     st=en+1;
     en=st+bin_width-11;
end
figure(5);
plot(FV);
xlabel('Sample Number');
ylabel('Feature Vector');
         


