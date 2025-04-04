% function [p5_x, p5_y] = calculate_position_5(position_8_x, position_8_y, l5, l8)
%     % ���� ����
%     syms p5_x p5_y
% 
%     % ������ 1: �� 5�� �� 4 ������ �Ÿ� (p5_x^2 + p5_y^2 = l5^2, 4�� �����̶�)
%     eq1 = p5_x^2 + p5_y^2 == l5^2;
%     
%     % ������ 2: �� 8�� �� 5 ������ �Ÿ� (�� 8�� ��ǥ�� position_8_x, position_8_y)
%     eq2 = (p5_x - position_8_x)^2 + (p5_y - position_8_y)^2 == l8^2;
%     
%     % ���� ������ Ǯ��
%     sol = solve([eq1, eq2], [p5_x, p5_y]);
%     
%     % ����� ���������� ��ȯ
%     p5_x = double(sol.p5_x);
%     p5_y = double(sol.p5_y);
%    
%        %%%%���� ������ �ֱ⿡ Ȯ���� ������ ���� 7���� y������ �������Ѵٴ� �´µ�, mcp�ִ�� ������ ������
% end

function [p5_x, p5_y] = calculate_position_5(position_8_x, position_8_y,position_7_y, l5, l8)
    % ���� ����
    syms p5_x p5_y

    % ������ 1: �� 5�� �� 4 ������ �Ÿ� (p5_x^2 + p5_y^2 = l5^2, 4�� �����̶�)
    eq1 = p5_x^2 + p5_y^2 == l5^2;
    
    % ������ 2: �� 8�� �� 5 ������ �Ÿ� (�� 8�� ��ǥ�� position_8_x, position_8_y)
    eq2 = (p5_x - position_8_x)^2 + (p5_y - position_8_y)^2 == l8^2;
    
    % ���� ������ Ǯ��
    sol = solve([eq1, eq2], [p5_x, p5_y]);
    
    % ����� ���������� ��ȯ
    p5_x = double(sol.p5_x);
    p5_y = double(sol.p5_y);
    
    % �� 5�� y��ǥ�� �� 7���� ���� �־�� �Ѵٴ� ���� �߰�
    valid_solutions = p5_y > position_7_y;  % �� 5�� y��ǥ�� �� 8�� y��ǥ���� Ŀ�� ��
    
    if any(valid_solutions)
        % ������ �����ϴ� �ذ� �ִٸ� �� �ظ� ����
        p5_x = p5_x(valid_solutions);
        p5_y = p5_y(valid_solutions);
        
        % �� ���� ��ȿ�� �ذ� ���� ��� y���� �� ū �ظ� ����
        if length(p5_y) > 1
            [~, idx] = max(p5_y);  % y���� �� ū �ε��� ����
            p5_x = p5_x(idx);
            p5_y = p5_y(idx);
        end
    else
        % ������ �����ϴ� �ذ� ������ ��� �޽��� ���
        warning('�� 5�� �� 8���� y������ ���� ���� �� �����ϴ�.');
        p5_x = NaN;
        p5_y = NaN;
    end
    
end
