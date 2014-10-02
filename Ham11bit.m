function bOut=Ham11bit(bIn)
% Accepts a string of bits and adds 4 check bits and 1 detection bit for
% every 11 data bits. These values will make it possible to detect and
% sometimes correct errors in the bit string.

    bLen=length(bIn);
    fbLen=floor(bLen/11);
    bOut=[];
    for i=1:1:fbLen % For every 11 bits...
        b=bIn((11*(i-1)+1):(11*i));
        temp(1)=bXOR(b,[1,2,4,5,7,9,11]); % ...calculate the check bit...
        temp(2)=bXOR(b,[1,3,4,6,7,10,11]);
        temp(3)=b(1); % ...and insert each data bit.
        temp(4)=bXOR(b,[2,3,4,8,9,10,11]);
        temp(5)=b(2);
        temp(6)=b(3);
        temp(7)=b(4);
        temp(8)=bXOR(b,(5:1:11));
        temp(9)=b(5);
        temp(10)=b(6);
        temp(11)=b(7);
        temp(12)=b(8);
        temp(13)=b(9);
        temp(14)=b(10);
        temp(15)=b(11);
        temp(16)=bXOR(temp,(1:1:15)); % calculate the detection bit.
        
        bOut=[bOut temp]; % append values.
    end
    if(mod(bLen,11)~=0)
        bOut=[bOut bIn((fbLen*11+1):end)];
    end
end