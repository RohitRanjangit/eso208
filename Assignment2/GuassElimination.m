function x = GuassElimination(A,B,n)
    for k = 1:n
        for i = k+1:n
            pivot = k;
            if A(k,k)==0
                for z = k+1:n
                    if A(z,k) ~=0 
                        pivot = z;
                        break;
                    end
                end
            end
            temp = A(k,:);
            A(k,:) = A(pivot,:);
            A(pivot,:) = temp;
            l = A(i,k)/A(k,k);
            A(i,:) = A(i,:)-l*A(k,:);
            B(i) = B(i) - l* B(k);
        end
    end
    disp(A)
    x = zeros(1,n);
    for i  = n:-1:1
        x(i) = (B(i)- x*A(i,:)')/A(i,i);
    end
end

