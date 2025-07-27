class
    CUBIC_INTERPOLATION

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
            Result := interpolate_cubic(
                points[segment_index],
                points[segment_index + 1],
                points[segment_index + 2],
                points[segment_index + 3],
                t.frac
            )
        end

feature -- Implementation

    points: ARRAY[TUPLE[x, y: REAL_64]]

    interpolate_cubic(p0, p1, p2, p3: TUPLE[x, y: REAL_64]; t: REAL_64): TUPLE[x, y: REAL_64]
        local
            t2, t3: REAL_64
        do
            t2 := t * t
            t3 := t2 * t
            Result := [
                (-0.5 * t3 + t2 - 0.5 * t) * p0.x +
                (1.5 * t3 - 2.5 * t2 + 1) * p1.x +
                (-1.5 * t3 + 2 * t2 + 0.5 * t) * p2.x +
                (0.5 * t3 - 0.5 * t2) * p3.x,
                (-0.5 * t3 + t2 - 0.5 * t) * p0.y +
                (1.5 * t3 - 2.5 * t2 + 1) * p1.y +
                (-1.5 * t3 + 2 * t2 + 0.5 * t) * p2.y +
                (0.5 * t3 - 0.5 * t2) * p3.y
            ]
        end

end