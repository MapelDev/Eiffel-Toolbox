class
    VECTOR_3I

create
    make, make_zero, make_one

feature -- Access

    x: INTEGER
    y: INTEGER
    z: INTEGER

    magnitude: REAL
            -- Length of the vector.
        do
            Result := ((x * x) + (y * y) + (z * z)).sqrt
        ensure
            non_negative: Result >= 0.0
        end

    square_magnitude: INTEGER
            -- Squared length (faster than `magnitude`).
        do
            Result := (x * x) + (y * y) + (z * z)
        ensure
            non_negative: Result >= 0
        end

feature -- Creation

    make (a_x, a_y, a_z: INTEGER)
            -- Create a vector with given coordinates.
        do
            x := a_x
            y := a_y
            z := a_z
        ensure
            x_set: x = a_x
            y_set: y = a_y
            z_set: z = a_z
        end

    make_zero
            -- Create a (0,0,0) vector.
        do
            make (0, 0, 0)
        ensure
            is_zero: x = 0 and y = 0 and z = 0
        end

    make_one
            -- Create a (1,1,1) vector.
        do
            make (1, 1, 1)
        ensure
            is_one: x = 1 and y = 1 and z = 1
        end

feature -- Element Change

    set (a_x, a_y, a_z: INTEGER)
            -- Set new `x`, `y`, `z` values.
        do
            x := a_x
            y := a_y
            z := a_z
        ensure
            x_set: x = a_x
            y_set: y = a_y
            z_set: z = a_z
        end

    scale (scale_vector: VECTOR_3I)
            -- Scale this vector component-wise.
        require
            scale_vector_attached: scale_vector /= Void
        do
            x := x * scale_vector.x
            y := y * scale_vector.y
            z := z * scale_vector.z
        ensure
            scaled: x = old x * scale_vector.x and
                    y = old y * scale_vector.y and
                    z = old z * scale_vector.z
        end

    clamp (min_vector, max_vector: VECTOR_3I)
            -- Clamp components between min and max vectors.
        require
            min_vector_attached: min_vector /= Void
            max_vector_attached: max_vector /= Void
        do
            x := x.max (min_vector.x).min (max_vector.x)
            y := y.max (min_vector.y).min (max_vector.y)
            z := z.max (min_vector.z).min (max_vector.z)
        end

feature -- Comparison

    is_equal (other: VECTOR_3I): BOOLEAN
            -- Are vectors exactly equal?
        require
            other_attached: other /= Void
        do
            Result := x = other.x and y = other.y and z = other.z
        end

    is_greater (other: VECTOR_3I): BOOLEAN
            -- Greater by magnitude.
        require
            other_attached: other /= Void
        do
            Result := square_magnitude > other.square_magnitude
        end

    is_lesser (other: VECTOR_3I): BOOLEAN
            -- Lesser by magnitude.
        require
            other_attached: other /= Void
        do
            Result := square_magnitude < other.square_magnitude
        end

feature -- Operators

    infix "+" (other: VECTOR_3I): VECTOR_3I
            -- Addition
        require
            other_attached: other /= Void
        do
            create Result.make (x + other.x, y + other.y, z + other.z)
        ensure
            result_attached: Result /= Void
        end

    infix "-" (other: VECTOR_3I): VECTOR_3I
            -- Subtraction
        require
            other_attached: other /= Void
        do
            create Result.make (x - other.x, y - other.y, z - other.z)
        ensure
            result_attached: Result /= Void
        end

    infix "*" (scalar: INTEGER): VECTOR_3I
            -- Scalar multiplication
        do
            create Result.make (x * scalar, y * scalar, z * scalar)
        ensure
            result_attached: Result /= Void
        end

    infix "/" (scalar: INTEGER): VECTOR_3I
            -- Scalar division
        require
            scalar_non_zero: scalar /= 0
        do
            create Result.make (x // scalar, y // scalar, z // scalar)
        ensure
            result_attached: Result /= Void
        end

feature -- Output

    to_string: STRING
            -- Text representation "(x, y, z)"
        do
            create Result.make_from_string ("(" + x.out + ", " + y.out + ", " + z.out + ")")
        ensure
            result_attached: Result /= Void
        end

feature -- Static Utilities

    frozen distance (a, b: VECTOR_3I): REAL
            -- Distance between two 3D vectors.
        require
            a_attached: a /= Void
            b_attached: b /= Void
        do
            Result := ((a.x - b.x) * (a.x - b.x) +
                       (a.y - b.y) * (a.y - b.y) +
                       (a.z - b.z) * (a.z - b.z)).sqrt
        ensure
            non_negative: Result >= 0.0
        end

    frozen min (a, b: VECTOR_3I): VECTOR_3I
            -- Component-wise minimum
        require
            a_attached: a /= Void
            b_attached: b /= Void
        do
            create Result.make (a.x.min (b.x), a.y.min (b.y), a.z.min (b.z))
        ensure
            result_attached: Result /= Void
        end

    frozen max (a, b: VECTOR_3I): VECTOR_3I
            -- Component-wise maximum
        require
            a_attached: a /= Void
            b_attached: b /= Void
        do
            create Result.make (a.x.max (b.x), a.y.max (b.y), a.z.max (b.z))
        ensure
            result_attached: Result /= Void
        end

invariant
    -- Always valid vector
    valid_coordinates: True

note
	copyright: "Copyright (c) 2025, KontinuumGames"
	license:   "MIT, redistributable, keep author references"
	source: "[
			Eiffel Toolbox,
			Github: https://github.com/MapelSiroup/Eiffel-Toolbox
		]"
end -- INTEGER VECTOR3
