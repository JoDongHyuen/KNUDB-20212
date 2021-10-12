import csv
import random
import os
import datetime

def random_date(start, end):
    delta = end - start
    int_delta = (delta.days * 24 * 60 * 60) + delta.seconds
    random_second = random.randrange(int_delta)
    return start + datetime.timedelta(seconds=random_second)

os.putenv('NLS_LANG', '.UTF8')

f = open('C:/Users/Boat/Downloads/simple_merged_ID.csv  ', 'r')
ff = open('C:/Users/Boat/Desktop/ㅈㅂ/데이터베이스/팀프/cust_books_str.sql', 'w')

rdr = csv.reader(f)

email = []
starttime='2021/09/30 1:00'
endtime = '2021/10/12 9:00'

d1 = datetime.datetime.strptime(starttime, '%Y/%m/%d %I:%M')
d2 = datetime.datetime.strptime(endtime, '%Y/%m/%d %I:%M')

for line in rdr:
    email.append(line[2])

for i in range(len(email) - 1):
#    sql = "insert into cust_books_str values (:1, :2, :3, :4)"
    n = random.randrange(0, 3)#0에서 2개

    for j in range(n):
        rand_bnum = random.randrange(1, 399)
        r_date = random_date(d1, d2)

        ff.write("insert into cust_books_str values ('" + email[i+1])
        ff.write("', " + str(rand_bnum))
        ff.write(", TO_DATE('" + str(r_date))
        ff.write("', 'YYYY-MM-DD HH24:MI:SS'));\n")
