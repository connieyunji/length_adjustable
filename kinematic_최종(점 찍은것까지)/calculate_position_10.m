function [p10_x, p10_y] = calculate_position_10(position_13_x, position_13_y,position_9_x, position_9_y, l18, l14, total_theta)
    % 변수 정의
    syms p10_x p10_y

    % 방정식 1: 점 10과 13거리
    eq1 = (p10_x - position_13_x)^2 + (p10_y - position_13_y)^2 == l18^2;
    
    % 방정식 2: 점 10과 9거리
     eq2 = (p10_x - position_9_x)^2 + (p10_y - position_9_y)^2 == l14^2;
    
    % 연립 방정식 풀기
    sol = solve([eq1, eq2], [p10_x, p10_y]);
    
    % 결과를 더블형으로 변환
    p10_x = double(sol.p10_x);
    p10_y = double(sol.p10_y);
    
    if total_theta >= 90
        % y축 값이 더 높은 값을 선택
        [~, idx] = min(p10_x);  % x값이 더 작은 인덱스를 찾음
    else
        % x축 값이 더 작은 값을 선택
        [~, idx] = max(p10_y);  % y값이 더 큰 인덱스를 찾음
    end
    
    % 조건을 만족하는 해 선택
    p10_x = p10_x(idx);
    p10_y = p10_y(idx);
    
   
end