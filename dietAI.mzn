% Declaring the input variables
int: GenderBoy1Girl2;
float: WeightKG;
float: HeightCM;
float: AgeYR;
int: RateActivity1to5;

% Activity level values
array[1..5]of float: ActivityLevelList=[1.2, 1.375, 1.55, 1.725, 1.9];

% Declaring variables
var float: ActivityLevel; %user's activity level
var float: BMR; %user's BMR(basal metabolic rate)
var float: BMI; %user's BMI(body mass index)
var float: TDEE; %user's TDEE(total daily energy expenditure)
var float: IntakeCalories= TDEE*0.75; %total calories to intake(less than TDEE for healthy diet)
var int: BMIRange; %3 types of BMI(underweight, normal, overweight)

array[1..3] of float: HighCarb=[0.60,0.25,0.15]; % Carbohydrate, Protein, Fat Ratio in High Carb
array[1..3] of float: ModerateCarb=[0.50,0.30,0.20]; % Carbohydrate, Protein, Fat Ratio in Moderate Carb
array[1..3] of float: LowCarb=[0.25,0.35,0.40]; % Carbohydrate, Protein, Fat Ratio in Low Carb
array[1..3] of var float: DietType; %3 types of diet(High Carb, Moderate Carb, Low Carb)

float: CarbValue=4; %1 gm Carbohydrate equals 4 Calories
float: ProteinValue=4; %1 gm Protein equals 4 Calories
float: FatValue=9; %1 gm Fat equals 9 Calories

% Calculate the Carbohydrate, Protein and Fat amount to intake
var float: CarbIntake= ((IntakeCalories * DietType[1]) / CarbValue);
var float: ProteinIntake= ((IntakeCalories * DietType[2]) / ProteinValue);
var float: FatIntake= ((IntakeCalories * DietType[3]) / FatValue);



% Activity Level of user
constraint ActivityLevel=ActivityLevelList[RateActivity1to5];
  
% Calculating BMR          
constraint if GenderBoy1Girl2== 1 then BMR=((10*WeightKG)+(6.25*HeightCM)-(5*AgeYR)+5) %Calculate BMR for boy
           elseif GenderBoy1Girl2== 2 then BMR=((10*WeightKG)+(6.25*HeightCM)-(5*AgeYR)-161) %Calculate BMR for girl
           else BMR=0
           endif;
          
%Calculate BMI
constraint BMI=WeightKG/(HeightCM*HeightCM/10000);

%Calculate TDEE
constraint TDEE= BMR*ActivityLevel;

% Selecting BMI Level
constraint if BMI<=18.5 then BMIRange=1
           elseif BMI>18.5 /\ BMI<=24.9 then BMIRange=2
           elseif BMI>24.9 then BMIRange=3
           else BMIRange=0
           endif;


% Selecting diet type
constraint if BMIRange==1 then (forall(t in 1..3) (DietType[t]=HighCarb[t]))
           elseif BMIRange==2 then (forall(t in 1..3) (DietType[t]=ModerateCarb[t]))
           elseif BMIRange==3 then (forall(t in 1..3) (DietType[t]=LowCarb[t]))
           else DietType=[0.0,0.0,0.0]
           endif;

% Determine the intake amounts
solve satisfy;

%Output the intake amounts
output ["\(CarbIntake)\n\(ProteinIntake)\n\(FatIntake)"];