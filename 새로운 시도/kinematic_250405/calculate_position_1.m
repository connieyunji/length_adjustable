function [position_1_x, position_1_y] = calculate_position_1(alpha, l24)


position_1 = [l24*cosd(alpha), l24*sind(alpha)];
position_1_x = position_1(1);
position_1_y = position_1(2);

end

