note
	description: "ENGINE is the class that handles game events and handles the rendering of the application"
	author: "Florent Perreault"
	date: "11/9/24"
	revision: "1.0.0"

class
	ENGINE

inherit
	GAME_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialization
	old_timestamp:NATURAL_32
			-- Dernier timestamp recu du frames counter
	make
			-- Initialization de `Current'
		local
			l_window_builder:GAME_WINDOW_RENDERED_BUILDER
		do
			old_timestamp := 0
			create l_window_builder
			l_window_builder.set_dimension (1024, 768)	-- Width, Height
			l_window_builder.enable_must_renderer_synchronize_update	-- Ask to the video card to manage the frame synchronisation (FPS)
			window := l_window_builder.generate_window

			-- Initialise the demos
			create lerp_demo.make(window.renderer)
			create lerp_demo_circle.make(window.renderer)
			create vec2_demo.make(window.renderer)
		end
feature -- Access

	run
			-- Lance le jeu si aucune erreur est detecter.
		require
			No_Error: not has_error
		do
			game_library.quit_signal_actions.extend (agent on_quit)
			window.key_pressed_actions.extend (agent on_key_pressed)
			window.key_released_actions.extend (agent on_key_released)
			game_library.iteration_actions.extend (agent on_iteration)
			if window.renderer.driver.is_present_synchronized_supported then	-- If the Video card accepted the frame synchronisation (FPS)
				game_library.launch_no_delay									-- Don't let the library managed the frame synchronisation
			else
				game_library.launch
			end
		end


	has_error:BOOLEAN
			-- `True' if an error occured during the creation of `Current'

	window:GAME_WINDOW_RENDERED
			-- The window to draw the scene

feature {NONE} -- Implementation

	on_iteration(a_timestamp:NATURAL_32)
			-- Event that is launched at each iteration.
		do
			-- clear the screen from last iteration
			window.renderer.clear
			-- Launches the Lerp Demo
			lerp_demo.update(a_timestamp)
			--lerp_demo_circle.update(a_timestamp)


			-- Update titlebar
			window.set_title ("EIFFEL-TOOLBOX (DEMO-PREVIEW) " + "FPS: " + (1/((a_timestamp - old_timestamp)/1000)).floor.out)

			--Update window renderer
			window.renderer.present		-- Update modification in the screen
			old_timestamp := a_timestamp	--Set old_timestamp to current timestamp
		end

	on_key_pressed(a_timestamp: NATURAL_32; a_key_event: GAME_KEY_EVENT)
			-- Action when a keyboard key has been pushed
			-- @params a_timestamp : le timestamp courrant
			-- @params a_key_event : SDL2 key event (key code)
		do
			if not a_key_event.is_repeat then		-- Be sure that the event is not only an automatic repetition of the key
			end
		end

	on_key_released(a_timestamp: NATURAL_32; a_key_event: GAME_KEY_EVENT)
			-- Action when a keyboard key has been released
			-- @params a_timestamp : le timestamp courrant
			-- @params a_key_event : SDL2 key event (key code)
		do
			if not a_key_event.is_repeat then		-- Be sure that the event is not only an automatic repetition of the key
			end
		end

	on_quit(a_timestamp: NATURAL_32)
			-- This method is called when the quit signal is sent to the application (ex: window X button pressed).
			-- @params a_timestamp : le moment present
		do
			game_library.stop  -- Stop the controller loop (allow game_library.launch to return)
		end

feature {NONE} -- Attributes
	lerp_demo: DEMO_BASICPATH
		-- Lerp Demo
	lerp_demo_circle: DEMO_BASICPATH_CIRCLE
		-- Lerp Circle Demo
	vec2_demo: VEC_DEMO
		-- Vector Demo

note
	copyright: "Copyright (c) 2024, Florent Perreault"
	license:   "MIT"
	source: "[
			Eiffel Toolbox, 
			Github: https://github.com/MapelSiroup/Eiffel-Toolbox
		]"
end	-- CLASS ENGINE
