class
    VECTOR_2R

create
    make, make_zero, make_one

feature -- Access

    x: REAL
    y: REAL

    magnitude: REAL
            -- Length of the vector.
        do
            Result := (x*x + y*y).sqrt
        ensure
            non_negative: Result >= 0.0
        end

    square_magnitude: REAL
            -- Squared length.
        do
            Result := (x*x + y*y)
        ensure
            non_negative: Result >= 0.0
        end

    normalized: VECTOR_2R
            -- Return a normalized vector.
        local
            mag: REAL
        do
            mag := magnitude
            if mag > 1e-6 then
                create Result.make (x / mag, y / mag)
            else
                create Result.make_zero
            end
        ensure
            result_attached: Result /= Void
        end

feature -- Creation

    make (a_x, a_y: REAL)
            -- Create from components.
        do
            x := a_x
            y := a_y
        ensure
            x_set: x = a_x
            y_set: y = a_y
        end

    make_zero
            -- (0, 0) vector.
        do
            make (0.0, 0.0)
        end

    make_one
            -- (1, 1) vector.
        do
            make (1.0, 1.0)
        end

feature -- Operations

    infix "+" (other: VECTOR_2R): VECTOR_2R
            -- Addition
        require
            other_attached: other /= Void
        do
            create Result.make (x + other.x, y + other.y)
        end

    infix "-" (other: VECTOR_2R): VECTOR_2R
            -- Subtraction
        require
            other_attached: other /= Void
        do
            create Result.make (x - other.x, y - other.y)
        end

    infix "*" (scalar: REAL): VECTOR_2R
            -- Scalar multiplication
        do
            create Result.make (x * scalar, y * scalar)
        end

    infix "/" (scalar: REAL): VECTOR_2R
            -- Scalar division
        require
            scalar_non_zero: scalar /= 0.0
        do
            create Result.make (x / scalar, y / scalar)
        end

    dot_product (other: VECTOR_2R): REAL
            -- Dot product
        require
            other_attached: other /= Void
        do
            Result := x * other.x + y * other.y
        end

    lerp (target: VECTOR_2R; t: REAL): VECTOR_2R
            -- Linear interpolation.
        require
            target_attached: target /= Void
            t_valid: t >= 0.0 and t <= 1.0
        do
            create Result.make (
                x + (target.x - x) * t,
                y + (target.y - y) * t
            )
        end

    rotate (radians: REAL): VECTOR_2R
            -- Rotate vector by angle (radians).
        local
            cos_theta, sin_theta: REAL
        do
            cos_theta := radians.cos
            sin_theta := radians.sin
            create Result.make (
                x * cos_theta - y * sin_theta,
                x * sin_theta + y * cos_theta
            )
        end

feature -- Output

    to_string: STRING
        do
            create Result.make_from_string ("(" + x.out + ", " + y.out + ")")
        end

invariant
    valid_components: True

note
	copyright: "Copyright (c) 2025, KontinuumGames"
	license:   "MIT, redistributable, keep author references"
	source: "[
			Eiffel Toolbox,
			Github: https://github.com/MapelSiroup/Eiffel-Toolbox
		]"
end -- REAL VECTOR2
