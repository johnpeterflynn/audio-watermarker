% John Flynn
% Section 5, Final Project

% Clear window.
clear;
clc;

% Default values
key=[31,12,7,10,26,34,75,2,19]; % random key
exampleRun=0;
fSize=3969; % 90ms intervals.
ErrChk=1; % error checking on.
Message='ENG6-2011-UCD'; % watermark string.
File='BrickHouse'; % example file.
Quant=0; % quantization off.
vQuant=0.01; % quantization level.
LowPass=0; % lowpass filtering off.
vLowPass=0.4; % filter floor percentage.

fprintf('==== Introduction - Stage 1 ====\n');
fprintf('Hello and welcome to the Digital Audio Watermarking Program by John Flynn!\n');
fprintf('This program can input a wave file of any length and add a hidden user-specified string.\n');

if(ynCheck('Would you like to see an example run(y/n)?\n')=='y')
    exampleRun=1;
    fprintf('==== Data Entry - Stage 2a ====\n');
    Message='ENG6-2011-UCD'; % watermark string.
    File='dramatic'; % example file 1.
else % Allow the user to specify input.
    fprintf('==== Data Entry - Stage 2b ====\n');
    File=input('Please specify a valid file name:\n','s'); % File name
    Message=input('Please specify a watermark string using [A-Z][a-z][0-9][-]:\n','s'); % watermark
    if(ynCheck('Would you like to modify the frame size(y/n)?\n')=='y') % Frame size
        fSize=input('Please enter a frame size:\n');
    end
    if(ynCheck('Would you like to turn off error checking(y/n)?\n')=='y') % Error checking
        ErrChk=0;
    end
end
fprintf('==== Watermark Integration - Stage 3 ====\n');
fprintf('-Settings-\n'); % Summary of options
fprintf('File:%s\n',File);
fprintf('Watermark:%s\n',Message);
fprintf('Frame Size:%5.0f\n',fSize);
fprintf('Error Checking:%1.0f\n',ErrChk);

% read the wave file selected.
[y2,fs]=wavread(File);
fy=addWM(y2,fSize,Message,key,ErrChk);

% Display Spectrograms
subplot(2,1,1);
specgram(y2(:,1));
title('Sound file before encoding');
subplot(2,1,2);
specgram(fy(:,1));
title('Sound file after encoding');

fprintf('==== Testing - Stage 4 ====\n'); % Test the product.
if(ynCheck('Would you like to play the watermarked sound file?\n')=='y')
    sound(fy,fs);
end
if(ynCheck('Would you like to save the watermarked sound file?\n')=='y')
    name=input('Please enter a file name:\n','s');
    wavwrite(fy,fs,name);
end

% Decoding.
fprintf('==== Decoding - Stage 5 ====\n'); % Decode the product.
name=input('Please enter a file name for decoding:\n','s');
[fy,fs]=wavread(name);

if(ynCheck('Would you like to modify the frame size(y/n)?\n')=='y') % frame sized used above.
    fSize=input('Please enter a frame size:\n');
end
if(ynCheck('Would you like to turn off error checking(y/n)?\n')=='y') % options used above.
    ErrChk=0;
end
if(ynCheck('Would you like to enable quantization(y/n)?\n')=='y') % Quantization attack
    fprintf('Max quantization suggested to preserve quality: -2.\n');
    power=input('Please enter the integer power of 10 you with to quantize by (e.g log 0.01=-2):\n');
    Quant=1;
    vQuant=10^round(power);
end
if(ynCheck('Would you like to enable lowpass filtering(y/n)?\n')=='y') % lowpass filter attack.
    fprintf('Max lowpass filtering suggested to preserve quality: 0.7.\n');
    perc=input('Please enter the percentage of high frequencies you would like to filter:\n');
    LowPass=1;
    vLowPass=1-perc;
end

% Attack the watermark:
if(Quant) % Quantization
    fy=quant(fy,vQuant);
end % Low Pass Filtering
if(LowPass)
    ffy=fft(fy); % Truncate a centain percentage.
    ffy(ceil(length(ffy)*vLowPass):end,:)=0;
    fy=real(ifft(ffy));
end

% Conclude the program. Display results.
fprintf('-Settings-\n');
fprintf('Frame Size:%5.0f\n',fSize);
fprintf('Error Checking:%1.0f\n',ErrChk);
fprintf('Quantization:%1.0f, Level:%2.4f\n',Quant,vQuant);
fprintf('Lowpass Filtering:%1.0f, Percentage:%2.4f\n',LowPass,1-vLowPass);

% Display extracted watermark.
fprintf('Watermark: %s\n',(extractWM(fy,fSize,key,ErrChk)));