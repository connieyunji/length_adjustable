function [p0_list, p3_list, l1] = cal_p0_linear(p1, p_act, l3)

    % l1 길이 정의
    l1_step = [11, 15, 19, 23, 27, 31];  % step 6개, 4mm 간격
    l1 = l1_step(6);

    theta_link = 30;  % 링크1과 링크2 사이 각도 (고정)
    
    % 액추에이터 길이 범위
    L_array = linspace(100, 150, 200);  % 액추에이터 길이 변화
    
    motor_base = p_act;
    
    % 결과 저장용 배열
    p3_list = [];
    p1_list = [];
    p0_list = [];
    
    for k = 1:length(L_array)
        L = L_array(k);  % 현재 액추에이터 길이
    
        r = motor_base - p1;
        d = norm(r);
    
        if d < (L + l1) && d > abs(L - l1)
            alpha = acos((d^2 + l1^2 - L^2) / (2 * d * l1));
            theta_r = atan2(r(2), r(1));
            theta2 = theta_r + alpha;
    
            % p0 위치 계산
            p0 = p1 + l1 * [cos(theta2), sin(theta2)];
    
            % p1 이후 계산
            theta1_cand1 = theta2 + theta_link;
            theta1_cand2 = theta2 - theta_link;
    
            p3_cand1 = p1 + l3 * [cos(theta1_cand1), sin(theta1_cand1)];
            p3_cand2 = p1 + l3 * [cos(theta1_cand2), sin(theta1_cand2)];
    
            % 방향 판단
            v1 = p1 - p3_cand1;
            v2 = p0 - p1;
            cross1 = v1(1)*v2(2) - v1(2)*v2(1);
    
            if cross1 > 0
                p3 = p3_cand1;
            else
                p3 = p3_cand2;
            end
    
            % 저장
            p3_list = [p3_list; p3];
            p1_list = [p1_list; p1];  % 고정점이지만 배열 유지 위해 저장
            p0_list = [p0_list; p0];
        end
    end
end
