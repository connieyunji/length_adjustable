% 힘 받아오는 코드

clc; clear; close all;
addpath('kinematic_250405\')


get_positions();

%각도 받아오기
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


%0번 위치들 받아오기 (리니어 엑츄에이터에 의한)

[p0_list, p3_list, l1] = cal_p0_linear([p1_x, p1_y],[p_act_x, p_act_y],l3);




% ang_act_0_x = cal_angle(p_act_x, p_act_y, p0_x, p0_y);


% F_act: 일정하다고 가정
F_act = 30;
F_ext_array = zeros(size(p0_list,1),1);  % 프레임마다 저장할 배열
% p_act_y = p_act_y-40;
for k = 1:size(p0_list, 1)
    % 각 프레임의 p0 좌표
    p0_x_k = p0_list(k,1);
    p0_y_k = p0_list(k,2);

    % 각도 계산 (act → p0 → p1)
    ang_act_0_1 = cal_3_angle([p_act_x, p_act_y], [p0_x_k, p0_y_k], [p1_x, p1_y]);

    % 수직 성분 힘 계산
    F_act_M = F_act * sind(180 - ang_act_0_1);

    % 모멘트 계산
    M_1 = F_act_M * l1;

    % 외력 계산
    F_ext_array(k) = M_1 / l3;
end

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
    
    % 🔸 F_ext 값 출력 (매 프레임에 맞게)
    text(120, 140, sprintf('F_{ext} = %.2f N', F_ext_array(k)),'FontSize', 12, 'Color', 'r');


    title(sprintf('Frame %d / %d', k, size(p0_list,1)));
    pause(0.03);
end


%% ----------------------------------------------------- %%
% 여기서부터는 나머지 힘 분석







