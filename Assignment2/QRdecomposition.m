function [EigenValues_updated,iters] = QRdecomposition(n,A,error,iters,EigenValues)
    iters = iters +1;
    q = zeros(n);
    for k = 1:n
        if k ==1
            q(:,k) = A(:,k)/norm(A(:,k));
        else
            temp = zeros(n,1);
            for i = 1: k - 1
                temp = temp + (A(:,k)' *q(:,i))*q(:,i);
            end
            z = A(:,k) - temp;
            q(:,k) = z/norm(z);
        end
    end
    
    r = q'*A;
    A = r*q;
    EigenValues_updated = diag(A);
    rel_error = 100;
    if iters >1
        diff = EigenValues_updated - EigenValues;
        for i = 1:n
            diff(i) = diff(i)/EigenValues(i);
        end
        rel_error = max(diff);
    end
    if rel_error < error 
        return;
    else
        [EigenValues_updated,iters] = QRdecomposition(n,A,error,iters,EigenValues_updated);
    end
    
    
    
end

