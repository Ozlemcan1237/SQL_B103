/*
ORDER BY cumlecigi bir sorgu deyimi icerisinde belli bir sutuna gore SIRALAMA yapmak icin kullanilir
ORDER BY sutun_adi  INT==>KUCUKTEN BUYUGE  STRING==>A-Z
ORDER BY sutun_adi DESC INT==>BUYUKTEN KUCUGE  STRING==>Z-A
*/

CREATE TABLE meslekler
(
id int PRIMARY KEY,
isim VARCHAR(50),
soyisim VARCHAR(50),
meslek CHAR(9),
maas int
);	
	
	
INSERT INTO meslekler VALUES(1, 'Ali', 'Can', 'Doktor', '20000' );
INSERT INTO meslekler VALUES(2, 'Veli', 'Cem', 'Mühendis', '18000');
INSERT INTO meslekler VALUES(3, 'Mine', 'Bulut', 'Avukat', '17000');
INSERT INTO meslekler VALUES(4, 'Mahmut', 'Bulut', 'Ögretmen', '15000');
INSERT INTO meslekler VALUES (5, 'Mine', 'Yasa', 'Teknisyen', '13000');
INSERT INTO meslekler VALUES (6, 'Veli', 'Yilmaz', 'Hemşire', '12000');
INSERT INTO meslekler VALUES(7, 'Ali', 'Can', 'Marangoz', '10000' );
INSERT INTO meslekler VALUES(8, 'Veli', 'Cem', 'Tekniker', '14000');

select * from meslekler

-- SORU1: meslekler tablosunu meslek'e göre sıralayarak sorgulayınız.
select * from meslekler order by meslek;

-- SORU2: meslekler tablosunda maas'i buyukten kucuge siralayiniz
select * from meslekler order by maas desc;

-- SORU3: meslekler tablosunda maas'i kucukten buyuge siralayiniz
select * from meslekler order by maas;

-- SORU4: meslekler tablosunda isim'i 'Mine' olanları,
-- maas'a göre büyükten küçüge sıralayarak sorgulayınız
select * from meslekler 
where isim='Mine'
order by maas desc;

-- SORU5: meslekler tablosunda soyisim 'i 'Can' olanları,
-- maas sıralı olarak sorgulayınız.
select * from meslekler where soyisim='Can'
order by maas;

-- SORU6: meslekler tablosunda maası en yüksek 5 kişinin
--bilgilerini listeleyiniz
select * from meslekler order by maas desc limit 5;

-- SORU7: meslekler tablosunda en yüksek maaşı alan 3. 4. 5. 6. kişilerin 
--bilgilerini listele
select * from meslekler order by maas desc offset 2 limit 4;


CREATE TABLE magaza
(
    isim varchar(30),
    urun_adi varchar(20),
    urun_miktari int
);
	
INSERT INTO magaza VALUES( 'Hasan', 'Terlik', 3);
INSERT INTO magaza VALUES( 'Cihan', 'Kazak', 8);
INSERT INTO magaza VALUES( 'Ahmet', 'Gömlek', 9);
INSERT INTO magaza VALUES( 'Hasan', 'Terlik', 2);
INSERT INTO magaza VALUES( 'Said', 'Kazak', 3);
INSERT INTO magaza VALUES( 'Said', 'Gömlek', 6);

select * from magaza

--SORU1: Satılan urun_adi'na göre gruplandırarak,
--satılan max urun_miktari'nı ve min urun_miktari'nı,
--min urun_miktari'na göre sıralayarak listeleyiniz
select urun_adi, max(urun_miktari) as max, min(urun_miktari) as min from magaza 
group by urun_adi 
order by min;



