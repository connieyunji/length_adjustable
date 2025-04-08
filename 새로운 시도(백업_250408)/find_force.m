% 외력 계산 코드

clc; clear; close all;
addpath('kinematic_250405\')

get_positions();

% 참고용 각도 계산 (필요 시 주석 해제)
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


% 0번 위치 계산 (액추에이터와 링크 사이 거리 기준)
[p0_list, p3_list, l1] = cal_p0_linear([p1_x, p1_y],[p_act_x, p_act_y],l3);

% 외력 계산
F_act = 30;  % 액추에이터 힘 (N)
F_ext_array = zeros(size(p0_list,1),1);  % 프레임별 외력 결과 저장

for k = 1:size(p0_list, 1)
    % 현재 프레임의 p0 좌표
    p0_x_k = p0_list(k,1);
    p0_y_k = p0_list(k,2);

    % 각도 계산 (act → p0 → p1)
    ang_act_0_1 = cal_3_angle([p_act_x, p_act_y], [p0_x_k, p0_y_k], [p1_x, p1_y]);

    % 수직 성분으로 모멘트 생성
    F_act_M = F_act * sind(180 - ang_act_0_1);

    % M = F * 거리
    M_1 = F_act_M * l1;

    % 외력 계산 (F = M / 거리)
    F_ext_array(k) = M_1 / l3;
end

% 애니메이션 출력
figure;
axis equal;
grid on;
xlim([-50, 200]);
ylim([-50, 150]);

for k = 1:size(p0_list, 1)
    cla; hold on;
    
    % 현재 좌표
    p0_x = p0_list(k, 1);
    p0_y = p0_list(k, 2);
    
    p3_x = p3_list(k, 1);
    p3_y = p3_list(k, 2);

    % 링크1: p3 → p1
    plot([p3_x, p1_x], [p3_y, p1_y], 'b-', 'LineWidth', 2);
    
    % 링크2: p1 → p0
    plot([p1_x, p0_x], [p1_y, p0_y], 'g-', 'LineWidth', 2);
    
    % 액추에이터: motor_base → p0
    plot([p_act_x, p0_x], [p_act_y, p0_y], 'r-', 'LineWidth', 1.5);

    % 점 출력
    scatter(p3_x, p3_y, 'bo', 'filled');
    scatter(p1_x, p1_y, 'ko', 'filled');
    scatter(p0_x, p0_y, 'go', 'filled');
    scatter(p_act_x, p_act_y, 'ro', 'filled');

    % 이동 경로
    scatter(p0_list(1:k,1), p0_list(1:k,2), 10, 'm', 'filled');

    % 텍스트 라벨
    text(p3_x, p3_y, ' 3');
    text(p1_x, p1_y, ' 1');
    text(p0_x, p0_y, ' 0');
    text(p_act_x, p_act_y, ' actuator');
    
    % 현재 외력 표시
    text(120, 140, sprintf('F_{ext} = %.2f N', F_ext_array(k)),'FontSize', 12, 'Color', 'r');

    title(sprintf('Frame %d / %d', k, size(p0_list,1)));
    pause(0.03);
end

%% ----------------------------------------------------- %%
% 여기서부터는 추가 계산 또는 결과 저장용 블록 가능
