note
    description: "Demonstration de l'utilisation du Basic Path Circles"
    author: "Florent Perreault"
    date: "11-7-2024"
    revision: "1.0"
class
    DEMO_BASICPATH_CIRCLE
create
    make
feature {NONE}
    make(a_renderer: GAME_RENDERER) -- rendering for debugging/visualisation purposes
    do
    	renderer_ref := a_renderer
        create nav_lerp_demo.make

        -- Setup Path Nodes
        initialise_path

        -- Initialise the demo with a new navigable object
		create nav_agent.make(nav_lerp_demo)

		-- Init colors
		create bg_color.make (50, 50, 50, 255)
		create nav_agent_dbg_color.make (255, 255, 255, 255)

        -- Pathing Config
        nav_agent.movement_speed := 150
        nav_lerp_demo.is_loop := true

        -- Register an agent to be called when the path is completed (WIP)
        nav_lerp_demo.add_on_complete_agent(on_path_completed)
    end

    on_path_completed: detachable PROCEDURE[ANY]
        do
            print("Path completed!%N")
            -- Add any other actions you want to perform when the path is completed
        end

    initialise_path
    do
        -- Initialize nodes
        nav_lerp_demo.add_node(create {NAV_NODE}.make(50,80))
        init_path_circle(300, 400, 100)
    end

    init_path_circle(centre_x, centre_y, radius: INTEGER)
        -- these are nodes that connect into a circular shape
    local
            diameter: INTEGER
            x, l_x, y, tx, ty: INTEGER
            error: INTEGER
    do
        diameter := radius * 2
        x := radius - 1
        y := 0
        tx := 1
        ty := 1
        error := tx - diameter

        from l_x := x until l_x >= y loop
            -- Make a point at every octant vertex position of the circle
            nav_lerp_demo.add_node(create {NAV_NODE}.make((centre_x + l_x), (centre_y - y)))
            nav_lerp_demo.add_node(create {NAV_NODE}.make((centre_x + l_x), (centre_y + y)))
            nav_lerp_demo.add_node(create {NAV_NODE}.make((centre_x - l_x), (centre_y - y)))
            nav_lerp_demo.add_node(create {NAV_NODE}.make((centre_x - l_x), (centre_y + y)))
            nav_lerp_demo.add_node(create {NAV_NODE}.make((centre_x + y), (centre_y - l_x)))
            nav_lerp_demo.add_node(create {NAV_NODE}.make((centre_x + y), (centre_y + l_x)))
            nav_lerp_demo.add_node(create {NAV_NODE}.make((centre_x - y), (centre_y - l_x)))
            nav_lerp_demo.add_node(create {NAV_NODE}.make((centre_x - y), (centre_y + l_x)))

            if error <= 0 then
                y := y + 1
                error := error + ty
                ty := ty + 2
            end

            if error > 0 then
                l_x := l_x - 1
                tx := tx + 2
                error := error + (tx - diameter)
            end
        end
        --nav_lerp_demo.add_node(create {NAV_NODE}.make(100, 250))
    end


feature -- Access
    update(a_timestamp: NATURAL_32)
    do
        -- This calls the navigable agent to update its position along the path per frame.
		-- If you have multiple agents/objects: you have to make a list/array of them, then loop
		-- across all of them and call their update methods. you could also call this method
		-- from outside the iteration loop provided that the timestamp parameter stays as the current time (`now`) in MS.
		nav_agent.update(a_timestamp)

		-- this is to visualise where the agent goes
		renderer_ref.set_drawing_color(nav_agent_dbg_color)
		renderer_ref.draw_line(nav_agent.current_node.x, nav_agent.current_node.y, nav_agent.target_node.x, nav_agent.target_node.y)
		renderer_ref.draw_filled_rectangle(nav_agent.x - 3, nav_agent.y - 3, 7, 7)
		renderer_ref.set_drawing_color(bg_color)
    end

feature {NONE}

	renderer_ref: GAME_RENDERER
		-- renderer reference for visualisation of the path taken

	nav_lerp_demo: NAV_PATH
		-- LERP demo Path component

	nav_agent: NAVIGABLE
		-- LERP demo movable Agent/Object Component

	bg_color: GAME_COLOR
		-- Default background color of the window

	nav_agent_dbg_color: GAME_COLOR
		-- Debug color for lerp_nav_agent demo

note
	copyright: "Copyright (c) 2024, Florent Perreault"
	license:   "MIT"
	source: "[
			Eiffel Toolbox,
			Github: https://github.com/MapelSiroup/Eiffel-Toolbox
		]"
end -- class DEMO_BASICPATH
