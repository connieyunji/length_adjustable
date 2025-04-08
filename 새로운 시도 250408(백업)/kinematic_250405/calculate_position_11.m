

% function [position_11_x, position_11_y] = calculate_position_11(position_7_x, position_7_y, theta, l10)
% 
%     % ���� ��ǥ 
%     position_7 = [position_7_x; position_7_y]; 
% 
%     % ȸ�� ��� ���� 
%     R = [cosd(theta), -sind(theta);
%          sind(theta),  cosd(theta)];
% 
%     % �̵� ����
%     T = [-l10 ; 0]; 
% 
% 
%     % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
%     position_11 = position_7 + R * T;
% 
%     position_11_x = position_11(1);
%     position_11_y = position_11(2);
% 
% end

function [position_11_x, position_11_y] = calculate_position_11(position_7_x, position_7_y, theta, l10)

    % ȸ�� ��� ��� ��� (��ε�ĳ���� ����)
    cos_theta = cosd(theta);
    sin_theta = sind(theta);

    % �̵� ���� (ũ�� ��ȯ �ʿ� ����)
    T_x = -l10;
    T_y =  0;

    % ���ο� ��ġ ��� (��ε�ĳ���� Ȱ��)
    position_11_x = position_7_x + cos_theta .* T_x - sin_theta .* T_y;
    position_11_y = position_7_y + sin_theta .* T_x + cos_theta .* T_y;

end