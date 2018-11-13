function [pos,alpha,theta_arriba] = inverse_kinematic_arrob(TCP,tcp_theta)
%TCP = [140 50 120];
%tcp_theta = 314;

links_length = [95 105 117 190];

%%%%%Parte 1
 alpha = atand(TCP(2)/TCP(1));
 base_rot_mat = [cosd(alpha)  -sind(alpha)   0;
                   sind(alpha)   cosd(alpha)   0;
                             0             0   1];
 
new_TCP = TCP*base_rot_mat;
%new_TCP = [14.28 0 11.76]; %%%%%%%%%%%%%Linea de debug
% 
% %   %%Parte 2
%new_TCP(3) = new_TCP(3)-links_length(1);
% %  
% % %%%%%%%%%Calculo de P3
x3 = new_TCP(1)-links_length(4)*cosd(tcp_theta);
y3 = new_TCP(2);
z3 = new_TCP(3)-links_length(4)*sind(tcp_theta);
% 
% 
% % %%%%%%%Calculo de theta 2
cos_theta2 = (x3^2+(z3-links_length(1))^2-links_length(2)^2-links_length(3)^2)/(2*links_length(2)*links_length(3));

sen_theta2_arriba = -sqrt(1-cos_theta2^2);
%sen_theta2_arriba = sqrt(1-cos_theta2^2);
% % 
theta2_arriba = round(atand(sen_theta2_arriba/cos_theta2));
%theta2_arriba = atand(sen_theta2_arriba/cos_theta2)
% 
% % %%%%%%%%%%Calculo de theta1
theta1_arriba = round((atand((z3-links_length(1))/x3)-atand((links_length(3)*sen_theta2_arriba)/(links_length(2)+links_length(3)*cos_theta2))));
%theta1_arriba = atand(y3/x3)-atand((links_length(3)*sen_theta2_arriba)/(links_length(2)+links_length(3)*cos_theta2))
% % 
theta_3 = tcp_theta-(theta1_arriba+theta2_arriba)-360;
% % 
% 
% % 
cla
draw_axis(300);
hold on;
grid on;

pos = draw_arrob([alpha theta1_arriba theta2_arriba theta_3 0],links_length);
theta_arriba = [theta1_arriba theta2_arriba theta_3];
end