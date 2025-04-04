function [position_0_x, position_0_y] = calculate_position_0(position_1_x, position_1_y, position_3_x, position_3_y, l3, ang_3_1_0)
    % 점 1을 중심으로 반지름 l2 원 위에서 각도 theta_deg을 만족하는 점 0을 찾음


    l1_step = [11, 15, 19, 23, 27, 31];  % step 6개, 4mm 간격
    l1 = l1_step(1);

    % 벡터 3 -> 1
    v31_x = position_3_x - position_1_x;
    v31_y = position_3_y - position_1_y;
    
    
    % 점 0이 원 위에 있도록 설정 (방정식 활용)
    % 점 0의 좌표는 점 1을 중심으로 하여 반지름 l2를 따라 30도 회전한 점
    rot_matrix = [cosd(-ang_3_1_0), -sind(-ang_3_1_0); sind(-ang_3_1_0), cosd(-ang_3_1_0)];
    v31_unit = [v31_x; v31_y] / l3; % 단위 벡터화
    
    % 회전 적용
    v10_rotated = rot_matrix * v31_unit * l1;
    
    % 점 0 좌표 계산
    position_0_x = position_1_x + v10_rotated(1);
    position_0_y = position_1_y + v10_rotated(2);

end
