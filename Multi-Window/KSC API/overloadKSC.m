function overloadKSC(DEV, CH)

KSC = openKSC(DEV);

INOVLD = query(KSC, [num2str(CH), ':INOVLD?'], '%s\n' ,'%s');
fprintf(['INPUT OVERLOAD STATUS FOR CHANNEL ', num2str(CH), ' = ',  num2str(INOVLD), '\r'])

OUTOVLD = query(KSC, [num2str(CH), ':OUTOVLD?'], '%s\n' ,'%s');
fprintf(['OUTPUT OVERLOAD STATUS FOR CHANNEL ', num2str(CH), ' = ',  num2str(OUTOVLD), '\r'])

OUTOVLDLIM = query(KSC, [num2str(CH), ':OUTOVLDLIM?'], '%s\n' ,'%s');
fprintf(['OUTPUT OVERLOAD LIMIT FOR CHANNEL ', num2str(CH), ' = ',  num2str(OUTOVLDLIM),'V', '\r'])

closeKSC(KSC)