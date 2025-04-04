function [position_12_x, position_12_y] = calculate_position_12(position_11_x, position_11_y, theta, ang_12_11_14, l16)
    
    % 기준 좌표 
    position_11 = [position_11_x; position_11_y]; 
    
    % 회전 행렬 정의 
    R = [cosd(theta), -sind(theta);
         sind(theta),  cosd(theta)];
     
    % 이동 벡터
    T = [-l16 * cosd(ang_12_11_14); l16 * sind(ang_12_11_14)]; 
  
    
    % 새로운 위치 계산 (회전 적용 후 병진 변환)
    position_12 = position_11 + R * T;
    
    position_12_x = position_12(1);
    position_12_y = position_12(2);
   
end

% function [position_12_x, position_12_y] = calculate_position_12(position_11_x, position_11_y, theta, ang_12_11_14, l16)
%     % 기준 좌표 
%     position_11 = [position_11_x; position_11_y];
%     
%     % T의 크기에 맞게 기준 좌표를 복제 (3D 배열)
%     position_11_x_3D = repmat(position_11(1), size(theta));  
%     position_11_y_3D = repmat(position_11(2), size(theta));  
%     
%     % 회전 행렬 정의 theta가 **양수(+)**일 때 반시계 방향 회전 / theta가 **음수(-)**일 때 시계 방향 회전
%     R = [cosd(-theta), -sind(-theta);
%          sind(-theta),  cosd(-theta)];
%      
%     
%     % 이동 벡터 (x축과 y축에 대한 이동)
%     T_x = repmat(-l16 * cosd(ang_12_11_14), size(theta));  % x 방향 이동
%     T_y = repmat(l16 * sind(ang_12_11_14), size(theta));   % y 방향 이동
%     
%     
%     % 새로운 위치 계산 (회전 적용 후 병진 변환)
%     position_12_x = position_11_x_3D + R(1) .* T_x + R(2) .* T_y;  % x 좌표 계산
%     position_12_y = position_11_y_3D + R(3) .* T_x + R(4) .* T_y;  % y 좌표 계산
%     % 결과 반환
%     position_12_x = reshape(position_12_x, [], 1);
%     position_12_y = reshape(position_12_y, [], 1);
% end