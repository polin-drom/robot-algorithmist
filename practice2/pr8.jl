function find_door(r::Robot)
    steps = 1
    while isborder(r, Nord)
        side = Ost
        move_side(r, steps, side)
        side = West
        move_side(r, steps, side)
        move_side(r, steps, side)
        side = Ost
        move_side(r, steps, side)
        steps += 1
    end
end

function move_side(r::Robot, steps::Int, side::HorizonSide)
    for i = 1:steps
        if !isborder(r, Nord)
            break
        end
        move!(r,side)
    end
end