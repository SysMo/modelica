within SysMo.Automotive.CryoCompressed;

model Heater
  replaceable package h2_medium = Modelica.Media.Interfaces.PartialMedium "Medium in the component" 
    annotation (choicesAllMatching = true);
  Modelica.Thermal.HeatTransfer.Components.Convection conv_ev_pr annotation(
    Placement(visible = true, transformation(origin = {-38, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant k_conv_ev_pr(k = 100) annotation(
    Placement(visible = true, transformation(origin = {-80, 20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Fluid.Vessels.ClosedVolume pipe_ev_pr(redeclare model HeatTransfer = Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer, redeclare package Medium = h2_medium, V = 1e-3, nPorts = 3, p_start = 10e5, use_HeatTransfer = true, use_portsData = false) annotation(
    Placement(visible = true, transformation(origin = {6, -10}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_a inlet(redeclare package Medium = h2_medium)  annotation(
    Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b outlet(redeclare package Medium = h2_medium)  annotation(
    Placement(visible = true, transformation(origin = {104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium = h2_medium)  annotation(
    Placement(visible = true, transformation(origin = {24, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput t_out annotation(
    Placement(visible = true, transformation(origin = {58, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(k_conv_ev_pr.y, conv_ev_pr.Gc) annotation(
    Line(points = {{-73, 20}, {-57.5, 20}, {-57.5, 32}, {-38, 32}}, color = {0, 0, 127}));
  connect(pipe_ev_pr.heatPort, conv_ev_pr.fluid) annotation(
    Line(points = {{-4, -10}, {-4, -9.5}, {-18, -9.5}, {-18, 22.5}, {-28, 22.5}, {-28, 22}}, color = {191, 0, 0}));
  connect(inlet, pipe_ev_pr.ports[1]) annotation(
    Line(points = {{-104, 0}, {6, 0}}, color = {0, 127, 255}));
  connect(outlet, pipe_ev_pr.ports[2]) annotation(
    Line(points = {{104, 0}, {6, 0}}, color = {0, 127, 255}));
  connect(pipe_ev_pr.ports[3], temperature.port) annotation(
    Line(points = {{6, 0}, {6, 28}, {24, 28}}, color = {0, 127, 255}));
  connect(temperature.T, t_out) annotation(
    Line(points = {{32, 38}, {58, 38}, {58, 96}}, color = {0, 0, 127}));

annotation(
    Icon(graphics = {Rectangle(origin = {-50, 0}, fillColor = {53, 132, 228}, fillPattern = FillPattern.Solid, extent = {{-50, 40}, {50, -40}}), Rectangle(origin = {50, 0}, fillColor = {224, 27, 36}, fillPattern = FillPattern.Solid, extent = {{-50, 40}, {50, -40}}), Text(origin = {0, -58}, extent = {{-100, 14}, {100, -14}}, textString = "%name")}, coordinateSystem(extent = {{-100, -40}, {100, 40}})),
    Diagram(coordinateSystem(extent = {{-100, -40}, {100, 40}})));
end Heater;