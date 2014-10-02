function example=ynCheck(str)
% Ensures that the user enter correct input.
    while(true)
        example=input(str,'s');
        if(example=='y' || example=='n') % If y or n///
            break
        end
        % otherwise, ask again.
        fprintf('%s is not valid input. Please enter y or n.\n',example);
    end
end