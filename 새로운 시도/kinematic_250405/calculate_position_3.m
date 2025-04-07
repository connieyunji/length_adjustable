% function [p3_x, p3_y] = calculate_position_3(position_6_x, position_6_y, position_1_x, position_1_y, l4, l3, total_theta)
%     % ���� ����
%     syms p3_x p3_y
% 
%     % ������ 1: �� 6�� 3 �Ÿ� (l4)
%     eq1 = (p3_x - position_6_x)^2 + (p3_y - position_6_y)^2 == l4^2;
% 
%     % ������ 2: �� 1�� 3 �Ÿ� (l3)
%     eq2 = (p3_x - position_1_x)^2 + (p3_y - position_1_y)^2 == l3^2;
% 
%     % ���� ������ Ǯ��
%     sol = solve([eq1, eq2], [p3_x, p3_y]);
% 
%     % ����� double ������ ��ȯ
%     p3_x = double(sol.p3_x);
%     p3_y = double(sol.p3_y);
% 
%     % ���� 1: x��ǥ�� position_1_x���� ū �� �켱 ����
%     valid_solutions = p3_x > position_1_x;
% 
%     if any(valid_solutions) % ��ȿ�� �ذ� �ִ� ���
%         p3_x = p3_x(valid_solutions);
%         p3_y = p3_y(valid_solutions);
%     end
% 
%     % ���� 2: y���� �� ū �� ���� (���� �� ���� ���)
%     if numel(p3_y) > 1
%         [~, idx] = max(p3_y);
%         p3_x = p3_x(idx);
%         p3_y = p3_y(idx);
%     end
% end


function [position_3_x, position_3_y] = calculate_position_3(position_6_x, position_6_y, position_1_x, position_1_y, l4, l3)

    % ���� �� �Ÿ� ���
    d = sqrt((position_6_x - position_1_x).^2 + (position_6_y - position_1_y).^2);

    % �ڻ��� ��Ģ�� �̿��� ���� ���
    cos_theta_6 = (l4^2 + d.^2 - l3^2) ./ (2 * l4 .* d);
    cos_theta_6 = max(min(cos_theta_6, 1), -1);  % acosd ����ȭ
    ang_3_6_1 = acosd(cos_theta_6);

    % ���� ����
    ang_6_1_x = rad2deg(atan2(position_1_y - position_6_y, position_1_x - position_6_x));

    % ���� ����
    angle_option = ang_6_1_x + ang_3_6_1;

    % ��ġ ���
    position_3_x = position_6_x + l4 * cosd(angle_option);
    position_3_y = position_6_y + l4 * sind(angle_option);

    % �Ÿ� ����
    distance_6_3 = sqrt((position_6_x - position_3_x).^2 + (position_6_y - position_3_y).^2);
    distance_3_1 = sqrt((position_3_x - position_1_x).^2 + (position_3_y - position_1_y).^2);

    % ��� ����
    tol = 1e-2;

    % ������ �������� �ʴ� �ε����� NaN ó��
    invalid_idx = abs(distance_6_3 - l4) > tol | abs(distance_3_1 - l3) > tol;
    position_3_x(invalid_idx) = NaN;
    position_3_y(invalid_idx) = NaN;

end
