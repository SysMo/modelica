within SysMo.Automotive.CryoCompressed;

model CcH2InnerVessel
  parameter Modelica.Units.SI.Volume v_tank = 0.2;
  replaceable package h2_medium = Modelica.Media.Interfaces.PartialMedium "Medium in the component" 
    annotation (choicesAllMatching = true);
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor tank_insulation(G = 1) annotation(
    Placement(visible = true, transformation(origin = {-50, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Pressure p_tank(redeclare package Medium = h2_medium) annotation(
    Placement(visible = true, transformation(origin = {20, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Density rho_tank(redeclare package Medium = h2_medium) annotation(
    Placement(visible = true, transformation(origin = {80, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sensors.Temperature t_tank(redeclare package Medium = h2_medium) annotation(
    Placement(visible = true, transformation(origin = {50, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Vessels.ClosedVolume h2_tank(redeclare model HeatTransfer = Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer, redeclare package Medium = h2_medium, T_start = 100, V = v_tank, nPorts = 5, p_start = 300e5, use_HeatTransfer = true, use_portsData = false) annotation(
    Placement(visible = true, transformation(origin = {-14, -12}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain rho2m(k = Modelica.Units.Conversions.to_unit1(v_tank)) annotation(
    Placement(visible = true, transformation(origin = {78, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Fluid.Interfaces.FluidPort_a fueling_port(redeclare package Medium = h2_medium)  annotation(
    Placement(visible = true, transformation(origin = {-102, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-210, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Interfaces.FluidPort_b extraction_port(redeclare package Medium = h2_medium)  annotation(
    Placement(visible = true, transformation(origin = {106, -36}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {210, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput p_out annotation(
    Placement(visible = true, transformation(origin = {24, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput t_out annotation(
    Placement(visible = true, transformation(origin = {54, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a amb_heat annotation(
    Placement(visible = true, transformation(origin = {-74, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-150, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput rho_out annotation(
    Placement(visible = true, transformation(origin = {76, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {150, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a tank_he_heat annotation(
    Placement(visible = true, transformation(origin = {-32, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(tank_insulation.port_b, h2_tank.heatPort) annotation(
    Line(points = {{-40, 16}, {4, 16}, {4, -12}, {-4, -12}}, color = {191, 0, 0}));
  connect(h2_tank.ports[4], t_tank.port) annotation(
    Line(points = {{-14, -22}, {-14, -36}, {50, -36}, {50, -18}}, color = {0, 127, 255}));
  connect(h2_tank.ports[5], rho_tank.port) annotation(
    Line(points = {{-14, -22}, {-14, -36}, {80, -36}, {80, -18}}, color = {0, 127, 255}));
  connect(h2_tank.ports[3], p_tank.port) annotation(
    Line(points = {{-14, -22}, {-13, -22}, {-13, -36}, {20, -36}, {20, -18}}, color = {0, 127, 255}));
  connect(rho_tank.d, rho2m.u) annotation(
    Line(points = {{91, -8}, {97, -8}, {97, 14}, {78, 14}, {78, 26}}, color = {0, 0, 127}));
  connect(h2_tank.ports[1], fueling_port) annotation(
    Line(points = {{-14, -22}, {-14, -36}, {-102, -36}}, color = {0, 127, 255}));
  connect(h2_tank.ports[2], extraction_port) annotation(
    Line(points = {{-14, -22}, {-12, -22}, {-12, -36}, {106, -36}}, color = {0, 127, 255}));
  connect(p_tank.p, p_out) annotation(
    Line(points = {{31, -8}, {33, -8}, {33, 48}, {24, 48}, {24, 70}}, color = {0, 0, 127}));
  connect(t_tank.T, t_out) annotation(
    Line(points = {{57, -8}, {61, -8}, {61, 20}, {47, 20}, {47, 54}, {54, 54}, {54, 70}}, color = {0, 0, 127}));
  connect(rho_tank.d, rho_out) annotation(
    Line(points = {{91, -8}, {97, -8}, {97, 56}, {76, 56}, {76, 70}}, color = {0, 0, 127}));
  connect(amb_heat, tank_insulation.port_a) annotation(
    Line(points = {{-74, 66}, {-74, 16}, {-60, 16}}, color = {191, 0, 0}));
  connect(h2_tank.heatPort, tank_he_heat) annotation(
    Line(points = {{-4, -12}, {4, -12}, {4, 50}, {-32, 50}, {-32, 66}}, color = {191, 0, 0}));
  annotation(
    Diagram(graphics = {Ellipse(extent = {{-56, 52}, {-56, 52}})}, coordinateSystem(extent = {{-200, -60}, {200, 60}})),
    Icon(graphics = {Ellipse(origin = {0, -10}, fillColor = {98, 160, 234}, fillPattern = FillPattern.VerticalCylinder, extent = {{-200, 50}, {200, -50}}), Text(origin = {28, 48}, extent = {{-20, 12}, {20, -12}}, textString = "p"), Text(origin = {90, 46}, extent = {{-20, 12}, {20, -12}}, textString = "T"), Text(origin = {150, 48}, extent = {{-20, 12}, {20, -12}}, textString = "rho"), Text(origin = {-152, 46}, extent = {{-20, 12}, {20, -12}}, textString = "amb"), Text(origin = {-90, 46}, extent = {{-20, 12}, {20, -12}}, textString = "HE"), Text(origin = {0, -75}, extent = {{-200, 11}, {200, -11}}, textString = "%name")}, coordinateSystem(extent = {{-200, -60}, {200, 60}})),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", variableFilter = ".*"));
end CcH2InnerVessel;