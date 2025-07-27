note
    description: "Un interpolation de type lineaire."
    author: "Florent Perreault"
    date: "11-7-2024"
    revision: "1.0"

class
    LINEAR_INTERPOLATION

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
            Result := interpolate_linear(points[segment_index], points[segment_index + 1], t.frac)
        end

feature -- Implementation

    points: ARRAY[TUPLE[x, y: REAL_64]]

    interpolate_linear(p1, p2: TUPLE[x, y: REAL_64]; t: REAL_64): TUPLE[x, y: REAL_64]
        do
            Result := [p1.x + (p2.x - p1.x) * t, p1.y + (p2.y - p1.y) * t]
        end

note
	copyright: "Copyright (c) 2024, Florent Perreault"
	license:   "MIT"
	source: "[
			Eiffel Toolbox,
			Github: https://github.com/MapelSiroup/Eiffel-Toolbox
		]"
end