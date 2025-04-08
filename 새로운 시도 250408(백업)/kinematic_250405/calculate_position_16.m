% function [position_16_x, position_16_y] = calculate_position_16(position_14_x, position_14_y, theta, ang_16_14_17, l26)
% 
%     % ���� ��ǥ 
%     position_14 = [position_14_x; position_14_y]; 
% 
%     % ȸ�� ��� ���� 
%     R = [cosd(theta), -sind(theta);
%          sind(theta),  cosd(theta)];
% 
%     % �̵� ����
%     T = [-l26 * cosd(ang_16_14_17); l26 * sind(ang_16_14_17)]; 
% 
% 
%     % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
%     position_16 = position_14 + R * T;
% 
%     position_16_x = position_16(1);
%     position_16_y = position_16(2);
% 
% end

function [position_16_x, position_16_y] = calculate_position_16(position_14_x, position_14_y, theta, ang_16_14_17, l26)

    % ����ȭ�� ȸ�� ��� ���
    cos_theta = cosd(theta);
    sin_theta = sind(theta);

    % �̵� ���� (���� ���� ����)
    T_x = -l26 * cosd(ang_16_14_17);
    T_y =  l26 * sind(ang_16_14_17);

    % ���ο� ��ġ ��� (��Һ� ����)
    position_16_x = position_14_x + cos_theta .* T_x - sin_theta .* T_y;
    position_16_y = position_14_y + sin_theta .* T_x + cos_theta .* T_y;

end


