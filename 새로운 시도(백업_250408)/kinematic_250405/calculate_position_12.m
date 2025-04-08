% function [position_12_x, position_12_y] = calculate_position_12(position_11_x, position_11_y, theta, ang_12_11_14, l16)
% 
%     % 기준 좌표 
%     position_11 = [position_11_x; position_11_y]; 
% 
%     % 회전 행렬 정의 
%     R = [cosd(theta), -sind(theta);
%          sind(theta),  cosd(theta)];
% 
%     % 이동 벡터
%     T = [-l16 * cosd(ang_12_11_14); l16 * sind(ang_12_11_14)]; 
% 
% 
%     % 새로운 위치 계산 (회전 적용 후 병진 변환)
%     position_12 = position_11 + R * T;
% 
%     position_12_x = position_12(1);
%     position_12_y = position_12(2);
% 
% end

function [position_12_x, position_12_y] = calculate_position_12(position_11_x, position_11_y, theta, ang_12_11_14, l16)

    % 회전 행렬 요소 계산 (브로드캐스팅 적용)
    cos_theta = cosd(theta);
    sin_theta = sind(theta);

    % 이동 벡터 (크기 변환 필요 없음)
    T_x = -l16 * cosd(ang_12_11_14);
    T_y =  l16 * sind(ang_12_11_14);

    % 새로운 위치 계산 (브로드캐스팅 활용)
    position_12_x = position_11_x + cos_theta .* T_x - sin_theta .* T_y;
    position_12_y = position_11_y + sin_theta .* T_x + cos_theta .* T_y;

end
