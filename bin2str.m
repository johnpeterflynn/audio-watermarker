function out=bin2str(bIn)
% Converts a string of binary values to a string of characters.
    lenB=length(bIn);
%    if(mod(lenB,6)~=0)
%        fprintf('ERROR in bin2str: bIn is not a multiple of 6.\n');
%    end
    for i=1:1:lenB/6;
        D(i)=bin2dec(bIn((6*(i-1)+1):(6*i))); % Get the decimal value.
        
        % We are basically adding num back to the value sIn(i) from
        % str2bin(). This method is very clean and intuitive.
        if(D(i)>=0 && D(i)<=25) % "A-Z"  select its adder
            num=65;
        elseif(D(i)>=26 && D(i)<=35) % "0-9"
            num=22;
        elseif(D(i)==36) % "-"
            num=9;
        elseif(D(i)>=37 && D(i)<=62) % "a-z"
            num=60;
        elseif(D(i)==63) % "\"  This serves as a break for the watermark
            num=29;
        end
        out(i)=bInCorrect(char(D(i)+num)); % Add back num and convert to char.
    end

end