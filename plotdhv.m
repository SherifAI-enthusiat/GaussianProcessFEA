function [data] = plotdhv(data,conint)
lab = {'Diagonal test data','Horizontal test data','Vertical test data','Test Area'};

for i = 1:3;
record = 1:size(data(i).input(:,1),1);
[a b] = bounds(data(i).input(:,6));

figure()
% Lower Bounds
if min(conint(i).paths(:,2))<a || min(data(i).MLSstress(:,1))<a % Prevent the premature truncation of the graph
    slb(1) = min(conint(i).paths(:,2));
    slb(2) = min(data(i).MLSstress(:,1));
    a = min(slb);
end
% Upper bounds
if max(conint(i).paths(:,3))>b || max(data(i).MLSstress(:,1))>b % Prevent the premature truncation of the graph
    sub(1) = max(conint(i).paths(:,3));
    sub(2) = max(data(i).MLSstress(:,1));
    b = max(sub);
end
% 
plot(record,data(i).input(:,6),'ko', 'LineWidth', 2); % Plot of original data
ylim([a,b]);
hold on 

plot(record,data(i).MLSstress(:,1),'b-', 'LineWidth', 2) 
plot(record,data(i).stress(:,1),'r-', 'LineWidth', 2);
% Upper and Lower Bounds
line(record, conint(i).paths(:,3), 'Color', 'r', 'LineStyle', '--', 'LineWidth', 1)
line(record, conint(i).paths(:,2), 'Color', 'r', 'LineStyle', '--', 'LineWidth', 1)

xlabel('Record','FontSize',13); ylabel('Stress (MPa)','FontSize',13)
legend('FEA','MLS','GP','GP bounds','FontSize',12)
title(cellstr(lab(i)),'FontSize',13)
hold off
end
%% Plot of Disp and Stress
record = 1:size(data(4).input(:,1),1);
% Displacement Var
[a b] = bounds(data(4).input(:,4));
if min(data(4).disp(:,1))<a  || min(data(4).MLSdisp(:,1))<a
    dlb(1) = min(data(4).disp(:,1));
    dlb(2) = min(data(4).MLSdisp(:,1));
    a = min(dlb);
end


if max(data(4).disp(:,1))<b || max(data(4).MLSdisp(:,1))<b
    dub(1) = max(data(4).disp(:,1));
    dub(2) = max(data(4).MLSdisp(:,1));
    b = max(dub);
end


% Stress Var
[a1 b1] = bounds(data(4).input(:,6));
if min(data(4).stress(:,1))<a1 || min(data(i).MLSstress(:,1))<a1
    slb(1) = min(data(4).stress(:,1));
    slb(2) = min(data(4).MLSstress(:,1));
    a1 = min(slb);
end

if max(data(4).stress(:,1))>b1 || max(data(i).MLSstress(:,1))>b1
    sub(1) = max(data(4).stress(:,1));
    sub(2) = max(data(4).MLSstress(:,1));
    b1 = max(sub);
end

% Displacement variables
figure()
subplot(2,1,1)
plot(record,data(4).input(:,4),'ko', 'LineWidth', 2); % Plot of original data
ylim([a,b]);
hold on 
%
plot(record,data(4).MLSdisp(:,1),'b*', 'LineWidth', 2) 
plot(record,data(4).disp(:,1),'r*', 'LineWidth', 2);
%
xlabel('Record','FontSize',13); ylabel('Displacement(mm)','FontSize',13)
legend('FEA','MLS','GP','FontSize',12)
title('Test Area','FontSize',13)
hold off

% Stress Variables
subplot(2,1,2)
plot(record,data(4).input(:,6),'ko', 'LineWidth', 2); % Plot of original data
ylim([a1,b1]);
hold on 

plot(record,data(4).MLSstress(:,1),'b*', 'LineWidth', 2) 
plot(record,data(4).stress(:,1),'r*', 'LineWidth', 2);

xlabel('Record','FontSize',13); ylabel('Stress(MPa)','FontSize',13)
legend('FEA','MLS','GP','FontSize',12)
title('Test Area','FontSize',13)
hold off


end
