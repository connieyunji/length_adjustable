function [position_9_x, position_9_y] = calculate_position_9(position_8_x, position_8_y, theta, l11)
    
    % 기준 좌표 
    position_8 = [position_8_x; position_8_y]; 
    
    % 회전 행렬 정의 
    R = [cosd(theta), -sind(theta);
         sind(theta),  cosd(theta)];
     
    % 이동 벡터
    T = [- l11; 0]; 
  
    
    % 새로운 위치 계산 (회전 적용 후 병진 변환)
    position_9 = position_8 + R * T;
    
    position_9_x = position_9(1);
    position_9_y = position_9(2);
   
end

% function [position_9_x, position_9_y] = calculate_position_9(position_8_x, position_8_y, theta, l11)
%     % 기준 좌표 
%     position_8 = [position_8_x; position_8_y];
%     
%     % T의 크기에 맞게 기준 좌표를 복제 (3D 배열)
%     position_8_x_3D = repmat(position_8(1), size(theta));  
%     position_8_y_3D = repmat(position_8(2), size(theta));  
%      
%     % 회전 행렬 정의 theta가 **양수(+)**일 때 반시계 방향 회전 / theta가 **음수(-)**일 때 시계 방향 회전
%     R = [cosd(-theta), -sind(-theta);
%          sind(-theta),  cosd(-theta)];
%     
%     % 이동 벡터 (x축과 y축에 대한 이동)
%     T_x = repmat(-l11 , size(theta));  % x 방향 이동
%     T_y = repmat(0 , size(theta));   % y 방향 이동
%     
%     
%     % 새로운 위치 계산 (회전 적용 후 병진 변환)
%     position_9_x = position_8_x_3D + R(1) .* T_x + R(2) .* T_y;  % x 좌표 계산
%     position_9_y = position_8_y_3D + R(3) .* T_x + R(4) .* T_y;  % y 좌표 계산
%     % 결과 반환
%     position_9_x = reshape(position_9_x, [], 1);
%     position_9_y = reshape(position_9_y, [], 1);
% end

% function [position_9_x, position_9_y] = calculate_position_9(position_8_x, position_8_y, theta, l11)
%     % 기준 좌표 (8번 조인트)
%     position_8_x_3D = repmat(position_8_x, size(theta));  
%     position_8_y_3D = repmat(position_8_y, size(theta));  
%     
%     % 회전 행렬 정의 (theta가 3D 배열이므로, 개별 요소마다 적용)  
%     R11 = cosd(theta);   % R(1,1)
%     R12 = -sind(theta);  % R(1,2)
%     R21 = sind(theta);   % R(2,1)
%     R22 = cosd(theta);   % R(2,2)
%     
%     % 이동 벡터 (3D 배열 크기와 맞춤)
%     T_x = -l11 * ones(size(theta));  % x 방향 이동
%     T_y = zeros(size(theta));   % y 방향 이동
%     
%     % 새로운 위치 계산 (회전 행렬 적용)
%     position_9_x = position_8_x_3D + R11 .* T_x + R12 .* T_y;
%     position_9_y = position_8_y_3D + R21 .* T_x + R22 .* T_y;
% 
%     % 결과 반환 (벡터 형태 유지)
%     position_9_x = position_9_x(:);
%     position_9_y = position_9_y(:);
% end

% function [position_9_x, position_9_y] = calculate_position_9(position_8_x, position_8_y, theta, l11)
%     % 입력된 theta의 크기를 가져오기
%     theta_size = size(theta);
%     
%     % position_8_x, position_8_y를 theta와 동일한 크기로 맞춤
%     position_8_x = repmat(position_8_x, theta_size);
%     position_8_y = repmat(position_8_y, theta_size);
%     
%     % 회전 행렬 요소 계산 (theta 크기 유지)
%     R11 = cosd(theta);   % R(1,1)
%     R12 = -sind(theta);  % R(1,2)
%     R21 = sind(theta);   % R(2,1)
%     R22 = cosd(theta);   % R(2,2)
%     
%     % 이동 벡터 (theta 크기에 맞게 변환)
%     T_x = repmat(-l11, theta_size);  % x 방향 이동
%     T_y = zeros(theta_size);         % y 방향 이동
%     
%     % 새로운 위치 계산 (회전 행렬 적용)
%     position_9_x = position_8_x + R11 .* T_x + R12 .* T_y;
%     position_9_y = position_8_y + R21 .* T_x + R22 .* T_y;
% end
% 
