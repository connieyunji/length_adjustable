% function [p6_x, p6_y] = calculate_position_6(position_10_x, position_10_y,position_5_x, position_5_y, l12, l6, total_theta)
%     % 변수 정의
%     syms p6_x p6_y
% 
%     % 방정식 1: 점 6과 10거리
%     eq1 = (p6_x - position_10_x)^2 + (p6_y - position_10_y)^2 == l12^2;
% 
%     % 방정식 2: 점 6과 5거리
%      eq2 = (p6_x - position_5_x)^2 + (p6_y - position_5_y)^2 == l6^2;
% 
%     % 연립 방정식 풀기
%     sol = solve([eq1, eq2], [p6_x, p6_y]);
% 
%     % 결과를 더블형으로 변환
%     p6_x = double(sol.p6_x);
%     p6_y = double(sol.p6_y);
% 
%     % % 모든 해 출력
%     % disp('p6_x possible values:');
%     % disp(p6_x);
%     % disp('p6_y possible values:');
%     % disp(p6_y);
% 
%     if total_theta >= -100           %모든 값에 다 적용되는 조건
%         % y축 값이 더 높은 값을 선택
%         [~, idx] = max(p6_y);    
%     end   
% 
%     % 조건을 만족하는 해 선택
%     p6_x = p6_x(idx);
%     p6_y = p6_y(idx);
% 
% 
% end


function [position_6_x, position_6_y] = calculate_position_6(position_10_x, position_10_y, position_5_x, position_5_y,position_8_x, position_8_y, l12, l6)

    % 벡터 간 거리 계산
    d = sqrt((position_10_x - position_5_x).^2 + (position_10_y - position_5_y).^2);

    % 코사인 법칙을 이용한 각도 계산
    cos_theta_10 = (l12^2 + d.^2 - l6^2) ./ (2 * l12 .* d);
    cos_theta_10 = max(min(cos_theta_10, 1), -1);  % acosd 오류 방지
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

    % 허용 오차 (예: 0.1mm)
    tol = 1e-2;
    
    % 조건 위반 인덱스
    invalid_dist = abs(distance_6_10 - l12) > tol | abs(distance_6_5 - l6) > tol;

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


