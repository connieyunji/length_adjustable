

function [position_3_x, position_3_y] = calculate_position_3(position_6_x, position_6_y, position_1_x, position_1_y,position_5_x, position_5_y, l4, l3, l6)

    % 벡터 간 거리 계산
    d = sqrt((position_6_x - position_1_x).^2 + (position_6_y - position_1_y).^2);

    % 코사인 법칙을 이용한 각도 계산
    cos_theta_6 = (l4^2 + d.^2 - l3^2) ./ (2 * l4 .* d);
    cos_theta_6 = max(min(cos_theta_6, 1), -1);  % acosd 안정화
    ang_3_6_1 = acosd(cos_theta_6);

    % 기준 각도
    ang_6_1_x = rad2deg(atan2(position_1_y - position_6_y, position_1_x - position_6_x));

    % 최종 각도
    angle_option = ang_6_1_x + ang_3_6_1;

    % 위치 계산
    position_3_x = position_6_x + l4 * cosd(angle_option);
    position_3_y = position_6_y + l4 * sind(angle_option);

    % 거리 검증
    distance_6_3 = sqrt((position_6_x - position_3_x).^2 + (position_6_y - position_3_y).^2);
    distance_3_1 = sqrt((position_3_x - position_1_x).^2 + (position_3_y - position_1_y).^2);
    distance_5_1 = sqrt((position_5_x - position_1_x).^2 + (position_5_y - position_1_y).^2);
    distance_5_6 = sqrt((position_5_x - position_6_x).^2 + (position_5_y - position_6_y).^2);
    



    % 허용 오차
    tol = 1e-3;

    % 삼각형 성립 조건
    triangle_valid = (l4 + l3 > d) & (l4 + d > l3) & (l3 + d > l4);
    triangle_valid_651 = (d + l6 > distance_5_1) & (d + distance_5_1 > l6) & (l6 + distance_5_1 > d);

    % 조건 위반 인덱스
    invalid_idx = abs(distance_6_3 - l4) > tol | ...
                  abs(distance_3_1 - l3) > tol | ...
                  abs(distance_5_6 - l6) > tol | ...
                  ~triangle_valid | ...
                  ~triangle_valid_651;

    % NaN 처리
    position_3_x(invalid_idx) = NaN;
    position_3_y(invalid_idx) = NaN;

end

