function [p3_x, p3_y] = calculate_position_3(position_6_x, position_6_y, position_1_x, position_1_y, l4, l3, total_theta)
    % ���� ����
    syms p3_x p3_y

    % ������ 1: �� 6�� 3 �Ÿ� (l4)
    eq1 = (p3_x - position_6_x)^2 + (p3_y - position_6_y)^2 == l4^2;

    % ������ 2: �� 1�� 3 �Ÿ� (l3)
    eq2 = (p3_x - position_1_x)^2 + (p3_y - position_1_y)^2 == l3^2;

    % ���� ������ Ǯ��
    sol = solve([eq1, eq2], [p3_x, p3_y]);

    % ����� double ������ ��ȯ
    p3_x = double(sol.p3_x);
    p3_y = double(sol.p3_y);

    % ���� 1: x��ǥ�� position_1_x���� ū �� �켱 ����
    valid_solutions = p3_x > position_1_x;
    
    if any(valid_solutions) % ��ȿ�� �ذ� �ִ� ���
        p3_x = p3_x(valid_solutions);
        p3_y = p3_y(valid_solutions);
    end

    % ���� 2: y���� �� ū �� ���� (���� �� ���� ���)
    if numel(p3_y) > 1
        [~, idx] = max(p3_y);
        p3_x = p3_x(idx);
        p3_y = p3_y(idx);
    end
end
