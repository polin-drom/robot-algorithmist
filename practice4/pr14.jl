function mark_kross(r)
    include("roblib.jl")
    for side in (Nord, West, Sud, Ost)
        num = putmarkers!(r, side)
        movements!(r, inverse(side), num)
    end
    putmarker!(r)
end

function putmarkers!(r::Robot, side::HorizonSide)
    num = 0
    while move_if_possible(r, side)
        putmarker!(r)
        num += 1
    end
    return num
end
