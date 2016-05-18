function [mres, fres, q, BW, in] = resonanceProperties(search, f)
    % This function finds the resonant frequency (fres), the value at that 
    % frequency (mres), the index of it in the vector f, the points closest
    % to what the -3dB values are (fL, fH), the bandwidth (BW) and the 
    % quality factor q 
    %%%
    % $$q = f_{res}/BW$$
    %
    % for more information click
    % <http://www.allaboutcircuits.com/textbook/alternating-current/chpt-6/q-and-bandwidth-resonant-circuit/
    % here>


    [mres, in] = max(search);
    fres = f(in);
    % Find fL and fH to determine the q factor
    mLH = .707*fres; % magnitude at -3 dB
    [~, index] = min(abs(search(1:in)-mLH)); % find close
    fL = f(index);
    [~, index] = min(abs(search(in:end)-mLH));
    fH = (f(index));
    % bandwidth
    BW = fH - fL;
    % Quality factor, q
    q = fres/BW;
    
end