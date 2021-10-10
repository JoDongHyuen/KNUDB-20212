import csv
import sys


f = open('D:simple_merged_owner_IDsssss.csv', 'r')
ff = open('D:insert_owner.txt', 'w')
rdr = csv.reader(f)

a = 0

for line in rdr:
    ff.write("insert into owner values (")
    temp = str(a)
    ff.write(temp)
    ff.write(", '" + line[0][0])
    ff.write("', '" + line[0][1] + line[0][2])
    ff.write("', '" + line[4])
    ff.write("', '" + line[2])
    ff.write("', '" + line[5])
    ff.write("', " + line[1])
    ff.write(");\n")
    print(line)
    a = a + 1
    



f.close()
ff.close()
