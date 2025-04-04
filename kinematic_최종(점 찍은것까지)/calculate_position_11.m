% 
% function [position_11_x, position_11_y] = calculate_position_11(position_7_x, position_7_y, theta, l10)
%     % 기준 좌표 (7번 조인트)
%     position_7 = [position_7_x; position_7_y];
%     
%     % T1의 크기에 맞게 기준 좌표를 복제 (3D 배열)
%     position_7_x_3D = repmat(position_7(1), size(theta));  
%     position_7_y_3D = repmat(position_7(2), size(theta));  
%     
%     % 회전 행렬 정의 theta가 **양수(+)**일 때 반시계 방향 회전 / theta가 **음수(-)**일 때 시계 방향 회전
%     R = [cosd(-theta), -sind(-theta);
%          sind(-theta),  cosd(-theta)];
%      
%      
%     
%     % 이동 벡터 (x축과 y축에 대한 이동)
%     T_x = repmat(-l10, size(theta));  % x 방향 이동
%     T_y = repmat(0, size(theta));   % y 방향 이동
%     
%     
%     % 새로운 위치 계산 (회전 적용 후 병진 변환)
%     position_11_x = position_7_x_3D + R(1) .* T_x + R(2) .* T_y;  % x 좌표 계산
%     position_11_y = position_7_y_3D + R(3) .* T_x + R(4) .* T_y;  % y 좌표 계산
%     % 결과 반환
%     position_11_x = reshape(position_11_x, [], 1);
%     position_11_y = reshape(position_11_y, [], 1);
% end

function [position_11_x, position_11_y] = calculate_position_11(position_7_x, position_7_y, theta, l10)
    
    % 기준 좌표 
    position_7 = [position_7_x; position_7_y]; 
    
    % 회전 행렬 정의 
    R = [cosd(theta), -sind(theta);
         sind(theta),  cosd(theta)];
     
    % 이동 벡터
    T = [-l10 ; 0]; 
  
    
    % 새로운 위치 계산 (회전 적용 후 병진 변환)
    position_11 = position_7 + R * T;
    
    position_11_x = position_11(1);
    position_11_y = position_11(2);
   
end
