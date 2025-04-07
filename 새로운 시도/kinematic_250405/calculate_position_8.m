% function [position_8_x, position_8_y] = calculate_position_8(position_7_x, position_7_y, theta, ang_8_7_11, l9)
% 
%     % 기준 좌표 (7번 조인트)
%     position_7 = [position_7_x; position_7_y]; 
% 
%     % 회전 행렬 정의 (theta1_default만큼 회전)
%     R = [cosd(theta), -sind(theta);
%          sind(theta),  cosd(theta)];
% 
%     % 이동 벡터
%     T = [-l9 * cosd(ang_8_7_11); l9 * sind(ang_8_7_11)]; 
% 
% 
%     % 새로운 위치 계산 (회전 적용 후 병진 변환)
%     position_8 = position_7 + R .* T;
% 
%     position_8_x = position_8(1);
%     position_8_y = position_8(2);
% 
% end
% % 
% % 
% % 
% 
% 
% function [position_8_x, position_8_y] = calculate_position_8(position_7_x, position_7_y, theta, ang_8_7_11, l9)
% 
%     % theta의 크기 확인
%     sz = size(theta);
% 
%     % 기준 좌표 (7번 조인트) - theta와 동일한 크기로 확장
%     position_7_x = repmat(position_7_x, sz);
%     position_7_y = repmat(position_7_y, sz);
% 
%     % 회전 행렬 요소 계산
%     cos_theta = cosd(theta);
%     sin_theta = sind(theta);
% 
%     % 이동 벡터 (theta 크기에 맞춤)
%     T_x = -l9 * cosd(ang_8_7_11);  % 스칼라 값
%     T_y = l9 * sind(ang_8_7_11);   % 스칼라 값
% 
%     T_x = repmat(T_x, sz); % 크기 맞추기
%     T_y = repmat(T_y, sz); % 크기 맞추기
% 
%     % 새로운 위치 계산 (회전 적용 후 병진 변환)
%     position_8_x = position_7_x + cos_theta .* T_x - sin_theta .* T_y;
%     position_8_y = position_7_y + sin_theta .* T_x + cos_theta .* T_y;
% 
% end
% 

function [position_8_x, position_8_y] = calculate_position_8(position_7_x, position_7_y, theta, ang_8_7_11, l9)

    % 회전 행렬 요소 계산 (브로드캐스팅 적용)
    cos_theta = cosd(theta);
    sin_theta = sind(theta);

    % 이동 벡터 (크기 변환 필요 없음)
    T_x = -l9 * cosd(ang_8_7_11);
    T_y =  l9 * sind(ang_8_7_11);

    % 새로운 위치 계산 (브로드캐스팅 활용)
    position_8_x = position_7_x + cos_theta .* T_x - sin_theta .* T_y;
    position_8_y = position_7_y + sin_theta .* T_x + cos_theta .* T_y;

end
