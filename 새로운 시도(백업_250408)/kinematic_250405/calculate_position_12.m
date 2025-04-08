% function [position_12_x, position_12_y] = calculate_position_12(position_11_x, position_11_y, theta, ang_12_11_14, l16)
% 
%     % ���� ��ǥ 
%     position_11 = [position_11_x; position_11_y]; 
% 
%     % ȸ�� ��� ���� 
%     R = [cosd(theta), -sind(theta);
%          sind(theta),  cosd(theta)];
% 
%     % �̵� ����
%     T = [-l16 * cosd(ang_12_11_14); l16 * sind(ang_12_11_14)]; 
% 
% 
%     % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
%     position_12 = position_11 + R * T;
% 
%     position_12_x = position_12(1);
%     position_12_y = position_12(2);
% 
% end

function [position_12_x, position_12_y] = calculate_position_12(position_11_x, position_11_y, theta, ang_12_11_14, l16)

    % ȸ�� ��� ��� ��� (��ε�ĳ���� ����)
    cos_theta = cosd(theta);
    sin_theta = sind(theta);

    % �̵� ���� (ũ�� ��ȯ �ʿ� ����)
    T_x = -l16 * cosd(ang_12_11_14);
    T_y =  l16 * sind(ang_12_11_14);

    % ���ο� ��ġ ��� (��ε�ĳ���� Ȱ��)
    position_12_x = position_11_x + cos_theta .* T_x - sin_theta .* T_y;
    position_12_y = position_11_y + sin_theta .* T_x + cos_theta .* T_y;

end
