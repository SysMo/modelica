within SysMo.Media;

package HydrogenCoolprop 
//extends CoolPropMedium(
//      ThermoStates=ThermofluidStream.Media.myMedia.Interfaces.Choices.IndependentVariables.ph,
//      mediumName="Hydrogen"
//);

    extends ExternalMedia.Media.CoolPropMedium(
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.ph, 
      mediumName = "Hydrogen"//substanceNames = {"pH2"}
    );
      
end HydrogenCoolprop;