module NNChessMarker
    using HorizonSideRobots
    export mark_chess

    X_COORD = 0
    Y_COORD = 0

    SIZE = 0

    function mark_chess(r::Robot, n::Int)
        global SIZE
        SIZE = n

        cnt_hor, cnt_vert = move_to_corner(r)

        side = Ost
        mark_row(r, side)
        while !isborder(r, Nord)
            move_decart!(r, Nord)
            side = inverse(side)
            mark_row(r, side)
        end

        move_to_corner(r)
        move_back(r, Nord, cnt_vert)
        move_back(r, Ost, cnt_hor)
    end

    inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))

    function mark_row(r::Robot, side::HorizonSide)       
        putmarker_chess!(r)
        while !isborder(r, side)
            move_decart!(r, side)
            putmarker_chess!(r)
        end
    end

    function putmarker_chess!(r)
        global X_COORD, Y_COORD
        x_flag = (0 <= mod(X_COORD, 2 * SIZE) && mod(X_COORD, 2 * SIZE) < SIZE)
        y_flag = (0 <= mod(Y_COORD, 2 * SIZE) && mod(Y_COORD, 2 * SIZE) < SIZE)
        if (x_flag && y_flag || !x_flag && !y_flag) 
            putmarker!(r)
        end
    end

    function move_to_corner(r::Robot)
        cnt_hor = moves!(r, West)
        cnt_vert = moves!(r, Sud)
        return cnt_hor, cnt_vert
    end

    function moves!(r::Robot, side::HorizonSide)
        counter = 0
        while !isborder(r, side)
            move!(r, side)
            counter += 1
        end
        return counter
    end

    function move_back(r::Robot, side::HorizonSide, steps::Int)
        for i = 1:steps
            move!(r, side)
        end
    end

    function move_decart!(r, side)
        global X_COORD, Y_COORD
        if side == Nord
            Y_COORD += 1
        elseif side == Sud
            Y_COORD -= 1
        elseif side == Ost
            X_COORD +=1
        else
            X_COORD -= 1
        end
        move!(r, side)
    end
end