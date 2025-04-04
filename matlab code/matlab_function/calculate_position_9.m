function [position_9_x, position_9_y] = calculate_position_9(position_8_x, position_8_y, theta, l11)
    
    % ���� ��ǥ 
    position_8 = [position_8_x; position_8_y]; 
    
    % ȸ�� ��� ���� 
    R = [cosd(theta), -sind(theta);
         sind(theta),  cosd(theta)];
     
    % �̵� ����
    T = [- l11; 0]; 
  
    
    % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
    position_9 = position_8 + R * T;
    
    position_9_x = position_9(1);
    position_9_y = position_9(2);
   
end

% function [position_9_x, position_9_y] = calculate_position_9(position_8_x, position_8_y, theta, l11)
%     % ���� ��ǥ 
%     position_8 = [position_8_x; position_8_y];
%     
%     % T�� ũ�⿡ �°� ���� ��ǥ�� ���� (3D �迭)
%     position_8_x_3D = repmat(position_8(1), size(theta));  
%     position_8_y_3D = repmat(position_8(2), size(theta));  
%      
%     % ȸ�� ��� ���� theta�� **���(+)**�� �� �ݽð� ���� ȸ�� / theta�� **����(-)**�� �� �ð� ���� ȸ��
%     R = [cosd(-theta), -sind(-theta);
%          sind(-theta),  cosd(-theta)];
%     
%     % �̵� ���� (x��� y�࿡ ���� �̵�)
%     T_x = repmat(-l11 , size(theta));  % x ���� �̵�
%     T_y = repmat(0 , size(theta));   % y ���� �̵�
%     
%     
%     % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
%     position_9_x = position_8_x_3D + R(1) .* T_x + R(2) .* T_y;  % x ��ǥ ���
%     position_9_y = position_8_y_3D + R(3) .* T_x + R(4) .* T_y;  % y ��ǥ ���
%     % ��� ��ȯ
%     position_9_x = reshape(position_9_x, [], 1);
%     position_9_y = reshape(position_9_y, [], 1);
% end

% function [position_9_x, position_9_y] = calculate_position_9(position_8_x, position_8_y, theta, l11)
%     % ���� ��ǥ (8�� ����Ʈ)
%     position_8_x_3D = repmat(position_8_x, size(theta));  
%     position_8_y_3D = repmat(position_8_y, size(theta));  
%     
%     % ȸ�� ��� ���� (theta�� 3D �迭�̹Ƿ�, ���� ��Ҹ��� ����)  
%     R11 = cosd(theta);   % R(1,1)
%     R12 = -sind(theta);  % R(1,2)
%     R21 = sind(theta);   % R(2,1)
%     R22 = cosd(theta);   % R(2,2)
%     
%     % �̵� ���� (3D �迭 ũ��� ����)
%     T_x = -l11 * ones(size(theta));  % x ���� �̵�
%     T_y = zeros(size(theta));   % y ���� �̵�
%     
%     % ���ο� ��ġ ��� (ȸ�� ��� ����)
%     position_9_x = position_8_x_3D + R11 .* T_x + R12 .* T_y;
%     position_9_y = position_8_y_3D + R21 .* T_x + R22 .* T_y;
% 
%     % ��� ��ȯ (���� ���� ����)
%     position_9_x = position_9_x(:);
%     position_9_y = position_9_y(:);
% end

% function [position_9_x, position_9_y] = calculate_position_9(position_8_x, position_8_y, theta, l11)
%     % �Էµ� theta�� ũ�⸦ ��������
%     theta_size = size(theta);
%     
%     % position_8_x, position_8_y�� theta�� ������ ũ��� ����
%     position_8_x = repmat(position_8_x, theta_size);
%     position_8_y = repmat(position_8_y, theta_size);
%     
%     % ȸ�� ��� ��� ��� (theta ũ�� ����)
%     R11 = cosd(theta);   % R(1,1)
%     R12 = -sind(theta);  % R(1,2)
%     R21 = sind(theta);   % R(2,1)
%     R22 = cosd(theta);   % R(2,2)
%     
%     % �̵� ���� (theta ũ�⿡ �°� ��ȯ)
%     T_x = repmat(-l11, theta_size);  % x ���� �̵�
%     T_y = zeros(theta_size);         % y ���� �̵�
%     
%     % ���ο� ��ġ ��� (ȸ�� ��� ����)
%     position_9_x = position_8_x + R11 .* T_x + R12 .* T_y;
%     position_9_y = position_8_y + R21 .* T_x + R22 .* T_y;
% end
% 
