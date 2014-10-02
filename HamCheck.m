function out=HamCheck(ham, bMsg)
% Evaluate hamming code to check for errors in a binary string.

    s=0;
    d=0;
    out=[];
    fhLen=floor(length(ham)/16);
    for i=1:1:fhLen; % assume for the moment that its a mult of 4.
        b=ham((16*(i-1)+1):(16*i)); % Get a byte.

        % The XOR of the even parity bit with the check bit. If out is not
        % 000, then the value will equal the bit position of the invalid
        % bit. check(1) is the most significant bit.
        check(1)=bXOR(b,[8,9,10,11,12,13,14,15]); % Check each bit for errors.
        check(2)=bXOR(b,[4,5,6,7,12,13,14,15]);
        check(3)=bXOR(b,[2,3,6,7,10,11,14,15]);
        check(4)=bXOR(b,[1,3,5,7,9,11,13,15]);
        
        error=bin2dec(check); % determine the location of the error.
        detect=str2num(bXOR(b,(1:1:16))); % Determine if there are 2 errors.
        
        if(error~=0)
            b(error)=num2str(not(str2num(b(error))));
            if(detect==0) % 2 error detection
                d=d+1;
            else % 1 error correction
                s=s+1;
            end
        end
        out=[out b(3) b(5:7) b(9:15)]; % Remove hamming code.
    end
    
    if(mod(fhLen,16)~=0)
        out=[out ham((fhLen*16+1):end)];
    end
    
    % Display error signals.
    if(bMsg==0) % Don't display if bMsg is turned off.
        return
    end
    if(d>0)
        fprintf('%2.0f unrecoverable errors detected. Data may not be recoverable.\n',d*2);
    end
    if(s>0)
        fprintf('%2.0f error(s) found and corrected!\n',s);
    end
end