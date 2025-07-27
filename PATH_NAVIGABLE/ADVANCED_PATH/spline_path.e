note
    description: "Un chemin traversable de type spline composé de noeuds."
    author: "Florent Perreault"
    date: "11-10-2024"
    revision: "1.0"

class
    SPLINE_PATH

create
    make

feature -- Creation

    make(a_points: ARRAY[TUPLE[x, y: REAL_64]])
        do
            points := a_points
            create interpolation.make_empty
        end

feature -- Access

    set_interpolation(a_type: STRING)
        do
            if a_type.is_equal("linear") then
                interpolation := {LINEAR_INTERPOLATION}.make(points)
            elseif a_type.is_equal("cubic") then
                interpolation := {CUBIC_INTERPOLATION}.make(points)
            else
                interpolation := {CUSTOM_INTERPOLATION}.make(points)
            end
        end

    evaluate(t: REAL_64): TUPLE[x, y: REAL_64]
        do
            Result := interpolation.evaluate(t)
        end

feature -- Implementation

    points: ARRAY[TUPLE[x, y: REAL_64]]
    interpolation: INTERPOLATION

note
	copyright: "Copyright (c) 2024, Florent Perreault"
	license:   "MIT"
	source: "[
			Eiffel Toolbox,
			Github: https://github.com/MapelSiroup/Eiffel-Toolbox
		]"
end