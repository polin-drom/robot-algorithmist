include("roblib.jl")

function mark_plane(r::Robot)
    num_vert = count_moves!(r, Sud)
    num_hor = count_moves!(r, West)

    side = Nord
    while !(isborder(r, Ost) && (isborder(r, Ost) || isborder(r, Sud)))
        putmarker!(r)
        putmarkers!(r, side)
        move!(r, Ost)
        side = inverse(side)
    end

    putmarker!(r)
    putmarkers!(r, side)

    count_moves!(r, Sud)
    count_moves!(r, West)

    move_back!(r, Nord, num_vert)
    move_back!(r, Ost, num_hor)
end