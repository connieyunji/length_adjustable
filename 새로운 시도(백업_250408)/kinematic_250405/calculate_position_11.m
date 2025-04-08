

% function [position_11_x, position_11_y] = calculate_position_11(position_7_x, position_7_y, theta, l10)
% 
%     % 기준 좌표 
%     position_7 = [position_7_x; position_7_y]; 
% 
%     % 회전 행렬 정의 
%     R = [cosd(theta), -sind(theta);
%          sind(theta),  cosd(theta)];
% 
%     % 이동 벡터
%     T = [-l10 ; 0]; 
% 
% 
%     % 새로운 위치 계산 (회전 적용 후 병진 변환)
%     position_11 = position_7 + R * T;
% 
%     position_11_x = position_11(1);
%     position_11_y = position_11(2);
% 
% end

function [position_11_x, position_11_y] = calculate_position_11(position_7_x, position_7_y, theta, l10)

    % 회전 행렬 요소 계산 (브로드캐스팅 적용)
    cos_theta = cosd(theta);
    sin_theta = sind(theta);

    % 이동 벡터 (크기 변환 필요 없음)
    T_x = -l10;
    T_y =  0;

    % 새로운 위치 계산 (브로드캐스팅 활용)
    position_11_x = position_7_x + cos_theta .* T_x - sin_theta .* T_y;
    position_11_y = position_7_y + sin_theta .* T_x + cos_theta .* T_y;

end