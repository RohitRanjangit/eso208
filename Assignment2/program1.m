disp("** PROGRAMMING ASSIGNMENT-2 **");
%{
Initial input screen should have the following choices:
A. Solve a System of Equation
B. Perform a LU decomposition
C. Perform a Matrix Inversion
%}
prompt = [
    "Press A for Solving a System of Equation\n"
    "Press B for performing a LU decomposition\n"
    "Press C for performing a Matrix Inversion\n"
    "\nYour Response: "
    ];
prompt = strjoin(prompt,'');
resp = input(prompt,'s');
switch resp
    case 'A'
        f_resp = input("\nIs system  tri-diagonal (in Y/N) : ",'s');
        if isempty(f_resp)
            f_resp = 'Y';
        end
        if f_resp == 'y'
            f_resp = 'Y';
        else
            if f_resp == 'n'
                f_resp = 'N';
            end
        end
        if f_resp == 'Y'
            filename = input("Enter file name to read input: ",'s');
            filename = [filename '.txt'];
            fileID = fopen(filename);
            n = textscan(fileID,'%d',1);
            n = n{1};
            formatSpec = ['%s : ' repmat('%f ',1,n)];
            %disp(formatSpec);
            data = textscan(fileID,formatSpec);
            l= zeros(1,n);
            d = zeros(1,n);
            u= zeros(1,n);
            b = zeros(1,n);
            alpha = zeros(1,n);
            beta = zeros(1,n);
            for i = 1:n
                l(i) = data{i+1}(1);
                d(i) = data{i+1}(2);
                u(i) = data{i+1}(3);
                b(i) = data{i+1}(4); 
            end
            for i = 1:n
                if i==1
                    alpha(i) = d(i);
                    beta(i)= b(i);
                else
                    alpha(i)= d(i) - l(i)*u(i-1)/alpha(i-1);
                    beta(i)=  b(i) - l(i)*beta(i-1)/alpha(i-1);
                end
                
            end
            [x] = Thomas(n,alpha,beta,u);
            %celldisp(data);
            fclose(fileID);
            outputfile = input("Enter file name to store output: ",'s');
            ouptutfile = [outputfile '.txt'];
            fileID = fopen(outputfile,'w');
            fprintf(fileID,'* THOMAS ALGORITHM*\n');
            fprintf(fileID,'x\n');
            fprintf(fileID,'%f\n',x);
            fclose(fileID);
            type (outputfile);
        else
            filename = input("Enter file name to read input: ",'s');
            filename = [filename '.txt'];
            fileID = fopen(filename);
            n = textscan(fileID,'%d',1);
            n = n{1};
            formatSpec = repmat('%f ',1,n+1);
            %disp(formatSpec);
            data = textscan(fileID,formatSpec);
            A = zeros(n);
            for i = 1:n
                A(:,i) = data{i};
            end
            B = data{n+1};
            [x] = GuassElimination(A,B,n);
            %celldisp(data);
            fclose(fileID);
            outputfile = input("Enter file name to store output: ",'s');
            ouptutfile = [outputfile '.txt'];
            fileID = fopen(outputfile,'w');
            fprintf(fileID,'*GUASSIAN_ELIMINATION*\n');
            fprintf(fileID,'x\n');
            fprintf(fileID,'%f\n',x);
            fclose(fileID);
            type (outputfile);
        end
    case 'B'   
        f_resp = input("Is your matrix is symmetric and positive definite in(Y/N) : ",'s');
        if isempty(f_resp)
            f_resp = 'Y';
        end
        if f_resp == 'y'
            f_resp = 'Y';
        else
            if f_resp == 'n'
                f_resp = 'N';
            end
        end
        if f_resp == 'Y'
            filename = input("Enter file name to read input: ",'s');
            filename = [filename '.txt'];
            fileID = fopen(filename);
            n = textscan(fileID,'%d',1);
            n = n{1};
            formatSpec = repmat('%f ',1,n+1);
            %disp(formatSpec);
            data = textscan(fileID,formatSpec);
            A = zeros(n);
            for i = 1:n
                A(:,i) = data{i};
            end
            B = data{n+1};
            %disp(A);
            %disp(B);
            [L,x,log] = Cholesky(A,B,n);
            %celldisp(data);
            fclose(fileID);
            outputfile = input("Enter file name to store output: ",'s');
            ouptutfile = [outputfile '.txt'];
            fileID = fopen(outputfile,'w');
            formatSpec = repmat('%f ',1,n);
            formatSpec = [formatSpec '\n'];
            fprintf(fileID,'* CHOLESKY METHOD*\n');
            fprintf(fileID,'x\n');
            fprintf(fileID,'%f\n',x);
            fprintf(fileID,'L\n');
            fprintf(fileID,formatSpec,L');
            fprintf(fileID,'log of exchanges\n');
            fprintf(fileID,'%s\n',log);
            fclose(fileID);
            type(outputfile);
        else
            filename = input("Enter file name to read input: ",'s');
            filename = [filename '.txt'];
            fileID = fopen(filename);
            n = textscan(fileID,'%d',1);
            n = n{1};
            formatSpec = repmat('%f ',1,n+1);
            %disp(formatSpec);
            data = textscan(fileID,formatSpec);
            A = zeros(n);
            for i = 1:n
                A(:,i) = data{i};
            end
            B = data{n+1};
            prompt = [
                "Press 1 for Crout method\n"
                "Press 2 for Doolittle method: "
                ];
            prompt = strjoin(prompt,'');
            method = input(prompt);
            if method ~=1
                method = 2;
            end
              
            [x,L,U,log] = LUdecomposition(A,B,n,method);
            %celldisp(data);
            fclose(fileID);
            outputfile = input("Enter file name to store output: ",'s');
            ouptutfile = [outputfile '.txt'];
            fileID = fopen(outputfile,'w');
            fprintf(fileID,'*LU decomposition*\n');
            if method == 1
                method = 'Crout Method';
            else
                method = 'Doolittle Method';
            end
            formatSpec = repmat('%f ',1,n);
            formatSpec = [formatSpec '\n'];
            fprintf(fileID,'%s\n',method);
            fprintf(fileID,'x\n');
            fprintf(fileID,'%f\n',x);
            fprintf(fileID,'L\n');
            fprintf(fileID,formatSpec,L');
            fprintf(fileID,'U\n');
            fprintf(fileID,formatSpec,U');
            fprintf(fileID,'%s\n',log);
            fclose(fileID);
            type (outputfile);
        end
    otherwise
        filename = input("Enter file name to read input: ",'s');
        filename = [filename '.txt'];
        fileID = fopen(filename);
        n = textscan(fileID,'%d',1);
        n = n{1};
        formatSpec = repmat('%f ',1,n);
        %disp(formatSpec);
        data = textscan(fileID,formatSpec);
        fclose(fileID);
        A = zeros(n);
        for i = 1:n
            A(:,i) = data{i};
        end
        [B] = GuassJordan(n,A);
        outputfile = input("Enter file name to store output: ",'s');
        ouptutfile = [outputfile '.txt'];
        fileID = fopen(outputfile,'w');
        fprintf(fileID,'* Guass Jordan Elimination *\n');
        fprintf(fileID,'Inverse of A: \n');
        formatSpec = repmat('%f ',1,n);
        formatSpec = [formatSpec '\n'];
        fprintf(fileID,formatSpec,B');
        fclose(fileID);
        type (outputfile);
end
   

