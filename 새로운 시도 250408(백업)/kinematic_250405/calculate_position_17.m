% function [position_17_x, position_17_y] = calculate_position_17(position_14_x, position_14_y, theta, l23)
% 
%     % 기준 좌표 
%     position_14 = [position_14_x; position_14_y]; 
% 
%     % 회전 행렬 정의 
%     R = [cosd(theta), -sind(theta);
%          sind(theta),  cosd(theta)];
% 
%     % 이동 벡터
%     T = [-l23 ; 0]; 
% 
% 
%     % 새로운 위치 계산 (회전 적용 후 병진 변환)
%     position_17 = position_14 + R * T;
% 
%     position_17_x = position_17(1);
%     position_17_y = position_17(2);
% 
% end

function [position_17_x, position_17_y] = calculate_position_17(position_14_x, position_14_y, theta, l23)

    % 회전 행렬 요소 계산 (브로드캐스팅 적용)
    cos_theta = cosd(theta);
    sin_theta = sind(theta);

    % 이동 벡터 (크기 변환 필요 없음)
    T_x = -l23;
    T_y =  0;

    % 새로운 위치 계산 (브로드캐스팅 활용)
    position_17_x = position_14_x + cos_theta .* T_x - sin_theta .* T_y;
    position_17_y = position_14_y + sin_theta .* T_x + cos_theta .* T_y;

end
