#Cодержимое файла roblib.jl

"""
    movements!(r::Robot, side::HorizonSide, num_steps::Int)

-- Перемещает Робота в заданном направлении на заданное число шагов    
"""
movements!(r::Robot, side::HorizonSide, num_steps::Int) = for i in 1:num_steps move!(r, side) end

"""
    movements!(r::Robot, side::HorizonSide)

-- Перемещает Робота в заданном направлении до упора    
"""
movements!(r::Robot, side::HorizonSide) = while isborder(r, side)==false move!(r, side) end 


"""
    get_num_movements!(r::Robot, side::HorizonSide)

-- Перемещает Робота в заданном направлении до упора и возвращает сделанное число шагов    
"""
function get_num_movements!(r::Robot, side::HorizonSide)
    num_steps = 0
    while isborder(r, side)==false 
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
# - прежде было имя next, но все-таки будет существенно удобнее, если его заменить на  lef (это будет яснее)

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
function move_if_possible!(r::Robot, side::HorizonSide)::Bool
    orthogonal_side = left(side)
    reverse_side = inverse(orthogonal_side)
    num_steps = 0
    while isborder(r, side)
        if !isborder(r, orthogonal_side)
            move(r, orthogonal_side)
            num_steps += 1
        else
            break
        end
    end
    #УТВ: Робот или уперся в угол внешней рамки поля, или готов сделать шаг (или несколько) в направлении 
    # side
    if !isborder(r, side)
        while isborder(r, reverse_side)
            move!(r, side)
        end
        result = true
    else
        result = false
    end
    movements!(r, reverse_side, num_steps)
    return result
end