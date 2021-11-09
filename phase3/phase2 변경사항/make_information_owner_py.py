import csv
import sys
import random

f = open('D:\project_phase3\simple_merged_owner_IDsssss.csv', 'r')
ff = open('D:\project_phase3\insert_information_owner.txt', 'w')
rdr = csv.reader(f)

a = 0

for line in rdr:
    ff.write("insert into information values ('")
    ff.write(line[2] + "', '")
    a = random.randint(111111, 999999)
    ff.write(str(a))
    ff.write("', '")
    ff.write("owner');\n")
    print(line)



f.close()
ff.close()
