using Colors
using Dates
using WGLMakie

Q_ref = 45000.

affluency = [
    [0.2, 0.33, 0.4, 0.47, 0.47, 0.45, 0.4, 0.37, 0.4, 0.47, 0.45, 0.35],
    [0.25, 0.35, 0.5, 0.56, 0.55, 0.5, 0.35, 0.3, 0.25, 0.2, 0.1, 0.05],
    [0.28, 0.38, 0.55, 0.6, 0.63, 0.58, 0.42, 0.37, 0.33, 0.2, 0.12, 0.08],
    [0.33, 0.45, 0.63, 0.7, 0.7, 0.65, 0.57, 0.45, 0.33, 0.25, 0.15, 0.08],
    [0.28, 0.4, 0.55, 0.6, 0.6, 0.57, 0.57, 0.6, 0.66, 0.7, 0.66, 0.53],
    [0.33, 0.57, 0.75, 0.9, 0.85, 0.73, 0.66, 0.62, 0.6, 0.6, 0.6, 0.5],
    [0.25, 0.4, 0.6, 0.66, 0.65, 0.57, 0.5, 0.33, 0.25, 0.17, 0.1, 0.05]
]

Q_week = [i%24 in 10:21 ? Q_ref * affluency[ceil(Int, i/(24))][i%24-9] : 0. for i in 1:24*7]
seasonal_shift = 0.25 * [sin(2π*i/8760) for i in 1:8760] .+ 0.75
Q_year = [seasonal_shift[i] * Q_week[i%(24*7)+1] for i in 1:8760]

Q_tot = repeat(Q_year, 5)


function plot_affluency_day(i)
    fig = Figure()
    ax = Axis(fig[1, 1], yreversed = true)  
    lines!(ax, affluency[i])
    ylims!(ax, (0, 1))
    fig
end

function plot_weekly_Q()
    fig = Figure(size=(1500, 400))
    ax = Axis(fig[1, 1])  
    t = 1:24*7
    lines!(ax, t ./ 24., Q_week ./ (1000) )
    ax.xticks = 0:7
    ax.xtickformat = x -> ["$(dayname(Int(n)%7+1)) midnight" for n in x]
    ax.xminorticksvisible = true
    ax.xminorgridvisible = true
    ax.xminorticks = 0:1/2:7
    ax.ylabel = "Power [kW]"
    fig
end

function plot_Q()
    fig = Figure(size=(1500, 400))
    ax = Axis(fig[1, 1])  
    t = 1:8760
    lines!(ax, t ./ 730., Q_year ./ 1000 )
    ax.xticks = 0:12
    ax.xtickformat = x -> ["$(monthname(Int(n+3)%12+1))" for n in x]
    ax.ylabel = "Power [kW]"
    fig
end

monday_affluency = plot_affluency_day(1)
weekly = plot_weekly_Q()
yearly = plot_Q()

# save("examples/tekniska/plots/Q_week.png", weekly)
# save("examples/tekniska/plots/Q_year.png", yearly)