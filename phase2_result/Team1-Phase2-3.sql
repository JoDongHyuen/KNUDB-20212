-- Type1
-- 20 ~ 30�� ���� �� ��ȸ
SELECT Fname, Lname, Age
FROM CUSTOMER
WHERE Age BETWEEN 20 and 30;

-- ������ 4���� �̻��� ���� ��ȸ
SELECT Food_name, Price
FROM FOOD
WHERE Price >= 40000;

-- Type2
-- ������ġ ��ϴ����� ������ ����� �ð��� ��ȸ
SELECT Store_name, Time, Fname, Lname
FROM STORE, CUST_BOOKS_STR, CUSTOMER
WHERE Customer_email = Cemail
and Bnum = Breg_number
and Store_name = '������ġ��ϴ���';

-- �̸��� �������� ����� ���� ���� �̸��� ��ġ ��ȸ
SELECT Store_name, Location, Fname, Lname
FROM STORE, OWNER
WHERE Fname = '��'
AND Lname = '����'
and Bnum = Breg_number;

-- Type3
-- �򰡰� 2�� �̻� �ִ� ���� ��ȸ
SELECT Store_name, COUNT(*) AS Rating_Num
FROM STORE, RATING
WHERE Breg_number = Bnum
GROUP BY Store_name
HAVING COUNT(*) >= 2;

-- ���� 4���̻��� ���� �̸��� ��ġ ��ȸ
SELECT Store_name, Location, ROUND(avg(Score), 1)
FROM STORE, RATING
WHERE Breg_number = Bnum
GROUP BY Store_name, Location
HAVING avg(Score) >= 4;

-- Type4
-- ���� ������ �ִ� �����̸�, ��ġ, �����̸�
select distinct s.store_name, s.location, f.Food_name
from food f, rating r, store s
where f.bnum = r.bnum
and s.breg_number = r.bnum
and f.bnum = s. breg_number
and r.score =(
    select min(score)
    from rating
    group by r.bnum
); 

--�ְ� ������ ���� �����̸�, ������ ��ȸ
select f.food_name, o.country_name
from food f, origin o
where f.id = o.id
and f.price =(
    select max(price)
    from food
);

-- Type5
-- ���䰡 ���� �����̸� ��ȸ
SELECT Store_name
FROM STORE S
WHERE NOT EXISTS(
            SELECT *
            FROM RATING R
            WHERE R.Bnum = S.Breg_Number);
            
-- 1�� ������ �����ϴ� �����̸� ��ȸ
SELECT Store_name
FROM STORE S
WHERE EXISTS(
        SELECT *
        FROM RATING R
        WHERE R.Bnum = S.Breg_number
        AND R.Score = 1);

-- Type6
-- ������ ������ owner�� ������ �̸��� �������� ��ȸ
select s.store_name, s.store_type
from owner o, store s
where o.bnum = s.breg_number
and o.sex in(
    select sex
    from owner
    where sex = ' female'
);

-- �ְ� ������ �Ű��� �����̸�, ����, ���� ��ȸ
select f.food_name, f.price, r.score
from food f, rating r
where f.bnum = r.bnum
and r.score in(
    select max(score)
    from rating
    group by r.bnum
);

-- Type7
-- �ַ��� �Ĵ� ���� �̸��� �ַ� �̸�, ���� ��ȸ
SELECT Store_name, Drink_name, price
FROM (
    SELECT *
    FROM STORE, BEVERAGE
    WHERE Breg_number = Bnum)
WHERE Alcohol = 'Y';

-- �������� �ѱ��� ����, ���� ��ȸ
SELECT Food_name, Price
FROM (
    SELECT *
    FROM FOOD natural join ORIGIN
    )
WHERE Country_name = '�ѱ�';

-- Type8
-- ���� 4�� �̻� �� �� �̸��ϰ� ���Ը�, ���� ��ȸ, �������� ��������
select Customer_email, Store_name, Score  
from CUSTOMER C, RATING R, STORE S
where Score > 4
AND C.Customer_email = R.Cemail
AND R.Bnum = S.Breg_number
ORDER BY Score DESC;

-- 10�� 7�� ���Ŀ� ������ �ִ� ��� �̸��� ���� �ð��� ��ȸ
SELECT C.Fname, C.Lname, TO_CHAR(B.Time, 'YYYY-MM-DD HH24:MI:SS')
FROM CUSTOMER C,  CUST_BOOKS_STR B
WHERE B.Time > '2021/10/7' 
AND C.Customer_email = B.Cemail
ORDER BY B.time;

-- Type9
--natural join �̿� 30000�� �̻��� ������ 1�� �̻��� ���� ��ȸ
select Breg_number as bnum, Store_name, count(*)
from Store natural join food
where price in 
   (select price
   from food
   where price >= 30000
   )
and breg_number = Bnum
group by Breg_number, Store_name
having count(*) >= 1
order by bnum asc;

--�̱��� �������� ������ �����ϴ� ������ ���� ��հ��� ���
select Bnum, avg(price)
from food natural join origin
where Country_name in
                (select country_name
                from origin
                where country_name = '�̱�'
                )
and price > 40000
group by Bnum
order by avg(price) asc;

-- Type10
-- �Ǹ��ϴ� ��� ������ �ѱ����� ���� ��ȸ
SELECT Store_name
FROM STORE S
WHERE NOT EXISTS(
        SELECT F.Id
        FROM  FOOD F
        WHERE F.Bnum = S.Breg_number
        MINUS
        SELECT O.Id
        FROM ORIGIN O
        WHERE O.Country_name = '�ѱ�'
        );

-- �Ǹ��ϴ� ��� ���ᰡ �ַ��� ���� ��ȸ
SELECT Store_name
FROM STORE S
WHERE NOT EXISTS(
        SELECT B.Id
        FROM  BEVERAGE B
        WHERE B.Bnum = S.Breg_number
        AND B.Alcohol = 'Y'
        MINUS
        SELECT E.Id
        FROM BEVERAGE E
        WHERE E.Alcohol = 'Y'
        );