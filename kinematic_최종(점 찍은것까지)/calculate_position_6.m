function [p6_x, p6_y] = calculate_position_6(position_10_x, position_10_y,position_5_x, position_5_y, l12, l6, total_theta)
    % 변수 정의
    syms p6_x p6_y

    % 방정식 1: 점 6과 10거리
    eq1 = (p6_x - position_10_x)^2 + (p6_y - position_10_y)^2 == l12^2;
    
    % 방정식 2: 점 6과 5거리
     eq2 = (p6_x - position_5_x)^2 + (p6_y - position_5_y)^2 == l6^2;
    
    % 연립 방정식 풀기
    sol = solve([eq1, eq2], [p6_x, p6_y]);
    
    % 결과를 더블형으로 변환
    p6_x = double(sol.p6_x);
    p6_y = double(sol.p6_y);

    % % 모든 해 출력
    % disp('p6_x possible values:');
    % disp(p6_x);
    % disp('p6_y possible values:');
    % disp(p6_y);
    
    if total_theta >= -100           %모든 값에 다 적용되는 조건
        % y축 값이 더 높은 값을 선택
        [~, idx] = max(p6_y);    
    end   

    % 조건을 만족하는 해 선택
    p6_x = p6_x(idx);
    p6_y = p6_y(idx);
    
   
end