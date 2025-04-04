function [position_12_x, position_12_y] = calculate_position_12(position_11_x, position_11_y, theta, ang_12_11_14, l16)
    
    % ���� ��ǥ 
    position_11 = [position_11_x; position_11_y]; 
    
    % ȸ�� ��� ���� 
    R = [cosd(theta), -sind(theta);
         sind(theta),  cosd(theta)];
     
    % �̵� ����
    T = [-l16 * cosd(ang_12_11_14); l16 * sind(ang_12_11_14)]; 
  
    
    % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
    position_12 = position_11 + R * T;
    
    position_12_x = position_12(1);
    position_12_y = position_12(2);
   
end

% function [position_12_x, position_12_y] = calculate_position_12(position_11_x, position_11_y, theta, ang_12_11_14, l16)
%     % ���� ��ǥ 
%     position_11 = [position_11_x; position_11_y];
%     
%     % T�� ũ�⿡ �°� ���� ��ǥ�� ���� (3D �迭)
%     position_11_x_3D = repmat(position_11(1), size(theta));  
%     position_11_y_3D = repmat(position_11(2), size(theta));  
%     
%     % ȸ�� ��� ���� theta�� **���(+)**�� �� �ݽð� ���� ȸ�� / theta�� **����(-)**�� �� �ð� ���� ȸ��
%     R = [cosd(-theta), -sind(-theta);
%          sind(-theta),  cosd(-theta)];
%      
%     
%     % �̵� ���� (x��� y�࿡ ���� �̵�)
%     T_x = repmat(-l16 * cosd(ang_12_11_14), size(theta));  % x ���� �̵�
%     T_y = repmat(l16 * sind(ang_12_11_14), size(theta));   % y ���� �̵�
%     
%     
%     % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
%     position_12_x = position_11_x_3D + R(1) .* T_x + R(2) .* T_y;  % x ��ǥ ���
%     position_12_y = position_11_y_3D + R(3) .* T_x + R(4) .* T_y;  % y ��ǥ ���
%     % ��� ��ȯ
%     position_12_x = reshape(position_12_x, [], 1);
%     position_12_y = reshape(position_12_y, [], 1);
% end