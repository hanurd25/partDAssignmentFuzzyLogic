%%Sources
%The foundation for the creating this code is created by the lecturer, in 'Intelligente systemer', and  
%is from a class acticity 'Class activity_03.pdf', and can be found on blackboard page for the subject.

%Matlab turtorial for creating command-based fuzzy logic systems has also been used as guidance. Link:
%https://se.mathworks.com/help/fuzzy/working-from-the-command-line.html


%%THIS IS THE CODE FOR developing rule BASE 3 HVAC SYSTEM
%% Develop a FIS using command line in matlab
%mamfis is for Mamdani while sugfis is for sugeno
fis = mamfis('Name', "HVACMamdani");
%% Create a Mamdani fuzzy inference system .
%%fis = mamfis('Name',"TipMamdani");
%% Add input variables
fis = addInput(fis,[0 0.7],"Name","humidity");
fis = addInput(fis,[0 1],"Name","temperature");
fis = addInput(fis,[0 1],"Name","degree_Of_utility");
%% Add membership functions for each of the service
%Adding the membership functions for humidity

% quality levels using Gaussian membership functions.
%gaussmf is for normal distribution
%trimf is for triangular membership function

fis = addMF(fis,"humidity","trapmf",[-0.410 0 0.15 0.3],"Name","veryLow");
fis = addMF(fis,"humidity","trimf",[0.1 0.3 0.5],"Name","low");
fis = addMF(fis,"humidity","trapmf",[0.4 0.55 0.7 0.7],"Name","moderate");
%% Plot the membership functions for the first output variable.
plotmf(fis,"input",1);
%% Add membership functions temperature
%The temperature functions are good
% levels using trapezoidal membership functions.
%T
fis = addMF(fis,"temperature","trapmf",[-0.6 0.0 0.4 0.6],"Name","low");
fis = addMF(fis,"temperature","trimf",[0.4 0.6 0.8],"Name","moderate");
fis = addMF(fis,"temperature","trapmf",[0.6 0.8 1 1.4],"Name","high");
%% Plot the membership functions for the second output variable.
plotmf(fis,"input",2);

%% Adding the membership functions for degree_Of_utility
% levels using trapezoidal membership functions.
fis = addMF(fis,"degree_Of_utility","trapmf",[-0.5 0.0 0.17 0.35],"Name","low");
fis = addMF(fis,"degree_Of_utility","trimf",[0.15 0.3 0.45],"Name","ratherLow");
fis = addMF(fis,"degree_Of_utility","trimf",[0.3 0.5 0.7],"Name","moderate");
fis = addMF(fis,"degree_Of_utility","trimf",[0.55 0.7 85],"Name","ratherHigh");
fis = addMF(fis,"degree_Of_utility","trapmf",[0.6 0.8 1 1.4],"Name","high");

%Would actually be the output "Number of servers" in the excample
%fis = addMF(fis,"degree_Of_utility","trapmf",[-0.5 0.0 0.17 0.35],"Name","veryLow");
%fis = addMF(fis,"degree_Of_utility","trimf",[0.0 0.2 0.4],"Name","low");
%fis = addMF(fis,"degree_Of_utility","trimf",[0.15 0.3 0.45],"Name","ratherLow");
%fis = addMF(fis,"degree_Of_utility","trimf",[0.3 0.5 0.7],"Name","moderate");
%fis = addMF(fis,"degree_Of_utility","trimf",[0.55 0.7 85],"Name","ratherHigh");
%fis = addMF(fis,"degree_Of_utility","trimf",[0.6 0.8 1],"Name","high");
%fis = addMF(fis,"degree_Of_utility","trapmf",[0.6 0.8 1 1.4],"Name","veryHigh");


%% Add the output variable for the HVAC PLANT OUTPUT.
fis = addOutput(fis,[0 1],"Name","HVAC_PLANT_OUTPUT");
%% Add membership functions for the output.

fis = addMF(fis,"HVAC_PLANT_OUTPUT","trapmf",[-0.5 0.0 0.2 0.4],"Name","veryLow");
fis = addMF(fis,"HVAC_PLANT_OUTPUT","trimf",[0.0 0.2 0.4],"Name","low");
fis = addMF(fis,"HVAC_PLANT_OUTPUT","trimf",[0.25 0.35 0.45],"Name","ratherLow");
fis = addMF(fis,"HVAC_PLANT_OUTPUT","trimf",[0.3 0.5 0.7],"Name","moderate");
fis = addMF(fis,"HVAC_PLANT_OUTPUT","trimf",[0.55 0.65 75],"Name","ratherHigh");
fis = addMF(fis,"HVAC_PLANT_OUTPUT","trimf",[0.6 0.8 1],"Name","high");
fis = addMF(fis,"HVAC_PLANT_OUTPUT","trapmf",[0.7 0.9 1 1.4],"Name","veryHigh");
%%
%%plotmf(fis,"output",1);
rule1 = "If humidity is veryLow and degree_Of_utility is low and temperature is low then HVAC_PLANT_OUTPUT is veryLow" 
rule2 = "If humidity is low and degree_Of_utility is low and temperature is low then HVAC_PLANT_OUTPUT is veryLow" 
rule3 = "If humidity is moderate and degree_Of_utility is low and temperature is low then HVAC_PLANT_OUTPUT is veryLow" 
rule4 = "If humidity is veryLow and degree_Of_utility is ratherLow and temperature is low then HVAC_PLANT_OUTPUT is veryLow" 
rule5 = "If humidity is low and degree_Of_utility is ratherLow and temperature is low then HVAC_PLANT_OUTPUT is veryLow" 
rule6 = "If humidity is moderate and degree_Of_utility is ratherLow and temperature is low then HVAC_PLANT_OUTPUT is veryLow" 
rule7 = "If humidity is veryLow and degree_Of_utility is moderate and temperature is low then HVAC_PLANT_OUTPUT is veryLow" 
rule8 = "If humidity is low and degree_Of_utility is moderate and temperature is low then HVAC_PLANT_OUTPUT is veryLow" 
rule9 = "If humidity is moderate and degree_Of_utility is moderate and temperature is low then HVAC_PLANT_OUTPUT is veryLow" 
rule10 = "If humidity is veryLow and degree_Of_utility is ratherHigh and temperature is low then HVAC_PLANT_OUTPUT is low" 
rule11 = "If humidity is low and degree_Of_utility is ratherHigh and temperature is low then HVAC_PLANT_OUTPUT is low" 
rule12 = "If humidity is moderate and degree_Of_utility is ratherHigh and temperature is low then HVAC_PLANT_OUTPUT is veryLow" 
rule13 = "If humidity is veryLow and degree_Of_utility is high and temperature is low then HVAC_PLANT_OUTPUT is low" 
rule14 = "If humidity is low and degree_Of_utility is high and temperature is low then HVAC_PLANT_OUTPUT is low" 
rule15 = "If humidity is moderate and degree_Of_utility is high and temperature is low then HVAC_PLANT_OUTPUT is veryLow" 
rule16 = "If humidity is veryLow and degree_Of_utility is low and temperature is moderate then HVAC_PLANT_OUTPUT is low" 
rule17 = "If humidity is low and degree_Of_utility is low and temperature is moderate then HVAC_PLANT_OUTPUT is veryLow" 
rule18 = "If humidity is moderate and degree_Of_utility is low and temperature is moderate then HVAC_PLANT_OUTPUT is veryLow" 
rule19 = "If humidity is veryLow and degree_Of_utility is ratherLow and temperature is moderate then HVAC_PLANT_OUTPUT is low" 
rule20 = "If humidity is low and degree_Of_utility is ratherLow and temperature is moderate then HVAC_PLANT_OUTPUT is veryLow" 
rule21 = "If humidity is moderate and degree_Of_utility is ratherLow and temperature is moderate then HVAC_PLANT_OUTPUT is veryLow" 
rule22 = "If humidity is veryLow and degree_Of_utility is moderate and temperature is moderate then HVAC_PLANT_OUTPUT is ratherLow" 
rule23 = "If humidity is low and degree_Of_utility is moderate and temperature is moderate then HVAC_PLANT_OUTPUT is low" 
rule24 = "If humidity is moderate and degree_Of_utility is moderate and temperature is moderate then HVAC_PLANT_OUTPUT is veryLow" 
rule25 = "If humidity is veryLow and degree_Of_utility is ratherHigh and temperature is moderate then HVAC_PLANT_OUTPUT is moderate" 
rule26 = "If humidity is low and degree_Of_utility is ratherHigh and temperature is moderate then HVAC_PLANT_OUTPUT is ratherLow" 
rule27 = "If humidity is moderate and degree_Of_utility is ratherHigh and temperature is moderate then HVAC_PLANT_OUTPUT is low" 
rule28 = "If humidity is veryLow and degree_Of_utility is high and temperature is moderate then HVAC_PLANT_OUTPUT is moderate" 
rule29 = "If humidity is low and degree_Of_utility is high and temperature is moderate then HVAC_PLANT_OUTPUT is ratherLow" 
rule30 = "If humidity is moderate and degree_Of_utility is high and temperature is moderate then HVAC_PLANT_OUTPUT is low" 


rule31 = "If humidity is veryLow and degree_Of_utility is low and temperature is high then HVAC_PLANT_OUTPUT is veryHigh"

rule32 = "If humidity is low and degree_Of_utility is low and temperature is high then HVAC_PLANT_OUTPUT is high" 
rule33 = "If humidity is moderate and degree_Of_utility is low and temperature is high then HVAC_PLANT_OUTPUT is moderate" 
rule34 = "If humidity is veryLow and degree_Of_utility is ratherLow and temperature is high then HVAC_PLANT_OUTPUT is veryHigh" 
rule35 = "If humidity is low and degree_Of_utility is ratherLow and temperature is high then HVAC_PLANT_OUTPUT is ratherHigh" 
rule36 = "If humidity is moderate and degree_Of_utility is ratherLow and temperature is high then HVAC_PLANT_OUTPUT is ratherLow" 
rule37 = "If humidity is veryLow and degree_Of_utility is moderate and temperature is high then HVAC_PLANT_OUTPUT is moderate" 
rule38 = "If humidity is low and degree_Of_utility is moderate and temperature is high then HVAC_PLANT_OUTPUT is moderate" 
rule39 = "If humidity is moderate and degree_Of_utility is moderate and temperature is high then HVAC_PLANT_OUTPUT is low" 
rule40 = "If humidity is veryLow and degree_Of_utility is ratherHigh and temperature is high then HVAC_PLANT_OUTPUT is ratherHigh" 
rule41 = "If humidity is low and degree_Of_utility is ratherHigh and temperature is high then HVAC_PLANT_OUTPUT is moderate" 
rule42 = "If humidity is moderate and degree_Of_utility is ratherHigh and temperature is high then HVAC_PLANT_OUTPUT is ratherLow" 
rule43 = "If humidity is veryLow and degree_Of_utility is high and temperature is high then HVAC_PLANT_OUTPUT is high" 
rule44 = "If humidity is low and degree_Of_utility is high and temperature is high then HVAC_PLANT_OUTPUT is moderate" 
rule45 = "If humidity is moderate and degree_Of_utility is high and temperature is high then HVAC_PLANT_OUTPUT is ratherLow" 
rules = [rule1 rule2 rule3 rule4 rule5 rule6 rule7 rule8 rule9 rule10 rule11 rule12 rule13 rule14 rule15 rule16 rule17 rule18 rule19 rule20 rule21 rule22 rule23 rule24 rule25 rule26 rule27 rule28 rule29 rule30 rule31 rule32 rule33 rule34 rule35 rule36 rule37 rule38 rule39 rule40 rule41 rule42 rule43 rule44 rule45]


   
%% Add the rules to the FIS.
for i = 1:length(rules)
    fis = addRule(fis, rules{i}); % Adding each rule induvidually
end
%% Display the rules
fis.Rules
%% Plotting the membership functions
plotmf(fis, 'input', 1);
plotmf(fis, 'input', 2);
plotmf(fis, 'input', 3);

%% To get output from fis
evalfis(fis,[0.3 0.3 0.4]);
%% plotfis displays the whole system as a block diagram.
plotfis(fis);
%% Generate fuzzy inference system output surface
surfview(fis);% or gensurf(fis)
