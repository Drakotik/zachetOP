function move_until_border_r!(r::Robot, side::HorizonSide)
    if !isborder(r, side)
        move!(r, side)
        move_until_border_r!(r, side)
    end
end