using BoreholeNetworksSimulator
using BNSPlots
using BNSPlots: title

Δt = 3600.
Nt = 8760*5

network = all_parallel_network(10)
configurations = [  
    network
]

σ = 10.
Δy = 5.
borehole_positions = vcat([(σ*(i-1), 0.) for i in 1:5], [(σ*(i-1/2), Δy) for i in 1:5])

bf_fig = plot_borefield(network, borehole_positions)
title(bf_fig, "Wisdome Borefield")

group1 = [1, 6, 2, 7, 3, 8]
group2 = [4, 5, 9, 10]
bf_color_fig = plot_borefield(network, borehole_positions, distinguished_boreholes=[(i, i in group1 ? colorant"red" : colorant"green") for i in 1:10])
title(bf_color_fig, "Wisdome Borefield")

