function [data RMSE] = leastsqs(data,RMSE)
% This function calculates the least squares parameters and makes predictions on
% the values occuring at singular field

% data is the structure containing the training data.
% RMSE is the Root mean squared error for the different paths and test area
% This function is written for 2D but is easily changed for 3D

dim1 = [0.412 0.834 0.0161 0.028];
dim2 = [0.412 0.617 0.0161 0.028];
dim3 = [0.412 0.400 0.0166 0.028];
dim4 = [0.412 0.179 0.0166 0.028];
dim5 = [0.85 0.833 0.0203 0.028];
dim6 = [0.85 0.617 0.0203 0.028];
dim7 = [0.85 0.399 0.0208 0.028];
dim8 = [0.85 0.177 0.0208 0.028];

dec = 3; % The number of decimal places of the RMSE 
lab = {'Diagonal test data','Horizontal test data','Vertical test data','Singularity test data'};
lab1 =[dim1;dim2;dim3;dim4;dim5;dim6;dim7;dim8]; % this contains corrdinates for positioning text box
%% Initialisation
% This uses the training data same as the GP
variab = data(1).train(:,1:2);              % Change 2 to 3 for 3D geometry
ydisp = data(1).train(:,4);                 % these contain the displacement variables
ystress = data(1).train(:,6);               % these contain the stress variables

%% Basis functions based on the Pascal triangle [Refer to what-when-how.com]
% Linear Basis function
mat = horzcat(ones(size(variab,1),1),variab(:,:));                                              % linear Stresss = a + Bx + Cy.These are training variables
% Quadratic Basis function
mat1 = horzcat(ones(size(variab,1),1),variab(:,:),variab(:,1).*variab(:,2),variab(:,:).^2);     % Quadratic Stress = a + Bx + Cy + Dxy + Ex2 + Fy2

%% Least Squared Method 
% XtX reads X transpose X where X is the input data
XtX = mat'*mat;        % linear Stresss = a + Bx + Cy                                                    
XtX1 = mat1'*mat1;     % Quadratic Stress = a + Bx + Cy + Dxy + Ex2 + Fy2

%% Parameter estimation & Prediction for training data
% Displacement
para_disp = pinv(XtX)*mat'*ydisp;       % Using linear basis function
para_disp1 = pinv(XtX1)*mat1'*ydisp;    % Using quadratic basis function

% Stress
para_stress = pinv(XtX)*mat'*ystress;
para_stress1 = pinv(XtX1)*mat1'*ystress;

%% RMSE of the training data
% Linear
data(5).LSdisp = mat*para_disp;
data(5).LSstress = mat*para_stress;
RMSE(5).LSdisp   = sqrt(size(data(1).train,1)\sum((data(1).train(:,4) - data(5).LSdisp(:,1)).^2)); % sqrt((Actual output - Predicted).^2/size)
RMSE(5).LSstress = sqrt(size(data(1).train,1)\sum((data(1).train(:,6) - data(5).LSstress(:,1)).^2));
% Quadratic
data(5).LSqdisp  = mat1*para_disp1;
data(5).LSqstress = mat1*para_stress1;
RMSE(5).LSqdisp   = sqrt(size(data(1).train,1)\sum((data(1).train(:,4) - data(5).LSqdisp(:,1)).^2)); % sqrt((Actual output - Predicted).^2/length)
RMSE(5).LSqstress = sqrt(size(data(1).train,1)\sum((data(1).train(:,6) - data(5).LSqstress(:,1)).^2));

%% Prediction for paths and test area
for i=1:4;
% Input matrix
%I have ordered data from FE software Test variable i.e.input_d(i=1), input_h(i=2), input_v(i=3) and test(i=4)
mat_p = horzcat(ones(size(data(i).input,1),1),data(i).input(:,1:2)); 
% Where input_d,input_h and input_v are values taken based on a path defined in Ansys
mat_p1 = horzcat(ones(size(data(i).input,1),1),data(i).input(:,1:2),data(i).input(:,1).*data(i).input(:,2),data(i).input(:,1).^2,data(i).input(:,2).^2);

% Displacement
pred_disp = mat_p*para_disp;
pred_disp1 = mat_p1*para_disp1;
% Stress
pred_stress = mat_p*para_stress;
pred_stress1 = mat_p1*para_stress1;

%% RMSE
% RMSE of paths data
% Linear
data(i).LSdisp = mat_p*para_disp;
data(i).LSstress = mat_p*para_stress;
RMSE(i).LSdisp = sqrt(size(data(i).input,1)\sum((data(i).input(:,4) - mat_p*para_disp).^2)); % sqrt((Actual output - Predicted).^2/size)
RMSE(i).LSstress = sqrt(size(data(i).input,1)\sum((data(i).input(:,6) - mat_p*para_stress).^2));
% Quadratic
data(i).LSqdisp = mat_p1*para_disp1;
data(i).LSqstress = mat_p1*para_stress1;
RMSE(i).LSqdisp = sqrt(size(data(i).input,1)\sum((data(i).input(:,4) - mat_p1*para_disp1).^2)); % sqrt((Actual output - Predicted).^2/size)
RMSE(i).LSqstress = sqrt(size(data(i).input,1)\sum((data(i).input(:,6) - mat_p1*para_stress1).^2));

%% Plot 
record = 1:size(data(i).input,1);
% Displacement plot
figure(6)
a = 2*i-1;
subplot(4,2,a)

% Linear
plot(record, data(i).input(:,4),'ko')
hold on
plot(record, pred_disp,'r*')
xlabel('Record'); ylabel('Displacement(mm)')
legend('FEA','LS Linear')
title(cellstr(lab(i)))
% Create textbox
str = 'RMSE: ';
str = [str num2str(round(RMSE(i).LSdisp,dec))];
annotation('textbox',lab1(a,:),'String',str,'FitBoxToText','on');
hold off


b = 2*i;
subplot(4,2,b)
% Quadratic
plot(record, data(i).input(:,4),'ko')
hold on
plot(record, pred_disp1,'r*')
xlabel('Record'); ylabel('Displacement(mm)')
legend('FEA','LS Quad')
title(cellstr(lab(i)))
% Create textbox
str = 'RMSE: ';
str = [str num2str(round(RMSE(i).LSqdisp,dec))];
annotation('textbox',lab1(b,:),'String',str,'FitBoxToText','on');
hold off

%% Stress plot
figure(8)
subplot(4,2,a)
% Linear
plot(record, data(i).input(:,6),'ko')
hold on
plot(record,pred_stress,'r*')
xlabel('Record'); ylabel('Stress(MPa)')
legend('FEA','LS Linear')
title(cellstr(lab(i)))
% Create textbox
str = 'RMSE: ';
str = [str num2str(round(RMSE(i).LSstress,dec))];
annotation('textbox',lab1(a,:),'String',str,'FitBoxToText','on');
hold off

subplot(4,2,b)
% Quadratic
plot(record, data(i).input(:,6),'ko')
hold on
plot(record,pred_stress1,'r*')
xlabel('Record'); ylabel('Stress(MPa)')
title(cellstr(lab(i)))
% Create textbox
str = 'RMSE: ';
str = [str num2str(round(RMSE(i).LSqstress,dec))];
annotation('textbox',lab1(b,:),'String',str,'FitBoxToText','on');
legend('FEA','LS Quad')
hold off
end
end
