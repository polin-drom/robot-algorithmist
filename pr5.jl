function mark_corners(r::Robot)
    a = move_to_corner(r)    

    put_all_markers(r)

    move_back(r, a)
end

function move_to_corner(r::Robot)
    i = 1
    a = []
    while !isborder(r, West) || !isborder(r, Sud)
        if mod(i, 2) == 0
            side = West
        else
            side = Sud
        end
        cnt = moves!(r, side)
        push!(a, cnt)
        i += 1
    end
    return a
end

function put_all_markers(r::Robot)
    for i in 3:6
        putmarker!(r)
        moves!(r, HorizonSide(i % 4))
    end
end

function moves!(r::Robot, side::HorizonSide)
    counter = 0
    while !isborder(r, side)
        move!(r, side)
        counter += 1
    end
    return counter
end

function move_back(r::Robot, a::Array)
    n = length(a)
    while n > 0
        if mod(n, 2) == 0
            side = Ost
        else
            side = Nord
        end
        for i = 1:a[n]
            move!(r, side)
        end
        n -= 1
    end
end