
using Colors
include("../simulation_init.jl")

mass_flows = 0.5 * ones(10)

operator = ConstantOperator(network, mass_flows=mass_flows)
@time simulate!(operator=operator, options=options, containers=containers)

t_range = (Nt-24*7):Nt
const_m_plot = monitor(containers, [4, 7], options.t, steps = t_range, colors = [colorant"darkgreen", colorant"red"]) 
# save("examples/tekniska/plots/const_m.png", const_m_plot)

const_m_plot_5_year = monitor(containers, [4, 7], options.t, colors = [colorant"darkgreen", colorant"red"]) 
# save("examples/tekniska/plots/const_m_5_years.png", const_m_plot_5_year)