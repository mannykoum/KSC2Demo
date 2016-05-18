
function excitationKSC(DEV, CH, V, TYPE, SENSE)

KSC = openKSC(DEV);
%SET EXCITATION VOLTAGE
TRANSMIT_1 = [num2str(CH), ':EXC = ', num2str(V)];
fprintf(KSC, TRANSMIT_1);
verify = (fscanf(KSC, '%s'));

V_round = round(V/0.00125)*0.00125;
% if V<250
%     V_round = 500;
% end

if str2num(verify) == V_round
    fprintf(['EXCITATION VOLTAGE FOR CHANNEL ', num2str(CH) ,' SET TO ', num2str(V_round), 'V DC', '\r']);
else
    fprintf(['COMMUNICATION ERROR: EXC', '\r'])
end

%SET EXCITATION VOLTAGE TYPE
TRANSMIT_2 = [num2str(CH), ':EXCTYPE = ', TYPE];
fprintf(KSC, TRANSMIT_2);
verify = (fscanf(KSC, '%s'));
if length(verify) == length(TYPE)    
    if verify == TYPE
        fprintf(['EXCITATION TYPE FOR CHANNEL ', num2str(CH) ,' SET TO ', TYPE, '\r']);
    else
        fprintf(['COMMUNICATION ERROR: EXCITATION TYPE', '\r'])
    end
else
    fprintf(['COMMUNICATION ERROR: EXCITATION TYPE', '\r'])
end

%SET SENSE
TRANSMIT_3 = [num2str(CH), ':SENSE = ', SENSE];
fprintf(KSC, TRANSMIT_3);
verify = (fscanf(KSC, '%s'));
if length(verify) == length(SENSE)    
    if verify == SENSE
        fprintf(['SENSE MODE FOR CHANNEL ', num2str(CH) ,' SET TO ', SENSE, '\r']);
    else
        fprintf(['COMMUNICATION ERROR: SENSE MODE', '\r'])
    end
else
    fprintf(['COMMUNICATION ERROR: SENSE MODE', '\r'])
    
end

closeKSC(KSC)