function draw_arrob(theta_joints)
    links_length = [4 3 2 1];
    
    theta=theta_joints;
    d     = [links_length(1)     0                0                0       links_length(4)];
    a     = [0                   links_length(2)  links_length(3)  0       0];    
    alpha = [90                  0               0                90       0];
    
    link_01 = denavit_hartenberg(a(1), d(1), alpha(1), theta(1))
    link_12 = denavit_hartenberg(a(2), d(2), alpha(2), theta(2));
    link_23 = denavit_hartenberg(a(3), d(3), alpha(3), theta(3));
    link_34 = denavit_hartenberg(a(4), d(4), alpha(4), theta(4));
    link_45 = denavit_hartenberg(a(5), d(5), alpha(5), theta(5));
    
    link_02 = link_01*link_12;
    link_03 = link_02*link_23;
    link_04 = link_03*link_34;
    link_05 = link_04*link_45;
    
    x = [0 link_01(1,4) link_02(1,4) link_03(1,4) link_04(1,4) link_05(1,4)];
    y = [0 link_01(2,4) link_02(2,4) link_03(2,4) link_04(2,4) link_05(2,4)];
    z = [0 link_01(3,4) link_02(3,4) link_03(3,4) link_04(3,4) link_05(3,4)];
    
    cla
    hold on;
    view(50,25)
    rotate3d on;
    plot3([x(1) x(2)],[y(1) y(2)],[z(1) z(2)],'r');
    plot3([x(2) x(3)],[y(2) y(3)],[z(2) z(3)],'g');
    plot3([x(3) x(4)],[y(3) y(4)],[z(3) z(4)],'b');
    plot3([x(4) x(5)],[y(4) y(5)],[z(4) z(5)],'r');
    plot3([x(5) x(6)],[y(5) y(6)],[z(5) z(6)],'g')
    text(x(6),y(6),z(6),strcat("(",num2str(x(6)),",",num2str(y(6)),",",num2str(z(6)),")"));
    grid on;
    axis([-10 10 -10 10 0 10]);
    hold off;
    
end