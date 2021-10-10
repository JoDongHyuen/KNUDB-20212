import random

def loc_check(loc):
    if loc.find('경대로7길') != -1:
        return True
    elif loc.find('대현로19길') != -1:
        return True
    elif loc.find('경대로5길') != -1:
        return True
    elif loc.find('대학로13길') != -1:
        return True
    elif loc.find('산격로10길') != -1:
        return True
    elif loc.find('대학로15길') != -1:
        return True
    elif loc.find('대학로17길') != -1:
        return True
    elif loc.find('대동로6길') != -1:
        return True
    elif loc.find('대학로23길') != -1:
        return True
    elif loc.find('산격로6길') != -1:
        return True
    elif loc.find('대학로9길') != -1:
        return True
    return False

f = open("data.csv", 'r')
w1 = open("STORE.txt", 'w')
# w2 = open("STORE_LOCATION.txt", 'w')
lines = f.readlines()
num = 0

for line in lines:
    data = list(line.split(','))
    
    check = loc_check(data[2])
    if not check:
        continue
    
    r = random.randrange(20,41)
    num += 1
    w1.write("INSERT INTO STORE VALUES ({}, \'{}\', \'{}\', {}, \'{}\');\n".format(num, data[1], data[0], r, data[2]))
    # w2.write("INSERT INTO STORE_LOC ({}, \"{}\");\n".format(num, data[2]))

f.close()
w1.close()
# w2.close()