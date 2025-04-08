function [position_10_x, position_10_y] = calculate_position_10(position_13_x, position_13_y, position_9_x, position_9_y, position_12_x, position_12_y, l18, l14, l17)

    % ���� �� �Ÿ� ���
    d = sqrt((position_13_x - position_9_x).^2 + (position_13_y - position_9_y).^2);

    % �ڻ��� ��Ģ�� �̿��� ���� ���
    cos_theta_13 = (l18^2 + d.^2 - l14^2) ./ (2 * l18 .* d);
    cos_theta_13 = max(min(cos_theta_13, 1), -1);  % acosd ���� ����
    ang_10_13_9 = acosd(cos_theta_13);

    ang_13_9_x =  rad2deg(atan2(position_9_y - position_13_y, position_9_x - position_13_x));

    % ���� ���� ��� (�ϳ��� ���)
    angle_option = ang_13_9_x + ang_10_13_9;

    % ��ġ ���
    position_10_x = position_13_x + l18 * cosd(angle_option);
    position_10_y = position_13_y + l18 * sind(angle_option);
    
    % �Ÿ� Ȯ��
    distance_13_10 = sqrt((position_13_x - position_10_x).^2 + (position_13_y - position_10_y).^2);
    distance_10_9 = sqrt((position_10_x - position_9_x).^2 + (position_10_y - position_9_y).^2);
    distance_9_12 = sqrt((position_9_x - position_12_x).^2 + (position_9_y - position_12_y).^2);
    distance_13_12 = sqrt((position_13_x - position_12_x).^2 + (position_13_y - position_12_y).^2);

    % ��� ���� (��: 0.1mm)
    tol = 1e-3;

    % �ﰢ�� ����
    triangle_valid_1 = (l18 + l14 > d) & (l18 + d > l14) & (l14 + d > l18);
    triangle_valid_2 = (l17 + d > distance_9_12) & (l17 + distance_9_12 > d) & (d + distance_9_12 > l17);

    % ��ȿ���� ���� ��� NaN ó��
    invalid_idx = abs(distance_13_10 - l18) > tol | abs(distance_10_9 - l14) > tol|...
                  abs(distance_13_12 - l17) > tol| ~triangle_valid_1 | ~triangle_valid_2;

    position_10_x(invalid_idx) = NaN;
    position_10_y(invalid_idx) = NaN;

end
