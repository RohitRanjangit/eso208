function [str,root,relative_errors,iter] = muller(n,vector,a,b,c,f_min,max_rel_error,max_iter,iter,relative_errors)
    iter = iter+1;
    
    c_new = p_x(n,vector,c);
    
    b_new = divided_diff(n,vector,c,b) + (c-b)*super_divided_diff(n,vector,c,b,a);
    
    a_new = super_divided_diff(n,vector,c,b,a);
    real_part =real((b_new+ sqrt(b_new^2 - 4*a_new*c_new))/(2*a_new));
    if isnan(real_part)
        real_part=0;
    end
    c_next = c - real_part;
    %disp(c_next);
    
    relative_error = abs((c_next-c)/c_next);
    relative_errors(end+1) = relative_error;
    root = c_next;
    if iter>max_iter
       str =  'maximum iteration limit reached';
       return;
    end

    if relative_error*100 <= max_rel_error
        str = ['relative error can-t lesser than it-s limit, relative_error: ' num2str(relative_error)];
        return;
    else
        [str,root,relative_errors,iter] = muller(n,vector,b,c,c_next,f_min,max_rel_error,max_iter,iter,relative_errors);
    end
    if abs(p_x(n,vector,root)) < f_min
        str = ['function value at this point can-t be lower than it-s limit, f-value: ' num2str(p_x(n,vector,root))];
        return;
    end
end


function p_value = p_x(n,vector,x)
    p_value =0 ;
    for i = 1:n+1
        p_value = p_value+ vector(i)*(x^(i-1));
    end
end

function value = divided_diff(n,vector,c,b)
    p_b = p_x(n,vector,b);
    p_c = p_x(n,vector,c);
    value = (p_c - p_b)/(c-b);
end

function super_value = super_divided_diff(n,vector,c,b,a)
    dd_c_b = divided_diff(n,vector,c,b);
    dd_b_a = divided_diff(n,vector,b,a);
    super_value = (dd_c_b-dd_b_a)/(c-a);
end

