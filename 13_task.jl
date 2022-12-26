function snake!(r, (move_side, next_row_side)::NTuple{2,HorizonSide}=(Ost,Nord))
    steps = get_left_down_angle!(r)
    to_mark = (steps[1] + steps[2]) % 2 == 0
    get_left_down_angle!(r)
    while !isborder(r, next_row_side)
        while !isborder(r, move_side)
            if to_mark
                putmarker!(r)
            end
            move!(move_side)
            to_mark=!to_mark
        end
        if to_mark
            putmarker!(r)
        end
        move!(next_row_side)
        to_mark=!to_mark
        move_side = inverse_side(move_side)
    end
    get_left_down_angle!(r)
    get_to_origin!(r, steps)
end

snake!(r, (Ost, North))