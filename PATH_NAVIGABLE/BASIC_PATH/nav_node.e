note
    description: "Une position 2D avec des coordonnées x et y. Qui est sur le chemin d'un path"
    author: "Florent Perreault"
    date: "11-7-2024"
    revision: "1.0"
class
    NAV_NODE
create
    make

feature {NONE} -- Initialization

    make(a_x, a_y: INTEGER)
        -- Initialise le vecteur avec des coordonnées x et y.
        do
            x := a_x
            y := a_y
        end

feature -- Access

    x: INTEGER assign set_x
        -- Coordonnée x du noeud.

    y: INTEGER assign set_y
        -- Coordonnée y du noeud.

feature -- Implementation

    set_x(a_value: INTEGER)
        -- Définit la valeur de x.
        do
            x := a_value
        ensure
		    is_assign: x = a_value
        end

    set_y(a_value: INTEGER)
        -- Définit la valeur de y.
        do
            y := a_value
        ensure
		    is_assign: y = a_value
        end

note
	copyright: "Copyright (c) 2024, Florent Perreault"
	license:   "MIT"
	source: "[
			Eiffel Toolbox, 
			Github: https://github.com/MapelSiroup/Eiffel-Toolbox
		]"
end -- class NAV_NODE
