% function [position_13_x, position_13_y] = calculate_position_13(position_16_x, position_16_y, position_12_x, position_12_y, l25, l17, total_theta)
%     % 변수 정의
%     syms position_13_x position_13_y
% 
%     % 방정식 1: 점 13과 16 사이의 거리 (l25)
%     eq1 = (position_13_x - position_16_x)^2 + (position_13_y - position_16_y)^2 == l25^2;
% 
%     % 방정식 2: 점 13과 12 사이의 거리 (l17)
%     eq2 = (position_13_x - position_12_x)^2 + (position_13_y - position_12_y)^2 == l17^2;
% 
%     % 연립 방정식 풀기
%     sol = solve([eq1, eq2], [position_13_x, position_13_y]);
% 
%     % 결과를 더블형으로 변환
%     position_13_x = double(sol.position_13_x);
%     position_13_y = double(sol.position_13_y);
% 
%     if total_theta <= 90
%         % y축 값이 더 높은 값을 선택
%         [~, idx] = max(position_13_y);  % y값이 더 큰 인덱스를 찾음
%     else
%         % x축 값이 더 작은 값을 선택
%         [~, idx] = min(position_13_x);  % x값이 더 작은 인덱스를 찾음
%         if total_theta >= 200
%             % y축 값이 더 작은 값을 선택
%             [~, idx] = min(position_13_y);  
%         end
%     end
% 
%     % 조건을 만족하는 해 선택
%     position_13_x = position_13_x(idx);
%     position_13_y = position_13_y(idx);
% end


% 
function [position_13_x, position_13_y] = calculate_position_13(position_16_x, position_16_y, position_12_x, position_12_y, l25, l17)

    % 거리 계산
    d = sqrt((position_16_x - position_12_x).^2 + (position_16_y - position_12_y).^2);

    % 코사인 각도 계산
    cos_theta_16 = (l25^2 + d.^2 - l17^2) ./ (2 * l25 .* d);
    cos_theta_16 = max(min(cos_theta_16, 1), -1);  % 범위 제한
    ang_13_16_12 = acosd(cos_theta_16);

    ang_12_16_x = atan2d(position_12_y - position_16_y, position_12_x - position_16_x);

    % 두 가지 위치 후보 계산
    angle_option_1 = ang_12_16_x + ang_13_16_12;
    angle_option_2 = ang_12_16_x - ang_13_16_12;

    candidate1_x = position_16_x + l25 * cosd(angle_option_1);
    candidate1_y = position_16_y + l25 * sind(angle_option_1);
    dist1 = sqrt((candidate1_x - position_12_x).^2 + (candidate1_y - position_12_y).^2);

    candidate2_x = position_16_x + l25 * cosd(angle_option_2);
    candidate2_y = position_16_y + l25 * sind(angle_option_2);
    dist2 = sqrt((candidate2_x - position_12_x).^2 + (candidate2_y - position_12_y).^2);

    % 허용 오차
    tolerance = 1e-3;

    % 벡터 초기화
    position_13_x = NaN(size(position_16_x));
    position_13_y = NaN(size(position_16_y));

    % dist1이 맞는 경우 저장
    idx1 = abs(dist1 - l17) < tolerance;
    position_13_x(idx1) = candidate1_x(idx1);
    position_13_y(idx1) = candidate1_y(idx1);

    % dist2가 맞는 경우 저장 (아직 NaN인 부분만)
    idx2 = abs(dist2 - l17) < tolerance & isnan(position_13_x);
    position_13_x(idx2) = candidate2_x(idx2);
    position_13_y(idx2) = candidate2_y(idx2);
end
