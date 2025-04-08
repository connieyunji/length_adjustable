% 힘 받아오는 코드

clc; clear; close all;
addpath('kinematic_250405\')


get_positions();

%0번 위치들 받아오기 (리니어 엑츄에이터에 의한)
[p0_list, p3_list, l1] = cal_p0_linear([p1_x, p1_y],[p_act_x, p_act_y],l3);

F_act = 30;
ang_act_0_1 = cal_3_angle([p_act_x, p_act_y], [p0_x, p0_y], [p1_x, p1_y]);

%수직힘 확인
F_act_M = F_act * sind(180-ang_act_0_1);

%모멘트 계산
M_1 = F_act_M * l1;

F_ext = M_1 / l3;




% 에니메이션 그리기
figure;
axis equal;
grid on;
xlim([-50, 200]);
ylim([-50, 150]);

for k = 1:size(p0_list, 1)
    cla; hold on;
    
    % 현재 점들
    p0_x = p0_list(k, 1);
    p0_y = p0_list(k, 2);
    
    p3_x = p3_list(k, 1);
    p3_y = p3_list(k, 2);

    % 링크1: p3 → p1
    plot([p3_x, p1_x], [p3_y, p1_y], 'b-', 'LineWidth', 2);
    
    % 링크2: p1 → p0
    plot([p1_x, p0_x], [p1_y, p0_y], 'g-', 'LineWidth', 2);
    
    % 액추에이터: motor_base → p0
    plot([p_act_x, p0_x], [p_act_y, p0_y], 'r--', 'LineWidth', 1.5);

    % 포인트
    scatter(p3_x, p3_y, 'bo', 'filled');
    scatter(p1_x, p1_y, 'ko', 'filled');
    scatter(p0_x, p0_y, 'go', 'filled');
    scatter(p_act_x, p_act_y, 'ro', 'filled');

    % 🔹 누적된 p0 위치들 경로
    scatter(p0_list(1:k,1), p0_list(1:k,2), 10, 'm', 'filled');
    
    % 라벨
    text(p3_x, p3_y, ' 3');
    text(p1_x, p1_y, ' 1');
    text(p0_x, p0_y, ' 0');
    text(p_act_x, p_act_y, ' actuator');

    title(sprintf('Frame %d / %d', k, size(p0_list,1)));
    pause(0.03);
end


%% ----------------------------------------------------- %%

