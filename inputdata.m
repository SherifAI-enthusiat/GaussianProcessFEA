function [data] = inputdata(input_d,input_h,input_v,input,g)

%% Removing 'NaN' from the test data
%  This is acheck to see if there are NaN data at the singular field region.
inp_d   = ~isnan(input_d(:,4)); 
input_d = input_d(inp_d,:);
inp_h   = ~isnan(input_h(:,4));
input_h = input_h(inp_h,:);
inp_v   = ~isnan(input_v(:,4));
input_v = input_v(inp_v,:);
inp_te  = ~isnan(input(:,4)); % This the test area of the contour plot
input   = input(inp_te,:);

% Storing test inputs and outputs into structure
data(1).input = input_d; % Diagonal
data(2).input = input_h; % Horizontal
data(3).input = input_v; % Vertical
data(4).input = input; % This the test area data i.e. Near singularity or area of interest

% Collecting data from levels
for i=1:3;
mypath = 'data/Activefolder';
sgtn ='/Output/sampling/level'
filename = [mypath num2str(g) sgtn num2str(i) '.mat'];
load(filename)
data(i).test = input_sl; % This contains data from FEA. Taken from 3 section of the domain. All of this data is devoid of singularity influence
end
end
