within SysMo.Automotive.CryoCompressed;

model VehicleControllerSG
  Modelica.Units.SI.Pressure p_he_on = 30e5;
  Modelica.Units.SI.Pressure p_he_off = 50e5;

  Modelica.StateGraph.InitialStep parking(nOut = 1, nIn = 2) annotation(
    Placement(visible = true, transformation(origin = {-162, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.Step driving(nIn = 2, nOut = 2) annotation(
    Placement(visible = true, transformation(origin = {-82, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation(
    Placement(visible = true, transformation(origin = {-162, 172}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.Step driving_he(nIn = 1, nOut = 2) annotation(
    Placement(visible = true, transformation(origin = {4, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput p_tank annotation(
    Placement(visible = true, transformation(origin = {-220, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput he_out annotation(
    Placement(visible = true, transformation(origin = {210, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression he_out_source(y = driving_he.active) annotation(
    Placement(visible = true, transformation(origin = {148, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.IntegerInput requested_mode annotation(
    Placement(visible = true, transformation(origin = {-220, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput v_extr annotation(
    Placement(visible = true, transformation(origin = {210, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression v_extr_source(y = driving.active or driving_he.active) annotation(
    Placement(visible = true, transformation(origin = {150, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.Transition tr_park_drive(condition = requested_mode == 1)  annotation(
    Placement(visible = true, transformation(origin = {-128, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.Transition tr_he_on(condition = p_tank < p_he_on)  annotation(
    Placement(visible = true, transformation(origin = {-46, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.StateGraph.Transition tr_he_off(condition = p_tank > p_he_off)  annotation(
    Placement(visible = true, transformation(origin = {-48, 48}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.StateGraph.Transition tr_drive_park(condition = requested_mode == 0)  annotation(
    Placement(visible = true, transformation(origin = {-88, 130}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.StateGraph.Transition tr_drive_park_2(condition = requested_mode == 0) annotation(
    Placement(visible = true, transformation(origin = {62, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(he_out_source.y, he_out) annotation(
    Line(points = {{160, 60}, {210, 60}}, color = {255, 0, 255}));
  connect(v_extr_source.y, v_extr) annotation(
    Line(points = {{162, 100}, {210, 100}}, color = {255, 0, 255}));
  connect(driving.outPort[1], tr_he_on.inPort) annotation(
    Line(points = {{-72, 90}, {-50, 90}}));
  connect(tr_he_on.outPort, driving_he.inPort[1]) annotation(
    Line(points = {{-44, 90}, {-7, 90}}));
  connect(driving_he.outPort[1], tr_he_off.inPort) annotation(
    Line(points = {{14.5, 90}, {31.25, 90}, {31.25, 48}, {-44, 48}}));
  connect(tr_he_off.outPort, driving.inPort[1]) annotation(
    Line(points = {{-50, 48}, {-98, 48}, {-98, 90}, {-92, 90}}));
  connect(tr_park_drive.outPort, driving.inPort[2]) annotation(
    Line(points = {{-126.5, 90}, {-92, 90}}));
  connect(parking.outPort[1], tr_park_drive.inPort) annotation(
    Line(points = {{-151.5, 90}, {-132, 90}}));
  connect(driving_he.outPort[2], tr_drive_park_2.inPort) annotation(
    Line(points = {{14, 90}, {58, 90}}));
  connect(driving.outPort[2], tr_drive_park.inPort) annotation(
    Line(points = {{-72, 90}, {-64, 90}, {-64, 130}, {-84, 130}}));
  connect(tr_drive_park.outPort, parking.inPort[1]) annotation(
    Line(points = {{-90, 130}, {-190, 130}, {-190, 90}, {-172, 90}}));
  connect(tr_drive_park_2.outPort, parking.inPort[2]) annotation(
    Line(points = {{64, 90}, {106, 90}, {106, 146}, {-190, 146}, {-190, 90}, {-172, 90}}));
  annotation(
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-100, -200}, {100, 200}}), graphics = {Rectangle(extent = {{-100, -200}, {100, 200}}), Text(origin = {-9, 173}, extent = {{-33, 19}, {33, -19}}, textString = "%name")}),
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
  __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl", variableFilter = ".*"));
end VehicleControllerSG;