function [input_d,input_h,input_v,input,st] = loader(g)

st   =['data/Activefolder' sprintf(num2str(g))];

st1  ='/Output/data/point_d.mat';
st2  ='/Output/data/point_h.mat';
st3  ='/Output/data/point_v.mat';
st4  ='/Output/data/test.mat';
str1 = [st st1];
str2 = [st st2];
str3 = [st st3];
str4 = [st st4];
%% Data for Singular field region
load(str1) % Sampled along a diagonal line at vicinity of singular field from FEA  
load(str2) % Sampled along a horizontal line at vicinity of singular field from FEA  
load(str3) % Sampled along a vertical line at vicinity of singular field from FEA   
load(str4) % Sampled on 3 levels of the domain converging towards the singular fied from FEA
end