function bOut=bInCorrect(bIn)
% Re-assigns each most commonly used character to a bit with three 0's and
% three 1's. With 6 bits, we have 6 choose 3 equals 20 possible
% combinations. Each valid hexadecimal number and '-' will be assigned.
% Some characters already have such assignments and are therefore excluded.

% Unfortunately we must do this case by case.

    for i=1:1:length(bIn) % In case we input multipel bits...
        bOut(i)=bIn(i); % Initial value.
        switch bIn(i)
            case 'H'
                bOut(i)='A';
            case 'L'
                bOut(i)='B';
            case 'N'
                bOut(i)='C';
            case 'O'
                bOut(i)='D';
            case 'T'
                bOut(i)='E';
            case 'V'
                bOut(i)='F';
            case 'W'
                bOut(i)='1';
            case 'Z'
                bOut(i)='3';
            case 'a'
                bOut(i)='4';
            case 'b'
                bOut(i)='5';
            case 'e'
                bOut(i)='6';
            case 'f'
                bOut(i)='7';
            case 'h'
                bOut(i)='8';
            case 'm'
                bOut(i)='-';
            case 'A'
                bOut(i)='H';
            case 'B'
                bOut(i)='L';
            case 'C'
                bOut(i)='N';
            case 'D'
                bOut(i)='O';
            case 'E'
                bOut(i)='T';
            case 'F'
                bOut(i)='V';
            case '1'
                bOut(i)='W';
            case '3'
                bOut(i)='Z';
            case '4'
                bOut(i)='a';
            case '5'
                bOut(i)='b';
            case '6'
                bOut(i)='e';
            case '7'
                bOut(i)='f';
            case '8'
                bOut(i)='h';
            case '-'
                bOut(i)='m';
        end
    end
end