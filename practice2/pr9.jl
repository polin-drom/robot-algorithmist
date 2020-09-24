function find_marker(r::Robot)
    steps = 1
    while !ismarker(r)
        for i = 0:1
            move_side(r, steps, HorizonSide(i))
        end
        steps += 1
        for i = 2:3
            move_side(r, steps, HorizonSide(i))
        end
        steps += 1;
    end
end

function move_side(r::Robot, steps::Int, side::HorizonSide)
    for i = 1:steps
        if ismarker(r)
            break
        end
        move!(r, side)
    end
end