function [position_actuator_x, position_actuator_y] = calculate_position_actuator(position_1_x, position_1_y, l0, a_prime)


position_actuator = [position_1_x + l0 * cosd(a_prime) , position_1_y + l0 * sind(a_prime)];
position_actuator_x = position_actuator(1);
position_actuator_y = position_actuator(2);

end
