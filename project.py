import pymzn
solns = pymzn.minizinc('DietAI.mzn','DietAI.dzn' ,output_mode='item')
solList = solns[0].split('\n')
for i in range(len(solList)) :
    solList[i] = int(float(solList[i]))


fp = open("minimize.dzn","w")
titleList = ["intake_carb","intake_protein","intake_fat"]
j = 0
for i in range(len(solList)):
    str1 = titleList[j] + " = "+  str( int(solList[i]) ) + ";\n"
    # print(str1)
    j +=1
    fp.write(str1)
    # fp.write(str2)
fp.close()
print("Your Diet is:")

solns = pymzn.minizinc('minimize.mzn','minimize.dzn' ,output_mode='item')
print(solns)