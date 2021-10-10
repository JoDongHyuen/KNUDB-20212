import csv
import sys


f = open('D:simple_merged_ID.csv', 'r')
ff = open('D:client.txt', 'w')
rdr = csv.reader(f)

for line in rdr:
    ff.write("insert into customer values ('" + line[0][0])
    ff.write("', '" + line[0][1] + line[0][2])
    ff.write("', '" + line[4])
    ff.write("', '" + line[2])
    ff.write("', '" + line[5])
    ff.write("', " + line[1])
    ff.write(");\n")
    print(line)
    

f.close()
ff.close()
