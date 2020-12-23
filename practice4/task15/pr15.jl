include("roblib.jl")

function mark_frame_perimetr!(r::Robot)
    num_vert = moves!(r, Sud)
    num_hor = moves!(r, West)

    for i in 3:6
        putmarkers!(r, HorizonSide(i % 4))
    end

    move_back!(r, Nord, num_vert)
    move_back!(r, Ost, num_hor)
end

function moves!(r::Robot, side::HorizonSide)
    num_steps = 0
    while move_if_possible!(r, side)
        num_steps += 1
    end
    return num_steps
end

function putmarkers!(r::Robot, side::HorizonSide)
    while !isborder(r, side)
        move!(r, side)
        putmarker!(r)
    end
end