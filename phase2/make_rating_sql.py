import csv
import random
import os

f = open('C:/Users/Boat/Downloads/rating.csv  ', 'r')
f2 = open('C:/Users/Boat/Downloads/simple_merged_ID.csv  ', 'r')
ff = open('C:/Users/Boat/Desktop/ㅈㅂ/데이터베이스/팀프/rating.sql', 'w')

rdr = csv.reader(f)
rdr2 = csv.reader(f2)
id = []
email = []
count = 1

for line in rdr:
    id.append(line[0])

for line in rdr2:
    email.append(line[2])

for i in range(len(email)-1):

    for j in range(random.randrange(0, 3)):
        bnum = random.randrange(1, 399)
        score = random.randrange(2, 11) * 0.5

        ff.write("insert into rating values (" + str(bnum))
        ff.write(", '" + email[i+1])
        ff.write("', " + str(score))
        ff.write(", " + str(count))
        ff.write(");\n")

        count += 1
