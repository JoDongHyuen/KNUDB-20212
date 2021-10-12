import csv
import random
import os
os.putenv('NLS_LANG', '.UTF8')

f = open('C:/Users/Boat/Downloads/food.csv', 'r')
ff = open('C:/Users/Boat/Desktop/ㅈㅂ/데이터베이스/팀프/food.sql', 'w')

rdr = csv.reader(f)
food = []
num= 0
count = 0

for line in rdr:
    food.append(line[1])

for i in range(len(food)):
#    sql = "insert into food values (:1, :2, :3, :4)"
    num = num + 1
    price = random.randrange(10, 101) * 500
    
    if i%2==0:
        count = count + 1

    ff.write("insert into food values (" + str(count))
    ff.write(", " + str(num))
    ff.write(", " + str(price))
    ff.write(", '" + food[i])
    ff.write("');\n")

    if(num == 796):
        break

print(num)
    