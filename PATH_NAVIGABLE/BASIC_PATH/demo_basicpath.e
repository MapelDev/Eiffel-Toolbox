note
    description: "Demonstration de l'utilisation du Basic Path"
    author: "Florent Perreault"
    date: "11-7-2024"
    revision: "1.0"
class
    DEMO_BASICPATH
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
        nav_agent.movement_speed := 200
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
        nav_lerp_demo.add_node(create {NAV_NODE}.make(0, 0))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(100, 100))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(100, 250))
        init_path_sine
        nav_lerp_demo.add_node(create {NAV_NODE}.make(800, 250))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(500, 500))
        init_path_rand
        nav_lerp_demo.add_node(create {NAV_NODE}.make(250, 250))
    end

    init_path_sine
        -- these are nodes that connects x100 to x800 using a pre-calculated sine wave function, however
        -- these points are only at the apex and period resulting in visualitation looking more like a saw
        -- wave than a sine, but you could add more nodes into this stack to increase the acuracy and since
        -- we are using a speed variable instead of being frame dependant it shouldnt increase travel time.
    do
        nav_lerp_demo.add_node(create {NAV_NODE}.make(100, 250))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(125, 270))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(150, 250))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(175, 230))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(200, 250))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(225, 270))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(250, 250))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(275, 230))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(300, 250))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(325, 270))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(350, 250))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(375, 230))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(400, 250))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(425, 270))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(450, 250))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(475, 230))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(500, 250))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(525, 270))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(550, 250))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(575, 230))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(600, 250))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(625, 270))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(650, 250))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(675, 230))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(700, 250))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(725, 270))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(750, 250))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(775, 230))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(800, 250))
    end

    init_path_rand
        -- these nodes are random positions from 500,500 within a set radius
    local
    do
        -- 300px radius
        nav_lerp_demo.add_node(create {NAV_NODE}.make(671, 550))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(633, 472))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(372, 598))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(500, 499))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(634, 520))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(709, 673))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(496, 497))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(617, 517))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(471, 515))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(427, 701))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(463, 327))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(527, 452))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(437, 442))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(677, 545))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(670, 529))
        -- 50 px radius
        nav_lerp_demo.add_node(create {NAV_NODE}.make(513, 508))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(517, 486))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(505, 481))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(484, 499))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(482, 511))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(501, 500))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(497, 499))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(548, 507))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(500, 464))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(514, 479))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(495, 506))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(479, 460))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(502, 515))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(505, 530))
        nav_lerp_demo.add_node(create {NAV_NODE}.make(504, 508))

    end


feature -- Access
    update(a_timestamp: NATURAL_32)
    do
        -- This calls the navigable agent to update its position along the path per frame.
		-- If you have multiple agents/objects: you have to make a list/array of them, then loop
		-- across all of them and call their update methods. you could also call this method
		-- from outside the iteration loop provided that the timestamp parameter stays as the current time (`now`) in MS.
		--
        -- across navigables as nvg loop
        -- navigables.update(a_timestamp)
        -- end
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
			Github: http://www.gitlab.com/MapelSiroup/Eiffel-Toolbox
		]"
end -- class DEMO_BASICPATH
