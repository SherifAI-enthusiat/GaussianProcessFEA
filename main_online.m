%% Stress Singularity and Gaussina Machine Learning Study

% The script loads txt files from a defined file structure containing
% stress analysis data with stress singularity. The study uses the Gaussian machine learning algorithm within
% the Regression learner app to make estimates of the stresses occuring at
% Singularity.

% Stresses generated using the Gaussian machine learning algorithm is compared
% against results generated using the movingleast squares algorithm and
% from FEA results.

% In all cases the values of stress occuring at the region of stress
% singularity are not included in the GP, Moving least squares, 
for g=1:2 % Define number of test samples[The test samples have variations in the radius]

[input_d,input_h,input_v,input,st] = loader(g);
data = inputdata(input_d,input_h,input_v,input,g);
%% Sampling through the different levels to form training set
% The training set does not contain point from diagonal,horizontal,
% vertical or test area
p =[0.4,0.3,0.2];             % p is the percentatge of data to holdout from each strata/level.
data = stratsampln(data,3,p); % Uses a stratified means of sampling from the 3 different strata in test.mat defined by the variable p.Eg p=[.4,.4,.2] 1st&2nd level(60%);3rd level(80%)kept for training 

%% Gaussian Process method(GP)
% This is a Gaussian squared exponential kernel function generated using
% Matlabs Regression Learner
% The model uses a linear basis function for the kernel function
% The model uses the QuasiNewton method to achieve the desired minimum parameters of the kernel 
[DispModel, RMSEd] = GPmethoddisp(data(1).train);
[StressModel, RMSEs] = GPmethodstress(data(1).train);

%RMSE of training data
RMSE(5).GPdisp = RMSEd; % These are global RMSE of the displacment variables
RMSE(5).GPstress = RMSEs; % These are global RMSE of the stress variables
%% Prediction using the module from GP method
[data, RMSE, conint] = predictn(data,RMSE,DispModel,StressModel);

%% Least squares
% [data RMSE] = leastsqs(data,RMSE); % This gets the parameters,predicts and plots data

%% Moving least squares
% The mvglstsqs function applies the moving least squares algorithm  to
% generate a stress function 
[data, RMSE] = mvnglstsqs(data,RMSE,1,2,1,1);

%% Results
% Plot
[data] = plotdhv(data,conint);

% R squared
Stats = Rsquared(data,2);

% Residual Plot
figure()
for i = 1:6
    subplot(6,1,i)
record = 1:size(data(i).input,1);
record2 = zeros(1,length(record));
plot(record,(data(i).input(:,6)- data(i).stress(:,1)),'r*')
hold on
plot(record,record2,'k-')
hold off
end

% Results of Field
for i =1:4
dans(i,1:2) = max(data(i).input(:,[4,6]));    
dans(i,3) = max(data(i).disp);
dans(i,4) = max(data(i).stress);
dans(i,5) = max(data(i).MLSdisp);
dans(i,6) = max(data(i).MLSstress);
end

% Contour plot
data = visualize(data);

% Extract maximum stress and correspondig 95% interval
[mastr, Ind] = max(data(4).input(:,6));
[maxGPstress, Ind1] = max(data(4).stress); % GP max stress and index
[maxMLSstress, Ind2] = max(data(4).MLSstress); % MLS max stress
confinter(1,:) = conint(1).test(Ind1,:); % this extract the max stress std and the 95% confidence int
% confinter(2,:) = conint(1).test(Ind2,:);
for i= 1:3
    [mt, In]=max(data(i).stress);
    confinter(1+i,:)= zeros(1,4);
    confinter(1+i,:) = [mt,conint(i).paths(In,:)];
end

% Check for Singularity Location
to = 0;
parfor i= 1:size(data(4).input(:,1),1)
if data(4).input(i,1)==65 && data(4).input(i,1)==7
    to = to+1;
end
end

% GP model at the exact location
xval = 64.5:0.25:65.5;
yval = 6.5:0.25:7.5;
zval = zeros(1,size(xval,2));
t=[xval',yval',zval'];
[Maxm, ysd, bounds]= StressModel.predictFcn(t(:,1:3));

% Save workspace file
sgt  = '.mat';
nam = ['/Filletradius' sprintf(num2str(g))]; % This names the file as Filletradius
% labelling  the .mat files for use in the GP model
sgtr2 = [st nam sgt];
save(sgtr2)
end
