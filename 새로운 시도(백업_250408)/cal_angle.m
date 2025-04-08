function [ang_6_1_x] = cal_angle(p6_x,p6_y,p1_x,p1_y) 

    delta_x = p6_x - p1_x;
    delta_y = p6_y - p1_y;

    ang_6_1_x = rad2deg(atan2(delta_y,delta_x));

end