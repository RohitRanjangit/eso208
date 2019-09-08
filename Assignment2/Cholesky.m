function [L,x,log] = Cholesky(A,B,n)
    L = zeros(n);
    log = [""];
    for k = 1:n
        X = A(k:n,k:n);
        [p,q] =find(X == max(X(:)));
        if p==k && q==k
            temp = A(:,k);
            A(:,k) = A(:,q);
            A(:,q) = temp;
            temp = A(k,:);
            A(k,:) = A(p,:);
            A(p,:) = temp;
            log(end+1) = ['column: ' num2str(k) ' ' num2str(q) ' row: ' num2str(k) ' ' num2str(p)];         
        end
    end
    for j = 1:n
        L(j,j) = sqrt(A(j,j) - L(j,:)*(L(j,:))');
        for i = (j+1):n
            L(i,j) = (A(i,j) - L(j,:)*(L(i,:))')/L(j,j);
        end
    end
    %disp(L);
    U = L';
    y = zeros(1,n);
    x = zeros(1,n);
    for i = 1:n
        y(i) = (B(i) - y*L(i,:)')/L(i,i);
    end
    
    for i = n:-1:1
        x(i) = (y(i) - x*U(i,:)')/U(i,i);
    end
    
    s = size(log);
    for i = 2:s(2)
        idx = sscanf(log(i),'column: %d %d row: %d %d');
        tempx = x(idx(1));
        x(idx(1)) = x(idx(2));
        x(idx(2)) = tempx;
    end
    log = log(2:s(2));
end

