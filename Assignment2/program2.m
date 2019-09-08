filename = input("Enter file name to read input: ",'s');
filename = [filename '.txt'];
fileID = fopen(filename);
n = textscan(fileID,'%d',1);
n = n{1};
formatSpec = repmat('%f ',1,n);
%disp(formatSpec);
data = textscan(fileID,formatSpec,n);
error = textscan(fileID,'%f',1);
fclose(fileID);
error = error{1}/100;
A = zeros(n);
for i = 1:n
    A(:,i) = data{i};
end
prompt = "Press L for Largest Eigen-Value\nPress A for All Eigen Values\nResponse: ";
resp = input(prompt,'s');
if isempty(resp)
    resp = 'L';
end
if resp == 'l'
    resp = 'L';
else
    if resp == 'a'
        resp = 'A';
    end
end
if resp == 'L'
    [EigenValue,EigenVector,iters] = Power(n,A,error);
    outputfile = input("Enter file name to store output: ",'s');
    ouptutfile = [outputfile '.txt'];
    fileID = fopen(outputfile,'w');
    fprintf(fileID,'Eigen Value\n');
    fprintf(fileID,'%f\n',EigenValue);
    fprintf(fileID,'\nEigen Vector\n');
    fprintf(fileID,'%f\n',EigenVector);
    fprintf(fileID,'\nIterations\n');
    fprintf(fileID,'%d\n',iters);
    fclose(fileID);
    type (outputfile);
else
    [EigenValues_updated,iters] = QRdecomposition(n,A,error,0,zeros(n,1));
    outputfile = input("Enter file name to store output: ",'s');
    ouptutfile = [outputfile '.txt'];
    fileID = fopen(outputfile,'w');
    fprintf(fileID,'Eigen Values\n');
    fprintf(fileID,'%f\n',EigenValues_updated);
    fprintf(fileID,'\nIterations\n');
    fprintf(fileID,'%d\n',iters);
    fclose(fileID);
    type (outputfile);
end
    
