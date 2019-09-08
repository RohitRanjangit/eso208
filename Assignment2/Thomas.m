function x = Thomas(n,alpha,beta,u)
    x= zeros(1,n);
    for i = n:-1:1
        if i == n
            x(n) = beta(n)/alpha(n);
        else
            x(i) = (beta(i)- u(i)*x(i+1))/alpha(i);
        end
    end
end

