function ovldsetKSC(DEV, CH, LIM)

KSC = openKSC(DEV);

%SET OUTPUT VOLTAGE LIMIT
TRANSMIT_1 = [num2str(CH), ':OUTOVLDLIM = ', num2str(LIM)];
fprintf(KSC, TRANSMIT_1);
verify = (fscanf(KSC, '%s'));

LIM_round = round(LIM/0.1)*0.1;
if LIM>10.2
    LIM_round = 10.2;
end

if LIM<0.1
    LIM_round = 0.1;
end


if abs(str2num(verify)- LIM_round)<0.001
fprintf(['OUTPUT OVERLOAD LIMIT FOR CHANNEL ', num2str(CH) ,' SET TO ', num2str(LIM_round), ' V', '\r']);
else
    fprintf(['COMMUNICATION ERROR: OVERLOAD SET', '\r'])
end

closeKSC(KSC)