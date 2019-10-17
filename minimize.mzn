%include table data structure
include "table.mzn";

%Input Intake carbohydrate, protein and fat amount 
int: intake_carb;
int: intake_protein;
int: intake_fat;

% Determine Carb Protein and Fat amount for Breakfast (30 percent of total)
int: breakfast_carb = (intake_carb * 30) div 100;
int: breakfast_protein= (intake_protein * 30) div 100;
int: breakfast_fat=(intake_fat* 30) div 100;

% Determine Carb Protein and Fat amount for Lunch (50 percent of total)
int: lunch_carb=(intake_carb * 50) div 100;
int: lunch_protein=(intake_protein * 50) div 100;
int: lunch_fat=(intake_fat* 50) div 100;

% Determine Carb Protein and Fat amount for Dinner (20 percent of total)
int: dinner_carb=(intake_carb * 20) div 100;
int: dinner_protein=(intake_protein * 20) div 100;
int: dinner_fat=(intake_fat* 20) div 100;




%Data structure
%Breakfast Types
set of FOOD: breakfast_desserts;
set of FOOD: breakfast_mains;
set of FOOD: breakfast_sides;

%Lunch Types
set of FOOD: lunch_desserts;
set of FOOD: lunch_mains;
set of FOOD: lunch_sides;

%Dinner Types
set of FOOD: dinner_desserts;
set of FOOD: dinner_mains;
set of FOOD: dinner_sides;

%Declare Features of Food items
enum FEATURE={name, amount, cost, carb, protein, fat}; 
enum FOOD; 
array[FOOD,FEATURE] of int: dd; % food database

%Declare array of different food types
array[FEATURE] of var int: breakfast_main;
array[FEATURE] of var int: breakfast_side;
array[FEATURE] of var int: breakfast_dessert;

array[FEATURE] of var int: lunch_main;
array[FEATURE] of var int: lunch_side;
array[FEATURE] of var int: lunch_dessert;

array[FEATURE] of var int: dinner_main;
array[FEATURE] of var int: dinner_side;
array[FEATURE] of var int: dinner_dessert;

%Budget Variables
var int: budget;
var int: dinner_budget;
var int: lunch_budget;
var int: breakfast_budget;

%food items
FOOD = {EggPoach, CookedRice, Apple, Chicken, GreenVegetableAndLentil, Porota, Beef, Fish, Bread, Ruti, Mutton, Lentils, Milk, Curd, Mango, Tangerine, MashedPotato, Banana, Lemonade, Jam, Tea};

%Food list (Name,                  Amount,  Cost,   Carbohydrate, Protein, Fat)
dd=    [| EggPoach,                 100,    15,     13,          18,      5
        | Jam,                      50,     40,     13,          10,      13
        | CookedRice,               250,    20,     55,          20,       8
        | Lemonade,                 100,    15,     5,           3,        4
        | Banana,                   1,      7,      5,           3,        3
        | Apple,                    1,      25,     6,           22,       2
        | Chicken,                  100,    40,     11,          18,       2  
        | GreenVegetableAndLentil  ,250,    20,     25,          51,      20
        | MashedPotato,             150,    15,     30,          15,      14
        | Tea,                      1,      5,      1,           1,       1
        | Beef,                     100,    50,     25,          35,      8
        | Fish,                     150,    75,     4,           53,      13
        | Bread,                    3,      10,     17,          18,      9
        | Ruti,                     3,      15,     23,          5,       8
        | Mutton,                   50,     40,     6,           15,      5
        | Lentils,                  100,    15,     10,          40,      8
        | Milk,                     120,    20,     20,          50,      40
        | Curd,                     100,    25,     2,           18,      15
        | Mango,                    1,      30,     8,           10,      1
        | Tangerine,                1,      25,     4,           2,       3
        | Porota,                   3,      18,     27,          7,       5    |];
 
        
% Food Type List       
% Breakfast Menu
breakfast_desserts = { Apple, Mango, Banana, Tangerine };
breakfast_mains = {Porota, Bread, Ruti};
breakfast_sides = { EggPoach, Lentils, Jam};

% Lunch Menu
lunch_desserts = { Milk, Lemonade, Curd};
lunch_mains = { CookedRice, Porota, Ruti, MashedPotato };
lunch_sides = { Chicken, GreenVegetableAndLentil, Beef, Fish, Mutton};

% Dinner Menu
dinner_desserts = { Apple, Mango, Milk, Banana, Curd, Tangerine };
dinner_mains = { CookedRice, Porota, Bread, Ruti, MashedPotato };
dinner_sides = { Chicken, GreenVegetableAndLentil, Beef, Fish, Mutton};

%Constraints
constraint breakfast_main[name] in breakfast_mains;
constraint breakfast_side[name] in breakfast_sides;
constraint breakfast_dessert[name] in breakfast_desserts;

constraint lunch_main[name] in lunch_mains;
constraint lunch_side[name] in lunch_sides;
constraint lunch_dessert[name] in lunch_desserts;

constraint dinner_main[name] in dinner_mains;
constraint dinner_side[name] in dinner_sides;
constraint dinner_dessert[name] in dinner_desserts;


constraint table(breakfast_main, dd);
constraint table(breakfast_side, dd);
constraint table(breakfast_dessert, dd);

constraint table(lunch_main, dd);
constraint table(lunch_side, dd);
constraint table(lunch_dessert, dd);

constraint table(dinner_main, dd);
constraint table(dinner_side, dd);
constraint table(dinner_dessert, dd);


constraint breakfast_main[carb] + breakfast_side[carb] + breakfast_dessert[carb] < (breakfast_carb + 10) ;
constraint breakfast_main[carb] + breakfast_side[carb] + breakfast_dessert[carb] > (breakfast_carb - 10) ;
constraint breakfast_main[protein] + breakfast_side[protein] + breakfast_dessert[protein] < (breakfast_protein+10) ;
constraint breakfast_main[protein] + breakfast_side[protein] + breakfast_dessert[protein] > (breakfast_protein-10) ;
constraint breakfast_main[fat] + breakfast_side[fat] + breakfast_dessert[fat] < (breakfast_fat+10) ;
constraint breakfast_main[fat] + breakfast_side[fat] + breakfast_dessert[fat] > (breakfast_fat-10) ;

constraint lunch_main[carb] + lunch_side[carb] + lunch_dessert[carb] <(lunch_carb+10 );
constraint lunch_main[carb] + lunch_side[carb] + lunch_dessert[carb] >(lunch_carb-10 );
constraint lunch_main[protein]+lunch_side[protein]+lunch_dessert[protein] <(lunch_protein+10) ;
constraint lunch_main[protein]+lunch_side[protein]+lunch_dessert[protein] >(lunch_protein-10 );
constraint lunch_main[fat] + lunch_side[fat] + lunch_dessert[fat] <(lunch_fat+10) ;
constraint lunch_main[fat] + lunch_side[fat] + lunch_dessert[fat] >(lunch_fat-10) ;

constraint dinner_main[carb] + dinner_side[carb] + dinner_dessert[carb] <(dinner_carb+10) ;
constraint dinner_main[carb] + dinner_side[carb] + dinner_dessert[carb] >(dinner_carb-10 );
constraint dinner_main[protein] + dinner_side[protein] + dinner_dessert[protein] <(dinner_protein + 10 );
constraint dinner_main[protein] + dinner_side[protein] + dinner_dessert[protein] >(dinner_protein - 10 );
constraint dinner_main[fat] + dinner_side[fat] + dinner_dessert[fat] <(dinner_fat+10) ;
constraint dinner_main[fat] + dinner_side[fat] + dinner_dessert[fat] >(dinner_fat-10) ;



%Calculate Cost of breakfast, lunch and dinner
constraint breakfast_budget = breakfast_main[cost] + breakfast_side[cost] + breakfast_dessert[cost];
constraint lunch_budget = lunch_main[cost] + lunch_side[cost] + lunch_dessert[cost];
constraint dinner_budget = dinner_main[cost] + dinner_side[cost] + dinner_dessert[cost];

%Calculate total cost of all food items
constraint budget=breakfast_budget +lunch_budget+dinner_budget;

%Minimize budget
solve minimize budget;

%Printing the outputs
output ["breakfast_main = "++show(to_enum(FOOD,breakfast_main[name]))++",  "++" breakfast_side = "++show(to_enum(FOOD,breakfast_side[name]))++ ", breakfast_dessert = "++show(to_enum(FOOD,breakfast_dessert[name]))++", cost = "++show(breakfast_budget)++" \n"++"lunch_main = "++show(to_enum(FOOD,lunch_main[name]))++",  "++" lunch_side = "++show(to_enum(FOOD,lunch_side[name]))++ ", lunch_dessert = "++show(to_enum(FOOD,lunch_dessert[name]))++", cost = "++show(lunch_budget)++" \n"++"dinner_main = "++show(to_enum(FOOD,dinner_main[name]))++",  "++" dinner_side = "++show(to_enum(FOOD,dinner_side[name]))++ ", dinner_dessert = "++show(to_enum(FOOD,dinner_dessert[name]))++", cost = "++show(dinner_budget)++"\n"];


        

        


