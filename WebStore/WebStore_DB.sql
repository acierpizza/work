-- 1.0 stworz baze danych "Sklep odziezowy"

CREATE DATABASE Sklep_odziezowy;
USE Sklep_odziezowy;

-- 2.0 stworz tabele "Producenci"

CREATE TABLE Producenci (
	id_producenta INT PRIMARY KEY,
	nazwa_producenta VARCHAR(200) NOT NULL,
	adres_producenta VARCHAR(200) NOT NULL,
	nip_producenta VARCHAR(20) NOT NULL,
	data_podpisania_umowy DATE NOT NULL
);

-- 3.0 stworz tabele "Produkty"

CREATE TABLE Produkty (
	id_produktu INT PRIMARY KEY,
	id_producenta INT,
	nazwa_produktu VARCHAR(200) NOT NULL,
	opis_produktu TEXT,
	cena_netto_zakupu DECIMAL(10, 2) NOT NULL,
	cena_brutto_zakupu DECIMAL(10, 2) NOT NULL,
	cena_netto_sprzedazy DECIMAL(10, 2) NOT NULL,
	cena_brutto_sprzedazy DECIMAL(10, 2) NOT NULL,
	procent_VAT_sprzedazy DECIMAL(5, 2) NOT NULL, 
    
FOREIGN KEY (id_producenta) REFERENCES Producenci(id_producenta)
);

-- 4.0 stworz tabele "Zamowienia" --  FOREIGN KEY (id_klienta) REFERENCES Klienci(id_klienta)
CREATE TABLE Zamowienia (
  id_zamowienia INT PRIMARY KEY,
  id_klienta INT,
  id_produktu INT,
  data_zamowienia DATE NOT NULL,
  
  FOREIGN KEY (id_produktu) REFERENCES Produkty(id_produktu)
);

-- 5.0 stworz tabele "Klienci"
	
CREATE TABLE Klienci (    
    id_klienta INT PRIMARY KEY,
	id_zamowienia INT,
	imie VARCHAR(200) NOT NULL,
	nazwisko VARCHAR(200) NOT NULL,
	adres NVARCHAR(200) NOT NULL,
  
  FOREIGN KEY (id_zamowienia) REFERENCES Zamowienia(id_zamowienia)
  );

-- 6.0 polacz tabele za pomoca kluczy obcych:
-- a. Produkty – Producenci
-- wspolna kolumna: id_producenta czyli laczymy po id producenta 

SELECT *
FROM Produkty P
LEFT JOIN Producenci Pci ON  pci.id_producenta = p.id_producenta
ORDER BY nazwa_produktu
; 

-- b. Zamowienia – Produkty
-- wspolna kolumna: id_produktu

SELECT *
FROM Zamowienia Z
LEFT JOIN Produkty P ON  z.id_produktu = p.id_produktu
; 

-- c. Zamowienia - Klienci
-- wspolna kolumna: id_zamowienia lub id_klienta

SELECT *
FROM Zamowienia Z
LEFT JOIN Klienci K ON z.id_zamowienia  = k.id_zamowienia 
; 

-- 7.0 Każdą tabelę uzupełnij danymi wg:

-- a. Tabela „Producenci” – 4 pozycje
INSERT INTO Producenci (id_producenta, nazwa_producenta, adres_producenta,nip_producenta,data_podpisania_umowy) 
	VALUES 
	(1, 'Dom Ksiazki Sp. z.o.o', 'Jagielonska 32, Szczecin', '1234567890', '2023-01-02'),
	(2, 'Regaly Marcin Domanski ', 'Swiety Marcin 12, Poznan', '9876543210', '2022-02-15'),
	(3, 'Books24.pl', 'Piotrkowska 44, Lodz', '5432109876', '2021-03-10'),
	(4, 'GeoMapy Sp.z.o.o', 'Kopernika 23, Warszawa', '0123456789', '2022-04-20');
    ; 

SELECT *
FROM Producenci;

-- b. Tabela „Produkty” – 20 pozycji
INSERT INTO Produkty 
(id_produktu, 
id_producenta, 
nazwa_produktu, 
opis_produktu, 
cena_netto_zakupu, 
cena_brutto_zakupu, 
cena_netto_sprzedazy, 
cena_brutto_sprzedazy,
procent_VAT_sprzedazy)
VALUES
  (1, 1, 'Ksiazka: Pan Tadeusz', 'Najwazniejszy poemat Adama Mickiewicza, opisujacy losy Polakow w czasach zaborow.', 30.00, 36.90, 40.00, 49.20, 23),
  (2, 1, 'Ksiazka: W pustyni i w puszczy', 'Przygody dwoch polskich dzieci, Nel i Stasia, w Afryce.', 25.00, 30.75, 35.00, 43.05, 23),
  (3, 1, 'Ksiazka: Ogniem i mieczem', 'Historia Rzeczypospolitej w czasach potopu szwedzkiego.', 35.00, 43.05, 45.00, 55.35, 23),
  (4, 2, 'Regal drewniany', 'Solidny drewniany regal do przechowywania ksiazek i dekoracji.', 200.00, 246.00, 250.00, 307.50, 23),
  (5, 2, 'Regal metalowy', 'Wytrzymaly regal metalowy z regulowanymi polkami.', 150.00, 184.50, 200.00, 246.00, 23),
  (6, 2, 'Regal biurowy', 'Funkcjonalny regal biurowy z szufladami i polkami.', 300.00, 369.00, 400.00, 492.00, 23),
  (7, 1, 'Ksiazka: 1984', 'Przerazajaca wizja totalitarnej przyszlosci autorstwa Georgea Orwella.', 27.00, 33.21, 35.00, 43.05, 23),
  (8, 3, 'Ksiazka: Harry Potter i Kamien Filozoficzny', 'Pierwsza czesc kultowej serii o czarodzieju Harrym Potterze.', 25.00, 30.75, 35.00, 43.05, 23),
  (9, 3, 'Ksiazka: Wladca Pierscieni', 'Epicka saga fantasy autorstwa J.R.R. Tolkiena.', 30.00, 36.90, 40.00, 49.20, 23),
  (10, 3, 'Ksiazka: Alicja w Krainie Czarow', 'Niezwykla podroz malej Alicji przez kraine pelna nonsensow.', 22.00, 27.06, 30.00, 36.90, 23),
  (11, 2, 'Stolik nocny', 'Praktyczny stolik nocny z szufladka i polka.', 100.00, 123.00, 130.00, 159.90, 23),
  (12, 3, 'Ksiazka: Metro 2033', 'Postapokaliptyczna powiesc Dmitrija Gluchowskiego.', 28.00, 34.44, 38.00, 46.74, 23),
  (13, 4, 'Mapa Polski', 'Szczegolowa mapa Polski w skali 1:100 000.', 20.00, 24.60, 28.00, 34.44, 23),
  (14, 4, 'Mapa Europy', 'Kompletna mapa Europy w skali 1:1 000 000.', 30.00, 36.90, 40.00, 49.20, 23),
  (15, 4, 'Mapa Swiata', 'Mapa swiata z oznaczeniem panstw i stolic w skali 1:20 000 000.', 25.00, 30.75, 35.00, 43.05, 23),
  (16, 4, 'Mapa Gor', 'Mapa gorskiego regionu z szlakami turystycznymi i informacja o atrakcjach.', 22.00, 27.06, 30.00, 36.90, 23),
  (17, 2, 'Regal na ksiazki', 'Elegancki regal na ksiazki z drewna sosnowego.', 200.00, 246.00, 250.00, 307.50, 23),
  (18, 3, 'Ksiazka: Balladyna', 'Dramat romantyczny Juliusza Slowackiego o dziewczynie uwiklanej w zbrodnie.', 27.00, 33.21, 35.00, 43.05, 23),
  (19, 3, 'Ksiazka: Metro 2034', 'Kolejna powiesc z uniwersum Metro autorstwa Dmitrija Gluchowskiego.', 28.00, 34.44, 38.00, 46.74, 23),
  (20, 4, 'Mapa Polski: Mala', 'Podroznicza mapa Polski w kompaktowym formacie.', 20.00, 24.60, 28.00, 34.44, 23)
; 

SELECT *
FROM Produkty;

-- c. Tabela „Zamówienia” – 10 pozycji
INSERT INTO Zamowienia (id_zamowienia, id_klienta, id_produktu, data_zamowienia)
	VALUES 
	(1, 3, 5, '2023-09-01'),
    (2, 2, 1, '2023-10-22'),
    (3, 1, 19, '2023-03-13'),
    (4, 4, 8, '2023-08-14'),
    (5, 2, 20, '2023-01-05'),
    (6, 3, 14, '2023-12-20'),
    (7, 1, 7, '2023-04-07'),
    (8, 4, 20, '2023-10-19'),
    (9, 2, 11, '2023-11-09'),
    (10, 3, 16, '2023-03-17');
; 

SELECT *
FROM Zamowienia;

-- d. Tabela „Klienci” – 10 pozycji
INSERT INTO Klienci (id_klienta,id_zamowienia,imie,nazwisko, adres)
	VALUES 
		(1, 1, 'Adam', 'Kowalski', 'ul. Kwiatowa 1a, Warszawa'),
        (2, 2, 'Anna', 'Nowak', 'ul. Sloneczna 65, Krakow'),
        (3, 3, 'Piotr', 'Nowicki', 'ul. Lipowa 23, Gdansk'),
        (4, 4, 'Maria', 'Lewandowska', 'ul. Akacjowa 4b, Poznan'),
        (5, 5, 'Krzysztof', 'Wojcik', 'ul. Szopena 56c, Wroclaw'),
        (6, 6, 'Magdalena', 'Kaminska', 'ul. Lesna 6, Lodz'),
        (7, 7, 'Adam', 'Szymanski', 'ul. Cicha 7, Lublin'),
        (8, 8, 'Ewa', 'Dabrowska', 'ul. Szkolna 8, Szczecin'),
        (9, 9, 'Tomasz', 'Jankowski', 'ul. Ogrodowa 9, Rzeszow'),
        (10, 10, 'Milosz', 'Michalowski', 'ul. Mlynarska 23, Olsztyn')
; 

SELECT *
FROM Klienci;

-- 8.0 Wyświetl wszystkie produkty z wszystkimi danymi od producenta który znajduje się na pozycji 1 w tabeli „Producenci”

SELECT * 
FROM Produkty 
WHERE id_producenta = 1;

-- 9.0 Posortuj te produkty alfabetycznie po nazwie

SELECT * 
FROM Produkty 
WHERE id_producenta = 1
ORDER BY nazwa_produktu ASC;

-- 10.0 Wylicz średnią cenę za produktu od producenta z pozycji 1

SELECT 
AVG(cena_brutto_zakupu)
FROM Produkty  as avg_cena_producent1
WHERE id_producenta = 1; 

-- 11.0  Wyświetl dwie grupy produktów tego producenta: 
-- a. Połowa najtańszych to grupa: „Tanie”

SELECT *
FROM Produkty as Tanie
WHERE id_producenta = 1
AND cena_brutto_zakupu < 
	(SELECT 
	AVG(cena_brutto_zakupu) 
	FROM Produkty 
	WHERE id_producenta = 1)
;

-- b. Pozostałe to grupa: „Drogie” (wiekszne niz polowa)

SELECT *
FROM Produkty as Drogie
WHERE id_producenta = 1
AND cena_brutto_zakupu >
	(SELECT 
	AVG(cena_brutto_zakupu) 
	FROM Produkty 
	WHERE id_producenta = 1)
;

-- 12.0 Wyświetl produkty zamówione, wyświetlając tylko ich nazwę

SELECT DISTINCT P.nazwa_produktu
FROM Produkty P
JOIN Zamowienia Z ON P.id_produktu = Z.id_produktu;
; 

-- 13.0 Wyświetl wszystkie produkty zamówione – ograniczając wyświetlanie do 5 pozycji

SELECT *
FROM Produkty P
JOIN Zamowienia Z ON P.id_produktu = Z.id_produktu
LIMIT 5; 

-- 14.0 Policz łączną wartość wszystkich zamówień

SELECT SUM(cena_brutto_sprzedazy)
FROM Produkty P
JOIN Zamowienia Z ON P.id_produktu = Z.id_produktu
; 

-- 15.0 Wyświetl wszystkie zamówienia wraz z nazwą produktu sortując je wg daty od najstarszego do najnowszego

SELECT 
P.nazwa_produktu,
Z.data_zamowienia
FROM Produkty P
JOIN Zamowienia Z ON P.id_produktu = Z.id_produktu
GROUP BY 
P.nazwa_produktu,
Z.data_zamowienia
ORDER BY Z.data_zamowienia ASC;

-- 16.0 Sprawdź czy w tabeli produkty masz uzupełnione wszystkie dane – wyświetl pozycje dla których brakuje danych

SELECT * 
FROM Produkty; 

SELECT *
FROM Produkty
WHERE nazwa_produktu IS NULL;

-- 17.0 Wyświetl produkt najczęściej sprzedawany wraz z jego ceną (edge case! - moze ich byc wiecej niz 1 produkt! ) czyli ile razy powtorzyl sie ID produktu.  

SELECT 
P.nazwa_produktu, 
P.cena_brutto_sprzedazy,
Z.id_produktu, COUNT(*) AS freq 
FROM Produkty P
JOIN Zamowienia Z ON P.id_produktu = Z.id_produktu
GROUP BY 
P.nazwa_produktu, 
P.cena_brutto_sprzedazy,
Z.id_produktu
ORDER BY COUNT(Z.id_produktu) DESC;

-- 18.0 Znajdź dzień w którym najwięcej zostało złożonych zamówień (edge case! - moze ich byc wiecej niz 1 data)

SELECT Z.data_zamowienia, COUNT(*) AS freq
FROM Zamowienia Z
GROUP BY Z.data_zamowienia
ORDER BY COUNT(Z.data_zamowienia) DESC;



