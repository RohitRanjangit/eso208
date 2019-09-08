function [B] = GuassJordan(n,A)
    B = eye(n);
    for k = 1:n
        factor = A(k,k);
        B(k,:) = B(k,:)/factor;
        A(k,:) = A(k,:)/factor;
        for i = 1:n
            if i ~= k
                factor = A(i,k);
                A(i,:) = A(i,:) - factor *A(k,:);
                B(i,:) = B(i,:) - factor *B(k,:);
            end
        end
    end
end

