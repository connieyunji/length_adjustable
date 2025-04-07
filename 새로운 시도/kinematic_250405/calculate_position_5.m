% 
% 
% function [p5_x, p5_y] = calculate_position_5(position_8_x, position_8_y,position_7_y, l5, l8)
%     % 변수 정의
%     syms p5_x p5_y
% 
%     % 방정식 1: 점 5와 점 4 사이의 거리 (p5_x^2 + p5_y^2 = l5^2, 4가 원점이라서)
%     eq1 = p5_x^2 + p5_y^2 == l5^2;
% 
%     % 방정식 2: 점 8과 점 5 사이의 거리 (점 8의 좌표는 position_8_x, position_8_y)
%     eq2 = (p5_x - position_8_x)^2 + (p5_y - position_8_y)^2 == l8^2;
% 
%     % 연립 방정식 풀기
%     sol = solve([eq1, eq2], [p5_x, p5_y]);
% 
%     % 결과를 더블형으로 변환
%     p5_x = double(sol.p5_x);
%     p5_y = double(sol.p5_y);
% 
%     % 점 5의 y좌표가 점 7보다 위에 있어야 한다는 조건 추가
%     valid_solutions = p5_y > position_7_y;  % 점 5의 y좌표가 점 8의 y좌표보다 커야 함
% 
%     if any(valid_solutions)
%         % 조건을 만족하는 해가 있다면 그 해를 선택
%         p5_x = p5_x(valid_solutions);
%         p5_y = p5_y(valid_solutions);
% 
%         % 두 개의 유효한 해가 있을 경우 y값이 더 큰 해를 선택
%         if length(p5_y) > 1
%             [~, idx] = max(p5_y);  % y값이 더 큰 인덱스 선택
%             p5_x = p5_x(idx);
%             p5_y = p5_y(idx);
%         end
%     else
%         % 조건을 만족하는 해가 없으면 경고 메시지 출력
%         warning('점 5는 점 8보다 y축으로 위에 있을 수 없습니다.');
%         p5_x = NaN;
%         p5_y = NaN;
%     end
% 
% end


function [position_5_x, position_5_y] = calculate_position_5(position_8_x, position_8_y, position_4_x, position_4_y, l5, l8)

    % 벡터 간 거리 계산
    d = sqrt((position_8_x - position_4_x).^2 + (position_8_y - position_4_y).^2);


    % 코사인 법칙을 이용한 각도 계산
    cos_theta_8 = (l8^2 + d.^2 - l5^2) ./ (2 * l8 .* d);
    cos_theta_8 = max(min(cos_theta_8, 1), -1);  % acosd 오류 방지
    ang_5_8_4 = acosd(cos_theta_8);


    ang_4_8_x =  rad2deg(atan2(position_4_y - position_8_y, position_4_x - position_8_x));
    

    % 최종 각도 계산 (하나만 사용)
    angle_option = ang_4_8_x + ang_5_8_4;

    % 위치 계산
    position_5_x = position_8_x + l8 * cosd(angle_option);
    position_5_y = position_8_y + l8 * sind(angle_option);

end
