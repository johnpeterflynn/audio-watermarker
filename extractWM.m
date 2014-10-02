function out=extractWM(y2, fSize, key, erChk)
% Watermark extractor. Inputs a sound file and a frame size and outputs the
% watermark.
    [yLen,yCol]=size(y2);
    
    cLenSum=0;
    for n=1:1:yCol
        y=y2(:,n); % For each channel.
        
        % First we need to obtain the length of the watermark.
        for i=1:1:16
            fY(:,i) = fft(y((fSize*(i-1)+1):(fSize*(i)))); % Fourier transform
            if(real(fY(1,i))>=0) % Determine which bit is encoded.
                wmLen(i)='1';
            else
                wmLen(i)='0';
            end
        end
        % Check the data for errors and convert it to decimal.
        cLen=bin2dec(HamCheck(wmLen,0));
        
        % We will run the decryption even if we know the answer is wrong.
        % In any case where the length of the number of frames required is
        % greater than the length of the audio file, we must truncate the
        % code. This will most definitely destroy the watermark, but at
        % least we wont run into an error.
        if((16+cLen)*fSize>yLen)
            cLen=floor(yLen/fSize)-16;
        end
        
        for i=17:1:(16+cLen)
            fY(:,i) = fft(y((fSize*(i-1)+1):(fSize*(i)))); % Fourier transform
            if(real(fY(1,i))>=0) % Determine which bit is encoded.
                code(i+cLenSum-16)='1';
            else
                code(i+cLenSum-16)='0';
            end
        end
        cLenSum=cLenSum+cLen; % add up lengths to for the code vector.
    end
    % Output the watermark!
    if(erChk==0) % Allot the user to enable error checking.
        out=bin2str(bEncrypt(code,key,-1));
    else
        out=bin2str(bEncrypt(HamCheck(code,1),key,-1));
    end
end