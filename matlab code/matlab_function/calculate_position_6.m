function [p6_x, p6_y] = calculate_position_6(position_10_x, position_10_y,position_5_x, position_5_y, l12, l6, total_theta)
    % ���� ����
    syms p6_x p6_y

    % ������ 1: �� 6�� 10�Ÿ�
    eq1 = (p6_x - position_10_x)^2 + (p6_y - position_10_y)^2 == l12^2;
    
    % ������ 2: �� 6�� 5�Ÿ�
     eq2 = (p6_x - position_5_x)^2 + (p6_y - position_5_y)^2 == l6^2;
    
    % ���� ������ Ǯ��
    sol = solve([eq1, eq2], [p6_x, p6_y]);
    
    % ����� ���������� ��ȯ
    p6_x = double(sol.p6_x);
    p6_y = double(sol.p6_y);

    % % ��� �� ���
    % disp('p6_x possible values:');
    % disp(p6_x);
    % disp('p6_y possible values:');
    % disp(p6_y);
    
    if total_theta >= -100           %��� ���� �� ����Ǵ� ����
        % y�� ���� �� ���� ���� ����
        [~, idx] = max(p6_y);    
    end   

    % ������ �����ϴ� �� ����
    p6_x = p6_x(idx);
    p6_y = p6_y(idx);
    
   
end