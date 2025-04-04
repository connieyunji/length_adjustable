function [position_8_x, position_8_y] = calculate_position_8(position_7_x, position_7_y, theta, ang_8_7_11, l9)
    
    % ���� ��ǥ (7�� ����Ʈ)
    position_7 = [position_7_x; position_7_y]; 
    
    % ȸ�� ��� ���� (theta1_default��ŭ ȸ��)
    R = [cosd(theta), -sind(theta);
         sind(theta),  cosd(theta)];
     
    % �̵� ����
    T = [-l9 * cosd(ang_8_7_11); l9 * sind(ang_8_7_11)]; 
  
    
    % ���ο� ��ġ ��� (ȸ�� ���� �� ���� ��ȯ)
    position_8 = position_7 + R * T;
    
    position_8_x = position_8(1);
    position_8_y = position_8(2);
   
end



