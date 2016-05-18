function pregainKSC(DEV, CH, GAIN)

KSC = openKSC(DEV);
%SET FC
TRANSMIT_1 = [num2str(CH), ':PREGAIN = ', num2str(GAIN)];
fprintf(KSC, TRANSMIT_1);
verify = (fscanf(KSC, '%s'));

n = nextpow2(GAIN);
hi = 2^n;
lo = 2^(n-1);
if abs(hi-GAIN) <= abs(lo-GAIN)
    GAIN_round = hi;
else
    GAIN_round = lo;
end

if GAIN>128
    GAIN_round = 128;
end


if abs(str2num(verify)- GAIN_round)<0.001
fprintf(['PREGAIN FOR CHANNEL ', num2str(CH) ,' SET TO ', num2str(GAIN_round), ' V/V', '\r']);
else
    fprintf(['COMMUNICATION ERROR: PREGAIN', '\r'])
end

closeKSC(KSC)