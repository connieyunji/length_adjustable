% function [p3_x, p3_y] = calculate_position_3(position_6_x, position_6_y, position_1_x, position_1_y, l4, l3, total_theta)
%     % 변수 정의
%     syms p3_x p3_y
% 
%     % 방정식 1: 점 6과 3 거리 (l4)
%     eq1 = (p3_x - position_6_x)^2 + (p3_y - position_6_y)^2 == l4^2;
% 
%     % 방정식 2: 점 1과 3 거리 (l3)
%     eq2 = (p3_x - position_1_x)^2 + (p3_y - position_1_y)^2 == l3^2;
% 
%     % 연립 방정식 풀기
%     sol = solve([eq1, eq2], [p3_x, p3_y]);
% 
%     % 결과를 double 형으로 변환
%     p3_x = double(sol.p3_x);
%     p3_y = double(sol.p3_y);
% 
%     % 조건 1: x좌표가 position_1_x보다 큰 값 우선 선택
%     valid_solutions = p3_x > position_1_x;
% 
%     if any(valid_solutions) % 유효한 해가 있는 경우
%         p3_x = p3_x(valid_solutions);
%         p3_y = p3_y(valid_solutions);
%     end
% 
%     % 조건 2: y값이 더 큰 해 선택 (여러 개 있을 경우)
%     if numel(p3_y) > 1
%         [~, idx] = max(p3_y);
%         p3_x = p3_x(idx);
%         p3_y = p3_y(idx);
%     end
% end


function [position_3_x, position_3_y] = calculate_position_3(position_6_x, position_6_y, position_1_x, position_1_y, l4, l3)

    % 벡터 간 거리 계산
    d = sqrt((position_6_x - position_1_x).^2 + (position_6_y - position_1_y).^2);

    % 코사인 법칙을 이용한 각도 계산
    cos_theta_6 = (l4^2 + d.^2 - l3^2) ./ (2 * l4 .* d);
    cos_theta_6 = max(min(cos_theta_6, 1), -1);  % acosd 안정화
    ang_3_6_1 = acosd(cos_theta_6);

    % 기준 각도
    ang_6_1_x = rad2deg(atan2(position_1_y - position_6_y, position_1_x - position_6_x));

    % 최종 각도
    angle_option = ang_6_1_x + ang_3_6_1;

    % 위치 계산
    position_3_x = position_6_x + l4 * cosd(angle_option);
    position_3_y = position_6_y + l4 * sind(angle_option);

    % 거리 검증
    distance_6_3 = sqrt((position_6_x - position_3_x).^2 + (position_6_y - position_3_y).^2);
    distance_3_1 = sqrt((position_3_x - position_1_x).^2 + (position_3_y - position_1_y).^2);

    % 허용 오차
    tol = 1e-2;

    % 조건을 만족하지 않는 인덱스만 NaN 처리
    invalid_idx = abs(distance_6_3 - l4) > tol | abs(distance_3_1 - l3) > tol;
    position_3_x(invalid_idx) = NaN;
    position_3_y(invalid_idx) = NaN;

end
