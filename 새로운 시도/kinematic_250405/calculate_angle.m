function angle_8_7_11 = calculate_angle(point_8, point_7, point_11)
    % 벡터 정의
    vec1 = point_8 - point_7;
    vec2 = point_11 - point_7;

    % 벡터 크기 계산
    mag1 = norm(vec1);
    mag2 = norm(vec2);

    % 벡터 내적 계산
    dot_product1 = dot(vec1, vec2);

    % 코사인 값
    cos_theta1 = dot_product1 / (mag1 * mag2);

    % 오차 방지용 범위 제한
    cos_theta1 = min(1, max(-1, cos_theta1));

    % 각도 변환 (라디안을 도(degree)로 변환)
    angle_8_7_11 = acosd(cos_theta1);
end
