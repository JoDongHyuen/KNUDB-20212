import csv
import random
import os
os.putenv('NLS_LANG', '.UTF8')

ff = open('C:/Users/Boat/Desktop/ㅈㅂ/데이터베이스/팀프/origin.sql', 'w')
country = ['한국', '한국','한국','한국','한국','한국','한국','중국', '미국', '러시아', '호주', '일본', '베트남', '필리핀', '독일', '영국', '대만', '캐나다', '칠레', '벨기에', '프랑스']

for i in range(1, 797):
    k=random.randrange(0, len(country))

    ff.write("insert into origin values ('" + str(i))
    ff.write("', " + country[k])
    ff.write("');\n")
    