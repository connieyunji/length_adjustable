function [position_6_x, position_6_y] = calculate_position_6(position_10_x, position_10_y, position_5_x, position_5_y, position_9_x, position_9_y, l12, l6, l14)


    % 벡터 간 거리 계산
    d = sqrt((position_10_x - position_5_x).^2 + (position_10_y - position_5_y).^2);

    % 코사인 법칙을 이용한 각도 계산
    cos_theta_10 = (l12^2 + d.^2 - l6^2) ./ (2 * l12 .* d);
    cos_theta_10 = max(min(cos_theta_10, 1), -1);


    ang_6_10_5 = acosd(cos_theta_10);

    ang_5_10_x =  rad2deg(atan2(position_5_y - position_10_y, position_5_x - position_10_x));

    % 최종 각도 계산
    angle_option = ang_5_10_x + ang_6_10_5;

    % 위치 계산
    position_6_x = position_10_x + l12 * cosd(angle_option);
    position_6_y = position_10_y + l12 * sind(angle_option);


    % 거리 확인
    distance_6_10 = sqrt((position_6_x - position_10_x).^2 + (position_6_y - position_10_y).^2);
    distance_6_5 = sqrt((position_6_x - position_5_x).^2 + (position_6_y - position_5_y).^2);
    distance_10_9 = sqrt((position_10_x - position_9_x).^2 + (position_10_y - position_9_y).^2);
    distance_9_5   = sqrt((position_9_x - position_5_x).^2 + (position_9_y - position_5_y).^2);
    % 허용 오차 (예: 0.1mm)
    tol = 1e-3;

    % 삼각형 조건 (세 변의 합 비교)
    triangle_valid = (l12 + l6 > d) & (l12 + d > l6) & (l6 + d > l12);
    triangle_valid_1059 = (d + l14 > distance_9_5) & (d + distance_9_5 > l14) & (l14 + distance_9_5 > d);
    
    
    % 거리 또는 삼각형 조건 위반 인덱스
    invalid_idx = abs(distance_6_10 - l12) > tol | ...
                  abs(distance_6_5 - l6) > tol | ...
                  abs(distance_10_9 - l14) > tol | ...
                  ~triangle_valid | ~triangle_valid_1059;

    % NaN 처리
    position_6_x(invalid_idx) = NaN;
    position_6_y(invalid_idx) = NaN;

    % % angle 조건 위반 인덱스 (벡터화해서 처리)
    % point_6 = [position_6_x(:), position_6_y(:)];
    % point_5 = [position_5_x(:), position_5_y(:)];
    % point_8 = [position_8_x(:), position_8_y(:)];
    % 
    % angle_6_5_8 = arrayfun(@(i) calculate_angle(point_6(i,:), point_5(i,:), point_8(i,:)), 1:size(point_6,1));
    % 
    % invalid_angle = angle_6_5_8 < 20;
    % 
    % % 최종적으로 NaN 처리할 인덱스
    % invalid_idx = invalid_dist(:) | invalid_angle(:);
    % 
    % % NaN 처리
    % position_6_x(invalid_idx) = NaN;
    % position_6_y(invalid_idx) = NaN;

end



