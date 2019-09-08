function [EigenValue,EigenVector,iters] = Power(n,A,error)
    y = zeros(n,1);
    y(1) = 1;
    x  = zeros(n,1);
    iters =0;
    while abs(max(y-x)) > error
        x = y;
        z = A*y;
        y = z/norm(z);
        iters = iters+1;
    end
    EigenVector = y;
    EigenValue = (y'*A*y)/(y'*y);
end

