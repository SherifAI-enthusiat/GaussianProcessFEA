function [outputArg1,outputArg2] = dataprocessor(inputArg1,inputArg2)
  %This code is used to process the FEA data for the GP and the MLS code
% This code collects the coordinates of the FEA data i.e. X,Y,Z and the
% corresponding Total Displacement, Total equivalent Von Mise Strain and Stress
clear,close all,clc
lab1 = {'/point_d','/point_h','/point_v','/test'}; % File locations
for g=1:7    
if g <= 3;
    str = 'Activefolder/Input/trainingdata/level';
elseif g==4;
    str = 'Activefolder/Input/paths/point_d';
elseif g==5;
    str = 'Activefolder/Input/paths/point_h';
elseif g==6;
    str = 'Activefolder/Input/paths/point_v';
elseif g==7
    str = 'Activefolder/Input/paths/test';
end

str1 = '/DefTot.txt'; % This is the name of the FEA displacement test file
if g<=3
    str2 = [str sprintf(num2str(g)) str1];
else
    str2 = [str str1]; 
end
%% Deformation Data %%
data4 = readtable(str2);

% Relabelling data
data4.Properties.VariableNames{5} = 'DefTot';

% Removing Repeated or useless Columns (ie zero columns and coordinates)
data4(:,1)=[] ;

% Deformation Data Compilation
TotalDef = data4; 
%---------------------------------------------------------------------------------------
% Strain Data

% Some strain data have twice the number of rows as in the 'TotalDef'.
% Hence the need to half it.

% File location code
% Data in g<=3 is the level data
str1 = '/EquiVonStrain.txt'; % This is the name of the FEA strain test file
if g<=3
    str2 = [str sprintf(num2str(g)) str1];
else
% Data in g>3 is the paths and test area data
    str2 = [str str1]; 
end

data2 = readtable(str2);
k=1;
j=0;
a = size(TotalDef,1);
if a < size(data2,1);
for i = 1:a;
    da(i,:)= data2.EquivalentElasticStrain_mm_mm_(k,:)/data2.EquivalentElasticStrain_mm_mm_(k+1,:);
        if da(i,:) == 1;
            j = j + 1; % Check to see if a=j.if equal then data is exactly duplicated
        end  
            k = k+2;
end
end

% Strain Data compilation
defstra = TotalDef;
 for i = 1:a;
    if j==0;
            defstra.EquivalentStrain_mm_mm_(i) = data2.EquivalentElasticStrain_mm_mm_(i);      
    elseif j == a; % Needs to check this condition
            defstra.EquivalentStrain_mm_mm_(i) = data2.EquivalentElasticStrain_mm_mm_(2*i);
    end  
 end
 
%-----------------------------------------------------------------------------------
% Stress Data
% Sometimes this data is also duplicated for some reason hence the code

str1 = '/EquiVonStress.txt'; % This is the name of the FEA stress test file 

if g<=3
    str2 = [str sprintf(num2str(g)) str1];
else
    str2 = [str str1]; 
end

% str2 = [str sprintf(num2str(g)) str1];
data2 = readtable(str2);

da=[];
k=1;
j=0;
if a < size(data2,1);
for i = 1:a;
da(i,:)= data2.Equivalent_von_Mises_Stress_MPa_(k,:)/data2.Equivalent_von_Mises_Stress_MPa_(k+1,:);
    if da(i,:) == 1;
     j = j + 1;
    end  
k = k+2;
end
end

% Stress Data Compilation
data_sl = defstra;
 for i = 1:a;
        if j== 0;
            data_sl.Equivalent_von_Mises_Stress_MPa_(i)= data2.Equivalent_von_Mises_Stress_MPa_(i);
        elseif j== a;% need to check this condition
            data_sl.Equivalent_von_Mises_Stress_MPa_(i)= data2.Equivalent_von_Mises_Stress_MPa_(2*i);  
        end   
 end
 
%% Collecting Numerical data
if g<=3;
    input_sl = data_sl{1:a,1:end};  % X,Y,Z,DX,DY,DZ,Dtot,Stot
elseif g==4;
    input_d = data_sl{1:a,1:end};
elseif g==5;
    input_h = data_sl{1:a,1:end};
elseif g==6;
    input_v = data_sl{1:a,1:end};
elseif g==7;
    input = data_sl{1:a,1:end};
end

%% Saves output .mat files
st  = '.mat';

% labelling  the .mat files for use in the GP model
if g<=3; % this number depends on the number of levels I have created in FEA
    str = 'Activefolder/Output/sampling/level'; 
    str2 = [str sprintf(num2str(g)) st];
%     save(str2,'input_sl');
else
    str = 'Activefolder/Output/data';
    str2 = [str char(lab1{g-3}) st];
end

if g<=3
    save(str2,'input_sl')
elseif g ==4
    save(str2,'input_d')
elseif g ==5
    save(str2,'input_h')
elseif g ==6
    save(str2,'input_v')
elseif g ==7
    save(str2,'input')
end
end
clear,clc
end