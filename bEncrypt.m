function eOut=bEncrypt(bIn, key, dir)
% Encrypts a string of bits. Flips the bits around a certain number of
% times given by the value of each entry on key and the number of entries
% in key.

    % Error checking
    if(abs(dir)~=1)
        fprintf('ERROR: dir in bEncrypt can only be 1 or -1.\n');
        return
    end

    % Length of the key and the input.
    bLen=length(bIn);
    kLen=length(key); 
    % If dir is 1, count up. If -1, count down.
    for i=0.5*(kLen+1+dir*(1-kLen)):dir:0.5*(kLen+1+dir*(kLen-1))
        for j=0.5*(bLen+1+dir*(1-bLen)):dir:0.5*(bLen+1+dir*(bLen-1))
            n=mod(j+key(i)-1,bLen)+1; % Select the bit to switch with j.
            temp=bIn(j); % store a temprary value.
            bIn(j)=bIn(n);
            bIn(n)=temp;
        end
    end
    eOut=bIn; % output the result
end