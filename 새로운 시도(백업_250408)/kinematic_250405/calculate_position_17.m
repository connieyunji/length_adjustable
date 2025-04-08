% function [position_17_x, position_17_y] = calculate_position_17(position_14_x, position_14_y, theta, l23)
% 
%     % ���� ��ǥ 
%     position_14 = [position_14_x; position_14_y]; 
% 
%     % ȸ�� ��� ���� 
%     R = [cosd(theta), -sind(theta);
%          sind(theta),  cosd(theta)];
% 
%     % �̵� ����
%     T = [-l23 ; 0]; 
% 
% 
%     % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
%     position_17 = position_14 + R * T;
% 
%     position_17_x = position_17(1);
%     position_17_y = position_17(2);
% 
% end

function [position_17_x, position_17_y] = calculate_position_17(position_14_x, position_14_y, theta, l23)

    % ȸ�� ��� ��� ��� (��ε�ĳ���� ����)
    cos_theta = cosd(theta);
    sin_theta = sind(theta);

    % �̵� ���� (ũ�� ��ȯ �ʿ� ����)
    T_x = -l23;
    T_y =  0;

    % ���ο� ��ġ ��� (��ε�ĳ���� Ȱ��)
    position_17_x = position_14_x + cos_theta .* T_x - sin_theta .* T_y;
    position_17_y = position_14_y + sin_theta .* T_x + cos_theta .* T_y;

end
