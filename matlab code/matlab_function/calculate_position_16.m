function [position_16_x, position_16_y] = calculate_position_16(position_14_x, position_14_y, theta, ang_16_14_17, l26)
    
    % ���� ��ǥ 
    position_14 = [position_14_x; position_14_y]; 
    
    % ȸ�� ��� ���� 
    R = [cosd(theta), -sind(theta);
         sind(theta),  cosd(theta)];
     
    % �̵� ����
    T = [-l26 * cosd(ang_16_14_17); l26 * sind(ang_16_14_17)]; 
  
    
    % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
    position_16 = position_14 + R * T;
    
    position_16_x = position_16(1);
    position_16_y = position_16(2);
   
end

