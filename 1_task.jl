using HorizonSideRobots
import HorizonSideRobots.move!

function inverse_side(side::HorizonSide)::HorizonSide
    new_side = HorizonSide((Int(side) + 2) % 4)
    return new_side
end

function moves!(r::Robot, side::HorizonSide, num_steps::Int)
    for i in 1:num_steps
        move!(r, side)
    end
end

function move_until_border!(r::Robot, side::HorizonSide)::Int
    num_steps = 0
    while !isborder(r, side)
        num_steps+=1
        move!(r, side)
    end
    return num_steps
end

function putmarkers_until_border!(r::Robot, side::HorizonSide)::Int
    num_steps = 0
    while !isborder(r, side) 
        move!(r, side)
        putmarker!(r)
        num_steps+=1
    end 
    return num_steps
end

function mark_cross!(r::Robot)
    for side in (Nord, Sud, West, Ost)
        num_steps = putmarkers_until_border!(r, side)
        moves!(r, inverse_side(side), num_steps)
    end
    putmarker!(r)
end