% function [position_8_x, position_8_y] = calculate_position_8(position_7_x, position_7_y, theta, ang_8_7_11, l9)
% 
%     % ���� ��ǥ (7�� ����Ʈ)
%     position_7 = [position_7_x; position_7_y]; 
% 
%     % ȸ�� ��� ���� (theta1_default��ŭ ȸ��)
%     R = [cosd(theta), -sind(theta);
%          sind(theta),  cosd(theta)];
% 
%     % �̵� ����
%     T = [-l9 * cosd(ang_8_7_11); l9 * sind(ang_8_7_11)]; 
% 
% 
%     % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
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
%     % theta�� ũ�� Ȯ��
%     sz = size(theta);
% 
%     % ���� ��ǥ (7�� ����Ʈ) - theta�� ������ ũ��� Ȯ��
%     position_7_x = repmat(position_7_x, sz);
%     position_7_y = repmat(position_7_y, sz);
% 
%     % ȸ�� ��� ��� ���
%     cos_theta = cosd(theta);
%     sin_theta = sind(theta);
% 
%     % �̵� ���� (theta ũ�⿡ ����)
%     T_x = -l9 * cosd(ang_8_7_11);  % ��Į�� ��
%     T_y = l9 * sind(ang_8_7_11);   % ��Į�� ��
% 
%     T_x = repmat(T_x, sz); % ũ�� ���߱�
%     T_y = repmat(T_y, sz); % ũ�� ���߱�
% 
%     % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
%     position_8_x = position_7_x + cos_theta .* T_x - sin_theta .* T_y;
%     position_8_y = position_7_y + sin_theta .* T_x + cos_theta .* T_y;
% 
% end
% 

function [position_8_x, position_8_y] = calculate_position_8(position_7_x, position_7_y, theta, ang_8_7_11, l9)

    % ȸ�� ��� ��� ��� (��ε�ĳ���� ����)
    cos_theta = cosd(theta);
    sin_theta = sind(theta);

    % �̵� ���� (ũ�� ��ȯ �ʿ� ����)
    T_x = -l9 * cosd(ang_8_7_11);
    T_y =  l9 * sind(ang_8_7_11);

    % ���ο� ��ġ ��� (��ε�ĳ���� Ȱ��)
    position_8_x = position_7_x + cos_theta .* T_x - sin_theta .* T_y;
    position_8_y = position_7_y + sin_theta .* T_x + cos_theta .* T_y;

end
