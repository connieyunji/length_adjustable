% �ܷ� ��� �ڵ�

clc; clear; close all;
addpath('kinematic_250405\')

get_positions();

% ����� ���� ��� (�ʿ� �� �ּ� ����)
% ang_1_3_x  = cal_angle(p1_x,  p1_y,  p3_x,  p3_y);
% ang_3_6_x  = cal_angle(p3_x,  p3_y,  p6_x,  p6_y);
% ang_5_6_x  = cal_angle(p5_x,  p5_y,  p6_x,  p6_y);
% ang_4_5_x  = cal_angle(p4_x,  p4_y,  p5_x,  p5_y);
% ang_5_8_x  = cal_angle(p5_x,  p5_y,  p8_x,  p8_y);
% ang_6_10_x = cal_angle(p6_x,  p6_y,  p10_x, p10_y);
% ang_9_10_x = cal_angle(p9_x,  p9_y,  p10_x, p10_y);
% ang_10_13_x = cal_angle(p10_x, p10_y, p13_x, p13_y);
% ang_12_13_x = cal_angle(p12_x, p12_y, p13_x, p13_y);
% ang_13_16_x = cal_angle(p13_x, p13_y, p16_x, p16_y);
% ang_3_1_x = cal_angle(p3_x, p3_y, p1_x, p1_y);


% 0�� ��ġ ��� (���߿����Ϳ� ��ũ ���� �Ÿ� ����)
[p0_list, p3_list, l1] = cal_p0_linear([p1_x, p1_y],[p_act_x, p_act_y],l3);

% �ܷ� ���
F_act = 30;  % ���߿����� �� (N)
F_ext_array = zeros(size(p0_list,1),1);  % �����Ӻ� �ܷ� ��� ����

for k = 1:size(p0_list, 1)
    % ���� �������� p0 ��ǥ
    p0_x_k = p0_list(k,1);
    p0_y_k = p0_list(k,2);

    % ���� ��� (act �� p0 �� p1)
    ang_act_0_1 = cal_3_angle([p_act_x, p_act_y], [p0_x_k, p0_y_k], [p1_x, p1_y]);

    % ���� �������� ���Ʈ ����
    F_act_M = F_act * sind(180 - ang_act_0_1);

    % M = F * �Ÿ�
    M_1 = F_act_M * l1;

    % �ܷ� ��� (F = M / �Ÿ�)
    F_ext_array(k) = M_1 / l3;
end

% �ִϸ��̼� ���
figure;
axis equal;
grid on;
xlim([-50, 200]);
ylim([-50, 150]);

for k = 1:size(p0_list, 1)
    cla; hold on;
    
    % ���� ��ǥ
    p0_x = p0_list(k, 1);
    p0_y = p0_list(k, 2);
    
    p3_x = p3_list(k, 1);
    p3_y = p3_list(k, 2);

    % ��ũ1: p3 �� p1
    plot([p3_x, p1_x], [p3_y, p1_y], 'b-', 'LineWidth', 2);
    
    % ��ũ2: p1 �� p0
    plot([p1_x, p0_x], [p1_y, p0_y], 'g-', 'LineWidth', 2);
    
    % ���߿�����: motor_base �� p0
    plot([p_act_x, p0_x], [p_act_y, p0_y], 'r-', 'LineWidth', 1.5);

    % �� ���
    scatter(p3_x, p3_y, 'bo', 'filled');
    scatter(p1_x, p1_y, 'ko', 'filled');
    scatter(p0_x, p0_y, 'go', 'filled');
    scatter(p_act_x, p_act_y, 'ro', 'filled');

    % �̵� ���
    scatter(p0_list(1:k,1), p0_list(1:k,2), 10, 'm', 'filled');

    % �ؽ�Ʈ ��
    text(p3_x, p3_y, ' 3');
    text(p1_x, p1_y, ' 1');
    text(p0_x, p0_y, ' 0');
    text(p_act_x, p_act_y, ' actuator');
    
    % ���� �ܷ� ǥ��
    text(120, 140, sprintf('F_{ext} = %.2f N', F_ext_array(k)),'FontSize', 12, 'Color', 'r');

    title(sprintf('Frame %d / %d', k, size(p0_list,1)));
    pause(0.03);
end

%% ----------------------------------------------------- %%
% ���⼭���ʹ� �߰� ��� �Ǵ� ��� ����� ��� ����
