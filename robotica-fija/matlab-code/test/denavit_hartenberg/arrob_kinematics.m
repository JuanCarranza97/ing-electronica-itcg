clc

P1 = [0,0,10];
P2 = [10,0,10];
P3 = [10,0,20];

arrob_points = [P1;P2;P3];

arrob_draw_robot(arrob_points);

function arrob_draw_robot(points)
    number_of_points = size(points);
    number_of_points = number_of_points(1);
    x=[0];
    y=[0];
    z=[0];
    for i=1:number_of_points
        hold on
        x(i+1)=points(i,1);
        y(i+1)=points(i,2);
        z(i+1)=points(i,3);
        fprintf("Position %d: X=%d Y=%d Z=%d\n",i,x(i+1),y(i+1),z(i+1));
    end
    plot3(x,y,z,'-.r*');
    grid
    axis([-20 20 -20 20 0 20])
end


