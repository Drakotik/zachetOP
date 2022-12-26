function move_if_possible!(r::Robot, side::HorizonSide)::Bool
    if !isborder(r, side)
        move!(r, side)
        return true
    end
    return false
end

function inversed_path(path::Vector{Tuple{HorizonSide, Int}})::Vector{Tuple{HorizonSide, Int}}
    inv_path = []
    for step in path
        inv_step = (inverse_side(step[1]), step[2])
        push!(inv_path, inv_step)
    end
    reverse!(inv_path)
    return inv_path
end

function make_way!(r::Robot, path::Vector{Tuple{HorizonSide, Int}})
    for step in path
        moves!(r, step[1], step[2])
    end
end

function make_way_back!(r::Robot, path::Vector{Tuple{HorizonSide, Int}})
    inv_path = inversed_path(path)
    make_way!(r, inv_path)
end

function mark_inner_rectangle!(r::Robot)
    steps = get_left_down_angle_modified!(r)
    while isborder(r, Sud) && !isborder(r, Ost)
        move_until_border!(r, Nord)
        move!(r, Ost)
        while !isborder(r, Ost) && move_if_possible!(r, Sud) end
    end
    for sides in [(Sud, Ost), (Ost, Nord), (Nord, West), (West, Sud)]
        side_to_move, side_to_border = sides
        while isborder(r, side_to_border)
            putmarker!(r)
            move!(r, side_to_move)
        end
        putmarker!(r)
        move!(r, side_to_border)
    end
    get_left_down_angle_modified!(r)
    make_way_back!(r, steps)
end

#a

function mark_perimetr_with_inner_border!(r::Robot) 
    path = get_left_down_angle_modified!(r)
    mark_perimetr!(r)
    make_way_back!(r, path)
end

function moves_if_possible!(r::Robot, side::HorizonSide, n_steps::Int)::Bool
    while num_steps > 0 && move_if_possible!(r, side)
        num_steps-=1
    end
    if num_steps == 0
        return true
    end
    return false
end

#b

function mark_four_cells!(r::Robot) 
    path = get_left_down_angle_modified!(r)
    num_steps_to_sud = 0
    num_steps_to_west = 0
    for step in path
        if step[1] == Sud
            num_steps_to_sud+=step[2]
        else
            num_steps_to_west+=step[2]
        end
    end
    moves!(r, Ost, num_steps_to_west)
    putmarker!(r)
    move_until_border!(r, Ost)
    moves!(r, Nord, num_steps_to_sud)
    putmarker!(r)
    get_left_down_angle_modified!(r)
    moves!(r, Nord, num_steps_to_sud)
    putmarker!(r)
    move_until_border!(r, Nord)
    moves!(r, Ost, num_steps_to_west)
    putmarker!(r)
    get_left_down_angle_modified!(r)
    make_way_back!(r, path)
end