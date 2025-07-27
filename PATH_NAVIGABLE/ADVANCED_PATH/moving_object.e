note
    description: "Un objet qui permet de traverser un chemin de type spline composé de noeuds."
    author: "Florent Perreault"
    date: "11-10-2024"
    revision: "1.0"

class
    MOVING_OBJECT

create
    make

feature -- Creation

    make(a_spline_path: SPLINE_PATH; a_speed: REAL_64)
        do
            spline_path := a_spline_path
            speed := a_speed
            position := spline_path.points.first
            time := 0
        end

feature -- Access

    update(delta_time: REAL_64)
        do
            time := time + delta_time / speed
            if time >= 1 then
            	-- keep the domain [0,1] inclusively since this fonction only operates in 0-1 float values
                time := time - 1.floor
            end
            position := spline_path.evaluate(time)
        end

    get_position: TUPLE[x, y: REAL_64]
        do
            Result := position
        end

feature -- Implementation

    spline_path: SPLINE_PATH
    speed: REAL_64
    time: REAL_64
    position: TUPLE[x, y: REAL_64]

end