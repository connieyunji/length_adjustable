

function [position_3_x, position_3_y] = calculate_position_3(position_6_x, position_6_y, position_1_x, position_1_y,position_5_x, position_5_y, l4, l3, l6)

    % ���� �� �Ÿ� ���
    d = sqrt((position_6_x - position_1_x).^2 + (position_6_y - position_1_y).^2);

    % �ڻ��� ��Ģ�� �̿��� ���� ���
    cos_theta_6 = (l4^2 + d.^2 - l3^2) ./ (2 * l4 .* d);
    cos_theta_6 = max(min(cos_theta_6, 1), -1);  % acosd ����ȭ
    ang_3_6_1 = acosd(cos_theta_6);

    % ���� ����
    ang_6_1_x = rad2deg(atan2(position_1_y - position_6_y, position_1_x - position_6_x));

    % ���� ����
    angle_option = ang_6_1_x + ang_3_6_1;

    % ��ġ ���
    position_3_x = position_6_x + l4 * cosd(angle_option);
    position_3_y = position_6_y + l4 * sind(angle_option);

    % �Ÿ� ����
    distance_6_3 = sqrt((position_6_x - position_3_x).^2 + (position_6_y - position_3_y).^2);
    distance_3_1 = sqrt((position_3_x - position_1_x).^2 + (position_3_y - position_1_y).^2);
    distance_5_1 = sqrt((position_5_x - position_1_x).^2 + (position_5_y - position_1_y).^2);
    distance_5_6 = sqrt((position_5_x - position_6_x).^2 + (position_5_y - position_6_y).^2);
    



    % ��� ����
    tol = 1e-3;

    % �ﰢ�� ���� ����
    triangle_valid = (l4 + l3 > d) & (l4 + d > l3) & (l3 + d > l4);
    triangle_valid_651 = (d + l6 > distance_5_1) & (d + distance_5_1 > l6) & (l6 + distance_5_1 > d);

    % ���� ���� �ε���
    invalid_idx = abs(distance_6_3 - l4) > tol | ...
                  abs(distance_3_1 - l3) > tol | ...
                  abs(distance_5_6 - l6) > tol | ...
                  ~triangle_valid | ...
                  ~triangle_valid_651;

    % NaN ó��
    position_3_x(invalid_idx) = NaN;
    position_3_y(invalid_idx) = NaN;

end

