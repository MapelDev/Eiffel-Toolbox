note
    description: "Un chemin traversable composé de noeuds."
    author: "Florent Perreault"
    date: "11-7-2024"
    revision: "1.0"
class
    NAV_PATH
create
    make
feature {NONE} -- Initialization

    make
        -- Initialise le chemin vide.
        do
            create nodes.make
        end

feature -- Access

    nodes: LINKED_LIST[NAV_NODE]
        -- Liste des noeuds du chemin.

	--
	--	OPTIONAL PARAMETERS
	--
    is_loop: BOOLEAN assign set_is_loop
    	-- should we loop back to the beginning?
    chemin_width: INTEGER
        -- Width du chemin

feature -- Implementation

    start_node: NAV_NODE
        -- Premier noeud du chemin.
        require
            not_empty: not nodes.is_empty
        do
            Result := nodes.first
        end

    next_node(a_current_node: NAV_NODE): NAV_NODE
        -- Prochain nœud après le noeud courant.
        local
            index: INTEGER
        do
            index := nodes.index_of(a_current_node, 1)
            if index + 1 > nodes.count then
                if is_loop then
                	Result := nodes.first
                else
                	Result := nodes.last
                end

            else
                Result := nodes.at(index + 1)
            end
        ensure
            result_attached: attached Result
        end

    add_node(a_new_node: NAV_NODE)
        -- Ajoute un nouveau noeud à la fin du chemin.
        do
            nodes.extend(a_new_node)
        end

feature -- LAMBDAs
    add_on_complete_agent(a_agent: detachable PROCEDURE [ANY])
        -- Add an agent to be called when the path is completed
        do
            if attached a_agent then
                on_complete_agents.extend(a_agent)
            end
        end

    complete_path
        -- Call all registered agents when the path is completed
        local
            i: INTEGER
        do
            from
                i := 1
            until
                i > on_complete_agents.count
            loop
                if attached on_complete_agents[i] as l_agent then
                    l_agent.call([Void])
                end
                i := i + 1
            end
        end

feature -- Setters
    set_is_loop(a_value:BOOLEAN)
	do
		is_loop := a_value
	ensure
		is_assign: is_loop = a_value
	end

feature {NONE} -- Private Attribute
    on_complete_agents: ARRAYED_LIST[PROCEDURE [ANY]]
        -- Array of agents to be called when the path is completed
        once
            create Result.make(0)
        end

note
	copyright: "Copyright (c) 2024, Florent Perreault"
	license:   "MIT"
	source: "[
			Eiffel Toolbox, 
			Github: https://github.com/MapelSiroup/Eiffel-Toolbox
		]"
end -- class
