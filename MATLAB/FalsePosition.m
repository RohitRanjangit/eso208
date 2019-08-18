function [str,root,bracket_sizes,iter] = FalsePosition(f_x,a,b,max_rel_error,f_min,max_iter,iter,bracket_sizes)
%this function for FalsePosition method
    bracket_size = abs(a-b);
    
    iter = iter +1;
    bracket_sizes(end+1) = bracket_size;
    next = a - ((b-a)/(f_x(b)-f_x(a)))*f_x(a);
    root = next;
    if f_x(next) == 0
        disp("exact root found");
        str = ['function has reached it-s minimum value ' num2str(feval(f_x,next))];
        return ;
    end
    if iter > max_iter
        str = 'iteration limit reached';
        return ;
    end

    if abs(feval(f_x,next)) < f_min
        str = ['function has reached it-s minimum value ' num2str(feval(f_x,next))];
        return;
    end
    if bracket_size  <= max_rel_error
        str = ['bracketing size becomes lesser than threshold which is ' num2str(bracket_size)];
        return;
    end

    
    if feval(f_x,next)*feval(f_x,a) < 0
       [str,root,bracket_sizes,iter] = FalsePosition(f_x,a,next,max_rel_error,f_min,max_iter,iter,bracket_sizes);
    else 
       [str,root,bracket_sizes,iter] = FalsePosition(f_x,next,b,max_rel_error,f_min,max_iter,iter,bracket_sizes);
    end
    
end

