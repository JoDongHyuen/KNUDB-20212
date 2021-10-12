-- Type1
-- 20 ~ 30세 사이 고객 조회
SELECT Fname, Lname, Age
FROM CUSTOMER
WHERE Age BETWEEN 20 and 30;

-- 가격이 4만원 이상인 음식 조회
SELECT Food_name, Price
FROM FOOD
WHERE Price >= 40000;

-- Type2
-- 맘스터치 경북대점에 예약한 사람과 시간대 조회
SELECT Store_name, Time, Fname, Lname
FROM STORE, CUST_BOOKS_STR, CUSTOMER
WHERE Customer_email = Cemail
and Bnum = Breg_number
and Store_name = '맘스터치경북대점';

-- 이름이 장현우인 사람이 가진 가게 이름과 위치 조회
SELECT Store_name, Location, Fname, Lname
FROM STORE, OWNER
WHERE Fname = '장'
AND Lname = '현우'
and Bnum = Breg_number;

-- Type3
-- 평가가 2개 이상 있는 가게 조회
SELECT Store_name, COUNT(*) AS Rating_Num
FROM STORE, RATING
WHERE Breg_number = Bnum
GROUP BY Store_name
HAVING COUNT(*) >= 2;

-- 평점 4점이상인 가게 이름과 위치 조회
SELECT Store_name, Location, ROUND(avg(Score), 1)
FROM STORE, RATING
WHERE Breg_number = Bnum
GROUP BY Store_name, Location
HAVING avg(Score) >= 4;

-- Type4
-- 최하 평점이 있는 가게이름, 위치, 음식이름
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

--최고 가격을 가진 음식이름, 원산지 조회
select f.food_name, o.country_name
from food f, origin o
where f.id = o.id
and f.price =(
    select max(price)
    from food
);

-- Type5
-- 리뷰가 없는 가게이름 조회
SELECT Store_name
FROM STORE S
WHERE NOT EXISTS(
            SELECT *
            FROM RATING R
            WHERE R.Bnum = S.Breg_Number);
            
-- 1점 평점이 존재하는 가게이름 조회
SELECT Store_name
FROM STORE S
WHERE EXISTS(
        SELECT *
        FROM RATING R
        WHERE R.Bnum = S.Breg_number
        AND R.Score = 1);

-- Type6
-- 성별이 여성인 owner의 가게의 이름과 가게종류 조회
select s.store_name, s.store_type
from owner o, store s
where o.bnum = s.breg_number
and o.sex in(
    select sex
    from owner
    where sex = ' female'
);

-- 최고 평점이 매겨진 음식이름, 가격, 평점 조회
select f.food_name, f.price, r.score
from food f, rating r
where f.bnum = r.bnum
and r.score in(
    select max(score)
    from rating
    group by r.bnum
);

-- Type7
-- 주류를 파는 가게 이름과 주류 이름, 가격 조회
SELECT Store_name, Drink_name, price
FROM (
    SELECT *
    FROM STORE, BEVERAGE
    WHERE Breg_number = Bnum)
WHERE Alcohol = 'Y';

-- 원산지가 한국인 음식, 가격 조회
SELECT Food_name, Price
FROM (
    SELECT *
    FROM FOOD natural join ORIGIN
    )
WHERE Country_name = '한국';

-- Type8
-- 평점 4점 이상 준 고객 이메일과 가게명, 평점 조회, 평점으로 내림차순
select Customer_email, Store_name, Score  
from CUSTOMER C, RATING R, STORE S
where Score > 4
AND C.Customer_email = R.Cemail
AND R.Bnum = S.Breg_number
ORDER BY Score DESC;

-- 10월 7일 이후에 예약이 있는 사람 이름과 예약 시간대 조회
SELECT C.Fname, C.Lname, TO_CHAR(B.Time, 'YYYY-MM-DD HH24:MI:SS')
FROM CUSTOMER C,  CUST_BOOKS_STR B
WHERE B.Time > '2021/10/7' 
AND C.Customer_email = B.Cemail
ORDER BY B.time;

-- Type9
--natural join 이용 30000원 이상인 음식이 1개 이상인 가게 조회
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

--미국이 원산지인 음식을 포함하는 가게의 음식 평균가격 출력
select Bnum, avg(price)
from food natural join origin
where Country_name in
                (select country_name
                from origin
                where country_name = '미국'
                )
and price > 40000
group by Bnum
order by avg(price) asc;

-- Type10
-- 판매하는 모든 음식이 한국산인 가게 조회
SELECT Store_name
FROM STORE S
WHERE NOT EXISTS(
        SELECT F.Id
        FROM  FOOD F
        WHERE F.Bnum = S.Breg_number
        
        MINUS
        
        SELECT O.Id
        FROM ORIGIN O
        WHERE O.Country_name = '한국'
        );

-- 판매하는 모든 음료가 주류인 가게 조회
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