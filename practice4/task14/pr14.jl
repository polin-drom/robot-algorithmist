include("roblib.jl")
function mark_kross(r)
    for side in 0:3
        num = putmarkers!(r, HorizonSide(side))
        move_back!(r, inverse(HorizonSide(side)), num)
    end
    putmarker!(r)
end

function putmarkers!(r::Robot, side::HorizonSide)
    num = 0
    while move_if_possible!(r, side)
        putmarker!(r)
        num += 1
    end
    return num
end
