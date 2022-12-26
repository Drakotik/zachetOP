function mark_perimetr!(r::Robot)
    l_d_steps = [0, 0]
    l_d_steps[1] = move_until_border!(r, Sud)
    l_d_steps[2] = move_until_border!(r, West)
    for side in (Nord, Ost, Sud, West)
        putmarkers_until_border!(r, side)
    end
    moves!(r, Ost, l_d_steps[2])
    moves!(r, Nord, l_d_steps[1])
end