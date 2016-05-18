%% cavitycompKSC takes the parameters to compensate for the Helmholtz 
%packaing related resonances 
% cavitycompKSC(DEV, CH, COMPFILT,varargin) 
% varargin=(COMPFILTFC, COMPFILTQ) 
%COMOPFILT = 'ON' or 'OFF' - turns on and off cavity compensation
% COMPFILTFC= 500\1000\...\127500 Sets cavity compensation center frequency
% COMPFILTQ= 1\1.1\...50 input cavity resonance quality factor
% IF YOU ARE TURNING THE FILTER OFF JUST LET COMPFILT='OFF' and don't add
% anything else - code uses varargin e.g.
% cavitycompKSC(KSC,1,'OFF') 
% Filter on: cavitycompKSC(DEV1, 2, 'ON', 37e3, 6);


%%

function [verify]=cavitycompKSC(DEV, CH, COMPFILT_ONOFF, varargin)

%delete_all_objects; 

try 

    KSC = openKSC(DEV);
    %SET FC
    if strcmp(COMPFILT_ONOFF,'ON') 

        TRANSMIT_1 = [num2str(CH), ':COMPFILT = ',COMPFILT_ONOFF];
        verifyCC=query(KSC,TRANSMIT_1)
        
        %fprintf(KSC, TRANSMIT_1);
        %verifyCC=query(KSC,[num2str(CH),':COMPFILT?'])

        %verify = (fscanf(KSC, '%s'));

        TRANSMIT_2 = [num2str(CH), ':COMPFILTFC = ', num2str(varargin{1})];
        %fprintf(KSC, TRANSMIT_2);
        %verifyCCCF=query(KSC,[num2str(CH),':COMPFILTFC'])
        verifyCCCF=query(KSC,TRANSMIT_2);
        
        
        TRANSMIT_3 = [num2str(CH), ':COMPFILTQ = ', num2str(varargin{2})];
        verifyCCQ=query(KSC,TRANSMIT_3);
        
        disp(['Cavity Compensation CH',num2str(CH),'SET TO CENTER FREQ=',num2str(verifyCCCF),'Hz, Q=',num2str(verifyCCQ)]);
        
        %fprintf(KSC, TRANSMIT_3);
        %verifyCCQ=query(KSC,[num2str(CH),':COMPFILTQ?'])
       %verifyCCQ2=query(KSC,[num2str(CH),':COMPFILTQ?'])
       % fprintf(['CAVITY COMPENSATION CH ', num2str(CH) ,' SET TO CENTER FREQ=',verifyCCCF, verifyCCQ2]); %',HZ, Q=',verifyCCQ]);

            
    else
        TRANSMIT_1 = [num2str(CH), ':COMPFILT = ', num2str(COMPFILT_ONOFF)];
        query(KSC, TRANSMIT_1);
        %fprintf(['FILTER COMPENSATION CH ', num2str(CH) ,' SET TO ', COMPFILT_ONOFF, '\r']);
        disp(['FILTER COMPENSATION CH ', num2str(CH) ,' SET TO ', COMPFILT_ONOFF]);
    end

    
    closeKSC(KSC)
    
catch MExc
    
    MExc.identifier
    MExc.message
    MExc.cause
    MExc.stack
    closeKSC(KSC);
    %delete_all_objects;
end

end
