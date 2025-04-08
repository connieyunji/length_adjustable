function angle_array = cal_3_angle(p_act, p0_all, p1)
    N = size(p0_all, 1);
    angle_array = zeros(N, 1);

    for i = 1:N
        p0 = p0_all(i, :);
        vec1 = p_act - p0;
        vec2 = p1 - p0;

        mag1 = norm(vec1);
        mag2 = norm(vec2);

        if mag1 == 0 || mag2 == 0
            angle_array(i) = NaN;
        else
            cos_theta = dot(vec1, vec2) / (mag1 * mag2);
            cos_theta = min(1, max(-1, cos_theta));  % æ»¡§»≠
            angle_array(i) = acosd(cos_theta);
        end
    end
end
