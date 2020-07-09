%% Displacement field
a = min(data(5).input(:,4));
b = max(data(5).input(:,4));

h=figure()
subplot(4,1,1)
plot(data(5).input(:,1),data(5).input(:,4),'k*')
hold on
plot(data(4).input(:,1),data(4).input(:,4),'r*')
ylim([a,b]);
xlabel('X coordinate','FontSize',13); ylabel('Displacement(mm)','FontSize',13); legend('Non-singular region','singularity region','FontSize',11)
hold off 

subplot(4,1,2)
plot(data(5).input(:,2),data(5).input(:,4),'k*')
hold on
plot(data(4).input(:,2),data(4).input(:,4),'r*')
ylim([min(data(5).input(:,4)), max(data(5).input(:,4))]);
xlabel('Y coordinate','FontSize',13); ylabel('Displacement(mm)','FontSize',13); legend('Non-singular region','singularity region','FontSize',11)
hold off

subplot(4,1,3)
plot(data(5).input(:,3),data(5).input(:,4),'k*')
hold on
plot(data(4).input(:,3),data(4).input(:,4),'r*')
ylim([min(data(5).input(:,4)), max(data(5).input(:,4))]);
xlabel('Z coordinate','FontSize',13); ylabel('Displacement(mm)','FontSize',13); legend('Non-singular region','singularity region','FontSize',13)
hold off

subplot(4,1,4)
plot3(data(5).input(:,1),data(5).input(:,2),data(5).input(:,4),'k*')
hold on
plot3(data(4).input(:,1),data(4).input(:,2),data(4).input(:,4),'r*')
zlim([min(data(5).input(:,4)), max(data(5).input(:,4))]);
xlabel('X coordinate','FontSize',13); ylabel('Y coordinate','FontSize',13);zlabel('Displacement (mm)','FontSize',13); legend('Non-singular region','singularity region','FontSize',11)
hold off
% %% Strain field
% a = min(data(5).input(:,5));
% b = max(data(5).input(:,5));
% 
% figure()
% subplot(4,1,1)
% plot(data(5).input(:,1),data(5).input(:,5),'k*')
% hold on
% plot(data(4).input(:,1),data(4).input(:,5),'r*')
% xlabel('X coordinate','FontSize',13);ylabel('Strain'); legend('Non-singular region','singularity region')
% ylim([a,b]);
% 
% hold off 
% 
% subplot(4,1,2)
% plot(data(5).input(:,2),data(5).input(:,5),'k*')
% hold on
% plot(data(4).input(:,2),data(4).input(:,5),'r*')
% ylim([a,b]);
% xlabel('Y coordinate');ylabel('Strain'); legend('Non-singular region','singularity region')
% hold off
% 
% subplot(4,1,3)
% plot(data(5).input(:,3),data(5).input(:,5),'k*')
% hold on
% plot(data(4).input(:,3),data(4).input(:,5),'r*')
% ylim([a,b]);
% xlabel('Z coordinate');ylabel('Strain'); legend('Non-singular region','singularity region')
% hold off
% 
% subplot(4,1,4)
% plot3(data(5).input(:,1),data(5).input(:,2),data(5).input(:,5),'k*')
% hold on
% plot3(data(4).input(:,1),data(4).input(:,2),data(4).input(:,5),'r*')
% zlim([a,b]);
% xlabel('X coordinate'); ylabel('Y coordinates');zlabel('Strain'); legend('Non-singular region','singularity region')
% hold off


%% Stress field
a = min(data(5).input(:,6));
b = max(data(5).input(:,6));

figure()
subplot(3,1,1)
plot(data(5).input(:,1),data(5).input(:,6),'k*')
hold on
plot(data(4).input(:,1),data(4).input(:,6),'r*')
ylim([a,b]);
% xlabel('X coordinate'); ylabel('Stress (MPa)'); legend('Non-singular region','singularity region')
xlabel('X coordinate','FontSize',13); ylabel('Stress (MPa)','FontSize',13); legend('Non-singular region','Test region','FontSize',11)
hold off 

subplot(3,1,2)
plot(data(5).input(:,2),data(5).input(:,6),'k*')
hold on
plot(data(4).input(:,2),data(4).input(:,6),'r*')
ylim([a,b]);
% xlabel('Y coordinate'); ylabel('Stress (MPa)'); legend('Non-singular region','singularity region')
xlabel('Y coordinate','FontSize',13); ylabel('Stress (MPa)','FontSize',13); legend('Non-singular region','Test region','FontSize',11)
hold off

% subplot(4,1,3)
% plot(data(5).input(:,3),data(5).input(:,6),'k*')
% hold on
% plot(data(4).input(:,3),data(4).input(:,6),'r*')
% ylim([a,b]);
% xlabel('Z coordinate'); ylabel('Stress (MPa)'); legend('Non-singular region','singularity region')
% hold off

subplot(3,1,3)
plot3(data(5).input(:,1),data(5).input(:,2),data(5).input(:,6),'k*')
hold on
plot3(data(4).input(:,1),data(4).input(:,2),data(4).input(:,6),'r*')
zlim([a,b]);
% xlabel('X coordinate');ylabel('Y coordinate'); zlabel('Stress (MPa)'); legend('Non-singular region','singularity region')
xlabel('X coordinate','FontSize',13);ylabel('Y coordinate','FontSize',13); zlabel('Stress (MPa)','FontSize',13); legend('Non-singular region','Test region','FontSize',11)
hold off