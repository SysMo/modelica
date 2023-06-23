within SysMo;

package ElectricalKids
  model _01_BasicModel
  Modelica.Electrical.Analog.Sources.ConstantVoltage voltage_source(V = 1.5)  annotation(
      Placement(visible = true, transformation(origin = {-74, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Resistor lamp(R = 1)  annotation(
      Placement(visible = true, transformation(origin = {18, -20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-74, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch sw1 annotation(
      Placement(visible = true, transformation(origin = {-28, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanPulse pulse_source(period = 1)  annotation(
      Placement(visible = true, transformation(origin = {-62, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
  connect(voltage_source.n, lamp.n) annotation(
      Line(points = {{-74, -30}, {18, -30}}, color = {0, 0, 255}));
  connect(ground.p, voltage_source.n) annotation(
      Line(points = {{-74, -38}, {-74, -30}}, color = {0, 0, 255}));
  connect(sw1.n, lamp.p) annotation(
      Line(points = {{-18, -10}, {18, -10}}, color = {0, 0, 255}));
  connect(voltage_source.p, sw1.p) annotation(
      Line(points = {{-74, -10}, {-38, -10}}, color = {0, 0, 255}));
  connect(pulse_source.y, sw1.control) annotation(
      Line(points = {{-50, 34}, {-28, 34}, {-28, 2}}, color = {255, 0, 255}));
  annotation(
      experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.1),
      __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
      __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", variableFilter = ".*"));
end _01_BasicModel;
equation

end ElectricalKids;