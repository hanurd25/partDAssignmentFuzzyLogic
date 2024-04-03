%%https://se.mathworks.com/help/fuzzy/working-from-the-command-line.html
%% Develop a FIS using command line in matlab
%% Createing a Mamdani fuzzy inference system .
%mamfis is for Mamdani while sugfis is for sugeno
fis = mamfis('Name', "HVACMamdani");
%% Add input variables for the service and food quality.
fis = addInput(fis,[0 1],"Name","humidity");
fis = addInput(fis,[0 1],"Name","temperature");
fis = addInput(fis,[0 1],"Name","degree_Of_utility");
%% Add membership functions for each of the service
%Adding the membership functions for humidity

% quality levels using Gaussian membership functions.
%gaussmf is for normal distribution
%trimf is for triangular membership function

fis = addMF(fis,"humidity","trimf",[-0.416667 0 0.4],"Name","poor");
fis = addMF(fis,"humidity","trimf",[0.6 1 1.44],"Name","good");
fis = addMF(fis,"humidity","trimf",[0.4 0.5 0.6],"Name","high");
%% Plot the membership functions for the first output variable.
plotmf(fis,"input",1);
%% Add membership functions for each of the food temperature
% levels using trapezoidal membership functions.
fis = addMF(fis,"temperature","trimf",[-0.416667 0 0.3],"Name","low");
fis = addMF(fis,"temperature","trimf",[0.25 0.35 0.45],"Name","moderate");
fis = addMF(fis,"temperature","trimf",[0.4 1 1.4],"Name","high");
%% Plot the membership functions for the second output variable.
plotmf(fis,"input",2);

%% Adding the membership functions for degree_Of_utility
% levels using trapezoidal membership functions.
fis = addMF(fis,"degree_Of_utility","trimf",[0.0 0.2 0.4],"Name","veryLow");
fis = addMF(fis,"degree_Of_utility","trimf",[0.2 0.4 0.6],"Name","low");
fis = addMF(fis,"degree_Of_utility","trimf",[0.4 0.6 0.8],"Name","moderate");
fis = addMF(fis,"degree_Of_utility","trimf",[0.6 0.8 1],"Name","high");
fis = addMF(fis,"degree_Of_utility","trimf",[0.8 1 1.4],"Name","veryHigh");
%% Add the output variable for the HVAC PLANT OUTPUT.
fis = addOutput(fis,[0 1],"Name","HVAC_PLANT_OUTPUT");
%% Add membership functions for the output.

fis = addMF(fis,"HVAC_PLANT_OUTPUT","trimf",[0.0 0.2 0.4],"Name","veryLow");
fis = addMF(fis,"HVAC_PLANT_OUTPUT","trimf",[0.2 0.4 0.6],"Name","low");
fis = addMF(fis,"HVAC_PLANT_OUTPUT","trimf",[0.4 0.6 0.8],"Name","moderate");
fis = addMF(fis,"HVAC_PLANT_OUTPUT","trimf",[0.6 0.8 1],"Name","high");
fis = addMF(fis,"HVAC_PLANT_OUTPUT","trimf",[0.8 1 1.4],"Name","veryHigh");
%% Plot for Sugeno output do not support.
%%plotmf(fis,"output",1);
%% Specify if-then rules using linguistic expressions.
% Initialize rules array as a cell array
rules = {};

% Define the labels for readability
humidityLabels = ["poor", "good", "high"];
temperatureLabels = ["low", "moderate", "high"];
degreeOfUtilityLabels = ["veryLow", "low", "moderate", "high", "veryHigh"];
outputLabels = ["veryHigh", "high", "moderate", "low", "veryLow"]; % Inverse relationship

ruleCount = 1; % To keep track of rule numbers

for h = 1:length(humidityLabels)
    for t = 1:length(temperatureLabels)
        for d = 1:length(degreeOfUtilityLabels)
            % Determine the output based on provided criteria
            if h == 1 % If humidity is poor
                output = "veryHigh";
            elseif t == 3 % If temperature is high
                output = "veryHigh";
            else
                % Inversely related to the degree of utility
                output = outputLabels(d);
            end
            
            % creating the rule statements
            rule = "If humidity is " + humidityLabels(h) + " and temperature is " + temperatureLabels(t) + " and degree_Of_utility is " + degreeOfUtilityLabels(d) + " then HVAC_PLANT_OUTPUT is " + output + "";
            
            % Display each rule - optional
            disp(rule);
            
            % Append to the rules array
            rules{end+1} = rule;
            
            ruleCount = ruleCount + 1; % Increment rule number
        end
    end
end
%% Add the rules to the FIS.
for i = 1:length(rules)
    fis = addRule(fis, rules{i}); % Add each rule individually to the FIS
end
%% Display the rules
fis.Rules
%% To get output from fis
evalfis(fis,[0.3 0.3 0.4]);
%% plotfis displays the whole system as a block diagram.
plotfis(fis);
%% Generating the fuzzy inference system output surface
surfview(fis);% or gensurf(fis)
