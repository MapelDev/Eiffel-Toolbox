note
	description: "Demonstration of Vector Operations"
	author: "Florent Perreault"
	date: "$Date$"
	revision: "$Revision$"

class
	VEC_DEMO

create
	make

feature {NONE} -- Initialization

	make(a_renderer: GAME_RENDERER)
			-- Initialization for `Current'.
		local
			bg_color: GAME_COLOR
		do
			renderer_ref := a_renderer
			-- Set background color
            create bg_color.make (50, 50, 50, 255)

			--setup vectors
			create vec2d.make_vec2(100,150)
			create vec2d_1.make_vec2(300,250)

			launch_vec2_tests(bg_color)
		end
feature {NONE} -- Demos

	launch_vec2_tests(bg_color: GAME_COLOR)
	local
		angle_degrees: DOUBLE
	do
		angle_degrees := 45.75
		print(vec2d.get_relative_angle_between(vec2d_1).out + "%N")
		print(vec2d.to_coord +"difference between angles%N")
		print(vec2d.dot(vec2d_1).out +"dot product from vec2d_1%N")-- dot product
		vec2d.rotate(angle_degrees) -- rotate
		print(vec2d.to_coord+"rotated 45.75 degrees%N")
		vec2d.perp -- perpendicular vector
		print(vec2d.to_coord+"perp'd from vec2d_1%N")

			-- Set up rendering
            renderer_ref.set_drawing_color(bg_color)

            -- Draw background
            renderer_ref.draw_filled_rectangle(0, 0, 800, 600)

            -- Set up colors
            renderer_ref.set_drawing_color(create {GAME_COLOR}.make (255, 255, 255, 255))

            -- Draw initial vectors
            draw_vector(vec2d, 400, 300, 1)
            draw_vector(vec2d_1, 400, 300, -1)

            -- Rotate vec2d by 45 degrees
            angle_degrees := 45.75
            vec2d.rotate(angle_degrees)

            -- Draw rotated vector
            draw_vector(vec2d, 400, 300, 1)

            -- Draw dot product line
            draw_dot_product_line(vec2d, vec2d_1, 400, 300)

            -- Draw perpendicular vector
            draw_perpendicular(vec2d, 400, 300)
	end

	launch_vec3_tests
	do

	end
feature {NONE} -- Drawing helpers

    draw_vector(v: VEC2; origin_x, origin_y: INTEGER; scale_factor: DOUBLE)
        local
            scaled_x, scaled_y: INTEGER
        do
            scaled_x := origin_x + (v.x * scale_factor).rounded
            scaled_y := origin_y - (v.y * scale_factor).rounded
            renderer_ref.draw_line(origin_x, origin_y, scaled_x, scaled_y)
        end

    draw_dot_product_line(v1, v2: VEC2; origin_x, origin_y: INTEGER)
        local
            angle: DOUBLE
            cos_angle: DOUBLE
            sin_angle: DOUBLE
            length: DOUBLE
            scaled_length: INTEGER
        do
            angle := v1.get_relative_angle_between(v2)
            cos_angle := {DOUBLE_MATH}.cosine(angle)
            sin_angle := {DOUBLE_MATH}.sine(angle)
            length := v1.dot(v2) / (v1.get_length * v2.get_length)
            scaled_length := (length * 100).rounded

            renderer_ref.set_drawing_color(create {GAME_COLOR}.make (255, 255, 0, 255))
            renderer_ref.draw_line((origin_x + v1.x.rounded).to_integer, (origin_y - v1.y.rounded).to_integer,
                                  (origin_x + v1.x.rounded + scaled_length * cos_angle).floor,
                                  (origin_y - v1.y.rounded + scaled_length * sin_angle).floor)
        end

    draw_perpendicular(v: VEC2; origin_x, origin_y: INTEGER)
        local
            scaled_x, scaled_y: INTEGER
        do
            renderer_ref.set_drawing_color(create {GAME_COLOR}.make (255, 0, 0, 255))
            scaled_x := origin_x + v.x.rounded
            scaled_y := origin_y - v.y.rounded
            renderer_ref.draw_line(origin_x, origin_y, scaled_x, scaled_y)

            -- Draw perpendicular line
            renderer_ref.draw_line(scaled_x, scaled_y,
                                   scaled_x + (-v.y * 50).rounded,
                                   scaled_y + (v.x * 50).rounded)
        end

feature -- Attributes

	renderer_ref: GAME_RENDERER
		-- reference to the renderer

	vec2d, vec2d_1: VEC2
		-- 2D vector to do some testing with

	--vec3d, vec3d_1: VEC3

note
	copyright: "Copyright (c) 2024, Florent Perreault"
	license:   "MIT"
	source: "[
			Eiffel Toolbox, 
			Github: https://github.com/MapelSiroup/Eiffel-Toolbox
		]"
end
