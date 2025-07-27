note
	description: "2D Vector Class, with most vector operations."
	author: "FLORENT PERREAULT"
	date: "1/18/2023"
	revision: "$Revision$"
	todo: "1) This is not a fully functional class, some things dont make sense yet but most of it is there"

class
	VEC2

create
    make,
    make_vec2,
    make_from_vec

feature -- Attributes

    x: DOUBLE assign set_x
    y: DOUBLE assign set_y

feature -- Initialization

    make
        do
            x := 0.0
            y := 0.0
        end

    make_vec2 (a_x, a_y: DOUBLE)
        do
            x := a_x
            y := a_y
        end

    make_from_vec (v: VEC2)
        do
            x := v.x
            y := v.y
        end

feature -- Access

    set_values (a_x, a_y: DOUBLE)
        do
            x := a_x
            y := a_y
        ensure
			is_assign: x = a_x and y = a_y
        end
	set_x (a_x: DOUBLE)
        do
            x := a_x
        ensure
			is_assign: x = a_x
        end
	set_y (a_y: DOUBLE)
        do
            y := a_y
        ensure
			is_assign: y = a_y
        end
    set_from_vec (v: VEC2)
        do
            x := v.x
            y := v.y
        ensure
			is_assign: x = v.x and y = v.y
        end

feature -- Operations

	trim_floatingpoint_innaccuracies(a_value: REAL_64;a_tolerance:REAL_32):REAL_64
	do
		if (a_value + a_tolerance) > a_value.abs then
			--near ceil
			result := a_value.ceiling--.sign * (a_value.abs + a_tolerance).floor
		elseif (a_value - a_tolerance) < a_value.abs then
			--near floor
			result := a_value.floor--.sign * (a_value.abs - a_tolerance)
		else
			result := a_value
		end
	end

    rotate_degrees (a_angle: DOUBLE)
        -- deprecated use rotate_direction instead
        local
            nx, ny: DOUBLE
        do
            nx := x * {DOUBLE_MATH}.cosine (a_angle) - y * {DOUBLE_MATH}.sine (a_angle)
            ny := x * {DOUBLE_MATH}.sine (a_angle) + y * {DOUBLE_MATH}.cosine (a_angle)
            nx := trim_floatingpoint_innaccuracies(nx, 0.0001)
            ny := trim_floatingpoint_innaccuracies(ny, 0.0001)
            set_values (nx, ny)
        end

    rotate(a_angle: DOUBLE)
    -- use this instead of VEC2.rotate_degrees because this one uses radians which is what double math expects. also better for cartesian manipulations.
        local
            nx, ny,conv_rad: DOUBLE
        do
            conv_rad := (360 - a_angle) * {MATH_CONST}.PI / 180.0 -- Convert degrees to radians
            nx := x * {DOUBLE_MATH}.cosine (conv_rad) - y * {DOUBLE_MATH}.sine (conv_rad)
            ny := x * {DOUBLE_MATH}.sine (conv_rad) + y * {DOUBLE_MATH}.cosine (conv_rad)
            nx := trim_floatingpoint_innaccuracies(nx, 0.0001)
            ny := trim_floatingpoint_innaccuracies(ny, 0.0001)
            set_values (nx, ny)
        end

    translate (a_x, a_y: DOUBLE)
        do
            set_values (x + a_x, y + a_y)
        end
    translate_vec (a_vec: VEC2)
        do
            set_values (x + a_vec.x, y + a_vec.y)
        end

    scale(s: DOUBLE)
        do
            set_values (x * s, y * s)
        end

    add (vec: VEC2)
        local
            nx, ny: DOUBLE
        do
            nx := x + vec.x
            ny := y + vec.y
            set_values (nx, ny)
        end

    subtract (vec: VEC2)
        local
            nx, ny: DOUBLE
        do
            nx := x - vec.x
            ny := y - vec.y
            set_values (nx, ny)
        end

    perp
        do
            set_values (-y, x)
        end

feature -- Queries

    dot alias "|*" (a_vec: VEC2): DOUBLE
        do
            Result := x * a_vec.x + y * a_vec.y
        end

    cross (vec: VEC2): DOUBLE
        do
            Result := x * vec.y - y * vec.x
        end

    get_length: DOUBLE
        do
            Result := {DOUBLE_MATH}.sqrt(x * x + y * y)
        end

    normalize
        local
            length, den: DOUBLE
        do
            length := get_length
            if length /= 0.0 then
                den := 1 / length
                x := x * den
                y := y * den
            end
        end

    get_relative_angle_between (vec: VEC2): DOUBLE
        do
            Result := get_sign (vec) * {DOUBLE_MATH}.arc_cosine(dot(vec) / (get_length * vec.get_length))
        end

    get_sign (vec: VEC2): INTEGER
        do
            Result := if (y * vec.x > x * vec.y) then -1 else 1 end
        end

feature -- String representation

    to_string: STRING
        do
            create Result.make_from_string ("Vec2{x=" + x.out + ", y=" + y.out + "}")
        end

   	to_coord: STRING
   		do
            create Result.make_from_string ("{X:" + x.out + ", Y:" + y.out + "}")
        end
        
note
	copyright: "Copyright (c) 2024, Florent Perreault"
	license:   "MIT"
	source: "[
			Eiffel Toolbox, 
			Github: https://github.com/MapelSiroup/Eiffel-Toolbox
		]"
end -- class VEC2
