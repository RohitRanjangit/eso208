function [str,root,relative_errors,iter] = FixedPoint(g_x,a,max_rel_error,max_iter,iter,relative_errors)
%this function for Fixed -point method
    next = g_x(a);
    iter = iter+1;

    relative_error = abs((next - a)/a);
    root = next;
    relative_errors(end+1) = relative_error;
    if iter > max_iter 
        str = 'maximum iteration has reached';
        return;
    end
    
    if relative_error*100  <= max_rel_error
        str = ['relative error becomes lesser than it-s limit which is ' num2str(relative_error)];
        return;
    else
        [str,root,relative_errors,iter] = FixedPoint(g_x,next,max_rel_error,max_iter,iter,relative_errors);
    end

end

