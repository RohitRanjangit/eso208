res = input('Is your equation/function is polynomial? Y/N \n','s');
if isempty(res)
    res = 'Y';
elseif res == 'y'
    res = 'Y';
elseif res == 'n'
    res = 'N';
end

if res == 'N'
   disp('**Choose your iteration method**');
   prompt =join({
       ' Press 1 for Bisection method\n'
       'Press 2 for False-position\n'
       'Press 3 for Fixed-Point\n'
       'Press 4 for Newton-Raphson\n'
       'Press 5 for Secant Method\n'
   }); 
   method = input(prompt{1},'s');
   switch method
       case '1'
           
           disp("**bisection - method**");
           
           %y = feval(f,x) ;
           
           str = input('Enter your function f(x):\n','s');
           f_x = str2func(['@(x)',str]);
           x0 = input('Enter 1st starting point: ');
           x1 = input('Enter 2nd starting point: ');
           
           while x1 == x0
               disp("Oops you have entered same value as of 1st starting point.Try other")
               x1 = input('Enter 2nd starting point: ');
           end
           while f_x(x0)*f_x(x1)>0
               disp("There is no root between selected points try again");
               x0 = input('Enter 1st starting point: ');
               x1 = input('Enter 2nd starting point: ');
           
               while x1 == x0
                   disp("Oops you have entered same value as of 1st starting point.Try other")
                   x1 = input('Enter 2nd starting point: ');
               end
           end
           
           
           %take input of stopping criterias %
           disp("==Now, Enter three stopping criterias==");
           max_rel_error = input("Convergence criterion for relative approximate errors in successive iterations in % : ");
           f_min = input("Convergence criteria for the function value: ");
           max_iter = input("Maximum iteration number (must be integer): ");
           
           [str,root,bracket_sizes,iter] = bisection(f_x,x0,x1,max_rel_error/100,f_min,max_iter,0,[]);
           disp(str);
           disp(['your expected root is: ' num2str(root,'%20d')]);
           disp(['no. of iterations: ' num2str(iter)]);
           temp = size(bracket_sizes);
           x_iter =1:temp(2) ;
           x = linspace(x0-5,x1+15,5000);
           y = [];
           for i = x
               y(end+1) = f_x(i);
           end
           if abs(f_x(root)) > f_min
               disp("root not found in given conditions");
           end
           plot(x_iter,bracket_sizes,x,y);
           
       case '2'
           
           disp("**False - Position**");
           
           str = input('Enter your function f(x):\n','s');
           f_x = str2func(['@(x)',str]);
           
           x0 = input('Enter 1st starting point: ');
           x1 = input('Enter 2nd starting point: ');
           while x1 == x0
               disp("Oops you have entered same value as of 1st starting point.Try other")
               x1 = input('Enter 2nd starting point: ');
           end
           while f_x(x0)*f_x(x1)>0
               disp("There is no root between selected points try again");
               x0 = input('Enter 1st starting point: ');
               x1 = input('Enter 2nd starting point: ');
           
               while x1 == x0
                   disp("Oops you have entered same value as of 1st starting point.Try other")
                   x1 = input('Enter 2nd starting point: ');
               end
           end
           
           
           %take input of stopping criterias %
           disp("==Now, Enter three stopping criterias==");
           max_rel_error = input("Convergence criterion for relative approximate errors in successive iterations in % : ");
           f_min = input("Convergence criteria for the function value: ");
           max_iter = input("Maximum iteration number (must be integer): ");
           
           [str,root,bracket_sizes,iter] = FalsePosition(f_x,x0,x1,max_rel_error/100,f_min,max_iter,0,[]);
           disp(str);
           disp(['no. of iterations: ' num2str(iter)]);
           disp(['your expected root is: ' num2str(root,'%20d')]);
           temp = size(bracket_sizes);
           x_iter =1:temp(2) ;
           x = linspace(x0-5,x1+15,5000);
           y = [];
           for i = x
               y(end+1) = f_x(i);
           end
           if abs(f_x(root)) > f_min
               disp("root not found in given conditions");
           end
           plot(x_iter,bracket_sizes,x,y);
           
       case '3'
           
           disp("**Fixed- point**");
           disp("you should express your function in x = g(x) form");
           str = input('Enter your function f(x):\n','s');
           g_x = str2func(['@(x)',str]);
           x0 = input('Enter initial guess: ');
           
           
           %take input of stopping criterias %
           disp("==Now, Enter three stopping criterias==");
           max_rel_error = input("Convergence criterion for relative approximate errors in successive iterations in % : ");
           max_iter = input("Maximum iteration number (must be integer): ");
           
           [str,root,relative_errors,iter] = FixedPoint(g_x,x0,max_rel_error,max_iter,0,[]);
           disp(str);
           disp(['no. of iterations: ' num2str(iter)]);
           if iter< max_iter
               disp(['your expected root is: ' num2str(root,'%20d')]);
           else
               disp("root not found in above conditions");
               disp(['your expected value of iterate is: ' num2str(root,'%20d')]);
           end
           temp = size(relative_errors);
           x_iter =1:temp(2) ;
           x = linspace(x0-15,x0+15,6000);
           y = [];
           for i = x
               y(end+1) = g_x(i);
           end
           
           plot(x_iter,relative_errors,x,y);
       case '4'
           
           disp("**Newton-Raphson**\n");
           disp("You need to calculate derivative of f(x)\n");
           str = input('Enter your function f(x):\n','s');
           f_x = str2func(['@(x)' ,str]);
           str = input("Enter derviavte of f(x) is f'(x):\n",'s');
           f_d_x = str2func(['@(x)' ,str]);
           x0 = input('Enter initial guess:');
           
           
           %take input of stopping criterias %
           disp("==Now, Enter three stopping criterias==");
           max_rel_error = input("Convergence criterion for relative approximate errors in successive iterations in % : ");
           f_min = input("Convergence criteria for the function value: ");
           max_iter = input("Maximum iteration number (must be integer): ");

           [str,root,relative_errors,iter] = NewtonRaphson(f_x,f_d_x,x0,f_min,max_rel_error,max_iter,0,[]);
           disp(str);
           disp(['no. of iterations: ' num2str(iter)]);
           
           if iter< max_iter
               disp(['your expected root is: ' num2str(root,'%20d')]);
           else
               disp("root not found in above conditions");
               disp(['your expected value of iterate is: ' num2str(root,'%20d')]);
           end
           temp = size(relative_errors);
           x_iter =1:temp(2) ;
           x = linspace(x0-15,x0+15,6000);
           y = [];
           for i = x
               y(end+1) = f_x(i);
               
           end
           
           plot(x_iter,relative_errors,x,y);
           
       otherwise
           disp("**Secant Method**");
           str = input('Enter your function f(x):\n','s');
           f_x = str2func(['@(x)',str]);
           
           x0 = input('Enter 1st starting point: ');
           x1 = input('Enter 2nd starting point: ');
           while x1 == x0
               disp("Oops you have entered same value as of 1st starting point.Try other")
               x1 = input('Enter 2nd starting point: ');
           end
           
           
           %take input of stopping criterias %
           disp("==Now, Enter three stopping criterias==");
           max_rel_error = input("Convergence criterion for relative approximate errors in successive iterations in % : ");
           f_min = input("Convergence criteria for the function value: ");
           max_iter = input("Maximum iteration number (must be integer): ");
           
           [str,root,relative_errors,iter] = secant(f_x,x0,x1,f_min,max_rel_error,max_iter,0,[]);
           disp(str);
           disp(['no. of iterations: ' num2str(iter)]);
           
           if iter< max_iter
               disp(['your expected root is: ' num2str(root,'%20d')]);
           else
               disp("root not found in above conditions");
               disp(['your expected value of iterate is: ' num2str(root,'%20d')]);
           end
           temp = size(relative_errors);
           x_iter =1:temp(2) ;
           x = linspace(x0-15,x0+15,6000);
           y = [];
           for i = x
               y(end+1) = f_x(i);
               
           end
           
           plot(x_iter,relative_errors,x,y);
   end
   
else 
   disp("**you have to enter a n-degree polynomial**");
   n = input("Enter degree of polynomial p(x): ");
   
   while n - floor(n) %#ok<BDLOG>
       disp("Oops it seems you haven't entered interger value. Try Again::");
       n = input("Enter degree of polynomial p(x): ");
   end
   
   %vector = zeros(1,n+1);
   %disp("**now enter coefficients of polynoamil p(x)**");
   %for x = 1:n+1
   %   prompt = ['Enter a' num2str(x-1) ' coefficient of polynomial: '];
   %    vector(x) = input(prompt);
   %end
   vector = input("Enter coefficents of polynomail in vector form\ni.e for p(x) = 3x^2 + 2x +1 vector input is [1 2 3]\n");
   temp = size(vector);
   while temp(2)~= n+1
       disp('vector you have entered is not valid for polynomial of degree you had entered. try again');
       vector = input("Enter coefficents of polynomail in vector form\ni.e for p(x) = 3x^2 + 2x +1 vector input is [1 2 3]\n");
       temp = size(vector);
   end
   
   
   disp('**Choose your iteration method**');
   
   prompt =join({
       ' Press 1 for Muller method\n'
       'Press 2 for Bairstow Method\n'
   });

   method = input(prompt{1},'s');
   
   if method == '1'
       disp("**Muller Method**");
       x0 = input('Enter 1st starting point: ');
       x1 = input('Enter 2nd starting point: ');
       
       while x1 == x0
           disp("Oops you have entered same value as of 1st starting point.Try other")
           x1 = input('Enter 2nd starting point: ');
       end
       
       x2 = input('Enter 3rd starting point: ');
       while x2==x1 || x2 == x0
           disp("Oops you have entered same value as of 1st starting point or 2nd starting point.Try other");
           x2 = input('Enter 3rd starting point: ');
       end
       
       
       %take input of stopping criterias %
       disp("==Now, Enter three stopping criterias==");
       max_rel_error = input("Convergence criterion for relative approximate errors in successive iterations in % : ");
       f_min = input("Convergence criteria for the function value: ");
       max_iter = input("Maximum iteration number (must be integer): ");
       
       [str,root,relative_errors,iter] = muller(n,vector,x0,x1,x2,f_min,max_rel_error,max_iter,0,[]);
           disp(str);
           disp(['no. of iterations: ' num2str(iter)]);
           
           if iter< max_iter
               disp(['your expected root is: ' num2str(root,'%20d')]);
           else
               disp("root not found in above conditions");
               disp(['your expected value of iterate is: ' num2str(root,'%d')]);
           end
           temp = size(relative_errors);
           x_iter =1:temp(2) ;
           x = linspace(-20,20,6000);
           y = [];
           for i = x
               y(end+1) = polynomial(n,vector,i);
               
           end
           
           plot(x_iter,relative_errors,x,y);
           
           
   else
       
       disp("**Bairstow Method**");
       r = input("Enter your r: ");
       s = input("Enter your s: ");
       
       
       %take input of stopping criterias %
       disp("==Now, Enter three stopping criterias==");
       max_rel_error = input("Convergence criterion for relative approximate errors in successive iterations in % : ");
       max_iter = input("Maximum iteration number (must be integer): ");
       
       [str,r,s,rel_errors_r,rel_errors_s,iter] = bairstow(n,vector,r,s,max_rel_error,max_iter,0,[],[]);
           disp(str);
           disp(['no. of iterations: ' num2str(iter)]);
           
           disp(['expected value of r: ' num2str(r) 'and s: ' num2str(s)]);
           temp = size(rel_errors_r);
           x_iter_r =1:temp(2) ;
           temp = size(rel_errors_s);
           x_iter_s =1:temp(2) ;
           x = linspace(-20,20,6000);
           y = [];
           for i = x
               y(end+1) = polynomial(n,vector,i);
               
           end
           
           plot(x,y,x_iter_r,rel_errors_r,x_iter_s,rel_errors_s);
       
   end
end
