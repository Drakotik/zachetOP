function breakthrough_r!(r::Robot, side::HorizonSide, num_steps::Int = 0)
    if isborder(r, side)
        num_steps += 1
        move!(r, next_side(side))
        breakthrough_r!(r, side, num_steps)
    else
        move!(r, side)
        along!(r, inverse_side(next_side(side)), num_steps)
    end
end