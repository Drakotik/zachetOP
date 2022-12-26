function putmarkers_until_border!(r::Robot, sides::NTuple{2, HorizonSide})::Int
    num_steps = 0
    while !isborder(r, sides[1]) && !isborder(r, sides[2])
        num_steps+=1
        move!(r, sides)
        putmarker!(r)
    end
    return num_steps
end

function moves!(r::Robot, sides::NTuple{2, HorizonSide}, num_steps::Int)
    for _ in 1:num_steps
        move!(r, sides)
    end
end

function move!(r::Robot, sides::NTuple{2, HorizonSide})
    for side in sides
        move!(r, side)
    end
end

function inverse_side(sides::NTuple{2, HorizonSide})
    new_sides = (inverse_side(sides[1]), inverse_side(sides[2]))
    return new_sides
end

function X_mark_the_spot!(r::Robot)
    sides = (Nord, Ost, Sud, West)
    for i in 1:4
        first_side = sides[i]
        second_side = sides[i%4+1]
        direction = (first_side, second_side)
        num_steps = putmarkers_until_border!(r, direction)
        moves!(r, inverse_side(direction), num_steps)
    end
    putmarker!(r)
end