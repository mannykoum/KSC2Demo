%KSC-2 MATLAB control scheme

clc;
clear;
%delete_all_objects;
%Specify COM PORT of KSC DEVices; Check WINDOWS DEVICE MANAGER/PORTS
DEV1 = 'COM9';
%DEV2 = 'COMXXX';
%DEV3 = 'COMXXX';

%loadKSC;

%KSC = openKSC('DEV1')
%closeKSC(KSC);

%configureKSC(DEV1, 2, 'AC', 'GROUND', 'OPERATE')  %configureKSC(CH, COUPLING, SHIELD, MODE)

configureKSC(DEV1, 1, 'AC', 'GROUND', 'OPERATE'); % configure coupling - AC for mic testing
filterKSC(DEV1, 1, 7.5e4, 'PULSE');   
excitationKSC(DEV1, 1, 10, 'BIPOLAR','REMOTE')%'BIPOLAR', 'LOCAL');
cavitycompKSC(DEV1,1,'OFF');
pregainKSC(DEV1, 1, 128); %4) %128
postgainKSC(DEV1, 1, 16); %4)   %16                      %postgainKSC(CH{1/2}, GAIN)\
   


configureKSC(DEV1, 2, 'AC', 'GROUND', 'OPERATE'); % configure coupling - AC for mic testing
filterKSC(DEV1, 2, 7.5e4, 'FLAT');   %filterKSC(CHANNEL{1/2}, FC, FILTER_TYPE{SHARP/LINEAR/NONE})
excitationKSC(DEV1, 2, 10, 'BIPOLAR', 'LOCAL');   %excitationKSC(CH{1/2}, V, TYPE{UNIPOLAR/BIPOLAR}, SENSE{LOCAL/REMOTE})
pregainKSC(DEV1, 2, 1);            %pregainKSC(CH{1/2}, GAIN
postgainKSC(DEV1, 2, 1) ;                        %postgainKSC(CH{1/2}, GAIN)\                   
cavitycompKSC(DEV1, 2, 'ON', 700, 10);
%cavitycompKSC(DEV1,2,'OFF');

saveKSC(DEV1);                                   %saveKSC();
%ovldsetKSC(DEV1, 2, 3)                           %ovldsetKSC(CH{1/2}, OUTPUT VOLTAGE LIMIT)
overloadKSC(DEV1, 2)                              
overloadKSC(DEV1, 1)

%delete_all_objects;
