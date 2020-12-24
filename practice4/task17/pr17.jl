include("roblib.jl")

function mark_plane(r::Robot)
    num_vert = count_moves!(r, Sud)
    num_hor = count_moves!(r, West)

    side = Ost
    all_steps = count_moves!(r, Ost)
    max_steps = all_steps
    count_moves!(r, West)

    while !(isborder(r, Nord) && (isborder(r, Ost) || isborder(r, West)))
        now_steps = count_moves!(r, Ost, max_steps)
        count_moves!(r, West)
        putmarker!(r)
        putmarkers!(r, side, now_steps)
        move_back!(r, inverse(side), now_steps)
        move!(r, Nord)
        max_steps -= 1
    end

    now_steps = count_moves!(r, Ost, max_steps)
    count_moves!(r, West)
    putmarker!(r)
    putmarkers!(r, side, now_steps)

    count_moves!(r, Sud)
    count_moves!(r, West)

    move_back!(r, Nord, num_vert)
    move_back!(r, Ost, num_hor)
end