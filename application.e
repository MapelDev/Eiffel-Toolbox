note
    description : "A game created in Eiffel."
    author      : ""
    generator   : "Eiffel Game2 Project Wizard"
    date        : "2024-11-07 03:10:32.761 +0000"
    revision    : "0.1"

class
    APPLICATION
inherit
	GAME_LIBRARY_SHARED		-- To use `game_library'

create
    make

feature {NONE} -- Initialization

    make
            -- Running the game.
        local
			l_engine:ENGINE
        do
            game_library.enable_video -- Enable the video functionalities
			create l_engine.make
			if not l_engine.has_error then
				l_engine.run
			end
        end

end
