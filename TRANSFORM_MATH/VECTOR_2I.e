class
    VECTOR_2I

create
    make, make_zero, make_one

feature -- Access

    x: INTEGER
    y: INTEGER

    magnitude: REAL
            -- Length of the vector.
        do
            Result := ((x * x) + (y * y)).sqrt
        ensure
            non_negative: Result >= 0.0
        end

    square_magnitude: INTEGER
            -- Squared length of the vector (faster than `magnitude`).
        do
            Result := (x * x) + (y * y)
        ensure
            non_negative: Result >= 0
        end

feature -- Creation

    make (a_x, a_y: INTEGER)
            -- Create a new vector with given `a_x` and `a_y`.
        do
            x := a_x
            y := a_y
        ensure
            x_set: x = a_x
            y_set: y = a_y
        end

    make_zero
            -- Create a (0, 0) vector.
        do
            make (0, 0)
        ensure
            is_zero: x = 0 and y = 0
        end

    make_one
            -- Create a (1, 1) vector.
        do
            make (1, 1)
        ensure
            is_one: x = 1 and y = 1
        end

feature -- Element Change

    set (a_x, a_y: INTEGER)
            -- Set new `x` and `y` values.
        do
            x := a_x
            y := a_y
        ensure
            x_set: x = a_x
            y_set: y = a_y
        end

    scale (scale_vector: VECTOR_2I)
            -- Scale this vector by another vector component-wise.
        require
            scale_vector_attached: scale_vector /= Void
        do
            x := x * scale_vector.x
            y := y * scale_vector.y
        ensure
            scaled: x = old x * scale_vector.x and y = old y * scale_vector.y
        end

    clamp (min_vector, max_vector: VECTOR_2I)
            -- Clamp components between min and max vectors.
        require
            min_vector_attached: min_vector /= Void
            max_vector_attached: max_vector /= Void
        do
            x := x.max (min_vector.x).min (max_vector.x)
            y := y.max (min_vector.y).min (max_vector.y)
        end

feature -- Rotation

    rotate (angle_radians: REAL)
            -- Rotate this vector around the origin (0, 0) by `angle_radians`.
        do
            rotate_around (angle_radians, create {VECTOR_2I}.make_zero)
        end

    rotate_around (angle_radians: REAL; center: VECTOR_2I)
            -- Rotate around a specific `center` point by `angle_radians`.
        require
            center_attached: center /= Void
        local
            cos_theta, sin_theta: REAL
            dx, dy: REAL
            new_x, new_y: REAL
        do
            cos_theta := angle_radians.cos
            sin_theta := angle_radians.sin

            dx := x - center.x
            dy := y - center.y

            new_x := dx * cos_theta - dy * sin_theta
            new_y := dx * sin_theta + dy * cos_theta

            x := (new_x + center.x).rounded
            y := (new_y + center.y).rounded
        end

    rotate_degrees (angle_degrees: REAL)
            -- Rotate by degrees around origin.
        do
            rotate (angle_degrees * {MATH_CONST}.pi / 180.0)
        end

    rotate_around_degrees (angle_degrees: REAL; center: VECTOR_2I)
            -- Rotate by degrees around center.
        do
            rotate_around (angle_degrees * {MATH_CONST}.pi / 180.0, center)
        end

feature -- Comparison

    is_equal (other: VECTOR_2I): BOOLEAN
            -- Are vectors exactly equal?
        require
            other_attached: other /= Void
        do
            Result := x = other.x and y = other.y
        end

    is_greater (other: VECTOR_2I): BOOLEAN
            -- Is this vector greater (magnitude) than `other`?
        require
            other_attached: other /= Void
        do
            Result := square_magnitude > other.square_magnitude
        end

    is_lesser (other: VECTOR_2I): BOOLEAN
            -- Is this vector lesser (magnitude) than `other`?
        require
            other_attached: other /= Void
        do
            Result := square_magnitude < other.square_magnitude
        end

feature -- Operators

    infix "+" (other: VECTOR_2I): VECTOR_2I
            -- Addition
        require
            other_attached: other /= Void
        do
            create Result.make (x + other.x, y + other.y)
        ensure
            result_attached: Result /= Void
        end

    infix "-" (other: VECTOR_2I): VECTOR_2I
            -- Subtraction
        require
            other_attached: other /= Void
        do
            create Result.make (x - other.x, y - other.y)
        ensure
            result_attached: Result /= Void
        end

    infix "*" (scalar: INTEGER): VECTOR_2I
            -- Scalar multiplication
        do
            create Result.make (x * scalar, y * scalar)
        ensure
            result_attached: Result /= Void
        end

    infix "/" (scalar: INTEGER): VECTOR_2I
            -- Scalar division
        require
            scalar_non_zero: scalar /= 0
        do
            create Result.make (x // scalar, y // scalar)
        ensure
            result_attached: Result /= Void
        end

feature -- Output

    to_string: STRING
            -- Text representation "(x, y)"
        do
            create Result.make_from_string ("(" + x.out + ", " + y.out + ")")
        ensure
            result_attached: Result /= Void
        end

feature -- Static Utilities

    frozen distance (a, b: VECTOR_2I): REAL
            -- Distance between two vectors.
        require
            a_attached: a /= Void
            b_attached: b /= Void
        do
            Result := ((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y)).sqrt
        ensure
            non_negative: Result >= 0.0
        end

    frozen min (a, b: VECTOR_2I): VECTOR_2I
            -- Component-wise minimum
        require
            a_attached: a /= Void
            b_attached: b /= Void
        do
            create Result.make (a.x.min (b.x), a.y.min (b.y))
        ensure
            result_attached: Result /= Void
        end

    frozen max (a, b: VECTOR_2I): VECTOR_2I
            -- Component-wise maximum
        require
            a_attached: a /= Void
            b_attached: b /= Void
        do
            create Result.make (a.x.max (b.x), a.y.max (b.y))
        ensure
            result_attached: Result /= Void
        end

invariant
    -- Always valid vector
    valid_coordinates: True

end
