function [data] = visualize(data)
k=2;
a = min(data(4).input(:,6));
b = max(data(4).input(:,6));

for i = 1:2;
%% Stress field

if i ==1;
    m = 1;
else
    m = 2;
end

        if i==1;
                figure()
                subplot(3,k,m)
                plot(data(5).input(:,1),data(5).input(:,6),'k*')
                hold on
                plot(data(4).input(:,1),data(4).input(:,6),'r*')
                ylim([a,b]);
                xlabel('X coordinate','FontSize',13); ylabel('Stress (MPa)','FontSize',13); 
                legend('Non-singular','Singular field','FontSize',11)
                hold off 
                m = m+2;

                subplot(3,k,m)
                plot(data(5).input(:,2),data(5).input(:,6),'k*')
                hold on
                plot(data(4).input(:,2),data(4).input(:,6),'r*')
                ylim([a,b]);

                xlabel('Y coordinate','FontSize',13); ylabel('Stress (MPa)','FontSize',13); 
                legend('Non-singular','Singular field','FontSize',11)
                hold off
                m = m+2;

                subplot(3,k,m)
                plot3(data(5).input(:,1),data(5).input(:,2),data(5).input(:,6),'k*')
                hold on
                plot3(data(4).input(:,1),data(4).input(:,2),data(4).input(:,6),'r*')
                zlim([a,b]);

                xlabel('X coordinate','FontSize',13);ylabel('Y coordinate','FontSize',13); zlabel('Stress (MPa)','FontSize',13); 
                legend('Non-singular','Singular field','FontSize',11)
                hold off

            else
                subplot(3,k,m)
                plot(data(5).input(:,1),data(5).input(:,6),'k*')
                hold on
                plot(data(4).input(:,1),data(4).stress(:,1),'r*')
                ylim([a,b]);
                xlabel('X coordinate','FontSize',13); ylabel('Stress (MPa)','FontSize',13); 
                legend('Non-singular','Predicted field','FontSize',11)
                hold off 
                m = m+2;

                subplot(3,k,m)
                plot(data(5).input(:,2),data(5).input(:,6),'k*')
                hold on
                plot(data(4).input(:,2),data(4).stress(:,1),'r*')
                ylim([a,b]);

                xlabel('Y coordinate','FontSize',13); ylabel('Stress (MPa)','FontSize',13); 
                legend('Non-singular','Predicted field','FontSize',11)
                hold off
                m = m+2;

                subplot(3,k,m)
                plot3(data(5).input(:,1),data(5).input(:,2),data(5).input(:,6),'k*')
                hold on
                plot3(data(4).input(:,1),data(4).input(:,2),data(4).stress(:,1),'r*')
                zlim([a,b]);

                xlabel('X coordinate','FontSize',13);ylabel('Y coordinate','FontSize',13); zlabel('Stress (MPa)','FontSize',13); 
                legend('Non-singular','Predicted field','FontSize',11)
                hold off
           end
    end
end
