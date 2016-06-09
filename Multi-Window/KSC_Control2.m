%% KSC Control Function 2 - Independent
% Manipulates the KSC settings useful for the demo

function KSC_Control2(freq_in, q_in, pregain_in, postgain_in, exc_in)

DEF_CF = 20000; % Default cutoff frequency for the low-pass filter
DEF_FR = 700; % Default fr, resonance frequency for the KSC's channel 2
DEF_Q = 50; % Default quality factor
DEF_PRE = 64; % Default pre-gain for the KSC's channel 1
DEF_POST = 16; % Default post-gain for the KSC's channel 1
DEF_EXCV = 12.5; % Default excitation voltage for the KSC's channel 1

% Important!! If findserial() breaks uncomment the line below and set DEV1
% to the communication port that the KSC-2 is connected to (see Control
% Panel > Device Manager)
DEV1 = findserial(); % KSC - Communication Port
% DEV1 = 'COM8';

fr = DEF_FR;
temp = freq_in;
if (not(isnan(temp))) % If there are no numbers in the input fields
    fr = temp; % set the frequency to the input one
end
q = DEF_Q;
temp = q_in;
if (not(isnan(temp)))
    q = temp;
end
pre = DEF_PRE;
temp = pregain_in;
if (not(isnan(temp)))
    pre = temp;
end
post = DEF_POST;
temp = postgain_in;
if (not(isnan(temp)))
    post = temp;
end
excV = DEF_EXCV;
temp = exc_in;
if (not(isnan(temp)))
    excV = temp;
end

configureKSC(DEV1, 1, 'AC', 'GROUND', 'OPERATE'); % configure coupling - AC for mic testing
configureKSC(DEV1, 2, 'AC', 'GROUND', 'OPERATE'); % configure coupling - AC for mic testing
pregainKSC(DEV1, 2, 1);
postgainKSC(DEV1, 2, 1);

filterKSC(DEV1,1,DEF_CF,'FLAT');
filterKSC(DEV1,2,DEF_CF,'FLAT');
cavitycompKSC(DEV1, 2, 'ON', fr, q);
postgainKSC(DEV1, 1, post);
pregainKSC(DEV1, 1, pre);
excitationKSC(DEV1, 1, excV, 'BIPOLAR', 'LOCAL')

saveKSC(DEV1);
overloadKSC(DEV1, 1);
overloadKSC(DEV1, 1);

end
