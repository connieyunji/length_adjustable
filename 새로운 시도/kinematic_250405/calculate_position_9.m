% function [position_9_x, position_9_y] = calculate_position_9(position_8_x, position_8_y, theta, l11)
% 
%     % 기준 좌표 
%     position_8 = [position_8_x; position_8_y]; 
% 
%     % 회전 행렬 정의 
%     R = [cosd(theta), -sind(theta);
%          sind(theta),  cosd(theta)];
% 
%     % 이동 벡터
%     T = [- l11; 0]; 
% 
% 
%     % 새로운 위치 계산 (회전 적용 후 병진 변환)
%     position_9 = position_8 + R * T;
% 
%     position_9_x = position_9(1);
%     position_9_y = position_9(2);
% 
% end
% 

function [position_9_x, position_9_y] = calculate_position_9(position_8_x, position_8_y, theta, l11)

    % 회전 행렬 요소 계산 (브로드캐스팅 적용)
    cos_theta = cosd(theta);
    sin_theta = sind(theta);

    % 이동 벡터 (크기 변환 필요 없음)
    T_x = -l11;  
    T_y = 0;    

    % 새로운 위치 계산 (브로드캐스팅 활용)
    position_9_x = position_8_x + cos_theta .* T_x - sin_theta .* T_y;
    position_9_y = position_8_y + sin_theta .* T_x + cos_theta .* T_y;
    
end
