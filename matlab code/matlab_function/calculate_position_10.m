function [p10_x, p10_y] = calculate_position_10(position_13_x, position_13_y,position_9_x, position_9_y, l18, l14, total_theta)
    % ���� ����
    syms p10_x p10_y

    % ������ 1: �� 10�� 13�Ÿ�
    eq1 = (p10_x - position_13_x)^2 + (p10_y - position_13_y)^2 == l18^2;
    
    % ������ 2: �� 10�� 9�Ÿ�
     eq2 = (p10_x - position_9_x)^2 + (p10_y - position_9_y)^2 == l14^2;
    
    % ���� ������ Ǯ��
    sol = solve([eq1, eq2], [p10_x, p10_y]);
    
    % ����� ���������� ��ȯ
    p10_x = double(sol.p10_x);
    p10_y = double(sol.p10_y);
    
    if total_theta >= 90
        % y�� ���� �� ���� ���� ����
        [~, idx] = min(p10_x);  % x���� �� ���� �ε����� ã��
    else
        % x�� ���� �� ���� ���� ����
        [~, idx] = max(p10_y);  % y���� �� ū �ε����� ã��
    end
    
    % ������ �����ϴ� �� ����
    p10_x = p10_x(idx);
    p10_y = p10_y(idx);
    
   
end