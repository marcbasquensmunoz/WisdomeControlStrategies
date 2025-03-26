
include("borefield_definition.jl")
include("load_definition.jl")

Δt = 3600.
Nt = 8760*5

# Ground properties
λ = 3.1
α = 1e-6
T0 = 9.

# Borehole properties
D = 4.
H = 240.
λg = 2.5
pipe_position = ((0.03, 0.0), (-0.03, 0.0))

medium = GroundMedium(λ=λ, α=α, T0=T0)
borehole = SingleUPipeBorehole(H=H, D=D, λg=λg, pipe_position=pipe_position)
borefield = EqualBoreholesBorefield(borehole_prototype=borehole, positions=borehole_positions)
constraint = TotalHeatLoadConstraint(Q_tot)
method = NonHistoryMethod()
fluid = EthanolMix()

options = SimulationOptions(
    method = method,
    constraint = constraint,
    borefield = borefield,
    fluid = fluid,
    medium = medium,
    Δt = Δt,
    Nt = Nt,
    configurations = configurations
)

containers = @time initialize(options)
