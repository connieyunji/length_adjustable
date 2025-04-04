function [position_14_x, position_14_y] = calculate_position_14(position_11_x, position_11_y, theta, l15)
    
    % ���� ��ǥ 
    position_11 = [position_11_x; position_11_y]; 
    
    % ȸ�� ��� ���� 
    R = [cosd(theta), -sind(theta);
         sind(theta),  cosd(theta)];
     
    % �̵� ����
    T = [-l15 ; 0]; 
  
    
    % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
    position_14 = position_11 + R * T;
    
    position_14_x = position_14(1);
    position_14_y = position_14(2);
   
end



% function [position_14_x, position_14_y] = calculate_position_14(position_11_x, position_11_y, theta, l15)
%     % ���� ��ǥ (7�� ����Ʈ)
%     position11 = [position_11_x; position_11_y];
%     
%     % T1�� ũ�⿡ �°� ���� ��ǥ�� ���� (3D �迭)
%     position_11_x_3D = repmat(position11(1), size(theta));  
%     position_11_y_3D = repmat(position11(2), size(theta));  
%     
%     % ȸ�� ��� ���� theta�� **���(+)**�� �� �ݽð� ���� ȸ�� / theta�� **����(-)**�� �� �ð� ���� ȸ��
%     R = [cosd(-theta), -sind(-theta);
%          sind(-theta),  cosd(-theta)];
%      
%      
%     
%     % �̵� ���� (x��� y�࿡ ���� �̵�)
%     T_x = repmat(-l15, size(theta));  % x ���� �̵�
%     T_y = repmat(0, size(theta));   % y ���� �̵�
%     
%     
%     % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
%     position_14_x = position_11_x_3D + R(1) .* T_x + R(2) .* T_y;  % x ��ǥ ���
%     position_14_y = position_11_y_3D + R(3) .* T_x + R(4) .* T_y;  % y ��ǥ ���
%     % ��� ��ȯ
%     position_14_x = reshape(position_14_x, [], 1);
%     position_14_y = reshape(position_14_y, [], 1);
% end