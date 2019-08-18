function [str,root,relative_errors,iter] = NewtonRaphson(f_x,f_d_x,a,f_min,max_rel_error,max_iter,iter,relative_errors)
    iter = iter+1;

    next = a - f_x(a)/f_d_x(a);
    relative_error = abs((next-a)/a);

    relative_errors(end+1) = relative_error;
    root = next;
    if iter>max_iter
       str =  'maximum iteration limit reached';
       return;
    end

    if relative_error*100 <= max_rel_error
        str = ['relative error can-t lesser than it-s limit, relative_error: ' num2str(relative_error)];
        return;
    else
        [str,root,relative_errors,iter] = NewtonRaphson(f_x,f_d_x,next,f_min,max_rel_error,max_iter,iter,relative_errors);
    end
    if abs(f_x(next)) < f_min
        str = ['function value at this point can-t be lower than it-s limit, f-value: ' num2str(f_x(next))];
        return;
    end

end
