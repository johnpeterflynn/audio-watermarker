function out=bXOR(b,num)
% Computes the XOR of a given number of bits in a string.
    bSum=0;
    for i=1:1:length(num)
        bSum=bSum+str2num(b(num(i))); % add up all 1's.
    end
    out=num2str(mod(bSum,2)); % calculate bSum mod 2 to find the XOR.
end