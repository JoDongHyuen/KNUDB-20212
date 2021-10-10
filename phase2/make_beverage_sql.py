import csv
import random
import os
os.putenv('NLS_LANG', '.UTF8')

f = open('C:/Users/Boat/Downloads/beverage.csv  ', 'r')
ff = open('C:/Users/Boat/Desktop/ㅈㅂ/데이터베이스/팀프/food.sql', 'w')

rdr = csv.reader(f)
beverage = []

num= 0

for line in rdr:
    food.append(line[1])

#    sql = "insert into food values (:1, :2, :3, :4)"
    num = num + 1
    price = random.randrange(10, 100) * 500

    ff.write("insert into customer values ('1'")
    ff.write("', '" + str(num))
    ff.write("', '" + str(price))
    ff.write("', '" + line[1])
    ff.write("');\n")

    if(num == 796):
        break

print(num)
    