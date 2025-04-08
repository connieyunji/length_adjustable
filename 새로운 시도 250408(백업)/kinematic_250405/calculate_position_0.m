function [position_0_x, position_0_y, l1] = calculate_position_0(position_1_x, position_1_y, position_3_x, position_3_y, position_actuator_x, position_actuator_y, l3, ang_3_1_0)

    % l1 길이 정의
    l1_step = [11, 15, 19, 23, 27, 31];  % step 6개, 4mm 간격
    l1 = l1_step(6);

    % 벡터 3 -> 1 계산
    v31_x = position_3_x - position_1_x;
    v31_y = position_3_y - position_1_y;
    % 단위 벡터로 변환 (2×N 형식)
    v31 = [v31_x(:)'; v31_y(:)'];     % 2×N
    v31_unit = v31 ./ l3;             % 크기 정규화

    % 회전 행렬
    cos_theta = cosd(-ang_3_1_0);
    sin_theta = sind(-ang_3_1_0);
    rot_matrix = [cos_theta, -sin_theta; sin_theta, cos_theta];

    % 회전 및 길이 적용
    v10_rotated = rot_matrix * v31_unit * l1;  % 결과도 2×N

    % 점 0 좌표 계산
    position_0_x = position_1_x + v10_rotated(1, :);
    position_0_y = position_1_y + v10_rotated(2, :);

    % 거리 확인 (0-1 거리)
    distance_0_1 = sqrt((position_0_x - position_1_x).^2 + (position_0_y - position_1_y).^2);

    % actuator까지 거리
    distance_x = position_0_x - position_actuator_x;
    distance_y = position_0_y - position_actuator_y;
    distance = sqrt(distance_x.^2 + distance_y.^2);

    % 허용 오차
    tol = 1e-2;

    % 조건별 유효성 검사
    invalid_distance_01 = abs(distance_0_1 - l1) > tol;
    % invalid_distance_actuator = distance < 100 | distance > 150;

    % 둘 중 하나라도 실패하면 NaN 처리
    invalid_idx = invalid_distance_01; %| invalid_distance_actuator;

    position_0_x(invalid_idx) = NaN;
    position_0_y(invalid_idx) = NaN;

end
