function saveKSC(DEV)

KSC = openKSC(DEV);

%SAVE CURRENT STATE
TRANSMIT_1 = ['SAVE'];
fprintf(KSC, TRANSMIT_1);
verify = (fscanf(KSC, '%s'));
if length(verify) == length('DONE')    
    if verify == 'DONE'
        fprintf(['CURRENT DEVICE CONFIGURATION SAVED TO NONVOLATILE MEMORY', '\r']);
    else
        fprintf(['COMMUNICATION ERROR: CONFIGURATION NOT SAVED', '\r'])
    end
else
    fprintf(['COMMUNICATION ERROR: CONFIGURATION NOT SAVED', '\r'])
    
end

closeKSC(KSC)