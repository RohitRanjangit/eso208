function [str,r_new,s_new,rel_errors_r,rel_errors_s,iter] = bairstow(n,vector,r,s,max_rel_error,max_iter,iter,rel_errors_r,rel_errors_s)
    iter  = iter+1;
    b = zeros(1,n+1);
    b = calculate_elements(n,vector,r,s,n-1,b);
    c = zeros(1,n+1);
    c = calculate_elements(n,b,r,s,n-1,c);
    mat =  [c(2) c(3);c(3) c(4)]\[-b(1);-b(2)];
    r_new = r + mat(1);
    s_new = s + mat(2);
    rel_error_r = abs(mat(1)/r);
    rel_error_s = abs(mat(2)/s);
    rel_errors_r(end+1) = rel_error_r;
    rel_errors_s(end+1) = rel_error_s;
    
    if iter > max_iter
        str = ['maximum iteration limit reached r_current: ' num2str(r_new) ' s_current: ' num2str(s_new) ];
        return;
    end
    
    if rel_error_r*100 <= max_rel_error && rel_error_s*100 <= max_rel_error
        str = ['rel errors in r and s can-t be lesser than it-s limit rel error in r: ' num2str(rel_error_r) ' rel error in s: ' num2str(rel_error_s) ];
        return;
    else
        [str,r_new,s_new,rel_errors_r,rel_errors_s,iter] = bairstow(n,vector,r_new,s_new,max_rel_error,max_iter,iter,rel_errors_r,rel_errors_s);
    end
end


function array = calculate_elements(n,parentArray,r,s,i,array)
    array(n+1) = parentArray(n+1);
    array(n) = parentArray(n) + r*array(n+1);
    while(i>=1)
        array(i) = parentArray(i) + r*array(i+1) + s*array(i+2);
        i = i-1;
    end
end


