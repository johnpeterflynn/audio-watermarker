function out=str2bin(sIn)
% Converts a string into an array of binary numbers based on a predefined
% table.
    
    for i=1:1:length(sIn) % for each character
        sIn(i)=bInCorrect(sIn(i)); % Shift special bits.
        if(sIn(i)==45) % "-"  select its subtractor
            num=9;
        elseif(sIn(i)>=48 && sIn(i)<=57) % "0-9"
            num=22;
        elseif(sIn(i)>=65 && sIn(i)<=90) % "A-Z"
            num=65;
        elseif(sIn(i)==92) % "\"  This serves as a break for the watermark
            num=29;
        elseif(sIn(i)>=97 && sIn(i)<=122) % "a-z"
            num=60;
        else
            num=sIn(i)-63; % For invalid bits, return "\"
        end
        temp=dec2bin(sIn(i)-num); % get the binary value
        for j=1:1:6 % insert it into a matrix.
            lenT=length(temp);
            if(lenT<6)
                if(j<=6-lenT) % special case if temp is not 6 bits long.
                    B(i,j)='0';
                else
                    B(i,j)=temp(j-(6-lenT));
                end
            else
                B(i,j)=temp(j); % Save the result.
            end
        end
    end
    
    out=B(1,:); % Give out an initial value.
    for i=2:1:length(sIn) % "Convert" B from a matrix into an array.
        out=[out B(i,:)];
    end
    
end