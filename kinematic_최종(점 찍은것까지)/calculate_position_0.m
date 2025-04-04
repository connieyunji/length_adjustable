function [position_0_x, position_0_y] = calculate_position_0(position_1_x, position_1_y, position_3_x, position_3_y, l3, ang_3_1_0)
    % �� 1�� �߽����� ������ l2 �� ������ ���� theta_deg�� �����ϴ� �� 0�� ã��


    l1_step = [11, 15, 19, 23, 27, 31];  % step 6��, 4mm ����
    l1 = l1_step(1);

    % ���� 3 -> 1
    v31_x = position_3_x - position_1_x;
    v31_y = position_3_y - position_1_y;
    
    
    % �� 0�� �� ���� �ֵ��� ���� (������ Ȱ��)
    % �� 0�� ��ǥ�� �� 1�� �߽����� �Ͽ� ������ l2�� ���� 30�� ȸ���� ��
    rot_matrix = [cosd(-ang_3_1_0), -sind(-ang_3_1_0); sind(-ang_3_1_0), cosd(-ang_3_1_0)];
    v31_unit = [v31_x; v31_y] / l3; % ���� ����ȭ
    
    % ȸ�� ����
    v10_rotated = rot_matrix * v31_unit * l1;
    
    % �� 0 ��ǥ ���
    position_0_x = position_1_x + v10_rotated(1);
    position_0_y = position_1_y + v10_rotated(2);

end
