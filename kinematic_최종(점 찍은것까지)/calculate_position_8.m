function [position_8_x, position_8_y] = calculate_position_8(position_7_x, position_7_y, theta, ang_8_7_11, l9)
    
    % 기준 좌표 (7번 조인트)
    position_7 = [position_7_x; position_7_y]; 
    
    % 회전 행렬 정의 (theta1_default만큼 회전)
    R = [cosd(theta), -sind(theta);
         sind(theta),  cosd(theta)];
     
    % 이동 벡터
    T = [-l9 * cosd(ang_8_7_11); l9 * sind(ang_8_7_11)]; 
  
    
    % 새로운 위치 계산 (회전 적용 후 병진 변환)
    position_8 = position_7 + R * T;
    
    position_8_x = position_8(1);
    position_8_y = position_8(2);
   
end



