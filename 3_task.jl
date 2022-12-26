function get_left_down_angle!(r::Robot)::NTuple{2, Int}
    l_steps = move_until_border!(r, West)
    d_steps = move_until_border!(r, Sud)
    return (d_steps, l_steps)
end

function get_to_origin!(r::Robot, steps::NTuple{2, Int})
    for (i, side) in enumerate((Nord, Ost))
        moves!(r, side, steps[i])
    end
end

function mark_field!(r::Robot)
    steps = get_left_down_angle!(r)
    putmarker!(r)
    while !isborder(r, Ost)
        putmarkers_until_border!(r,Nord)
        move!(r, Ost)
        putmarker!(r)
        putmarkers_until_border!(r, Sud)
    end
    get_left_down_angle!(r)
    get_to_origin!(r, steps)
end