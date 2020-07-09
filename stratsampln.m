function [data] = stratsampln(data,k,p)
% p is matrix of percentages i.e. [0.2,0.3,0.4,0.5] such that .2 means 20%
% of data is withheld
% k is the number of test areas
% data is a structure containing the test data from the sectioned parts of
% the domain
Utrain = [];                % This will contain the training data after randomly sampling 
Uorig = [];                 % This will contain the oringinal data without sampling
Ugen  =[];

for i = 1:k
    dat =[]; dat1 =[];
% Partition of Data 
N = size(data(i).test,1);
C = cvpartition(N,'Holdout',p(i));
trIdx = C.training;  teIdx = C.test;   Uorig = vertcat(Uorig,data(i).test);  

dat = data(i).test(trIdx,:); % Original test dat had more data hence the reason for Uoriginal(Uorig)
dat1 = data(i).test(teIdx,:); % The purpose of this is to test if the model generalises properly

data(i).test = dat;
Utrain = vertcat(Utrain,dat);
Ugen   = vertcat(Ugen,dat1);
end
%
data(1).train = Utrain; % Compiled level data with sampling
data(5).input = Uorig;  % Compile level data without sampling
data(6).input = Ugen;   % This is to check if the mode has generalized properly
end
