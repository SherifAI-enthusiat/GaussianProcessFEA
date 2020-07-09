function [data RMSE conint] = predictn(data,RMSE,DispModel,StressModel)

t = data(4).input(:,:);% Collecting test area data(This region has singular field).
% These are coordinates and outputs including disp,strain and stress

%% Prediction of data at region of singular field
data(4).disp = DispModel.predictFcn(t(:,1:3));
data(4).stress = StressModel.predictFcn(t(:,1:3));

RMSE(4).GPdisp = sqrt(size(t,1)\sum((t(:,4) - data(4).disp(:,1)).^2));
RMSE(4).GPstress = sqrt(size(t,1)\sum((t(:,6) - data(4).stress(:,1)).^2));
% Standard Deviation and Confidence Int

  [ypred ysd yint] = StressModel.predictFcn(t(:,1:3));
  other = [ypred,ysd,yint];
  conint.test = other;
%% Prediction of training set
t = data(5).input(:,:);
data(5).disp = DispModel.predictFcn(t(:,1:3));
data(5).stress = StressModel.predictFcn(t(:,1:3));

%% Prediction of test set
t = data(6).input(:,:);
data(6).disp = DispModel.predictFcn(t(:,1:3));
data(6).stress = StressModel.predictFcn(t(:,1:3));

RMSE(6).GPdisp = sqrt(size(t,1)\sum((t(:,4) - data(6).disp(:,1)).^2));
RMSE(6).GPstress = sqrt(size(t,1)\sum((t(:,6) - data(6).stress(:,1)).^2));

%% Predicting data along the paths defined in Ansys(Devoid of singualr values)
for i=1:3;
    t=[]; dat = []; dat1 = []; yint =[]; ysd =[];
t = data(i).input(:,:);         % Diagonal data 1st, Horizontal 2nd and 3rd is Vertical data

dat = DispModel.predictFcn(t(:,1:3));
RMSE(i).GPdisp = sqrt(size(t,1)\sum((t(:,4) - dat(:,1)).^2));

[dat1,ysd,yint] = StressModel.predictFcn(t(:,1:3));
RMSE(i).GPstress = sqrt(size(t,1)\sum((t(:,6) - dat1(:,1)).^2));
conint(i).paths = [ysd ,yint];
data(i).disp =  dat;
data(i).stress = dat1;

end
