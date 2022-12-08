   -- DISTINCT KULLANIMI
   
-- DISTINCT clause, çağrılan terimlerden tekrarlı olanların sadece birincisini alır.

CREATE TABLE maas 
(
id int, 
musteri_isim varchar(50),
maas int 
);

INSERT INTO maas VALUES (10, 'Ali', 5000); 
INSERT INTO maas VALUES (10, 'Ali', 7500); 
INSERT INTO maas VALUES (20, 'Veli', 10000); 
INSERT INTO maas VALUES (30, 'Ayse', 9000); 
INSERT INTO maas VALUES (20, 'Ali', 6500); 
INSERT INTO maas VALUES (10, 'Adem', 8000); 
INSERT INTO maas VALUES (40, 'Veli', 8500); 
INSERT INTO maas VALUES (20, 'Elif', 5500);

select * from maas

-- Musteri urun tablosundan urun isimlerini tekrarsiz(grup) listeleyin

-- group by cozumu
select urun_isim from musteri_urun
group by urun_isim

-- distinct cozumu
select distinct(urun_isim) from musteri_urun

-- Tabloda kac farkli meyve vardir 
select urun_isim,count(urun_isim) from musteri_urun
group by urun_isim

select urun_isim,count(distinct urun_isim) from musteri_urun
group by urun_isim --tekrarsiz veriyor

  ---- *** FETCH NEXT (SAYI) ROW ONLY- OFFSET - LIMIT *** ----
  
-- Musteri urun tablosundan ilk 3 kaydi listeleyin
select * from musteri_urun order by urun_id
FETCH NEXT 3 ROW ONLY


-- LIMIT
select * from musteri_urun order by urun_id
limit 3

-- Musteri urun tablosundan ilk kaydi listeleyin
select * from musteri_urun order by urun_id
limit 1

-- Musteri urun tablosundan son 3 kaydi listeleyin
select * from musteri_urun order by urun_id desc
limit 3

-- En yuksek maasi alan musteriyi listeleyiniz
select * from maas order by maas desc limit 1

-- Satir atlamak istedigimizde offset kullaniriz
-- Maas tablosundan en yuksek ikinci maasi listeleyiniz
select * from maas order by maas desc limit 1 offset 1

select * from maas order by maas desc
offset 1 row
fetch next 1 row only

-- Maas tablosundan en dusuk 4. maasi listeleyiniz
select * from maas order by maas offset 3 limit 1



		---- ****  ALTER TABLE STATEMENT  **** ----
	/*				
	ALTER TABLE statement tabloda add, Type(modify)/Set, Rename veya drop columns
	islemleri icin kullanilir.
	ALTER TABLE statement tablolari yeniden isimlendirmek icin de kullanilir.
 */
drop table personel

CREATE TABLE personel  (
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select * from personel

--1) ADD default deger ile tabloya bir field ekleme
ALTER TABLE personel
ADD ulke varchar(30)

ALTER TABLE personel
ADD adres varchar(50) DEFAULT 'Turkiye'

ALTER TABLE personel
ADD zipcode varchar(30)

--2) DROP tablodan sutun silme
alter table personel
drop column ulke

alter table personel
drop  zipcode


alter table personel
drop  adres,drop sirket --iki sutunu birden sildik


--3) RENAME COLUMN sutun adi degistirme

alter table personel
rename column sehir to il

--4) RENAME tablonun ismini degistirme
alter table personel
rename to isci

select * from isci

--5) TYPE/SET(modify) sutunlarin ozelliklerini degistirme
alter table isci
alter column il type varchar(30),
alter column maas set not null;

/*
Eger numeric data turune sahip bir sutunun data turune string bir data turu atamak istersek
type varchar(30) using (maas::varchar(30)) bu formati kullaniriz
*/
alter table isci
alter column maas
type varchar(30) using (maas::varchar(30))



	---- **** TRANSACTION (BEGIN - SAVEPOINT - ROLLBACK - COMMIT **** ----
/*			
	Transaction veritabani sistemlerinde bir islem basladiginda baslar ve bitince sona erer. Bu
	islemler veritabani olusturma, veri silme, veri guncelleme, veriyi geri getirme gibi islemler olabilir.
	
	Transaction baslatmak icin BEGIN komutu kullanmamiz gerekir ve Transaction'i sonlandirmak icin
	COMMIT komutunu calistirmaliyiz.
 */
CREATE TABLE ogrenciler2
(
id serial, --serial data turu otomatik olarak 1'den baslayarak sirali olarak sayi atamasi yapar
	       --insert into ile veri eklerken serial data turunu kullandigim veri degeri yarine default yazariz
	       --serial tavsiye edilmez
	   --Save pointten sonra ekledigimiz
	--veride sayac mantigi ile calistigi icin sayacta en son hangi sayida kaldiysa ordan devam eder.
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);

BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to x;
COMMIT; --commit yapmadan transaction blogundan cikmazsan, hep hata alirsin diger tablolarda

select * from ogrenciler2
delete from ogrenciler2
drop table ogrenciler2

/*
NOT :PostgreSQL de Transaction kullanımı için «Begin;» komutuyla başlarız sonrasında tekrar
	yanlış bir veriyi düzelmek veya bizim için önemli olan verilerden
	sonra ekleme yapabilmek için "SAVEPOINT savepointismi" komutunu
	kullanırız ve bu savepointe dönebilmek için "ROLLBACK TO savepointismi" komutunu
	kullanırız ve rollback çalıştırıldığında savepoint yazdığımız satırın üstündeki
	verileri tabloda bize verir ve son olarak Transaction'ı sonlandırmak için mutlaka
	"COMMIT" komutu kullanılır.
*/

