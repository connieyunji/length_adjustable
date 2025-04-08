function angle_8_7_11 = calculate_angle(point_8, point_7, point_11)
    % ���� ����
    vec1 = point_8 - point_7;
    vec2 = point_11 - point_7;

    % ���� ũ�� ���
    mag1 = norm(vec1);
    mag2 = norm(vec2);

    % ���� ���� ���
    dot_product1 = dot(vec1, vec2);

    % �ڻ��� ��
    cos_theta1 = dot_product1 / (mag1 * mag2);

    % ���� ������ ���� ����
    cos_theta1 = min(1, max(-1, cos_theta1));

    % ���� ��ȯ (������ ��(degree)�� ��ȯ)
    angle_8_7_11 = acosd(cos_theta1);
end
