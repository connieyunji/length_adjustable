% function [position_9_x, position_9_y] = calculate_position_9(position_8_x, position_8_y, theta, l11)
% 
%     % ���� ��ǥ 
%     position_8 = [position_8_x; position_8_y]; 
% 
%     % ȸ�� ��� ���� 
%     R = [cosd(theta), -sind(theta);
%          sind(theta),  cosd(theta)];
% 
%     % �̵� ����
%     T = [- l11; 0]; 
% 
% 
%     % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
%     position_9 = position_8 + R * T;
% 
%     position_9_x = position_9(1);
%     position_9_y = position_9(2);
% 
% end
% 

function [position_9_x, position_9_y] = calculate_position_9(position_8_x, position_8_y, theta, l11)

    % ȸ�� ��� ��� ��� (��ε�ĳ���� ����)
    cos_theta = cosd(theta);
    sin_theta = sind(theta);

    % �̵� ���� (ũ�� ��ȯ �ʿ� ����)
    T_x = -l11;  
    T_y = 0;    

    % ���ο� ��ġ ��� (��ε�ĳ���� Ȱ��)
    position_9_x = position_8_x + cos_theta .* T_x - sin_theta .* T_y;
    position_9_y = position_8_y + sin_theta .* T_x + cos_theta .* T_y;
    
end
