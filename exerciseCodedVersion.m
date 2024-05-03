%%Caution:
This system 

%%Sources:
%The foundation for the creating this code is created by the lecturer, in 'Intelligente systemer', and  
%is from a class acticity 'Class activity_03.pdf', and can be found on blackboard page for the subject.

%Matlab turtorial for creating command-based fuzzy logic systems has also been used as guidance. Link:
%https://se.mathworks.com/help/fuzzy/working-from-the-command-line.html

%% Developing a command-based FIS in MATLAB
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

fis = addMF(fis,"temperature","trimf",[-0.416667 0 0.3],"Name","low");
fis = addMF(fis,"temperature","trimf",[0.25 0.35 0.45],"Name","moderate");
fis = addMF(fis,"temperature","trimf",[0.4 1 1.4],"Name","high");
plotmf(fis,"input",2);

fis = addMF(fis,"degree_Of_utility","trimf",[0.0 0.2 0.4],"Name","veryLow");
fis = addMF(fis,"degree_Of_utility","trimf",[0.2 0.4 0.6],"Name","low");
fis = addMF(fis,"degree_Of_utility","trimf",[0.4 0.6 0.8],"Name","moderate");
fis = addMF(fis,"degree_Of_utility","trimf",[0.6 0.8 1],"Name","high");
fis = addMF(fis,"degree_Of_utility","trimf",[0.8 1 1.4],"Name","veryHigh");
fis = addOutput(fis,[0 1],"Name","HVAC_PLANT_OUTPUT");


fis = addMF(fis,"HVAC_PLANT_OUTPUT","trimf",[0.0 0.2 0.4],"Name","veryLow");
fis = addMF(fis,"HVAC_PLANT_OUTPUT","trimf",[0.2 0.4 0.6],"Name","low");
fis = addMF(fis,"HVAC_PLANT_OUTPUT","trimf",[0.4 0.6 0.8],"Name","moderate");
fis = addMF(fis,"HVAC_PLANT_OUTPUT","trimf",[0.6 0.8 1],"Name","high");
fis = addMF(fis,"HVAC_PLANT_OUTPUT","trimf",[0.8 1 1.4],"Name","veryHigh");
%%plotmf(fis,"output",1);
rules = {};

% Define the labels for readability
humidityLabels = ["poor", "good", "high"];
temperatureLabels = ["low", "moderate", "high"];
degreeOfUtilityLabels = ["veryLow", "low", "moderate", "high", "veryHigh"];
outputLabels = ["veryHigh", "high", "moderate", "low", "veryLow"]; 

ruleCount = 1; 

for h = 1:length(humidityLabels)
    for t = 1:length(temperatureLabels)
        for d = 1:length(degreeOfUtilityLabels)

            if h == 1 % If humidity is poor
                output = "veryHigh";
            elseif t == 3 % If temperature is high
                output = "veryHigh";
            else
                output = outputLabels(d);
            end
            
            % creating the rule statements
            rule = "If humidity is " + humidityLabels(h) + " and temperature is " + temperatureLabels(t) + " and degree_Of_utility is " + degreeOfUtilityLabels(d) + " then HVAC_PLANT_OUTPUT is " + output + "";
            
            disp(rule);
            
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

