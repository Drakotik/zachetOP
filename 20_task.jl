function along!(r, side, num_steps)
    steps = 0
    while !isborder(r, side) && steps < num_steps
        move!(r, side)
        steps += 1
    end
end


function putmarker_r!(r::Robot, side::HorizonSide, num_steps::Int = 0)
    if !isborder(r, side)
        num_steps += 1
        move!(r, side)
        putmarker_r!(r, side, num_steps)
    else
        putmarker!(r)
        along!(r, inverse_side(side), num_steps)
    end
end