%% KSC DEMO MATLAB PROGRAM - BACKEND
% The KSC-2 is a Signal Conditioning device created by Kulite Semiconductor
% Products Inc. based in Leonia, NJ. This MATLAB(R) script is the backbone
% of the demonstration of the capabilities of the KSC-2. It is meant to
% work with National instruments hardware (Dual channel, Session-based ADC
% with a high sampling rate).
%
% Dependencies: KSCDemoGUI, KSC_Control2, fftDataMag, findserial, KSC API
%
% Parameters:
%
% * handles
%
% which are the handles of the objects and data structures that define a 
% GUI. The GUI that is passed in KSCDemoBackend2 has to have a togglebutton
% tagged |startButton| and a static text box tagged |busy|.
% Multi-window and single-window GUIs are available.
% 
% @author Emmanuel Koumandakis (emmanuel@kulite.com)


%%%
function KSCDemoBackend2(handles)
%% Sample time, rate and session initialization
% Set the values for sample time, sampling rate, gain of KSC and 
% sensitivity of sensor, initialize the session, and acquire data until a
% value (|trigger|) is reached.
%
% |startForeground| command blocks MATLAB(R) from executing commands.
%
% |data| = mXn matrix of all analog inputs 1 column for each.
%
% |time| should automatically adjust depending upon the scan rate.
% 
% Default scan time is 1sec. |sampTime| sets it to the desired duration.


DEV1 = findserial(); % KSC - 2 port

sampTime = .5; % duration of a foreground session in seconds
fsampFinal = 51200; % Max sampling rate for NI 9218
gain=16*64; % gain (post-gain*pre-gain)
sensitivity = 39.2940; %17.294; % sensitivity in mV/psi
trigger = 4; % trigger value
FRES_LIMIT = 600; % if the resonant frequency is found to be below this 
            % value the test has to run again

s=daq.createSession('ni');
s.Rate = fsampFinal; % change the sampling rate
s.DurationInSeconds = 0.1; % Sets scan duration in seconds

addAnalogInputChannel(s,'cDAQ2Mod1','ai0','Voltage');
addAnalogInputChannel(s,'cDAQ2Mod1','ai1','Voltage');

[data, time] = s.startForeground;
show = true; % flag for plotting (in order not to plot the last data set)
set(handles.busy, 'String', 'Ready for data acquisition..');

%%%
% Condition in order to plot: the |data| has values higher than the 
% |trigger|.
% 
% The loop *breaks* when the stop button is pressed. It _continues_ if the 
% trigger is reached.
%
% After it is past the |while|-loop, the program re-takes data this time 
% for |sampTime| seconds instead of 0.2 of a second. 

while (data<trigger)
    if ~get(handles.startButton, 'value')
        show = false;
        break;
    end
    [data, time] = s.startForeground;
end

if show==true
    set(handles.busy, 'String', 'Hold for another second...');
    s.DurationInSeconds = sampTime; % Sets scan duration in seconds to the 
    % actual sample time value
    [data, time] = s.startForeground; % take dataset after we are sure air 
    % is blowing

    data = VtoPa(data,gain,sensitivity); % local function

    set(handles.busy, 'String', 'You may release now!');
end
%% Fast Fourier Transform 
%
% For the fast-fourier transform we are using 
% <file:///C:/Users/Public/Documents/MATLAB/KSCDemo/html/fftDataMag.html fftDataMag>
% which in return is using the regular |fft| function but then divides
% by the length of the FFT

SPLflag = true;
data1 = data(:,1);
data2 = data(:,2);
[~, xdft1] = fftDataMag(time, data1, SPLflag);
[f, xdft2] = fftDataMag(time, data2, SPLflag);
xdft = [xdft1,xdft2];

% Reset the KSC-2 cavity compensation to the updated resonant frequency and
% quality factor
if show == true
    search = xdft(:, 1);
    [mres, fres, q, ~, in] = resonanceProperties(search, f);
    % Instead of using q for the correct quality factor we use the
    % following default value due to a bug in resonanceProperties.m
    % TODO: fix resonanceProperties.m and change this
    DEF_Q = 50;
    
    % Find the attenuation of the compensated signal at the resonant freq
    attenuation = mres - xdft(in,2);
    
    % Find the index of the second harmonic
    searchhar = xdft(250:end, 1); % This hardcoded number might also cause
                                % problems. 250 is a good number in this
                                % test but could be different for others
    [~, in2] = max(searchhar);
    in2 = in2 + in;
    %d = [num2str(f(i+199)), ' is the frequency of the signal.']; 
    cavitycompKSC(DEV1, 2, 'ON', fres, DEF_Q); % Next compensation based on 
    % last signal
    
    % NOTE: for this demo the resonator resonates at 700Hz therefore
    % reading 600 Hz and below means that the test wasn't ran properly and
    % therefore it should be run again. I don't like this solution but
    % until I come up with a better way to evaluate the set we can use it.
    if fres < FRES_LIMIT
        show = false;
        set(handles.busy, 'String', 'Please try again.');
    end
end

%% Plot

if show == true 

    delete(findall(gcf,'Tag','ann')) % Deletes the previous plot annotation

    % Handle vars
    htime = handles.time;
    hfft = handles.fft;
    hres = handles.res;
    hharm = handles.harm;
    
    % ---------------- Data Plot 1/4 ---------------
    % TODO: Plotting the time data statically as I'm doing below is not 
    % optimal. Find a good looking data set and plot that maybe.
    p = plot(htime, time(1:301), data(10026:10326,1), time(1:301),...
        data(10026:10326,2));
    p(1).Color = 'r';
    p(2).Color = 'g';
%     p(2).Color = [55/256 125/256 46/256];
%     p(2).LineWidth = 1;
    xlabel(htime, 'Time [sec]');
    ylabel(htime, 'Pressure [Pa]');
    title(htime, 'Time History');
%     axis tight
%     set(ax,'XTickLabel',num2str(get(ax,'XTick').'))
%     set(ax,'YTickLabel',num2str(get(ax,'YTick').'))
    darkenAxes(htime);

    % -------- Fast Fourier Transform Plot 2/4 -----
    sem = semilogx(hfft, f, xdft); % in Pa or dB (SPL) depending on SPLflag
    sem(1).Color = 'r';
    sem(2).Color = 'g';
%     sem(2).Color = [55/256 125/256 46/256];
    sem(2).LineWidth = 1;
    xlabel(hfft, 'Frequency [Hz]');
    legend(hfft, 'Amplified Non-compensated Signal',...
        'REZCOMP® Corrected Signal','Location','SouthWest')    
    if SPLflag
        ylabel(hfft, 'Sound Pressure Level [dB]');
    else
        ylabel(hfft, 'Peak Amplitude [Pa]');
        % NOTE Peak amplitude, a, is a single peak from the DC value or 
        % from 0 NOT to be confused w/ peak-to-peak amplitude (2*a)  
    end
    title(hfft, 'Power Spectral Density - Frequency Domain');
%     axis tight
    darkenAxes(hfft);
     
    % -------- FFT Resonant Frequency Detail Plot 3/4 -----
    r = semilogx(hres, f(in-200:in+200), xdft(in-200:in+200,:)); 
    % in Pa or dB (SPL) depending on SPLflag
    r(1).Color = 'r';
    r(2).Color = 'g';
    r(2).LineWidth = 1;
    xlabel(hres, 'Frequency [Hz]');
    if SPLflag
        ylabel(hres, 'SPL [dB]');
    else
        ylabel(hres, 'Peak Amplitude [Pa]');
    end
    title(hres, 'Resonant Frequency Detail');
    str = strcat('Attenuation: ', num2str(attenuation), ' dB'); 
    annotation(hres.Parent, 'textbox', [0.3,0.65,0.55,0.05], ...
        'String', str, 'Color', 'k', 'FontSize', 8, 'EdgeColor', 'k',...
        'BackgroundColor', 'w', 'FaceAlpha', 0.8, 'Tag', 'ann'); %  'FitBoxToText', 'on'
    
    darkenAxes(hres);
    
    % ----------- FFT 1st Harmonic Detail Plot 4/4 --------
    h = semilogx(hharm, f((in2+250)-200:(in2+250)+200),...
    xdft((in2+250)-200:(in2+250)+200,:)); 
    % in Pa or dB (SPL) depending on SPLflag
    h(1).Color = 'r';
    h(2).Color = 'g';
    h(2).LineWidth = 1;
    xlabel(hharm, 'Frequency [Hz]');
    if SPLflag
        ylabel(hharm, 'SPL [dB]');
    else
        ylabel(hharm, 'Peak Amplitude [Pa]');
    end
    title(hharm, 'Harmonic Detail');
%     axis normal
    darkenAxes(hharm);
    axis([htime hfft hres hharm], 'tight') 
%     pause(2);
    play(data, fsampFinal);

end

%% Release session
set(handles.busy, 'String', '');

to_base_workspace()
s.release;
end

%% Additional Functions - local scope

%%% Convert data from units of Volts to Pascals
function data = VtoPa(data, gain, sensitivity)
% Default values for gain and sensitivity - if one only inputs data as a
% parameter
switch nargin
    case 1
        gain = 1024;
        sensitivity = 39.2940;
    case 2
        sensitivity = 39.2940; 
end

% From Volts to Pascals
data = data/gain; % Unamplified data
data = data*1000; % From V to mV
data = data/sensitivity; % From mV to psi
data = data*6894.75729; % From psi to Pa
end

%%% Function to make the plot axes dark
function darkenAxes(axes)
% gives the axes object "axes" a dark theme, unlike the default light 
%
% Axes Properties to be Modified:
% Box, color of axes, background color, grid color, grid visibility
% minor grid color, minor grid visibility, title color

axes.Box = 'on';
axes.XColor = 'w'; axes.YColor = 'w';
axes.Color = 'k';
axes.GridColor = 'w';
axes.XGrid = 'on'; axes.YGrid = 'on';
axes.MinorGridColor = 'w';
axes.XMinorGrid = 'on'; axes.YMinorGrid = 'on';
axes.Title.Color = 'w';

end

%%% Audio Playback of Data
function play(data, Fs)
% pause(2);
% tts('Raw signal');
% pause(.5);
% sound(data(:,1)./1000, Fs);
audiowrite('rawsignal.wav',data(:,1)./1000, Fs);

pause(2);
% tts('After resonance compensation');
% pause(.7);
% sound(data(:,2)./1000, Fs);
audiowrite('compensated.wav',data(:,2)./1000, Fs);
end
    
%%% Function to copy all variables to the base workspace
function to_base_workspace()
ws=evalin('caller','whos()');
for i=1:length(ws)
    tmp=evalin('caller',ws(i).name);
    assignin('base',ws(i).name,tmp);
end
end