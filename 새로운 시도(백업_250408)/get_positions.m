function get_positions()

    addpath('kinematic_250405\');

    % 각도 범위 설정 (단위: 도)
    theta1_range = 0:1:73;
    theta2_range = 0:1:86;
    theta3_range = 0:1:57;

    % 길이 및 각도 정보 불러오기
    T = readtable('length_angle_data.csv', 'ReadVariableNames', false);
    vars = table2cell(T(:,1));
    values = table2array(T(:,2));
    
    for i = 1:length(vars)
        assignin('caller', vars{i}, values(i));  % caller workspace로 변수 전달
        eval([vars{i} ' = ' num2str(values(i)) ';']);  % 현재 workspace에서 계산용 변수 생성
    end

    % 기준점 위치 정의
    position_4 = [0, 0];
    p4_x = position_4(1);
    p4_y = position_4(2);
    
    % 1번 위치 계산
    position_1 = [l24*cosd(alpha_angle), l24*sind(alpha_angle)];
    p1_x = position_1(1);
    p1_y = position_1(2);
    
    % 7번 위치 계산
    position_7 = [l7*cosd(beta_angle), -l7*sind(beta_angle)];
    p7_x = position_7(1);
    p7_y = position_7(2);

    % 액추에이터 위치 계산
    [p_act_x, p_act_y] = calculate_position_actuator(p1_x, p1_y, l0, a_prime);

    % 전체 theta 조합 생성
    [T1, T2, T3] = ndgrid(theta1_range, theta2_range, theta3_range);
    total_theta = (T1 + T2 + T3);

    % 각 점들의 위치 계산
    [p11_x, p11_y] = calculate_position_11(p7_x, p7_y, T1, l10);
    [p14_x, p14_y] = calculate_position_14(p11_x, p11_y, T1+T2, l15);
    [p17_x, p17_y] = calculate_position_17(p14_x, p14_y, T1+T2+T3, l23);
    [p8_x, p8_y] = calculate_position_8(p7_x, p7_y, T1, ang_8_7_11, l9);
    [p9_x, p9_y] = calculate_position_9(p8_x, p8_y, T1, l11);
    [p12_x, p12_y] = calculate_position_12(p11_x, p11_y, T1+T2, ang_12_11_14, l16);
    [p16_x, p16_y] = calculate_position_16(p14_x, p14_y, T1+T2+T3, ang_16_14_17, l26);

    % 1D 벡터로 변환
    p11_x = p11_x(:); p11_y = p11_y(:);
    p14_x = p14_x(:); p14_y = p14_y(:);
    p17_x = p17_x(:); p17_y = p17_y(:);
    p8_x = p8_x(:);   p8_y = p8_y(:);
    p9_x = p9_x(:);   p9_y = p9_y(:);
    p12_x = p12_x(:); p12_y = p12_y(:);
    p16_x = p16_x(:); p16_y = p16_y(:);
    total_theta = total_theta(:);

    % 이어지는 위치 계산
    [p13_x, p13_y] = calculate_position_13(p16_x, p16_y, p12_x, p12_y, l25, l17);
    [p10_x, p10_y] = calculate_position_10(p13_x, p13_y, p9_x, p9_y, l18, l14);
    [p5_x, p5_y] = calculate_position_5(p8_x, p8_y, p4_x, p4_y, l5, l8);
    [p6_x, p6_y] = calculate_position_6(p10_x, p10_y, p5_x, p5_y, p8_x, p8_y, l12, l6);
    [p3_x, p3_y] = calculate_position_3(p6_x, p6_y, p1_x, p1_y, l4, l3);
    [p0_x, p0_y, l1] = calculate_position_0(p1_x, p1_y, p3_x, p3_y, p_act_x, p_act_y, l3, ang_3_1_0);

    p0_x = p0_x';
    p0_y = p0_y';

    % 모든 변수 caller workspace로 전달
    vars_to_assign = {'p0_x','p0_y','p1_x','p1_y','p3_x','p3_y','p4_x', 'p4_y', 'p5_x', ...
                      'p5_y','p6_x','p6_y','p7_x','p7_y','p8_x','p8_y','p9_x','p9_y','p10_x','p10_y', ...
                      'p11_x','p11_y', 'p12_x','p12_y','p13_x','p13_y','p14_x','p14_y', ...
                      'p16_x','p16_y', 'p17_x','p17_y','total_theta','p_act_x', 'p_act_y', 'l1'};
    
    for i = 1:length(vars_to_assign)
        assignin('caller', vars_to_assign{i}, eval(vars_to_assign{i}));
    end
end
