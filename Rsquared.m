function [Stats] = Rsquared(data,n)
% n is the number of co-eficients
k=1;
for i = 4:2:6
%     
         for j = 1:6
             t = size(data(j).input(:,1),1);
             
             avg = mean(data(j).input(:,i)); % Displacement & Stress
             avg = repmat(avg,[size(data(j).input(:,1),1),1]);
%
        if i ==4    % Displacement Variables
             SSE = sum((data(j).input(:,i) - data(j).disp(:,1)).^2); % Displacement sum of squared errors
%              SSR = sum((avg - data(j).disp(:,1)).^2);                % Sum of squared regression
        elseif i==6 % Stress Variables
             SSE = sum((data(j).input(:,i) - data(j).stress(:,1)).^2); % Stress sum of squared errors 
%              SSR = sum((avg - data(j).stress(:,1)).^2);                % Sum of squared regression
        end
        

             SST = sum((avg - data(j).input(:,i)).^2);               % Sum of squared total 
             var = 1 - (SSE/SST);
             Stats(j).R2(1,k)= var;                                  % R squared 
%              Stats(j).AR2(1,k) = var-((n-1)/(t-n-1))*(1-var);
             Stats(j).AR2new(1,k) = 1 -((t-1)*(1-var))/(t-n-1);      % Adjusted R squared
%              Stats(j).AR2new1(1,k) = 1 -(SSE/SST)*((t-1)/(t-n-1));
         end
%     end
            k=k+1;

end

