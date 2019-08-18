function p_value = polynomial(n,vector,x)
    p_value =0 ;
    for i = 1:n+1
        p_value = p_value+ vector(i)*(x^(i-1));
    end
end
