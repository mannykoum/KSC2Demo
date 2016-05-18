function FILTER(DEV, CH, FC, TYPE)

KSC = openKSC(DEV);
%SET FC
TRANSMIT_1 = [num2str(CH), ':FC = ', num2str(FC)];
fprintf(KSC, TRANSMIT_1);
verify = (fscanf(KSC, '%s'));

FC_round = round(FC/500)*500;
if FC<250
    FC_round = 500;
end

if str2num(verify) == FC_round
fprintf(['FILTER CUTOFF FOR CHANNEL ', num2str(CH) ,' SET TO ', num2str(FC_round), 'Hz', '\r']);
else
    fprintf(['COMMUNICATION ERROR: FC', '\r'])
end

%SET FILTER TYPE
TRANSMIT_2 = [num2str(CH), ':FILTER = ', TYPE];
fprintf(KSC, TRANSMIT_2);
verify = (fscanf(KSC, '%s'));
if length(verify) == length(TYPE)    
    if verify == TYPE
        fprintf(['FILTER TYPE FOR CHANNEL ', num2str(CH) ,' SET TO ', TYPE, '\r']);
    else
        fprintf(['COMMUNICATION ERROR: FILTER TYPE', '\r'])
    end
else
    fprintf(['COMMUNICATION ERROR: FILTER TYPE', '\r'])
    
end


closeKSC(KSC)

end
