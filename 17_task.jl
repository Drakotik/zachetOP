function along!(stop_condition, robot, side, max_num)
    num_steps = 0
    while !stop_condition(side) && num_steps < max_num
        move!(robot, side)
        num_steps += 1
    end
    return num_steps
end


function spiral!(stop_condition::Function, robot)
    num_steps = 1
    side = Ost
    while !stop_condition(side)
        along!(stop_condition, robot, side, num_steps)
        side = next_side(side)
        along!(stop_condition, robot, side, num_steps)
        side = next_side(side)
        num_steps +=1
    end
end


function find_marker!(r::Robot)
    tmp = (side::HorizonSide) -> ismarker(r)
    spiral!(tmp, r)
end