function ports = findserial()
% returns cell array of found serial ports under Win
% uses CLI MODE command internally
%     fclose('all');
%     fopen('all');
    [~,res] = system('mode'); 
    % regexp returns only the 'COM#' from the data returned from system
    ports = regexp(res,'COM\d+','match'); % ports is an array of strings
    % NOT A STRING ITSELF. Use char(ports) to turn them into one string.
    ports = char(ports); % ports becomes string
    