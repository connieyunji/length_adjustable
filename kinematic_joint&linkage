%최종 kinematic 추정 코드

clc; clear; close all;

% 각도 범위 설정 (단위: 도)
theta1_range = 0:0.2:73;
theta2_range = 0:0.2:86;
theta3_range = 0:0.2:57;

%각도랑 길이 상수 받아오기
T = readtable('length_angle_data.csv', 'ReadVariableNames', false); % CSV 파일 읽기
vars = table2cell(T(:,1)); % 첫 번째 열 (변수명)
values = table2array(T(:,2)); % 두 번째 열 (값)

for i = 1:length(vars)
    assignin('base', vars{i}, values(i)); % 작업공간에 변수 저장
end


%% ROM그리기
% 기준 원점 (4번 조인트)
position_4 = [0, 0];

% 1번 조인트 위치
position_1 = [l24*cosd(alpha), l24*sind(alpha)];

% 7번 조인트 (MCP)
position_7 = [l7*cosd(beta), -l7*sind(beta)];

% 가능한 모든 조합을 벡터화하여 연산
[T1, T2, T3] = ndgrid(theta1_range, theta2_range, theta3_range);

% 벡터화된 위치 계산
pos_11_x = position_7(1) - l10 * cosd(T1);
pos_11_y = position_7(2) - l10 * sind(T1);

pos_14_x = pos_11_x - l15 * cosd(T1 + T2);
pos_14_y = pos_11_y - l15 * sind(T1 + T2);

pos_17_x = pos_14_x - l23 * cosd(T1 + T2 + T3);
pos_17_y = pos_14_y - l23 * sind(T1 + T2 + T3);

% 1D 배열로 변환
ROM_x = pos_17_x(:);
ROM_y = pos_17_y(:);

%%
% 한 번에 그리기 (속도 개선)
figure;
scatter(ROM_x, ROM_y, 2, 'b', 'filled'); % ROM 점들
hold on;
    

%% reachable 확인하기

theta1_range = 0:3:73; % 73
theta2_range = 0:3:86; % 86
theta3_range = 0:3:57; % 57

% 기준 원점 (4번 조인트)
position_4 = [0, 0];
position_4_x = position_4(1);
position_4_y = position_4(2);

% 1,7, actuator (고정점)
[position_1_x, position_1_y] = calculate_position_1(alpha, l24);
[position_7_x, position_7_y] = calculate_position_7(beta, l7);
[position_actuator_x, position_actuator_y] = calculate_position_actuator(position_1_x, position_1_y, l0, a_prime);

% ROM을 위한 배열 미리 할당 (속도 개선)
num_combinations = length(theta1_range) * length(theta2_range) * length(theta3_range);
ROM_x_17 = zeros(num_combinations,1);
ROM_y_17 = zeros(num_combinations,1);
ROM_x_13 = zeros(num_combinations,1);
ROM_y_13 = zeros(num_combinations,1);
ROM_x_10 = zeros(num_combinations,1);
ROM_y_10 = zeros(num_combinations,1);
ROM_x_6 = zeros(num_combinations,1);
ROM_y_6 = zeros(num_combinations,1);
ROM_x_3 = zeros(num_combinations,1);
ROM_y_3 = zeros(num_combinations,1);
ROM_x_0 = zeros(num_combinations,1);
ROM_y_0 = zeros(num_combinations,1);
index = 1;


% 모든 가능한 θ1, θ2, θ3 조합에 대해 fingertip 위치 계산
for theta1 = theta1_range
    disp(['현재 theta1 값: ', num2str(theta1)]); % theta1 값 출력
    [position_11_x, position_11_y] = calculate_position_11(position_7_x, position_7_y, theta1, l10);
    [position_8_x, position_8_y] = calculate_position_8(position_7_x, position_7_y, theta1, ang_8_7_11, l9);
    [position_9_x, position_9_y] = calculate_position_9(position_8_x, position_8_y, theta1, l11);
    [position_5_x, position_5_y] = calculate_position_5(position_8_x, position_8_y,position_7_y, l5, l8);

    for theta2 = theta2_range
        [position_14_x, position_14_y] = calculate_position_14(position_11_x, position_11_y, theta1+theta2, l15);
        [position_12_x, position_12_y] = calculate_position_12(position_11_x, position_11_y, theta1+theta2, ang_12_11_14, l16);

        for theta3 = theta3_range
            [position_17_x, position_17_y] = calculate_position_17(position_14_x, position_14_y, theta1+theta2+theta3, l23);
            [position_16_x, position_16_y] = calculate_position_16(position_14_x, position_14_y, theta1+theta2+theta3, ang_16_14_17, l26);
            [position_13_x, position_13_y] = calculate_position_13(position_16_x, position_16_y,position_12_x, position_12_y, l25, l17,theta1+theta2+theta3);
            [position_10_x, position_10_y] = calculate_position_10(position_13_x, position_13_y,position_9_x, position_9_y, l18, l14,theta1+theta2+theta3);
            [position_6_x, position_6_y] = calculate_position_6(position_10_x, position_10_y, position_5_x, position_5_y, l12, l6, theta1+theta2+theta3);
            [position_3_x, position_3_y] = calculate_position_3(position_6_x, position_6_y,position_1_x, position_1_y, l4, l3, theta1+theta2+theta3);
            [position_0_x, position_0_y] = calculate_position_0(position_1_x, position_1_y, position_3_x, position_3_y,l3, ang_3_1_0);
       
            %6그리기 하드웨어적 제한
            point_5 = [position_5_x, position_5_y];
            point_6 = [position_6_x, position_6_y];
            point_8 = [position_8_x, position_8_y];


            find_angle_6_5_8 = calculate_angle(point_6, point_5, point_8);
            % disp(['Calculated Angle: ', num2str(find_angle_6_5_8)]);  % 각도 확인
            
            if find_angle_6_5_8 < 20 %내가 측정한건 25긴 했음 => 다시 확인필요, 이거 없을때도 ROM 생기는지 확인해보기
                position_6_x = NaN;
                position_6_y = NaN;

            end


            % fingertip 위치 저장
            % 사전에 할당된 배열에 저장 (메모리 재할당 방지)
            ROM_x_17(index) = position_17_x;
            ROM_y_17(index) = position_17_y;
            ROM_x_13(index) = position_13_x;
            ROM_y_13(index) = position_13_y;
            ROM_x_10(index) = position_10_x;
            ROM_y_10(index) = position_10_y;
            ROM_x_6(index) = position_6_x;
            ROM_y_6(index) = position_6_y;
            ROM_x_3(index) = position_3_x;
            ROM_y_3(index) = position_3_y;
            ROM_x_0(index) = position_0_x;
            ROM_y_0(index) = position_0_y;
            index = index + 1;
        end
    end
end

% 거리 계산 (0과 actuator까지의 거리)
distance_x = position_0_x - position_actuator_x;
distance_y = position_0_y - position_actuator_y;
distance = sqrt( distance_x^2 + distance_y^2);

% NaN이 아닌 값들만 필터링
valid_idx = ~isnan(ROM_x_17) & ~isnan(ROM_y_17) & ...
            ~isnan(ROM_x_13) & ~isnan(ROM_y_13) & ...
            ~isnan(ROM_x_10) & ~isnan(ROM_y_10) & ...
            ~isnan(ROM_x_6) & ~isnan(ROM_y_6) & ...
            ~isnan(ROM_x_3) & ~isnan(ROM_y_3) & ...
            (distance >= 100) & (distance <= 150);

% scatter 한 번만 호출 (속도 향상)
scatter(ROM_x_17(valid_idx), ROM_y_17(valid_idx), 10, 'g', 'filled');



hold on;


%%

% 개별 조인트 위치 계산 (기본 자세)
theta1_default = -10;  %73, -10
theta2_default = 21;  %86, 20
theta3_default = 7;  %57, 7

[position_11_x_fix, position_11_y_fix] = calculate_position_11(position_7_x, position_7_y, theta1_default, l10);
[position_14_x_fix, position_14_y_fix] = calculate_position_14(position_11_x_fix, position_11_y_fix, theta1_default+theta2_default, l15);
[position_17_x_fix, position_17_y_fix] = calculate_position_17(position_14_x_fix, position_14_y_fix, theta1_default+theta2_default+theta3_default, l23);
% 8,9,12,16
[position_8_x_fix, position_8_y_fix] = calculate_position_8(position_7_x, position_7_y, theta1_default, ang_8_7_11, l9);
[position_9_x_fix, position_9_y_fix] = calculate_position_9(position_8_x_fix, position_8_y_fix, theta1_default, l11);
[position_12_x_fix, position_12_y_fix] = calculate_position_12(position_11_x_fix, position_11_y_fix, theta1_default+theta2_default, ang_12_11_14, l16);
[position_16_x_fix, position_16_y_fix] = calculate_position_16(position_14_x_fix, position_14_y_fix, theta1_default+theta2_default+theta3_default, ang_16_14_17, l26);

%5,13,10,6,3
[position_5_x_fix, position_5_y_fix] = calculate_position_5(position_8_x_fix, position_8_y_fix,position_7_y, l5, l8);
[position_13_x_fix, position_13_y_fix] = calculate_position_13(position_16_x_fix, position_16_y_fix,position_12_x_fix, position_12_y_fix, l25, l17,theta1_default+theta2_default+theta3_default);
[position_10_x_fix, position_10_y_fix] = calculate_position_10(position_13_x_fix, position_13_y_fix,position_9_x_fix, position_9_y_fix, l18, l14,theta1_default+theta2_default+theta3_default);
[position_6_x_fix, position_6_y_fix] = calculate_position_6(position_10_x_fix, position_10_y_fix, position_5_x_fix, position_5_y_fix, l12, l6, theta1_default+theta2_default+theta3_default);
[position_3_x_fix, position_3_y_fix] = calculate_position_3(position_6_x_fix, position_6_y_fix,position_1_x, position_1_y, l4, l3, theta1_default+theta2_default+theta3_default);


%0
[position_0_x_fix, position_0_y_fix] = calculate_position_0(position_1_x, position_1_y, position_3_x_fix, position_3_y_fix, l3, ang_3_1_0);

% 링크 위치를 보라색 점으로 표시
plot(position_4_x, position_4_y, 'ro', 'MarkerSize', 4, 'LineWidth', 2); % position_4 (고정 원점)
plot(position_1_x, position_1_y, 'mo', 'MarkerSize', 2, 'LineWidth', 2); % position_1
plot(position_actuator_x, position_actuator_y, 'mo', 'MarkerSize', 2, 'LineWidth', 2); % position_actuator
plot(position_7_x, position_7_y, 'mo', 'MarkerSize', 2, 'LineWidth', 2); % position_7 (MCP)
plot(position_11_x_fix, position_11_y_fix, 'mo', 'MarkerSize', 2, 'LineWidth', 2); % position_11
plot(position_14_x_fix, position_14_y_fix, 'mo', 'MarkerSize', 2, 'LineWidth', 2); % position_14
plot(position_17_x_fix, position_17_y_fix, 'mo', 'MarkerSize', 2, 'LineWidth', 2); % position_17 (손끝)
plot(position_16_x_fix, position_16_y_fix, 'mo', 'MarkerSize', 2, 'LineWidth', 2); 
plot(position_12_x_fix, position_12_y_fix, 'mo', 'MarkerSize', 2, 'LineWidth', 2); 
plot(position_8_x_fix, position_8_y_fix, 'mo', 'MarkerSize', 2, 'LineWidth', 2); 
plot(position_9_x_fix, position_9_y_fix, 'mo', 'MarkerSize', 2, 'LineWidth', 2); 
plot(position_5_x_fix, position_5_y_fix, 'bo', 'MarkerSize', 2, 'LineWidth', 2); 
plot(position_13_x_fix, position_13_y_fix, 'bo', 'MarkerSize', 2, 'LineWidth', 2); 
plot(position_10_x_fix, position_10_y_fix, 'bo', 'MarkerSize', 2, 'LineWidth', 2); 
%6그리기 (하드웨어적 제한 걸림)
point_5 = [position_5_x_fix, position_5_y_fix];
point_6 = [position_6_x_fix, position_6_y_fix];
point_8 = [position_8_x_fix, position_8_y_fix];
find_angle_6_5_8 =calculate_angle(point_6, point_5, point_8);
if find_angle_6_5_8 >= 10
    plot(position_6_x_fix, position_6_y_fix, 'bo', 'MarkerSize', 2, 'LineWidth', 2);

else
    error('Error: Angle between joint 6, 5, and 8 is less than 20 degrees.');
end

plot(position_3_x_fix, position_3_y_fix, 'bo', 'MarkerSize', 2, 'LineWidth', 2); 

distance_x_fix = position_0_x_fix - position_actuator_x;
distance_y_fix = position_0_y_fix - position_actuator_y;
distance = sqrt( distance_x_fix^2 + distance_y_fix^2);
if (distance >= 100) && (distance <= 150)
    plot(position_0_x_fix, position_0_y_fix, 'bo', 'MarkerSize', 2, 'LineWidth', 2); 
else
    error('Error: 리니어모터 길이 문제');
end
%%
%텍스트 추가
text(position_4_x+5, position_4_y, '4', 'FontSize', 8, 'HorizontalAlignment', 'right');
text(position_1_x, position_1_y-4, '1', 'FontSize', 8, 'HorizontalAlignment', 'right');
text(position_7_x, position_7_y-6, 'MCP(7)', 'FontSize', 8, 'VerticalAlignment', 'bottom');
text(position_11_x_fix, position_11_y_fix-10, 'PIP(11)', 'FontSize', 8, 'VerticalAlignment', 'bottom');
text(position_14_x_fix, position_14_y_fix-8, 'DIP(14)', 'FontSize', 8, 'VerticalAlignment', 'bottom');
text(position_17_x_fix-28, position_17_y_fix-5, 'finger tip(17)', 'FontSize', 8, 'VerticalAlignment', 'bottom');
text(position_16_x_fix+2, position_16_y_fix, '16', 'FontSize', 8);
text(position_12_x_fix+5, position_12_y_fix, '12', 'FontSize', 8);
text(position_8_x_fix+5, position_8_y_fix+1, '8', 'FontSize', 8);
text(position_9_x_fix-4, position_9_y_fix+2, '9', 'FontSize', 8);
text(position_5_x_fix+4, position_5_y_fix-2, '5', 'FontSize', 8);
text(position_13_x_fix, position_13_y_fix+5, '13', 'FontSize', 8);
text(position_10_x_fix, position_10_y_fix+5, '10', 'FontSize', 8);
text(position_3_x_fix+2, position_3_y_fix, '3', 'FontSize', 8);
text(position_6_x_fix, position_6_y_fix+4, '6', 'FontSize', 8);
text(position_0_x_fix+3, position_0_y_fix+5, '0', 'FontSize', 8);
text(position_actuator_x+3, position_actuator_y, 'actuator', 'FontSize', 8);
%%

% 조인트를 연결하는 링크 선 추가 (보라색)
plot([position_4_x, position_1_x], [position_4_y, position_1_y], 'm-', 'LineWidth', 2);
plot([position_4_x, position_7_x], [position_4_y, position_7_y], 'm-', 'LineWidth', 2);
plot([position_7_x, position_11_x_fix], [position_7_y, position_11_y_fix], 'm-', 'LineWidth', 2);
plot([position_11_x_fix, position_14_x_fix], [position_11_y_fix, position_14_y_fix], 'm-', 'LineWidth', 2);
plot([position_14_x_fix, position_17_x_fix], [position_14_y_fix, position_17_y_fix], 'm-', 'LineWidth', 2);
plot([position_7_x, position_8_x_fix], [position_7_y, position_8_y_fix], 'm-', 'LineWidth', 2);
plot([position_8_x_fix, position_9_x_fix], [position_8_y_fix, position_9_y_fix], 'm-', 'LineWidth', 2);
plot([position_12_x_fix, position_11_x_fix], [position_12_y_fix, position_11_y_fix], 'm-', 'LineWidth', 2);
plot([position_11_x_fix, position_9_x_fix], [position_11_y_fix, position_9_y_fix], 'm-', 'LineWidth', 2);
plot([position_12_x_fix, position_14_x_fix], [position_12_y_fix, position_14_y_fix], 'm-', 'LineWidth', 2);
plot([position_16_x_fix, position_17_x_fix], [position_16_y_fix, position_17_y_fix], 'm-', 'LineWidth', 2);
plot([position_16_x_fix, position_14_x_fix], [position_16_y_fix, position_14_y_fix], 'm-', 'LineWidth', 2);
plot([position_5_x_fix, position_8_x_fix], [position_5_y_fix, position_8_y_fix], 'm-', 'LineWidth', 2);
plot([position_5_x_fix, position_4_x], [position_5_y_fix, position_4_y], 'm-', 'LineWidth', 2);
plot([position_13_x_fix, position_16_x_fix], [position_13_y_fix, position_16_y_fix], 'm-', 'LineWidth', 2);
plot([position_13_x_fix, position_12_x_fix], [position_13_y_fix, position_12_y_fix], 'm-', 'LineWidth', 2);
plot([position_10_x_fix, position_13_x_fix], [position_10_y_fix, position_13_y_fix], 'm-', 'LineWidth', 2);
plot([position_10_x_fix, position_9_x_fix], [position_10_y_fix, position_9_y_fix], 'm-', 'LineWidth', 2);
plot([position_6_x_fix, position_10_x_fix], [position_6_y_fix, position_10_y_fix], 'm-', 'LineWidth', 2);
plot([position_6_x_fix, position_5_x_fix], [position_6_y_fix, position_5_y_fix], 'm-', 'LineWidth', 2);
plot([position_3_x_fix, position_6_x_fix], [position_3_y_fix, position_6_y_fix], 'm-', 'LineWidth', 2);
plot([position_3_x_fix, position_1_x], [position_3_y_fix, position_1_y], 'm-', 'LineWidth', 2);
plot([position_0_x_fix, position_1_x], [position_0_y_fix, position_1_y], 'm-', 'LineWidth', 2);
plot([position_actuator_x, position_1_x], [position_actuator_y, position_1_y], 'm-', 'LineWidth', 2);
plot([position_actuator_x, position_0_x_fix], [position_actuator_y, position_0_y_fix], 'k-', 'LineWidth', 2);

hold on;
A=[position_16_x_fix, position_16_y_fix];
B=[position_17_x_fix, position_17_y_fix];
C=[position_14_x_fix, position_14_y_fix];
D=[position_12_x_fix, position_12_y_fix];
E=[position_11_x_fix, position_11_y_fix];
F=[position_9_x_fix, position_9_y_fix];
G=[position_8_x_fix, position_8_y_fix];
H=[position_7_x, position_7_y];
%4,7,1,actuator
I=[position_7_x, position_7_y];
J=[position_4_x, position_4_y];
K=[position_1_x, position_1_y];
L=[position_actuator_x,position_actuator_y];

% x, y 좌표 배열 생성
x_1 = [A(1), B(1), C(1)];
y_1 = [A(2), B(2), C(2)];

x_2 = [C(1), D(1), E(1)];
y_2 = [C(2), D(2), E(2)];

x_3 = [E(1), F(1), G(1), H(1)];
y_3 = [E(2), F(2), G(2), H(2)];

x_4 = [I(1), J(1), K(1), L(1)];
y_4 = [I(2), J(2), K(2), L(2)];


% 삼각형 내부를 흰색으로 채우기
fill(x_1, y_1, 'b');
fill(x_2, y_2, 'b');
fill(x_3, y_3, 'b');
% fill(x_4, y_4, 'b');


xlabel('X Position (mm)');
ylabel('Y Position (mm)');
title('Fingertip ROM and Linkage Visualization');
grid on;
axis equal;

%% 각도 확인하기
% 
% point_8 = [position_8_x_fix, position_8_y_fix];
% point_7 = [position_7_x, position_7_y];
% point_11 = [position_11_x_fix, position_11_y_fix];
% point_9 = [position_9_x_fix, position_9_y_fix];
% point_12 = [position_12_x_fix, position_12_y_fix];
% point_14 = [position_14_x_fix, position_14_y_fix];
% point_17 = [position_17_x_fix, position_17_y_fix];
% point_16 = [position_16_x_fix, position_16_y_fix];
% 
% find_angle_8_7_11 = calculate_angle(point_8, point_7, point_11);
% find_angle_9_11_7 = calculate_angle(point_9, point_11, point_7);
% find_angle_12_11_14 = calculate_angle(point_12, point_11, point_14);
% find_angle_16_17_14 = calculate_angle(point_16, point_17, point_14);
% find_angle_16_14_17 = calculate_angle(point_16, point_14, point_17);
% 



