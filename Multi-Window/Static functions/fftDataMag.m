%% [f,xdft]=fftDataMag(time,data,SPLflag) 
% fftDataMag provides the frequency and magnitude of the a time series in
% terms of the peak-to-peak values of the input units 
% e.g. input is a time based voltage; fft will produce a spectral data set 
% that is in units of peak-to-peak values of the time based series ie
% Volts.
% Alternatively, it can output the data in dB (SPL).
%
%
% Parameters:
%%% 
% * time: the time vector
% * data: the data matrix
% * SPLflag: true returns output in dB (SPL), false returns output in terms 
% of the input units 

function [freq,xdft]=fftDataMag(time,data,SPLflag)

%Fs = 10;  % Sampling frequency
Fs=1./(time(2)-time(1));  %Samples per sec
t = time;
y = data;

NFFT = 2^(nextpow2(length(y))); % Next power of 2 from length of y Extend 
% to improve resolution of fft - changes bin size 
% Higher number of bins provides for more accurate amplitude estimation of
% fft 

xdft = fft(y);
xdft = xdft(1:length(xdft)/2+1);
xdft = xdft/length(y);
xdft(2:end-1) = 2*xdft(2:end-1);

%freq = Fs/2*linspace(0,1,NFFT/2+1);
freq = 0:Fs/(length(y)):Fs/2;


% NOTE Peak amplitude, a, is a single peak from the DC value or from 0 NOT to
% be confused w/ peak-to-peak amplitude (2*a)

% To display sound pressure level in terms of dB 
if SPLflag
    % SPL = 20*log10(P'rms./20e-6Pa)
    xdft = 20*log10((abs(xdft)/sqrt(2))./20e-6);
    % NOTE 20e-6 is in Pa and this is the human threshold for hearing 
end

