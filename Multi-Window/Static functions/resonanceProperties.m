function [mres, fres, q, BW, in] = resonanceProperties(search, f)

    [mres, in] = max(search);
    fres = f(in);
    % Find fL and fH to determine the q factor
    mLH = .707*fres; % magnitude at -3 dB
    [~, index] = min(abs(search(1:in)-mLH));
    fL = f(index);
    [~, index] = min(abs(search(in:end)-mLH));
    fH = (f(index));
    % bandwidth
    BW = fH - fL;
    % Quality factor, q
    q = fres/BW;
    
end