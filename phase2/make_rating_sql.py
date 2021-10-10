import csv
import random
import os

f = open('C:/Users/Boat/Downloads/rating.csv  ', 'r')
ff = open('C:/Users/Boat/Desktop/ㅈㅂ/데이터베이스/팀프/rating.sql', 'w')

rdr = csv.reader(f)
id = []
count = 0

for line in rdr:
    id.append(line[0])

for i in range(1194):
    #sql = "insert into beverage (B_BRNO, DRINKID, ALCOHOL, DRINKNAME) values (:1, :2, :3, :4)"

    score = random.randrange(2, 10) * 0.5
    if(i%3 == 0):
        count += 1

    ff.write("insert into rating values (" + str(count))
    ff.write(", 'email'")
    ff.write(", " + str(score))
    ff.write(", " + id[i])
    ff.write(");\n")
