% function [p10_x, p10_y] = calculate_position_10(position_13_x, position_13_y,position_9_x, position_9_y, l18, l14, total_theta)
%     % ���� ����
%     syms p10_x p10_y
% 
%     % ������ 1: �� 10�� 13�Ÿ�
%     eq1 = (p10_x - position_13_x)^2 + (p10_y - position_13_y)^2 == l18^2;
% 
%     % ������ 2: �� 10�� 9�Ÿ�
%      eq2 = (p10_x - position_9_x)^2 + (p10_y - position_9_y)^2 == l14^2;
% 
%     % ���� ������ Ǯ��
%     sol = solve([eq1, eq2], [p10_x, p10_y]);
% 
%     % ����� ���������� ��ȯ
%     p10_x = double(sol.p10_x);
%     p10_y = double(sol.p10_y);
% 
%     if total_theta >= 90
%         % y�� ���� �� ���� ���� ����
%         [~, idx] = min(p10_x);  % x���� �� ���� �ε����� ã��
%     else
%         % x�� ���� �� ���� ���� ����
%         [~, idx] = max(p10_y);  % y���� �� ū �ε����� ã��
%     end
% 
%     % ������ �����ϴ� �� ����
%     p10_x = p10_x(idx);
%     p10_y = p10_y(idx);
% 
% 
% end


function [position_10_x, position_10_y] = calculate_position_10(position_13_x, position_13_y, position_9_x, position_9_y, l18, l14)

    % ���� �� �Ÿ� ���
    d = sqrt((position_13_x - position_9_x).^2 + (position_13_y - position_9_y).^2);

    % �ڻ��� ��Ģ�� �̿��� ���� ���
    cos_theta_13 = (l18^2 + d.^2 - l14^2) ./ (2 * l18 .* d);
    cos_theta_13 = max(min(cos_theta_13, 1), -1);  % acosd ���� ����
    ang_10_13_9 = acosd(cos_theta_13);

    ang_13_9_x =  rad2deg(atan2(position_9_y - position_13_y, position_9_x - position_13_x));

    % ���� ���� ��� (�ϳ��� ���)
    angle_option = ang_13_9_x + ang_10_13_9;

    % ��ġ ���
    position_10_x = position_13_x + l18 * cosd(angle_option);
    position_10_y = position_13_y + l18 * sind(angle_option);
    
    % �Ÿ� Ȯ��
    distance_13_10 = sqrt((position_13_x - position_10_x).^2 + (position_13_y - position_10_y).^2);
    distance_10_9 = sqrt((position_10_x - position_9_x).^2 + (position_10_y - position_9_y).^2);

    % ��� ���� (��: 0.1mm)
    tol = 1e-2;

    % ������ �������� �ʴ� �ε����� NaN ó��
    invalid_idx = abs(distance_13_10 - l18) > tol | abs(distance_10_9 - l14) > tol;
    position_10_x(invalid_idx) = NaN;
    position_10_y(invalid_idx) = NaN;

end
