class
    DEGREE_UTILS

feature -- Conversion

    radians_to_degrees (radians: REAL): REAL
            -- Convert `radians` to degrees.
        do
            Result := radians * 180.0 / {MATH_CONST}.pi
        ensure
            valid_result: True
        end

    degrees_to_radians (degrees: REAL): REAL
            -- Convert `degrees` to radians.
        do
            Result := degrees * {MATH_CONST}.pi / 180.0
        ensure
            valid_result: True
        end

feature -- Utilities

    normalize_degrees (degrees: REAL): REAL
            -- Normalize degrees between [0, 360).
        local
            result_temp: REAL
        do
            result_temp := degrees \\ 360.0
            if result_temp < 0.0 then
                result_temp := result_temp + 360.0
            end
            Result := result_temp
        ensure
            between_0_and_360: Result >= 0.0 and Result < 360.0
        end

    normalize_radians (radians: REAL): REAL
            -- Normalize radians between [0, 2*PI).
        local
            result_temp: REAL
        do
            result_temp := radians \\ (2.0 * {MATH_CONST}.pi)
            if result_temp < 0.0 then
                result_temp := result_temp + (2.0 * {MATH_CONST}.pi)
            end
            Result := result_temp
        ensure
            between_0_and_2pi: Result >= 0.0 and Result < (2.0 * {MATH_CONST}.pi)
        end

end
