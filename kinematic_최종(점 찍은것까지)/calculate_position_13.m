function [p13_x, p13_y] = calculate_position_13(position_16_x, position_16_y, position_12_x, position_12_y, l25, l17, total_theta)
    % 변수 정의
    syms p13_x p13_y

    % 방정식 1: 점 13과 16 사이의 거리 (l25)
    eq1 = (p13_x - position_16_x)^2 + (p13_y - position_16_y)^2 == l25^2;
    
    % 방정식 2: 점 13과 12 사이의 거리 (l17)
    eq2 = (p13_x - position_12_x)^2 + (p13_y - position_12_y)^2 == l17^2;
    
    % 연립 방정식 풀기
    sol = solve([eq1, eq2], [p13_x, p13_y]);
    
    % 결과를 더블형으로 변환
    p13_x = double(sol.p13_x);
    p13_y = double(sol.p13_y);
    
    if total_theta <= 90
        % y축 값이 더 높은 값을 선택
        [~, idx] = max(p13_y);  % y값이 더 큰 인덱스를 찾음
    else
        % x축 값이 더 작은 값을 선택
        [~, idx] = min(p13_x);  % x값이 더 작은 인덱스를 찾음
        if total_theta >= 200
            % y축 값이 더 작은 값을 선택
            [~, idx] = min(p13_y);  
        end
    end
    
    % 조건을 만족하는 해 선택
    p13_x = p13_x(idx);
    p13_y = p13_y(idx);
end
