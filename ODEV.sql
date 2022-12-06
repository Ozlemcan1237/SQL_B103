/*
a) Yukarda verilen “personel” tablosunu olusturun
b) Tablodan maasi 5000’den az veya unvani isci olanlarin isimlerini listeleyin
c) Iscilerin tum bilgilerini listeleyin
d) Soyadi Can,Cem veya Gul olanlarin unvanlarini ve maaslarini listeleyin
e) Maasi 5000’den cok olanlarin emailve is baslama tarihlerini listeleyin
f) Maasi 5000’den cok veya 7000’den az olanlarin tum bilgilerini listeleyin
*/

create table personel
(
id int, 
isim char (10), 
soyisim varchar (20),
email varchar (20),
ise_baslama_tar date,
is_unvani varchar (20),
maas int
);

insert into personel values (123456789, 'Ali', 'Can', 'alican@gmail.com', '10-APR-10', 'isci', 5000); 
insert into personel values (123456788, 'Veli', 'Cem', 'velicem@gmail.com', '10-JAN-12', 'isci', 5500);
insert into personel values (123456787, 'Ayse', 'Gul', 'aysegul@gmail.com', '01-MAY-14', 'muhasebeci', 4500);
insert into personel values (123456788, 'Fatma', 'Yasa', 'fatmayasa@gmail.com', '10-APR-09', 'muhendis', 7500);

select * from personel



select * from personel where is_unvani = 'isci' or maas<5000;

select * from personel where is_unvani = 'isci';

select is_unvani,maas from personel where soyisim ='Can' or soyisim ='Cem' or soyisim = 'Gul';

select email,ise_baslama_tar from personel where maas>5000;

select * from personel where maas>5000 or maas<7000;


