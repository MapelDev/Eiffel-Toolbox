note
    description: "Une classe permettant d'evaluer une fonction d'interpolation entre 2 points."
    author: "Florent Perreault"
    date: "11-7-2024"
    revision: "1.0"

class
    INTERPOLATION

feature -- Access

    evaluate(t: REAL_64): TUPLE[x, y: REAL_64]
        deferred
        end

end