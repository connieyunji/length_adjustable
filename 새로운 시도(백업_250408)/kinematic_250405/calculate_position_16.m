% function [position_16_x, position_16_y] = calculate_position_16(position_14_x, position_14_y, theta, ang_16_14_17, l26)
% 
%     % 기준 좌표 
%     position_14 = [position_14_x; position_14_y]; 
% 
%     % 회전 행렬 정의 
%     R = [cosd(theta), -sind(theta);
%          sind(theta),  cosd(theta)];
% 
%     % 이동 벡터
%     T = [-l26 * cosd(ang_16_14_17); l26 * sind(ang_16_14_17)]; 
% 
% 
%     % 새로운 위치 계산 (회전 적용 후 병진 변환)
%     position_16 = position_14 + R * T;
% 
%     position_16_x = position_16(1);
%     position_16_y = position_16(2);
% 
% end

function [position_16_x, position_16_y] = calculate_position_16(position_14_x, position_14_y, theta, ang_16_14_17, l26)

    % 벡터화된 회전 행렬 요소
    cos_theta = cosd(theta);
    sin_theta = sind(theta);

    % 이동 벡터 (벡터 연산 적용)
    T_x = -l26 * cosd(ang_16_14_17);
    T_y =  l26 * sind(ang_16_14_17);

    % 새로운 위치 계산 (요소별 연산)
    position_16_x = position_14_x + cos_theta .* T_x - sin_theta .* T_y;
    position_16_y = position_14_y + sin_theta .* T_x + cos_theta .* T_y;

end


