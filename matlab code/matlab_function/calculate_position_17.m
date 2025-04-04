function [position_17_x, position_17_y] = calculate_position_17(position_14_x, position_14_y, theta, l23)
    
    % ���� ��ǥ 
    position_14 = [position_14_x; position_14_y]; 
    
    % ȸ�� ��� ���� 
    R = [cosd(theta), -sind(theta);
         sind(theta),  cosd(theta)];
     
    % �̵� ����
    T = [-l23 ; 0]; 
  
    
    % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
    position_17 = position_14 + R * T;
    
    position_17_x = position_17(1);
    position_17_y = position_17(2);
   
end

% function [position_17_x, position_17_y] = calculate_position_17(position_14_x, position_14_y, theta, l23)
%     % ���� ��ǥ (7�� ����Ʈ)
%     position14 = [position_14_x; position_14_y];
%     
%     % T1�� ũ�⿡ �°� ���� ��ǥ�� ���� (3D �迭)
%     position_11_x_3D = repmat(position14(1), size(theta));  
%     position_11_y_3D = repmat(position14(2), size(theta));  
%     
%     % ȸ�� ��� ���� theta�� **���(+)**�� �� �ݽð� ���� ȸ�� / theta�� **����(-)**�� �� �ð� ���� ȸ��
%     R = [cosd(-theta), -sind(-theta);
%          sind(-theta),  cosd(-theta)];
%      
%      
%     
%     % �̵� ���� (x��� y�࿡ ���� �̵�)
%     T_x = repmat(-l23, size(theta));  % x ���� �̵�
%     T_y = repmat(0, size(theta));   % y ���� �̵�
%     
%     
%     % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
%     position_17_x = position_11_x_3D + R(1) .* T_x + R(2) .* T_y;  % x ��ǥ ���
%     position_17_y = position_11_y_3D + R(3) .* T_x + R(4) .* T_y;  % y ��ǥ ���
%     % ��� ��ȯ
%     position_17_x = reshape(position_17_x, [], 1);
%     position_17_y = reshape(position_17_y, [], 1);
% end