function [position_5_x, position_5_y] = calculate_position_5(position_8_x, position_8_y, position_4_x, position_4_y, position_7_x,position_7_y, l5, l8, l9, l7)

    % ���� �� �Ÿ� ���
    d = sqrt((position_8_x - position_4_x).^2 + (position_8_y - position_4_y).^2);

    % �ڻ��� ��Ģ�� �̿��� ���� ���
    cos_theta_8 = (l8^2 + d.^2 - l5^2) ./ (2 * l8 .* d);
    cos_theta_8 = max(min(cos_theta_8, 1), -1);  % acosd ���� ����
    ang_5_8_4 = acosd(cos_theta_8);

    ang_4_8_x = rad2deg(atan2(position_4_y - position_8_y, position_4_x - position_8_x));

    % ���� ���� ���
    angle_option = ang_4_8_x + ang_5_8_4;

    % ��ġ ���
    position_5_x = position_8_x + l8 * cosd(angle_option);
    position_5_y = position_8_y + l8 * sind(angle_option);

    % �Ÿ� Ȯ��
    distance_8_5 = sqrt((position_5_x - position_8_x).^2 + (position_5_y - position_8_y).^2);
    distance_5_4 = sqrt((position_5_x - position_4_x).^2 + (position_5_y - position_4_y).^2);
    distance_8_7 = sqrt((position_8_x - position_7_x).^2 + (position_8_y - position_7_y).^2);
    distance_7_4 = sqrt((position_7_x - position_4_x).^2 + (position_7_y - position_4_y).^2);

    % ��� ����
    tol = 1e-3;

    % �ﰢ�� ����
    triangle_valid_1 = (l5 + l8 > d) & (l5 + d > l8) & (l8 + d > l5);
    triangle_valid_2 = (l9 + l7 > d) & (l9 + d > l7) & (l7 + d > l9);

    % ��ȿ���� ���� ��� NaN ó��
    invalid_idx = abs(distance_8_5 - l8) > tol | abs(distance_5_4 - l5) > tol |...
                  abs(distance_8_7 - l9) > tol | abs(distance_7_4 - l7) > tol |...
                  ~triangle_valid_1 | ~triangle_valid_2;
    position_5_x(invalid_idx) = NaN;
    position_5_y(invalid_idx) = NaN;

end
