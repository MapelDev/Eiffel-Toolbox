note
    description: "Une entité qui se déplace le long d'un chemin."
    author: "Florent Perreault"
    date: "11-7-2024"
    revision: "1.0"
class
    NAVIGABLE
create
    make

feature {NONE} -- Initialization

        make(a_path: NAV_PATH)
            -- Initialise l'objet à partir d'une position de départ d'un chemin.
            do
                --  ...  --
                current_node := a_path.start_node
                if a_path.nodes.count > 0 then
                    x := current_node.x
                    y := current_node.y
                    target_node := a_path.next_node(current_node)
                else
                    x := 0
                    y := 0
                    target_node := create {NAV_NODE}.make(0,0)
                end

                path := a_path
                movement_speed := 100 --en pixels par seconde
                interpolation_progress := 0.0
            end

feature -- Access

        current_node: NAV_NODE
            -- Noeud actuel du chemin.

        target_node: NAV_NODE
            -- Prochain noeud cible du chemin.

        movement_speed: REAL assign set_movement_speed
            -- Vitesse de déplacement en unité par seconde.

        interpolation_progress: REAL_64
            -- Progrès de l'interpolation entre les noeuds (entre 0 et 1).

        x: INTEGER assign set_x
            -- Position X de l'objet

        y: INTEGER assign set_y
            -- Position Y de l'objet

feature -- Implementation

        update(a_timestamp: NATURAL_32)
            -- Met à jour la position de l'objet selon le temps écoulé.
            local
                delta_time: REAL_64
            do
                delta_time := ((a_timestamp - old_timestamp) / 1000.0)
                interpolate(delta_time)
                old_timestamp := a_timestamp
            end

        interpolate(a_delta_time: REAL_64)
            -- Interpole la position de l'objet vers le prochain noeud.
            do
                interpolation_progress := interpolation_progress + (movement_speed * a_delta_time) / distance(current_node, target_node)
                if interpolation_progress >= 1.0 then
                    current_node := target_node
                    target_node := path.next_node(target_node)
                    interpolation_progress := 0.0
                    -- est-ce que nous avons reach le dernier noeud
                    if reached_last_node then
                        path.complete_path
                    end
                    --print(reached_last_node.out + " at: " + "["+ current_node.x.out+","+current_node.y.out+"] to: ["+target_node.y.out+","+target_node.x.out+"]%N")
                end
                x := lerp(current_node.x, target_node.x, interpolation_progress).floor
                y := lerp(current_node.y, target_node.y, interpolation_progress).floor
            end

        distance(a_vec1, a_vec2: NAV_NODE): REAL_64
            -- Calcule la distance entre deux vecteurs.
            do
                Result := {DOUBLE_MATH}.sqrt((a_vec1.x - a_vec2.x)^2 + (a_vec1.y - a_vec2.y)^2)
            end

        lerp(a_start, a_end, a_progress: REAL_64): REAL_64
            -- Interpolation linéaire entre deux valeurs.
            do
                Result := a_start + (a_end - a_start) * a_progress
            end

        reached_last_node: BOOLEAN
            -- Check if the agent has reached the last node
            do
                Result := current_node = path.nodes.at(path.nodes.count)
            end

feature -- Setters

	set_x(a_x:INTEGER)
	do
		x := a_x
	ensure
		is_assign: x = a_x
	end

    set_y(a_y:INTEGER)
	do
		y := a_y
	ensure
		is_assign: y = a_y
	end

    set_movement_speed(a_value: REAL)
	do
		movement_speed := a_value
	ensure
		is_assign: movement_speed = a_value
	end

feature {NONE} -- Implementation

        path: NAV_PATH
            -- Chemin que l'objet doit suivre.

        old_timestamp: NATURAL_32
            -- Timestamp de la dernière mise à jour.

note
	copyright: "Copyright (c) 2024, Florent Perreault"
	license:   "MIT"
	source: "[
			Eiffel Toolbox, 
			Github: http://www.gitlab.com/MapelSiroup/Eiffel-Toolbox
		]"
end -- class NAVIGABLE
