% function [position_13_x, position_13_y] = calculate_position_13(position_16_x, position_16_y, position_12_x, position_12_y, l25, l17, total_theta)
%     % ���� ����
%     syms position_13_x position_13_y
% 
%     % ������ 1: �� 13�� 16 ������ �Ÿ� (l25)
%     eq1 = (position_13_x - position_16_x)^2 + (position_13_y - position_16_y)^2 == l25^2;
% 
%     % ������ 2: �� 13�� 12 ������ �Ÿ� (l17)
%     eq2 = (position_13_x - position_12_x)^2 + (position_13_y - position_12_y)^2 == l17^2;
% 
%     % ���� ������ Ǯ��
%     sol = solve([eq1, eq2], [position_13_x, position_13_y]);
% 
%     % ����� ���������� ��ȯ
%     position_13_x = double(sol.position_13_x);
%     position_13_y = double(sol.position_13_y);
% 
%     if total_theta <= 90
%         % y�� ���� �� ���� ���� ����
%         [~, idx] = max(position_13_y);  % y���� �� ū �ε����� ã��
%     else
%         % x�� ���� �� ���� ���� ����
%         [~, idx] = min(position_13_x);  % x���� �� ���� �ε����� ã��
%         if total_theta >= 200
%             % y�� ���� �� ���� ���� ����
%             [~, idx] = min(position_13_y);  
%         end
%     end
% 
%     % ������ �����ϴ� �� ����
%     position_13_x = position_13_x(idx);
%     position_13_y = position_13_y(idx);
% end


% 
function [position_13_x, position_13_y] = calculate_position_13(position_16_x, position_16_y, position_12_x, position_12_y, l25, l17)

    % �Ÿ� ���
    d = sqrt((position_16_x - position_12_x).^2 + (position_16_y - position_12_y).^2);

    % �ڻ��� ���� ���
    cos_theta_16 = (l25^2 + d.^2 - l17^2) ./ (2 * l25 .* d);
    cos_theta_16 = max(min(cos_theta_16, 1), -1);  % ���� ����
    ang_13_16_12 = acosd(cos_theta_16);

    ang_12_16_x = atan2d(position_12_y - position_16_y, position_12_x - position_16_x);

    % �� ���� ��ġ �ĺ� ���
    angle_option_1 = ang_12_16_x + ang_13_16_12;
    angle_option_2 = ang_12_16_x - ang_13_16_12;

    candidate1_x = position_16_x + l25 * cosd(angle_option_1);
    candidate1_y = position_16_y + l25 * sind(angle_option_1);
    dist1 = sqrt((candidate1_x - position_12_x).^2 + (candidate1_y - position_12_y).^2);

    candidate2_x = position_16_x + l25 * cosd(angle_option_2);
    candidate2_y = position_16_y + l25 * sind(angle_option_2);
    dist2 = sqrt((candidate2_x - position_12_x).^2 + (candidate2_y - position_12_y).^2);

    % ��� ����
    tolerance = 1e-3;

    % ���� �ʱ�ȭ
    position_13_x = NaN(size(position_16_x));
    position_13_y = NaN(size(position_16_y));

    % dist1�� �´� ��� ����
    idx1 = abs(dist1 - l17) < tolerance;
    position_13_x(idx1) = candidate1_x(idx1);
    position_13_y(idx1) = candidate1_y(idx1);

    % dist2�� �´� ��� ���� (���� NaN�� �κи�)
    idx2 = abs(dist2 - l17) < tolerance & isnan(position_13_x);
    position_13_x(idx2) = candidate2_x(idx2);
    position_13_y(idx2) = candidate2_y(idx2);
end
