function [data] = weightfunc(data,p,wf,alpha)
% cubic_spline is a weight function to determine how relevant a given point
% s in relation to another
data(1).w = []; data(2).w = [];
for m =1:p % This is the number of dimensions
    for i = 1:size(data(1).diff(),2)% This is the number of cols
        for j = 1:size(data(1).diff,1)% This is the number of rows
           % Cubic spline
            if wf == 1
               if data(m).diff(j,i)<=0.5
               w = 2/3 - 4*data(m).diff(j,i)^2 + 4*data(m).diff(j,i)^3;
               elseif data(m).diff(j,i)<=1
           	   w = 4/3 - 4*data(m).diff(j,i) + 4*data(m).diff(j,i)^2-(4/3)*data(m).diff(j,i)^3;
               else 
               w = 0;
           	end

           % Exponential spline
            elseif wf == 2
                 if data(m).diff(j,i)<=1
                 w = exp(data(m).diff(j,i)/alpha);

                 elseif data(m).diff(j,i)>1
                 w = 0;
            	 end

           % Quartic spline
            elseif wf == 3
                if data(m).diff(j,i)<=1
                w = 1 - 6*data(m).diff(j,i)^2 + 8*data(m).diff(j,i)^3 -3*data(m).diff(j,i)^4;
                elseif data(m).diff(j,i)>1
                w = 0;
                end
            
            end
            data(m).w(j,i) = w;
        end
    end
end


% Summation of weights

[a b] = size(data(1).diff);
temp = zeros(a,b);
dat = []; dat1 = []; 
if p>1
for i = 1:p
    temp = temp + data(i).w(:,:).^2; % temp = x^2 + y^2;
end

data(1).mag_w =[];
for i = 1: a
data(1).mag_w(i,:) = sqrt(temp(i,:)); % mag(x) = sqrt(temp)
end
else
data(1).mag_w = data(m).w(:,:);  
end
end
