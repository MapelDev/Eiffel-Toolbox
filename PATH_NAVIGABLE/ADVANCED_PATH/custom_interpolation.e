class
    CUSTOM_INTERPOLATION

inherit
    INTERPOLATION
create
    make

feature -- Creation

    make(a_points: ARRAY[TUPLE[x, y: REAL_64]])
        do
            points := a_points
        end

feature -- Access

    evaluate(t: REAL_64): TUPLE[x, y: REAL_64]
        local
            segment_index: INTEGER
        do
            segment_index := t.floor.to_integer * (points.count - 1)
            Result := interpolate_custom(points[segment_index], points[segment_index + 1], t.frac)
        end

feature -- Implementation

    points: ARRAY[TUPLE[x, y: REAL_64]]

    interpolate_custom(p1, p2: TUPLE[x, y: REAL_64]; t: REAL_64): TUPLE[x, y: REAL_64]
        local
            t2, t3: REAL_64
        do
            -- Implement your custom interpolation here
            -- This example uses a simple quadratic interpolation
            t2 := t * t
            t3 := t2 * t
            Result := [
                (2 * t3 - 3 * t2 + 1) * p1.x + (-2 * t3 + 3 * t2) * p2.x,
                (2 * t3 - 3 * t2 + 1) * p1.y + (-2 * t3 + 3 * t2) * p2.y
            ]
        end

end