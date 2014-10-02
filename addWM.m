function out=addWM(y2, fSize, str, key, erChk)
% Add the weatermark to the audio file. Inputs the sound file, desired
% frame size and code to append.

    [yLen,yCol]=size(y2);
    frames=floor(yLen/fSize); % Determine the number of frames

    % Error checking. We can't write to the file if we don't have enough
    % frames.
    multFact=7+5*erChk;
    if(length(str)*multFact>frames*yCol)
        fprintf('WARNING: The watermark is too long.\n')
        fprintf('If you cannot shorten your string then you may modify the frame size.\n');
        fprintf('You can also turn off error checking.\n');
        str=str(1:floor(frames*yCol/multFact));
    end
    
    % Convert, encrypt and add error checking to the code.
    crypt=bEncrypt(str2bin(str),key,1);
    if(erChk==0) % Allot the user to enable error checking.
        codeIn=crypt;
    else
        codeIn=Ham11bit(crypt);
    end
    
    % Divide the code among different channels. See below.
    codeFloor=floor(length(codeIn)/yCol);
    
    for n=1:1:yCol
        y=y2(:,n);

        % This handles and takes advantage of audio files that implement
        % stereo sound.
        if(n==1)
            code=codeIn(1:codeFloor);
        else
            code=codeIn((codeFloor+1):end);
        end
        
        % We need to add a marker to the beginning that determines how far
        % down the audio file to read.
        cLen=length(code);
        init=dec2bin(cLen);
        for k=1:1:(11-length(init)) % generate the length marker to append to the beginning.
            init=['0' init];
        end
        code=[Ham11bit(init) code]; % Add error checking.
        cLen=length(code); % update the length of code.

        % This is where the magic happens. We break the sound file up into a given
        % number of frames and FFT each. We then flip the real part of the first
        % data point depending on the value of code(i).
        for i=1:1:frames
            if(i>cLen)
                break % end loop once all code is inserted.
            end
            % Transform and flip the bit, if necessary.
            fY(:,i) = fft(y((fSize*(i-1)+1):(fSize*i))); % Fourier transform
            fY(1,i)=fY(1,i)-real(fY(1,i))+abs(real(fY(1,i)))*(2*str2num(code(i))-1);
        end
        % Unused end of file. Must be attached for consistency.
        fEnd=i;

        % Convert back into a vector
        sY=ifft(fY);
        rY=[];
        for i=1:1:cLen
            rY=[rY;real(sY(:,i))];
        end
        
        % Append the unframed value at the end of the audio file.
        dY=[rY;y((fSize*(fEnd-1)+1):end)];

        out(:,n)=dY;
    end
end