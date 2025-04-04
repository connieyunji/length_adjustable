function [position_17_x, position_17_y] = calculate_position_17(position_14_x, position_14_y, theta, l23)
    
    % 기준 좌표 
    position_14 = [position_14_x; position_14_y]; 
    
    % 회전 행렬 정의 
    R = [cosd(theta), -sind(theta);
         sind(theta),  cosd(theta)];
     
    % 이동 벡터
    T = [-l23 ; 0]; 
  
    
    % 새로운 위치 계산 (회전 적용 후 병진 변환)
    position_17 = position_14 + R * T;
    
    position_17_x = position_17(1);
    position_17_y = position_17(2);
   
end

% function [position_17_x, position_17_y] = calculate_position_17(position_14_x, position_14_y, theta, l23)
%     % 기준 좌표 (7번 조인트)
%     position14 = [position_14_x; position_14_y];
%     
%     % T1의 크기에 맞게 기준 좌표를 복제 (3D 배열)
%     position_11_x_3D = repmat(position14(1), size(theta));  
%     position_11_y_3D = repmat(position14(2), size(theta));  
%     
%     % 회전 행렬 정의 theta가 **양수(+)**일 때 반시계 방향 회전 / theta가 **음수(-)**일 때 시계 방향 회전
%     R = [cosd(-theta), -sind(-theta);
%          sind(-theta),  cosd(-theta)];
%      
%      
%     
%     % 이동 벡터 (x축과 y축에 대한 이동)
%     T_x = repmat(-l23, size(theta));  % x 방향 이동
%     T_y = repmat(0, size(theta));   % y 방향 이동
%     
%     
%     % 새로운 위치 계산 (회전 적용 후 병진 변환)
%     position_17_x = position_11_x_3D + R(1) .* T_x + R(2) .* T_y;  % x 좌표 계산
%     position_17_y = position_11_y_3D + R(3) .* T_x + R(4) .* T_y;  % y 좌표 계산
%     % 결과 반환
%     position_17_x = reshape(position_17_x, [], 1);
%     position_17_y = reshape(position_17_y, [], 1);
% end