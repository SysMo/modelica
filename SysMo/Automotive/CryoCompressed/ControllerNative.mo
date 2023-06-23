within SysMo.Automotive.CryoCompressed;

model ControllerNative
  inner Modelica.Blocks.Interfaces.BooleanInput u annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  inner Modelica.Blocks.Interfaces.RealOutput y(start = 0) annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  inner Clock c1 = Clock(0.1);
  
  block S1
    outer input Boolean u;
    outer output Real y;
    outer Clock c1;
  equation
    when c1 then
      y  = previous(y) + 1;
    end when;
    annotation(
      Icon(graphics = {Text(extent = {{-100, 100}, {100, -100}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
      __Dymola_state = true,
      singleInstance = true);
  end S1;

  block S2
    outer input Boolean u;
    outer output Real y;
    outer Clock c1;
  equation
    when c1 then    
      y  = previous(y) - 0.5;
    end when;
    annotation(
      Icon(graphics = {Text(extent = {{-100, 100}, {100, -100}}, textString = "%name")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
      __Dymola_state = true,
      singleInstance = true);
  end S2;

  SysMo.Automotive.CryoCompressed.ControllerNative.S1 s1 annotation(
    Placement(visible = true, transformation(origin = {-49, 29}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
  SysMo.Automotive.CryoCompressed.ControllerNative.S2 s2 annotation(
    Placement(visible = true, transformation(origin = {73, 19}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
equation
  initialState(s1);
  transition(s1, s2, u == true, immediate = false, reset = true, synchronize = false, priority = 1) annotation(
    Line(points = {{-49, 54}, {-49, 82}, {73, 82}, {73, 42}}, color = {175, 175, 175}, smooth = Smooth.Bezier),
    Text(textColor = {95, 95, 95}, extent = {{-4, 4}, {-4, 10}}, textString = "%condition", fontSize = 10, textStyle = {TextStyle.Bold}, horizontalAlignment = TextAlignment.Right));
  transition(s2, s1, u == false, immediate = false, reset = true, synchronize = false, priority = 1) annotation(
    Line(points = {{73, -4}, {73, -38}, {-47, -40}, {-49, 4}}, color = {175, 175, 175}, smooth = Smooth.Bezier),
    Text(textColor = {95, 95, 95}, extent = {{-4, 4}, {-4, 10}}, textString = "%condition", fontSize = 10, textStyle = {TextStyle.Bold}, horizontalAlignment = TextAlignment.Right));
  annotation(
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", variableFilter = ".*"));
end ControllerNative;