function [x,L,U,log] = LUdecomposition(A,B,n,method)
    L = zeros(n);
    U = zeros(n);
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
    if method == 1
        for j= 1:n
            for i = j:n
                L(i,j) = A(i,j) - L(i,:)*U(:,j);
            end
        end
        for i =1:n
            U(i,i) = 1.0000;
            for j = i+1:n
                U(i,j) = (A(i,j) - L(i,:)*U(:,j))/L(i,i);
            end
        end
    else
        for i = 1:n
            for j = i:n
                U(i,j) =  A(i,j) - L(i,:)*U(:,j);
            end
        end
        for j = 1:n
            L(j,j) = 1.0000;
            for i = j+1:n
                L(i,j) = (A(i,j) - L(i,:)*U(:,j))/U(j,j);
            end
        end
    end
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

