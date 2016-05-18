
function closeKSC(KSC)
SN = query(KSC, ['SN?'], '%s\n' ,'%s');
fclose(KSC);
delete(KSC);
clear('KSC');
fprintf(['KSC-2: SN-', SN, ' HAS BEEN DISCONNECTED FROM COMMUNICATION PORT', '\r \r'])
end