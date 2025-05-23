%최종 kinematic 추정 코드

clc; clear; close all;

% 각도 범위 설정 (단위: 도)
theta1_range = 0:1:73;
theta2_range = 0:1:86;
theta3_range = 0:1:57;

%각도랑 길이 상수 받아오기
T = readtable('length_angle_data.csv', 'ReadVariableNames', false); % CSV 파일 읽기
vars = table2cell(T(:,1)); % 첫 번째 열 (변수명)
values = table2array(T(:,2)); % 두 번째 열 (값)

for i = 1:length(vars)
    assignin('base', vars{i}, values(i)); % 작업공간에 변수 저장
end


%% ROM그리기 (4,1,7,11,14,17)
% 기준 원점 (4번 조인트)
position_4 = [0, 0];
position_4_x = position_4(1);
position_4_y = position_4(2);

% 1번 조인트 위치
position_1 = [l24*cosd(alpha_angle), l24*sind(alpha_angle)];
position_1_x = position_1(1);
position_1_y = position_1(2);

% 7번 조인트 (MCP)
position_7 = [l7*cosd(beta_angle), -l7*sind(beta_angle)];
position_7_x = position_7(1);
position_7_y = position_7(2);

[position_actuator_x, position_actuator_y] = calculate_position_actuator(position_1_x, position_1_y, l0, a_prime);

% 가능한 모든 조합을 벡터화하여 연산
[T1, T2, T3] = ndgrid(theta1_range, theta2_range, theta3_range);

% 위치 계산 (연결된 부분) 11,14,17,16,12,9,8
[position_11_x, position_11_y] = calculate_position_11(position_7_x, position_7_y, T1, l10);
[position_14_x, position_14_y] = calculate_position_14(position_11_x, position_11_y, T1+T2, l15);
[position_17_x, position_17_y] = calculate_position_17(position_14_x, position_14_y, T1+T2+T3, l23);
[position_8_x, position_8_y] = calculate_position_8(position_7_x, position_7_y, T1, ang_8_7_11, l9);
[position_9_x, position_9_y] = calculate_position_9(position_8_x, position_8_y, T1, l11);
[position_12_x, position_12_y] = calculate_position_12(position_11_x, position_11_y, T1+T2, ang_12_11_14, l16);
[position_16_x, position_16_y] = calculate_position_16(position_14_x, position_14_y, T1+T2+T3, ang_16_14_17, l26);


% 1D 배열로 변환
ROM_17_x = position_17_x(:);
ROM_17_y = position_17_y(:);
ROM_11_x = position_11_x(:);
ROM_11_y = position_11_y(:);
ROM_14_x = position_14_x(:);
ROM_14_y = position_14_y(:);
ROM_8_x = position_8_x(:);
ROM_8_y = position_8_y(:);
ROM_9_x = position_9_x(:);
ROM_9_y = position_9_y(:);
ROM_12_x = position_12_x(:);
ROM_12_y = position_12_y(:);
ROM_16_x = position_16_x(:);
ROM_16_y = position_16_y(:);


% total_theta도 1D 배열로 변환
total_theta = (T1 + T2 + T3);
total_theta = total_theta(:);

%위치 계산 (바뀌는 부분) 13, 10, 5, 6, 3
[position_13_x, position_13_y] = calculate_position_13(ROM_16_x, ROM_16_y, ROM_12_x, ROM_12_y, l25, l17);
ROM_13_x = position_13_x(:);
ROM_13_y = position_13_y(:);
[position_10_x, position_10_y] = calculate_position_10(ROM_13_x, ROM_13_y, ROM_9_x, ROM_9_y, l18, l14);
ROM_10_x = position_10_x(:);
ROM_10_y = position_10_y(:);
[position_5_x, position_5_y] = calculate_position_5(ROM_8_x, ROM_8_y, position_4_x, position_4_y, l5, l8);
ROM_5_x = position_5_x(:);
ROM_5_y = position_5_y(:);
[position_6_x, position_6_y] = calculate_position_6(ROM_10_x, ROM_10_y, ROM_5_x, ROM_5_y, ROM_8_x, ROM_8_y, l12, l6);
ROM_6_x = position_6_x(:);
ROM_6_y = position_6_y(:);
[position_3_x, position_3_y] = calculate_position_3(ROM_6_x, ROM_6_y, position_1_x, position_1_y, l4, l3);
ROM_3_x = position_3_x(:);
ROM_3_y = position_3_y(:);
[position_0_x, position_0_y] = calculate_position_0(position_1_x, position_1_y, ROM_3_x, ROM_3_y, position_actuator_x,position_actuator_y, l3, ang_3_1_0);
ROM_0_x = position_0_x(:);
ROM_0_y = position_0_y(:);

% 한 번에 그리기 (속도 개선)
figure;
scatter(ROM_17_x, ROM_17_y, 2, 'k', 'filled');
hold on;
% scatter(ROM_11_x, ROM_11_y, 2, 'b', 'filled');
% hold on;
% scatter(ROM_14_x, ROM_14_y, 2, 'b', 'filled');
% hold on;
% scatter(ROM_8_x, ROM_8_y, 2, 'b', 'filled');
% hold on;
% scatter(ROM_9_x, ROM_9_y, 2, 'b', 'filled');
% hold on;
% scatter(ROM_12_x, ROM_12_y, 2, 'b', 'filled');
% hold on;
% scatter(ROM_16_x, ROM_16_y, 2, 'b', 'filled');
% hold on;
% scatter(ROM_13_x, ROM_13_y, 2, 'b', 'filled');
% hold on;
% scatter(ROM_10_x, ROM_10_y, 2, 'g', 'filled');
% hold on;
% scatter(ROM_5_x, ROM_5_y, 2, 'g', 'filled');
% hold on;
% scatter(ROM_6_x, ROM_6_y, 2, 'g', 'filled');
% hold on;
% scatter(ROM_3_x, ROM_3_y, 2, 'g', 'filled');
% hold on;
scatter(ROM_0_x, ROM_0_y, 2, 'b', 'filled');
hold on;

% NaN이 아닌 값들만 필터링
valid_idx = ~isnan(ROM_17_x) & ~isnan(ROM_17_y) & ...
            ~isnan(ROM_13_x) & ~isnan(ROM_13_y) & ...
            ~isnan(ROM_10_x) & ~isnan(ROM_10_y) & ...
            ~isnan(ROM_6_x)  & ~isnan(ROM_6_y)  & ...
            ~isnan(ROM_3_x)  & ~isnan(ROM_3_y)  & ...
            ~isnan(ROM_0_x)  & ~isnan(ROM_0_y);

scatter(ROM_17_x(valid_idx), ROM_17_y(valid_idx), 3, 'g', 'filled');
hold on;


%%
% 개별 조인트 위치 계산 (기본 자세)
theta1_default = 30;  %73, -10
theta2_default = 0;  %86, 21
theta3_default = 0;  %57, 7

[position_11_x_fix, position_11_y_fix] = calculate_position_11(position_7_x, position_7_y, theta1_default, l10);
[position_14_x_fix, position_14_y_fix] = calculate_position_14(position_11_x_fix, position_11_y_fix, theta1_default+theta2_default, l15);
[position_17_x_fix, position_17_y_fix] = calculate_position_17(position_14_x_fix, position_14_y_fix, theta1_default+theta2_default+theta3_default, l23);
% 8,9,12,16
[position_8_x_fix, position_8_y_fix] = calculate_position_8(position_7_x, position_7_y, theta1_default, ang_8_7_11, l9);
[position_9_x_fix, position_9_y_fix] = calculate_position_9(position_8_x_fix, position_8_y_fix, theta1_default, l11);
[position_12_x_fix, position_12_y_fix] = calculate_position_12(position_11_x_fix, position_11_y_fix, theta1_default+theta2_default, ang_12_11_14, l16);
[position_16_x_fix, position_16_y_fix] = calculate_position_16(position_14_x_fix, position_14_y_fix, theta1_default+theta2_default+theta3_default, ang_16_14_17, l26);

%5,13,10,6,3,0,act
[position_5_x_fix, position_5_y_fix] = calculate_position_5(position_8_x_fix, position_8_y_fix, position_4_x, position_4_y, l5, l8);
[position_13_x_fix, position_13_y_fix] = calculate_position_13(position_16_x_fix, position_16_y_fix,position_12_x_fix, position_12_y_fix, l25, l17);
[position_10_x_fix, position_10_y_fix] = calculate_position_10(position_13_x_fix, position_13_y_fix,position_9_x_fix, position_9_y_fix, l18, l14);
[position_6_x_fix, position_6_y_fix] = calculate_position_6(position_10_x_fix, position_10_y_fix, position_5_x_fix, position_5_y_fix, position_8_x_fix, position_8_y_fix, l12, l6);
[position_3_x_fix, position_3_y_fix] = calculate_position_3(position_6_x_fix, position_6_y_fix,position_1_x, position_1_y, l4, l3);
[position_0_x_fix, position_0_y_fix] = calculate_position_0(position_1_x, position_1_y, position_3_x_fix, position_3_y_fix, position_actuator_x, position_actuator_y, l3, ang_3_1_0);



% % 링크 위치를 보라색 점으로 표시
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
plot(position_6_x_fix, position_6_y_fix, 'bo', 'MarkerSize', 2, 'LineWidth', 2);
plot(position_3_x_fix, position_3_y_fix, 'bo', 'MarkerSize', 2, 'LineWidth', 2); 
plot(position_0_x_fix, position_0_y_fix, 'bo', 'MarkerSize', 2, 'LineWidth', 2); 

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

%%
xlabel('X Position (mm)');
ylabel('Y Position (mm)');
title('Fingertip ROM and Linkage Visualization');
grid on;
axis equal;

%% 각도에 맞는 인덱스 찾기
% 각도 설정
theta1 = 30;
theta2 = 10;
theta3 = 10;

% 인덱스 찾기
idx1 = find(theta1_range == theta1);
idx2 = find(theta2_range == theta2);
idx3 = find(theta3_range == theta3);

% linear 인덱스 계산
linear_idx = sub2ind(size(T1), idx1, idx2, idx3);

% ROM 위치 확인
x_17 = ROM_17_x(linear_idx);
y_17 = ROM_17_y(linear_idx);


%%
%길이 확인
% length_17_16 = sqrt((position_17_x_fix - position_16_x_fix)^2+ (position_17_y_fix - position_16_y_fix)^2)
% length_14_16 = sqrt((position_14_x_fix - position_16_x_fix)^2+ (position_14_y_fix - position_16_y_fix)^2)
% length_13_16 = sqrt((position_13_x_fix - position_16_x_fix)^2+ (position_13_y_fix - position_16_y_fix)^2)
% length_13_10 = sqrt((position_13_x_fix - position_10_x_fix)^2+ (position_13_y_fix - position_10_y_fix)^2)
% length_13_12 = sqrt((position_13_x_fix - position_12_x_fix)^2+ (position_13_y_fix - position_12_y_fix)^2)
% length_9_10 = sqrt((position_9_x_fix - position_10_x_fix)^2+ (position_9_y_fix - position_10_y_fix)^2)
% length_6_10 = sqrt((position_6_x_fix - position_10_x_fix)^2+ (position_6_y_fix - position_10_y_fix)^2)
% length_6_5 = sqrt((position_6_x_fix - position_5_x_fix)^2+ (position_6_y_fix - position_5_y_fix)^2)
% length_6_3 = sqrt((position_6_x_fix - position_3_x_fix)^2+ (position_6_y_fix - position_3_y_fix)^2)
% length_1_3 = sqrt((position_1_x - position_3_x_fix)^2+ (position_1_y - position_3_y_fix)^2)


% 각도 확인
% point_3 = [position_3_x_fix, position_3_y_fix];
% point_1 = [position_1_x, position_1_y];
% point_0 = [position_0_x_fix, position_0_y_fix];
% angle_3_1_0 = calculate_angle(point_3, point_1, point_0)