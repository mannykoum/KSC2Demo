function configureKSC(DEV, CH, COUPLING, SHIELD, MODE)

KSC = openKSC(DEV);

%SET COUPLING
TRANSMIT_3 = [num2str(CH), ':COUPLING = ', COUPLING];
fprintf(KSC, TRANSMIT_3);
verify = (fscanf(KSC, '%s'));
if length(verify) == length(COUPLING)    
    if verify == COUPLING
        fprintf(['COUPLING FOR CHANNEL ', num2str(CH) ,' SET TO ', COUPLING, '\r']);
    else
        fprintf(['COMMUNICATION ERROR: COUPLING', '\r'])
    end
else
    fprintf(['COMMUNICATION ERROR: COUPLING', '\r'])
    
end

%SET SHIELD MODE
TRANSMIT_3 = [num2str(CH), ':SHIELD = ', SHIELD];
fprintf(KSC, TRANSMIT_3);
verify = (fscanf(KSC, '%s'));
if length(verify) == length(SHIELD)    
    if verify == SHIELD
        fprintf(['SHIELD FOR CHANNEL ', num2str(CH) ,' SET TO ', SHIELD, '\r']);
    else
        fprintf(['COMMUNICATION ERROR: MODE', '\r'])
    end
else
    fprintf(['COMMUNICATION ERROR: SHIELD', '\r'])
    
end


%SET OPERATION MODE
TRANSMIT_3 = [num2str(CH), ':MODE = ', MODE];
fprintf(KSC, TRANSMIT_3);
verify = (fscanf(KSC, '%s'));
if length(verify) == length(MODE)    
    if verify == MODE
        fprintf(['MODE FOR CHANNEL ', num2str(CH) ,' SET TO ', MODE, '\r']);
    else
        fprintf(['COMMUNICATION ERROR: SHIELD', '\r'])
    end
else
    fprintf(['COMMUNICATION ERROR: MODE', '\r'])
    
end



closeKSC(KSC)