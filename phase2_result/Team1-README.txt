동작환경
OS : window10
SQL*PLUS : Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

실행방법
1. Team1-Phase2-1.sql로 relation schema를 생성합니다

2. INSERT 하기전에 '%'를 가진 문자열이 있기 때문에 SET DEFINE OFF 를 우선 실행 해준 뒤에
Team2-Phase2-2.sql로 Insert를 진행합니다. 그럼에도 에러가 발생하면 .sql 파일을 메모장으로 열어준 뒤에 ANSI로 인코딩 부탁드립니다.

3. Team2-Phase2-3.sql 을 통해 작성한 20개의 Query문들을 확인하시면 됩니다.

그외 테이블에 대한 설명, 각 column에 대한 설명이 첨부된 table_specification.xlsx 파일을 첨부하였으니
확인해주시면 감사하겠습니다.