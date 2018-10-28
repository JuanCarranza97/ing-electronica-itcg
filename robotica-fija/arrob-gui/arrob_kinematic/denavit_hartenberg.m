function dh=denavit_hartenberg(a,d,alpha,theta)
    dh=[cosd(theta) -cosd(alpha)*sind(theta) sind(alpha)*sind(theta) a*cosd(theta);
        sind(theta) cosd(alpha)*cosd(theta)  -sind(alpha)*cosd(theta) a*sind(theta);
        0           sind(alpha)              cosd(alpha)              d;
        0           0                        0                        1];
end
