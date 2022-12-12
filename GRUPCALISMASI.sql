CREATE TABLE ogrenciler
(
  id int,
  isim varchar(50),
  sehir varchar(50),
  puan int,
  bolum varchar(20)
);
INSERT INTO ogrenciler VALUES(100, 'Ahmet Ümit', 'İstanbul', 546, 'Bilgisayar Müh.');
INSERT INTO ogrenciler VALUES(101, 'R.Nuri Güntekin', 'Antalya', 486, 'İşletme');
INSERT INTO ogrenciler VALUES(102, 'S.Faik Abasıyanık', 'Bursa', 554, 'Bilgisayar Müh.');
INSERT INTO ogrenciler VALUES(103, 'Yaşar Kemal', 'İstanbul', 501, 'Matematik');
INSERT INTO ogrenciler VALUES(104, 'Halide E. Adıvar', 'İzmir', 473, 'Psikoloji');
INSERT INTO ogrenciler VALUES(105, 'Nazan Bekiroğlu', 'İzmir', 432, 'Edebiyat');
INSERT INTO ogrenciler VALUES(106, 'Peyami Safa', 'Antalya', 535, 'Bilgisayar Müh.');
INSERT INTO ogrenciler VALUES(107, 'Sabahattin Ali', 'İstanbul', 492, 'Matematik');

CREATE TABLE bolumler
(
  bolum_id int,
  bolum varchar(20),
  taban_puanı int,
  kampus varchar(20)
);
INSERT INTO bolumler VALUES(5001, 'Bilgisayar Müh.', 521,'Kuzey');
INSERT INTO bolumler VALUES(5002, 'Matematik', 455,'Güney');
INSERT INTO bolumler VALUES(5003, 'Psikoloji', 440,'Hisar');
INSERT INTO bolumler VALUES(5004, 'İşletme', 465,'Hisar');
INSERT INTO bolumler VALUES(5005, 'Edebiyat', 420,'Kuzey');

select * from ogrenciler

--1)Puanı, taban puanı en yüksek olan bölümün puanından yüksek olan öğrencilerin isim ve sehirlerini listeleyiniz.
select isim , sehir , puan from ogrenciler where puan > (select max (taban_puanı) from bolumler)

--2)Taban puanı 460 dan az olan bölümlerdeki öğrencilerin isimlerini ve bölümlerini listeleyiniz.
select isim , bolum from ogrenciler where bolum in (select bolum from bolumler where taban_puanı<460)

--3)İstanbulda yaşayan öğrencilerin bölümlerini ve taban puanlarını listeleyiniz.
select bolum , taban_puanı from bolumler where bolum in (select bolum from ogrenciler where sehir = 'İstanbul')

--4)Kuzey kampüsündeki bölümlerde okuyan öğrencilerin isimlerini, bölümlerini ve puanlarını listeleyiniz.
select isim , bolum , puan from ogrenciler where bolum in (select bolum from bolumler where kampus = 'Kuzey')

--5)Puanı 500 den büyük olan öğrencilerin bölümlerinin adını ve kampüslerini listeleyiniz.
select bolum , kampus from bolumler where bolum in (select bolum from ogrenciler where puan>500)

--6)Puanı taban puanlarının ortalamasından yüksek olan öğrencilerin isim ve puanlarını listeleyiniz.
select isim , puan from ogrenciler where puan > (select avg (taban_puanı) from bolumler)

--7)Bölüm isimlerini, kampüslerini ve her bölümde okuyan öğrencilerin en yüksek puanlarını listeleyiniz.
select  bolum , kampus,  (select max (puan) from ogrenciler where ogrenciler.bolum = bolumler.bolum) from bolumler

--8) Her bölümün ismini ve bölümde okuyan öğrencilerin kaç farklı şehirden geldiğini listeleyiniz.
select bolum , (select count (distinct sehir) from ogrenciler where ogrenciler.bolum = bolumler.bolum) from bolumler

--9) Taban puanı öğrencilerin puan ortalamasından düşük olan ve hisar kampüsünde olan bölümleri listeleyiniz.
select * from bolumler where taban_puanı< (select avg (puan) from ogrenciler) and kampus = 'Hisar'

--10)Hisar veya Güney kampüsünde okuyan öğrencilerin isimlerini listeleyiniz.
select * from ogrenciler where bolum in (select bolum from bolumler where kampus = 'Hisar' or kampus = 'Güney')