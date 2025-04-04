function [position_7_x, position_7_y] = calculate_position_7(beta, l7)


position_7 = [l7*cosd(beta), -l7*sind(beta)];
position_7_x = position_7(1);
position_7_y = position_7(2);

end

