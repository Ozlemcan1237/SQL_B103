  ---- ***** LIKE CONDITION ***** ----
 /*
	LIKE condition WHERE ile kullanilarak SELECT, INSERT, UPDATE, veya DELETE
	statement ile calisan wildcards’a(özel sembol) izin verir.. Ve bize pattern matching yapma
	imkani verir.
	
	LIKE yerine ~~ sembollerini kullanabiliriz. Eğer büyük küçük harf gözetmeksizin kullanmak istersek ~~* sembollerini kullanırız
	
    1) % => 0 veya birden fazla karakter belirtir
	% belli degil demek
	*/ 
CREATE TABLE musteriler  (
id int UNIQUE,
isim varchar(50) NOT NULL,
gelir int
);
INSERT INTO musteriler (id, isim, gelir) VALUES (1001, 'Ali', 62000);  
INSERT INTO musteriler (id, isim, gelir) VALUES (1002, 'Ayse', 57500);  
INSERT INTO musteriler (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1004, 'Fatma', 42000);  
INSERT INTO musteriler (id, isim, gelir) VALUES (1005, 'Kasim', 44000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1006, 'ahmet', 82000); 

select * from musteriler

-- SORU : Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yaz
select * from musteriler where isim LIKE 'A%' -- burda sadece buyuk 'A' ile baslayanlari getirir
select * from musteriler where isim ILIKE 'A%' -- boyle yazarsak kucuk 'a' olanida getirir
select * from musteriler where isim ~~ 'A%'
select * from musteriler where isim ~~* 'A%' --byk kck hepsini getirir

--Ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
select isim,gelir from musteriler where isim like '%e'

--Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
select isim,gelir from musteriler where isim like '%er%'

--Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERY yaz
select * from musteriler where isim ~~ '_atma'

--Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler where isim like '_a%'

--Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler where isim like '__s%'


 ---- REGEXP_LIKE
    /*
	REGEXP_LIKE =>Daha karmaşık sorgular için herhangi bir kod, metin icerisinde istenilen yazi
	veya kod parcasinin aranip bulunmasini saglayan kendine ait soz dizimi olan bir yapidir.
	(REGEXP_LIKE) PostgreSQL de ‘’ ~ ‘’ karekteri ile kullanilir
	*/
	
CREATE TABLE kelimeler  (
id int UNIQUE,
kelime varchar(50) NOT NULL,  Harf_sayisi int
);
INSERT INTO kelimeler VALUES (1001, 'hot', 3);  
INSERT INTO kelimeler VALUES (1002, 'hat', 3);  
INSERT INTO kelimeler VALUES (1003, 'hit', 3); 
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);  
INSERT INTO kelimeler VALUES (1008, 'hct', 3); 
INSERT INTO kelimeler VALUES (1005, 'adem', 4); 
INSERT INTO kelimeler VALUES (1006, 'selim', 5);  
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);
INSERT INTO kelimeler VALUES (1009, 'hAt', 5);

select * from kelimeler

--SORU : Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini yazdiran
--       QUERY yazin
select * from kelimeler where kelime ~* 'h[ai]t'

--SORU : Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin tum bilgilerini
--yazdiran QUERY yazin
select * from kelimeler where kelime ~* 'h[a-k]t' -- a-k iksinin arasinda demek

--SORU : a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime ~* '^[as]' --baslayan deyince ^ kullaniyoruz

--SORU : m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime ~* '[mf]$' --biten diyince $ isareti kullaniriz

--NOT LIKE
--ODEV


/*
LIKE = ~~
ILIKE = ~~*
NOT LIKE = !~~
NOT ILIKE = !~~*
NOT REGEXP_LIKE = !~* NOT REGEXP_LIKE = !~
*/

-- UPPER -- LOWER -- INITCAP
/*
Tablolari yazdirirken buyuk harf, kucuk harf veya ilk harfleri buyuk digerleri
kucuk harf yazdirmak icin kullaniriz
*/

-- Kelimeler tablosundaki kelime sutunundaki verileri once hepsi buyuk harf,
--sonra kucuk harf ve ilk harfleri buyuk olacak sekilde yazdiralim
select upper(kelime) AS kelime from kelimeler;
select lower(kelime) as kelime from kelimeler;
select INITCAP(kelime) as kelime from kelimeler; --ilk harf buyuk digerlerini kucuk yazdirir

--musteriler tablosundan butun isimleri buyuk harf yapalim
select upper(isim) from musteriler
/*
Eğer birden fazla sütundaki verileri büyük küçük harf yapmak istersek
select lower(title),UPPER(isim) from personel şekilde yapabiliriz
*/