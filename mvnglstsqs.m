function [data RMSE] = mvnglstsqs(data,RMSE,q,n,wf,alpha)
% data contains all the trains i.e. Diagonal, Horizontal and Vertical in that order
% q is a parameter that needs tuning. Ideally use an optimiser and consider
% RMSE to be the variable to minimise. 
% n is the basis function to use. 1 is linear basis i.e. A + Bx + Cy; 2 is
% quadratic basis i.e. A + Bx + Cy + Dxy + Ex^2+ Fy^2 and 3 is quadratic
% basis including an exponential term
% wf is the weight function to use. Where 1 is cubic, 2 is exponential and
% 3 is quartic weight function
% alpha is a variable associated with the exponential spline function hence
% required if expoential function is to be used

%% Code Adopted and modified from Github 
% https://github.com/louiemay/Moving-Least-Square
% Modification include compatibility with data structure and most
% importantly extention to multidimensional/extra features-although basis functions needs
% address for completeness

p = 2;                                   % p is the number of dimensions of the train (in this case 2D hence p=2)Easily extendend to 3D by adding terms to basis function in mat variable
%% Plot variables
% k =1;
% dim1 = [0.75 0.87 0.027 0.037];
% dim2 = [0.75 0.40 0.027 0.037];
% dec = 3;                                 % The number of decimal places of the RMSE mean 
% lab = {'Diagonal test data','Horizontal test data','Vertical test data','Singularity test data'};
%% Calcs variables
max_n = max(data(1).train(:,1:p)); 
min_n = min(data(1).train(:,1:p));
maxD1 = (max_n - min_n)*q;                  % "q" is a variable parameter which affects the RMSE. Ideally use an optimiser

%% Vondermonde matrix training data
% Training data
onz = ones(size(data(1).train,1),1);
mat = horzcat(onz,data(1).train(:,1:p));  % linear Stresss = A + Bx + Cy

if p >1
mat1 = horzcat(onz,data(1).train(:,1:p),data(1).train(:,1).*data(1).train(:,p),data(1).train(:,1:p).^2);   % Quad Stresss = A + Bx + Cy + Dxy + Ex^2+ Fy^2
mat2 = horzcat(onz,data(1).train(:,1:p),data(1).train(:,1).*data(1).train(:,p),data(1).train(:,1:p).^2,exp(-1*data(1).train(:,1:p)));
else
mat1 = horzcat(onz,data(1).train(:,1:p),data(1).train(:,1:p).^2);           % Quad Stresss = A + Bx + Ex^2 for 1D
end

%Training Variable Vondermonde
V(1).mat_train = mat;                                             % for 1D linear
V(2).mat_train = mat1;                                            % for 2D or 1D quadratic
V(3).mat_train = mat2;

%%
for g = 1:6                                                % This goes through out all of the input cases
%% Vondermonde matrix test data
% Input data (i.e Diagonal(g=1), Horizontal(g=2) Vertical (g=3) and Singular field area(g=4))
% if g <= 4
%     g = g;
% else
%     g = 6; % This points at test set from sampling
% end
onz = ones(size(data(g).input,1),1);
mat_t = horzcat(onz,data(g).input(:,1:p));   % linear Stresss = A + Bx + Cy
if p>1
    mat_t1 = horzcat(onz,data(g).input(:,1:p),data(g).input(:,1).*data(g).input(:,2),data(g).input(:,1:p).^2);   %2D Quad Stresss = A + Bx + Cy + Dxy + Ex^2+ Fy^2 
    mat_t2 = horzcat(onz,data(g).input(:,1:p),data(g).input(:,1).*data(g).input(:,2),data(g).input(:,1:p).^2,exp(-1*data(g).input(:,1:p))); % 2D Quad with exponential Stresss
else
    mat_t1 = horzcat(onz,data(g).input(:,1:p),data(g).input(:,1:p).^2);                                         
      % Quad Stresss = A + Bx + Ex^2 for 1D
end

%Test variable Vondermonde
V(1).mat_test = mat_t;  % for 1D linear
V(2).mat_test = mat_t1; % for 2D or 1D quadratic
V(3).mat_test = mat_t2;  % for 2D or 1D quadratic with exponetial function

%% input data and Delta S calcs
A(1).diff = [];
A(2).diff =[];
parfor i = 1:p     % p is the number of dimension(variables)
const = repmat(data(g).input(:,i)',[size(data(1).train,1),1]);  % These are the input variables
varia = repmat(data(1).train(:,i),[1,(size(data(g).input,1))]); % These are the train variables replicated to get the desired quantity
A(i).diff = abs(varia - const)./maxD1(i);
end


%% Weight function calcs

A = weightfunc(A,p,wf,alpha);

%%
[a b] = size(A(1).diff);
dat = []; dat1 = []; 
parfor i=1:b
% B = zeros(basis,basis); C =[]; % If anything fails use this instead
B = zeros(size(V(n).mat_test,2)); C =[];
        for j = 1:a
        B = B + A(1).mag_w(j,i)*(V(n).mat_train(j,:)'*V(n).mat_train(j,:));
        C = [C,A(1).mag_w(j,i)*V(n).mat_train(j,:)'];
        end

%         dat = [dat,[V(n).mat_test(i,:)]*pinv(B)*C*data(1).train(:,4)];   
%         dat1 = [dat1,[V(n).mat_test(i,:)]*pinv(B)*C*data(1).train(:,6)];
        dat = [dat,V(n).mat_test(i,:)*pinv(B)*C*data(1).train(:,4)];   
        dat1 = [dat1,V(n).mat_test(i,:)*pinv(B)*C*data(1).train(:,6)];
end
dat  = dat';
dat1 = dat1';
data(g).MLSdisp = dat ;
data(g).MLSstress = dat1 ;
A(1).pred = dat;
A(2).pred = dat1;
%% RMSE of the test area

t = data(g).input;
RMSE(g).MLSdisp = sqrt(size(t,1)\sum((t(:,4) - dat(:,1)).^2));
RMSE(g).MLSstress = sqrt(size(t,1)\sum((t(:,6) - dat1(:,1)).^2));

end

end