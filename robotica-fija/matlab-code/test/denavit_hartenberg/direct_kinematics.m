q=zeros(4,1);
T = direct_kinematics_4(q)


function dh=denavit_hartenberg(d,r,theta,alpha)
dh=[cos(theta)   -cos(alpha)*sin(theta)   sin(alpha)*sin(theta)   r*cos(theta);
    sin(theta)   cos(alpha)*cos(theta)    -sin(alpha)*cos(theta)  r*sin(theta);
    0            sin(alpha)               cos(alpha)              d;
    0            0                        0                       1];
end

function tool_position = direct_kinematics_4(q)
teta = [q(1)   0      0    q(4)];
d    = [0.4    q(2)   q(3) 0.2 ];
a    = [0      -0.1   0    0 ];
alfa = [0      -pi/2  0    0 ];

A01 = denavit_hartenberg(d(1), a(1), teta(1), alfa(1));
A12 = denavit_hartenberg( d(2), a(2), teta(2),alfa(2));
A23 = denavit_hartenberg( d(3), a(3), teta(3),alfa(3));
A34 = denavit_hartenberg( d(4), a(4), teta(4),alfa(4));
tool_position = A01 * A12 * A23 * A34;
end