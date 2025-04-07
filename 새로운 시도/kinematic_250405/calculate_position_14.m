% function [position_14_x, position_14_y] = calculate_position_14(position_11_x, position_11_y, theta, l15)
% 
%     % 기준 좌표 
%     position_11 = [position_11_x; position_11_y]; 
% 
%     % 회전 행렬 정의 
%     R = [cosd(theta), -sind(theta);
%          sind(theta),  cosd(theta)];
% 
%     % 이동 벡터
%     T = [-l15 ; 0]; 
% 
% 
%     % 새로운 위치 계산 (회전 적용 후 병진 변환)
%     position_14 = position_11 + R * T;
% 
%     position_14_x = position_14(1);
%     position_14_y = position_14(2);
% 
% end

function [position_14_x, position_14_y] = calculate_position_14(position_11_x, position_11_y, theta, l15)

    % 벡터화된 회전 행렬 요소
    cos_theta = cosd(theta);
    sin_theta = sind(theta);

    % 이동 벡터 (벡터 연산 적용)
    T_x = -l15;
    T_y =  0;

    % 새로운 위치 계산 (요소별 연산)
    position_14_x = position_11_x + cos_theta .* T_x - sin_theta .* T_y;
    position_14_y = position_11_y + sin_theta .* T_x + cos_theta .* T_y;

end


% function [position_14_x, position_14_y] = calculate_position_14(position_11_x, position_11_y, theta, l15)
%     % 기준 좌표 (7번 조인트)
%     position11 = [position_11_x; position_11_y];
%     
%     % T1의 크기에 맞게 기준 좌표를 복제 (3D 배열)
%     position_11_x_3D = repmat(position11(1), size(theta));  
%     position_11_y_3D = repmat(position11(2), size(theta));  
%     
%     % 회전 행렬 정의 theta가 **양수(+)**일 때 반시계 방향 회전 / theta가 **음수(-)**일 때 시계 방향 회전
%     R = [cosd(-theta), -sind(-theta);
%          sind(-theta),  cosd(-theta)];
%      
%      
%     
%     % 이동 벡터 (x축과 y축에 대한 이동)
%     T_x = repmat(-l15, size(theta));  % x 방향 이동
%     T_y = repmat(0, size(theta));   % y 방향 이동
%     
%     
%     % 새로운 위치 계산 (회전 적용 후 병진 변환)
%     position_14_x = position_11_x_3D + R(1) .* T_x + R(2) .* T_y;  % x 좌표 계산
%     position_14_y = position_11_y_3D + R(3) .* T_x + R(4) .* T_y;  % y 좌표 계산
%     % 결과 반환
%     position_14_x = reshape(position_14_x, [], 1);
%     position_14_y = reshape(position_14_y, [], 1);
% end