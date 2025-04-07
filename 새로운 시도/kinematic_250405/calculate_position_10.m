% function [p10_x, p10_y] = calculate_position_10(position_13_x, position_13_y,position_9_x, position_9_y, l18, l14, total_theta)
%     % 변수 정의
%     syms p10_x p10_y
% 
%     % 방정식 1: 점 10과 13거리
%     eq1 = (p10_x - position_13_x)^2 + (p10_y - position_13_y)^2 == l18^2;
% 
%     % 방정식 2: 점 10과 9거리
%      eq2 = (p10_x - position_9_x)^2 + (p10_y - position_9_y)^2 == l14^2;
% 
%     % 연립 방정식 풀기
%     sol = solve([eq1, eq2], [p10_x, p10_y]);
% 
%     % 결과를 더블형으로 변환
%     p10_x = double(sol.p10_x);
%     p10_y = double(sol.p10_y);
% 
%     if total_theta >= 90
%         % y축 값이 더 높은 값을 선택
%         [~, idx] = min(p10_x);  % x값이 더 작은 인덱스를 찾음
%     else
%         % x축 값이 더 작은 값을 선택
%         [~, idx] = max(p10_y);  % y값이 더 큰 인덱스를 찾음
%     end
% 
%     % 조건을 만족하는 해 선택
%     p10_x = p10_x(idx);
%     p10_y = p10_y(idx);
% 
% 
% end


function [position_10_x, position_10_y] = calculate_position_10(position_13_x, position_13_y, position_9_x, position_9_y, l18, l14)

    % 벡터 간 거리 계산
    d = sqrt((position_13_x - position_9_x).^2 + (position_13_y - position_9_y).^2);

    % 코사인 법칙을 이용한 각도 계산
    cos_theta_13 = (l18^2 + d.^2 - l14^2) ./ (2 * l18 .* d);
    cos_theta_13 = max(min(cos_theta_13, 1), -1);  % acosd 오류 방지
    ang_10_13_9 = acosd(cos_theta_13);

    ang_13_9_x =  rad2deg(atan2(position_9_y - position_13_y, position_9_x - position_13_x));

    % 최종 각도 계산 (하나만 사용)
    angle_option = ang_13_9_x + ang_10_13_9;

    % 위치 계산
    position_10_x = position_13_x + l18 * cosd(angle_option);
    position_10_y = position_13_y + l18 * sind(angle_option);
    
    % 거리 확인
    distance_13_10 = sqrt((position_13_x - position_10_x).^2 + (position_13_y - position_10_y).^2);
    distance_10_9 = sqrt((position_10_x - position_9_x).^2 + (position_10_y - position_9_y).^2);

    % 허용 오차 (예: 0.1mm)
    tol = 1e-2;

    % 조건을 만족하지 않는 인덱스만 NaN 처리
    invalid_idx = abs(distance_13_10 - l18) > tol | abs(distance_10_9 - l14) > tol;
    position_10_x(invalid_idx) = NaN;
    position_10_y(invalid_idx) = NaN;

end
