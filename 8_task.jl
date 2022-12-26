function move_if_not_marker!(r::Robot, side::HorizonSide)::Bool
    if !ismarker(r)
        move!(r, side)
        return false
    end
    return true
end

function moves_if_not_marker!(r::Robot, side::HorizonSide, num_steps::Int)::Bool
    for _ in 1:num_steps
        if move_if_not_marker!(r, side)
            return true
        end
    end
    return false
end

function next_side(side::HorizonSide)::HorizonSide
    return HorizonSide((Int(side)+1)%4)
end


function move_snake_until_marker!(r::Robot)
    num_steps = 1
    side = Ost
    c = 1
    while true
        if moves_if_not_marker!(r, side, num_steps)
            return
        end 
        side = next_side(side)
        if c%2==0
            num_steps+=1
        end
        c+=1
    end
end