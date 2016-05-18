function postgainKSC(DEV, CH, GAIN)

KSC = openKSC(DEV);
%SET FC
TRANSMIT_1 = [num2str(CH), ':POSTGAIN = ', num2str(GAIN)];
fprintf(KSC, TRANSMIT_1);
verify = (fscanf(KSC, '%s'));

GAIN_round = round(GAIN/0.0125)*0.0125;
if GAIN>16
    GAIN_round = 16;
end



if abs(str2num(verify)- GAIN_round)<0.001
fprintf(['POSTGAIN FOR CHANNEL ', num2str(CH) ,' SET TO ', num2str(GAIN_round), ' V/V', '\r']);
else
    fprintf(['COMMUNICATION ERROR: POSTGAIN', '\r'])
end

closeKSC(KSC)