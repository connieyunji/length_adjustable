% 
% function [position_11_x, position_11_y] = calculate_position_11(position_7_x, position_7_y, theta, l10)
%     % ���� ��ǥ (7�� ����Ʈ)
%     position_7 = [position_7_x; position_7_y];
%     
%     % T1�� ũ�⿡ �°� ���� ��ǥ�� ���� (3D �迭)
%     position_7_x_3D = repmat(position_7(1), size(theta));  
%     position_7_y_3D = repmat(position_7(2), size(theta));  
%     
%     % ȸ�� ��� ���� theta�� **���(+)**�� �� �ݽð� ���� ȸ�� / theta�� **����(-)**�� �� �ð� ���� ȸ��
%     R = [cosd(-theta), -sind(-theta);
%          sind(-theta),  cosd(-theta)];
%      
%      
%     
%     % �̵� ���� (x��� y�࿡ ���� �̵�)
%     T_x = repmat(-l10, size(theta));  % x ���� �̵�
%     T_y = repmat(0, size(theta));   % y ���� �̵�
%     
%     
%     % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
%     position_11_x = position_7_x_3D + R(1) .* T_x + R(2) .* T_y;  % x ��ǥ ���
%     position_11_y = position_7_y_3D + R(3) .* T_x + R(4) .* T_y;  % y ��ǥ ���
%     % ��� ��ȯ
%     position_11_x = reshape(position_11_x, [], 1);
%     position_11_y = reshape(position_11_y, [], 1);
% end

function [position_11_x, position_11_y] = calculate_position_11(position_7_x, position_7_y, theta, l10)
    
    % ���� ��ǥ 
    position_7 = [position_7_x; position_7_y]; 
    
    % ȸ�� ��� ���� 
    R = [cosd(theta), -sind(theta);
         sind(theta),  cosd(theta)];
     
    % �̵� ����
    T = [-l10 ; 0]; 
  
    
    % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
    position_11 = position_7 + R * T;
    
    position_11_x = position_11(1);
    position_11_y = position_11(2);
   
end
