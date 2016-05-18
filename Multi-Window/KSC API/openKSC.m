function comPORT = openKSC(COM)
comPORT = serial(COM, 'BaudRate', 57600, 'DataBits', 8, 'Parity', 'none', 'StopBits', 1);
fopen(comPORT);
SN = query(comPORT, ['SN?'], '%s\n' ,'%s');
fprintf(['KSC-2: SN-', SN, ' HAS BEEN SUCCESSFULLY CONNECTED TO ' , COM, '\r']);
end
