within SysMo.Media;

package Examples
  model TestHydrogenCoolprop
    inner ThermofluidStream.DropOfCommons dropOfCommons annotation(
      Placement(visible = true, transformation(origin = {-30, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermofluidStream.Boundaries.Volume volume(redeclare package Medium = SysMo.Media.HydrogenCoolprop, T_start(displayUnit = "K") = 250, V_par = 0.1, initialize_energy = true, initialize_pressure = true, p_start(displayUnit = "Pa") = 10000000, useInlet = false, useOutlet = true) annotation(
      Placement(visible = true, transformation(origin = {-54, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    ThermofluidStream.Sensors.SingleSensorSelect s1(redeclare package Medium = SysMo.Media.HydrogenCoolprop, outputValue = true, quantity = ThermofluidStream.Sensors.Internal.Types.Quantities.p_bar) annotation(
      Placement(visible = true, transformation(origin = {-8, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(s1.inlet, volume.outlet) annotation(
      Line(points = {{-18, -28}, {-44, -28}}, color = {28, 108, 200}));
    annotation(
      experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 1),
      __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
      __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", variableFilter = ".*"));
  end TestHydrogenCoolprop;
end Examples;