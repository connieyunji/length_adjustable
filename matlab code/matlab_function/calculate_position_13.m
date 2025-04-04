function [p13_x, p13_y] = calculate_position_13(position_16_x, position_16_y, position_12_x, position_12_y, l25, l17, total_theta)
    % ���� ����
    syms p13_x p13_y

    % ������ 1: �� 13�� 16 ������ �Ÿ� (l25)
    eq1 = (p13_x - position_16_x)^2 + (p13_y - position_16_y)^2 == l25^2;
    
    % ������ 2: �� 13�� 12 ������ �Ÿ� (l17)
    eq2 = (p13_x - position_12_x)^2 + (p13_y - position_12_y)^2 == l17^2;
    
    % ���� ������ Ǯ��
    sol = solve([eq1, eq2], [p13_x, p13_y]);
    
    % ����� ���������� ��ȯ
    p13_x = double(sol.p13_x);
    p13_y = double(sol.p13_y);
    
    if total_theta <= 90
        % y�� ���� �� ���� ���� ����
        [~, idx] = max(p13_y);  % y���� �� ū �ε����� ã��
    else
        % x�� ���� �� ���� ���� ����
        [~, idx] = min(p13_x);  % x���� �� ���� �ε����� ã��
        if total_theta >= 200
            % y�� ���� �� ���� ���� ����
            [~, idx] = min(p13_y);  
        end
    end
    
    % ������ �����ϴ� �� ����
    p13_x = p13_x(idx);
    p13_y = p13_y(idx);
end
