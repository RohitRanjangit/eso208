function [str,root,bracket_sizes,iter] = bisection(f_x,a,b,max_rel_error,f_min,max_iter,iter,bracket_sizes)
%this function for bisection method
    bracket_size = abs(a-b);
    
    iter = iter +1;
    bracket_sizes(end+1) = bracket_size;
    mid = (a+b)/2;
    root  = mid ;
    
    if f_x(mid) == 0
        disp("exact root found");
        str = ['function has reached it-s minimum value ' num2str(feval(f_x,mid))];
        return ;
    end
    if iter > max_iter
        str = 'iteration limit reached';
        return ;
    end

    if abs(feval(f_x,mid)) < f_min
        str = ['function has reached it-s minimum value ' num2str(feval(f_x,mid))];
        return;
    end
    if bracket_size  <= max_rel_error
        str = ['bracketing size becomes lesser than threshold which is ' num2str(bracket_size)];
        return;
    end

    
    if feval(f_x,mid)*feval(f_x,a) < 0
       [str,root,bracket_sizes,iter] = bisection(f_x,a,mid,max_rel_error,f_min,max_iter,iter,bracket_sizes);
    else 
       [str,root,bracket_sizes,iter] = bisection(f_x,mid,b,max_rel_error,f_min,max_iter,iter,bracket_sizes);
    end
    
end

