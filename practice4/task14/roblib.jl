#Cодержимое файла roblib.jl

function move_back!(r::Robot, side::HorizonSide, num_steps::Int)
    while num_steps > 0
        move_if_possible!(r, side)
        num_steps -= 1
    end
end

"""
    movements!(r::Robot, side::HorizonSide)

-- Перемещает Робота в заданном направлении до упора    
"""

function movements!(r::Robot, side::HorizonSide)
    while !isborder(r, side)
        move!(r, side)
    end 
end

"""
    movements!(r::Robot, side::HorizonSide, num_steps::Int)

-- Перемещает Робота в заданном направлении на заданное число шагов    
"""

function movements!(r::Robot, side::HorizonSide, num_steps::Int)
    for i in 1:num_steps
        move!(r, side)
    end 
end

"""
    count_movements!(r::Robot, side::HorizonSide)

-- Перемещает Робота в заданном направлении до упора и возвращает сделанное число шагов    
"""
function count_movements!(r::Robot, side::HorizonSide)
    num_steps = 0
    while !isborder(r, side) 
        move!(r, side) 
        num_steps += 1    
    end
    return num_steps
end

"""
    inverse(side::HorizonSide)

-- Возвращает направление, противоположное заданному    
"""
inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))

"""
    left(side::HorizonSide)

-- Возвращает направление, следующее, если отсчитывать против часовой стредки, по отношению к заданному    
"""
left(side::HorizonSide) = HorizonSide(mod(Int(side) + 1, 4))

"""
    right(side::HorizonSide)

-- Возвращает направление, предыдущее, если отсчитывать против часовой стредки, по отношению к заданному    
"""
right(side::HorizonSide) = HorizonSide(mod(Int(side) - 1, 4))

"""
    move_if_possible!(r::Robot, side::HorizonSide)

-- Перемещает робота в заданном направлении на 1 шаг, если не существует преград
"""
#move_if_possible!(r::Robot, side::HorizonSide) = isborder(r,side) ? (move!(r,side); true) : false

"""
    move_if_possible!(r::Robot, side::HorizonSide)::Bool

-- Перемещает Робота в заданном направлении на 1 шаг и возвращает true - это, если мешающей перегородки нет, или, если её можно обойти; имеется ввиду изолированная перегородка прямоугольной формы. 
В противном случае Робот остается на месте и функция возвращает false.
"""
# Перемещает робота в заданном направлении, если это возможно, и возвращает true,
# если перемещение состоялось; в противном случае - false.

function move_if_possible!(r::Robot, now_side::HorizonSide)::Bool
    # в направлении now_side не встретилось перегородки
    if !isborder(r, now_side)
        move!(r, now_side)
        return true
    end

    # в направлении now_side есть перегородка => начинается ее обход
    left_side = left(now_side)
    right_side = inverse(left_side)
    num_steps = 0

    back_steps = 0

    while isborder(r, now_side)
        if !isborder(r, left_side)
            move!(r, left_side)
            num_steps += 1
            back_steps += 1
        else
            movements!(r, right_side, back_steps)
            return false # робот пришел в угол
        end
    end

    move!(r, now_side)

    back_steps = 0

    while isborder(r, right_side)
        if !isborder(r, now_side)
            move!(r, now_side)
            back_steps += 1
        else
            movements!(r, left_side, back_steps)
            return false # робот пришел в угол
        end
    end

    for i in 1:num_steps
        move!(r, right_side)
    end 
    
    return true
end