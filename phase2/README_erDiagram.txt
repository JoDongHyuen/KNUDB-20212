README수정사항

ER DIAGRAM 수정사항
	RESEARCHES를  불필요한 것 같아서 제거하였습니다.
	
	BOOKS에 time 이라는 새로운 attribute 를 추가하였습니다.

	key attributes 로 SSN 를 없에고 대신에 Customer_email를
	key attributes 로 설정하였습니다
	

	age 와 sex 를 derieved attributes 에서 normal attributes
	로 바꾸었습니다. 

	CUSTOMER 에서 Password 를 제거하였습니다.
	
	STORE에서 Store_name을 추가하였습니다.

	RATING에서 Comment 를 삭제하였습니다.

	OWNER에서 key attributes를 owner_id에서 owner_email 로 수정하였습니다.
	OWNER에서 password 를 제거하였습니다.
	OWNER에서 CUSTOMER의 정보와 비슷하게 매칭하기 위해서
	name (Lname, Fname) 과 ,age, sex 를 추가하였습니다.

	FOOD 와  COUNTRY OF ORIGIN 은 Weak Entity 관계이므로 total participate 	로 설정하였습니다.
	RATING 과 STORE 은 Weak Entity 관계이므로 total participate 	로 설정하였습니다.

	데이터를 찾다보니 가계이름이 하나이고 장소가 여러개인
	데이터를 찾기 힘들어서 
	Multi attributes 인 location 을 Normal attributes 로 바꾸었습니다.
	
	





