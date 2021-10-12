import csv
import random
import os
os.putenv('NLS_LANG', '.UTF8')

f = open('C:/Users/Boat/Downloads/beverage.csv  ', 'r')
ff = open('C:/Users/Boat/Desktop/ㅈㅂ/데이터베이스/팀프/beverage.sql', 'w')

rdr = csv.reader(f)
beverage = []
num = []
count = 0

for line in rdr:
    num.append(int(line[0]))
    beverage.append(line[1])

for i in range(200):
    #sql = "insert into beverage (B_BRNO, DRINKID, ALCOHOL, DRINKNAME) values (:1, :2, :3, :4)"

    if num[i] > 120:
        alcohol = 'Y'
    else:
        alcohol = 'N'
    
    count = random.randrange(1, 399)  
    price = random.randrange(10, 101) * 50

    ff.write("insert into beverage values (" + str(count))
    ff.write(", " + str(num[i]))
    ff.write(", '" + alcohol)
    ff.write("', '" + beverage[i])
    ff.write("', " + str(price))
    ff.write(");\n")
