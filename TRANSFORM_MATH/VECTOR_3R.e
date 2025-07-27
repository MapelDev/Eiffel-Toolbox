class
    VECTOR_3R

create
    make, make_zero, make_one

feature -- Access

    x: REAL
    y: REAL
    z: REAL

    magnitude: REAL
            -- Length of the vector.
        do
            Result := (x*x + y*y + z*z).sqrt
        ensure
            non_negative: Result >= 0.0
        end

    square_magnitude: REAL
            -- Squared length.
        do
            Result := (x*x + y*y + z*z)
        ensure
            non_negative: Result >= 0.0
        end

    normalized: VECTOR_3R
            -- Return a normalized vector.
        local
            mag: REAL
        do
            mag := magnitude
            if mag > 1e-6 then
                create Result.make (x / mag, y / mag, z / mag)
            else
                create Result.make_zero
            end
        end

feature -- Creation

    make (a_x, a_y, a_z: REAL)
            -- Create from components.
        do
            x := a_x
            y := a_y
            z := a_z
        end

    make_zero
            -- (0, 0, 0) vector.
        do
            make (0.0, 0.0, 0.0)
        end

    make_one
            -- (1, 1, 1) vector.
        do
            make (1.0, 1.0, 1.0)
        end

feature -- Operations

    infix "+" (other: VECTOR_3R): VECTOR_3R
            -- Addition
        require
            other_attached: other /= Void
        do
            create Result.make (x + other.x, y + other.y, z + other.z)
        end

    infix "-" (other: VECTOR_3R): VECTOR_3R
            -- Subtraction
        require
            other_attached: other /= Void
        do
            create Result.make (x - other.x, y - other.y, z - other.z)
        end

    infix "*" (scalar: REAL): VECTOR_3R
            -- Scalar multiplication
        do
            create Result.make (x * scalar, y * scalar, z * scalar)
        end

    infix "/" (scalar: REAL): VECTOR_3R
            -- Scalar division
        require
            scalar_non_zero: scalar /= 0.0
        do
            create Result.make (x / scalar, y / scalar, z / scalar)
        end

    dot_product (other: VECTOR_3R): REAL
            -- Dot product
        require
            other_attached: other /= Void
        do
            Result := x * other.x + y * other.y + z * other.z
        end

    cross_product (other: VECTOR_3R): VECTOR_3R
            -- Cross product (returns perpendicular vector).
        require
            other_attached: other /= Void
        do
            create Result.make (
                y * other.z - z * other.y,
                z * other.x - x * other.z,
                x * other.y - y * other.x
            )
        end

    lerp (target: VECTOR_3R; t: REAL): VECTOR_3R
            -- Linear interpolation.
        require
            target_attached: target /= Void
            t_valid: t >= 0.0 and t <= 1.0
        do
            create Result.make (
                x + (target.x - x) * t,
                y + (target.y - y) * t,
                z + (target.z - z) * t
            )
        end

feature -- Output

    to_string: STRING
        do
            create Result.make_from_string ("(" + x.out + ", " + y.out + ", " + z.out + ")")
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
end -- REAL VECTOR 3
