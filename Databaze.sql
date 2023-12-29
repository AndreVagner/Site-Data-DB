DROP TABLE IF EXISTS Prijmy;
DROP TABLE IF EXISTS Rozpocet;
DROP TABLE IF EXISTS Vydaje;
DROP TABLE IF EXISTS Uzivatele;
DROP TABLE IF EXISTS Kategorie;
DROP TABLE IF EXISTS Uzivatel;
DROP TABLE IF EXISTS troll;

CREATE TABLE "Prijmy"  (
	"ID"	INTEGER,
	"Popis"	VARCHAR,
	"Castka"	DECIMAL,
	"Datum"	DATE,
	"UserID"	INTEGER,
	FOREIGN KEY("UserID") REFERENCES "Uzivatele"("ID"),
	PRIMARY KEY("ID")
);

CREATE TABLE "Rozpocet" (
	"ID"	INTEGER,
	"Castka"	DECIMAL,
	"Rok"	VARCHAR,
	"UserID"	INTEGER,
	FOREIGN KEY("UserID") REFERENCES "Uzivatele"("ID"),
	PRIMARY KEY("ID")
);

CREATE TABLE "Vydaje" (
	"ID"	INTEGER,
	"Kategorie" INTEGER,
	"Popis"	VARCHAR,
	"Castka"	DECIMAL,
	"Datum"	DATE,
	"UserID"	INTEGER,
	FOREIGN KEY("Kategorie") REFERENCES "Kategorie"("ID"),
	FOREIGN KEY("UserID") REFERENCES "Uzivatele"("ID"),
	PRIMARY KEY("ID")
);

CREATE TABLE "Uzivatele" (
	"ID"	INTEGER,
	"Jmeno"	VARCHAR(255) NOT NULL UNIQUE,
	"Heslo"	VARCHAR(255) NOT NULL,
	"Email"	VARCHAR(255) NOT NULL UNIQUE,
	PRIMARY KEY("ID")
);

CREATE TABLE "Kategorie" (
	"ID"	INTEGER PRIMARY KEY,
	"Nazev" VARCHAR(255) NOT NULL
);


INSERT INTO "Uzivatele" ("Jmeno", "Heslo", "Email") VALUES
  ('JohnDoe', 'password123', 'john.doe@example.com'),
  ('AliceSmith', 'securepass', 'alice.smith@example.com'),
  ('BobJohnson', 'secret123', 'bob.johnson@example.com'),
  ('EvaWilliams', 'eva_pass', 'eva.williams@example.com'),
  ('DavidBrown', 'david123', 'david.brown@example.com'),
  ('SophieClark', 'sophie_pass', 'sophie.clark@example.com'),
  ('MichaelTaylor', 'michael123', 'michael.taylor@example.com'),
  ('OliviaMoore', 'olivia_pass', 'olivia.moore@example.com'),
  ('DanielAnderson', 'daniel123', 'daniel.anderson@example.com'),
  ('GraceWhite', 'grace_pass', 'grace.white@example.com');

INSERT INTO "Prijmy" ("Popis", "Castka", "Datum", "UserID") VALUES
  ('Paycheck', 2500.00, '2023-01-15', 1),
  ('Freelance Income', 1200.50, '2023-01-20', 2),
  ('Bonus', 500.00, '2023-02-05', 3),
  ('Investment Dividends', 300.25, '2023-02-10', 4),
  ('Salary', 3000.00, '2023-03-15', 5),
  ('Gift Money', 50.00, '2023-03-20', 6),
  ('Side Job Payment', 800.00, '2023-04-05', 7),
  ('Tax Refund', 200.00, '2023-04-10', 8),
  ('Online Sales', 150.75, '2023-05-15', 9),
  ('Part-time Job Earnings', 600.00, '2023-05-20', 10),
  ('Monthly Bonus', 700.00, '2023-06-05', 1),
  ('Consulting Fee', 1500.50, '2023-06-10', 3),
  ('Stock Dividends', 400.00, '2023-07-15', 3),
  ('Project Completion Bonus', 800.25, '2023-07-20', 4),
  ('Performance Bonus', 2500.00, '2023-08-15', 9),
  ('Birthday Gift', 100.00, '2023-08-20', 6),
  ('Contract Renewal Payment', 1200.00, '2023-09-05', 7),
  ('Insurance Refund', 180.00, '2023-09-10', 9),
  ('Year-End Bonus', 3000.75, '2023-10-15', 10),
  ('Royalties', 500.00, '2023-10-20', 1),
  ('Special Project Payment', 900.50, '2023-11-05', 1);

INSERT INTO "Vydaje" ("Kategorie", "Popis", "Castka", "Datum", "UserID") VALUES
  ('Groceries', 'Weekly Grocery Shopping', 75.50, '2023-01-05', 3),
  ('Utilities', 'Monthly Electricity Bill', 120.00, '2023-01-10', 5),
  ('Entertainment', 'Movie Night Out', 30.00, '2023-02-15', 8),
  ('Rent', 'Monthly Rent Payment', 1500.00, '2023-02-20', 10),
  ('Dining Out', 'Fine Dining Experience', 60.00, '2023-03-25', 2),
  ('Travel', 'Flight Tickets for Vacation', 400.00, '2023-03-30', 4),
  ('Clothing', 'New Wardrobe Addition', 45.00, '2023-04-10', 7),
  ('Healthcare', 'Prescription Medication Refill', 40.00, '2023-04-15', 9),
  ('Home Improvement', 'DIY Project Supplies', 200.00, '2023-05-20', 1),
  ('Electronics', 'Smartphone Upgrade', 200.00, '2023-05-20', 1),
  ('Education', 'Online Course Enrollment', 180.00, '2023-05-25', 6),
  ('Home Improvement', 'DIY Project Supplies', 750.00, '2023-06-05', 8),
  ('Fitness', 'Gym Membership Fee', 75.00, '2023-06-10', 3),
  ('Dining Out', 'Casual Dinner with Friends', 50.00, '2023-07-15', 7),
  ('Travel', 'Weekend Getaway', 300.00, '2023-07-20', 9),
  ('Clothing', 'Shoe Shopping', 35.00, '2023-08-05', 10),
  ('Healthcare', 'Dental Checkup', 90.00, '2023-08-10', 1),
  ('Electronics', 'Tech Gadgets Purchase', 250.00, '2023-09-15', 4),
  ('Education', 'Language Learning Course', 120.00, '2023-09-20', 6),
  ('Home Improvement', 'Furniture Upgrade', 180.00, '2023-10-05', 2),
  ('Fitness', 'Fitness Tracker Purchase', 60.00, '2023-10-10', 5);

INSERT INTO "Rozpocet" ("Castka", "Rok", "UserID") VALUES
  (1500.00, '2023', 1),
  (2000.50, '2023', 2),
  (1800.00, '2023', 3),
  (2500.00, '2023', 4),
  (2200.00, '2023', 5),
  (1600.00, '2023', 6),
  (1800.00, '2023', 7),
  (500.00, '2023', 8),
  (1900.00, '2023', 9),
  (2300.00, '2023', 10);

INSERT INTO "Kategorie" ("Nazev") VALUES
  ('Potraviny'),
  ('Elektronika'),
  ('Oblečení'),
  ('Cestování'),
  ('Zábava'),
  ('Zdravotní péče'),
  ('Domácnost'),
  ('Školství');

SELECT U.Jmeno AS Uživatelské_jméno, GROUP_CONCAT(P.Popis, ',') AS Zdroj_příjmů, SUM(P.Castka) AS Celková_částka
FROM Uzivatele U JOIN Prijmy P ON U.ID = P.UserID GROUP BY U.Jmeno;


SELECT U.Jmeno AS Uživatelské_jméno, GROUP_CONCAT(V.Popis, ',') AS Zdroj_výdajů, SUM(V.Castka) AS Celková_částka
FROM Uzivatele U JOIN Vydaje V ON U.ID = V.UserID
WHERE V.Datum >= '2023-04-01' AND V.Datum <= '2023-07-01' AND V.Castka > 10 GROUP BY U.Jmeno;

UPDATE Prijmy SET Castka = 2800.00 WHERE Popis = 'Paycheck' AND UserID = 1;

DELETE FROM Vydaje WHERE Popis = 'Electricity Bill' AND UserID = 2;

WITH Rozpocty AS (
  SELECT U.ID AS UserID, SUM(R.Castka) AS Rozpocet FROM Uzivatele U
  LEFT JOIN Rozpocet R ON U.ID = R.UserID GROUP BY U.ID )

SELECT
  U.Jmeno AS Uživatelské_jméno,
  SUM(P.Castka) AS Celkové_příjmy,
  SUM(V.Castka) AS Celkové_výdaje,
  R.Rozpocet AS Rozpocet,
    (R.Rozpocet + SUM(P.Castka) - SUM(V.Castka)) ||
    ' - ' ||
    CASE WHEN R.Rozpocet + SUM(P.Castka) - SUM(V.Castka) < 0
         THEN 'Překročeno'
         ELSE 'Nepřekročeno' END AS Stav_rozpočtu
FROM Uzivatele U
LEFT JOIN
  (SELECT UserID, SUM(Castka) AS Castka FROM Prijmy GROUP BY UserID) P ON U.ID = P.UserID
LEFT JOIN
  (SELECT UserID, SUM(Castka) AS Castka FROM Vydaje GROUP BY UserID) V ON U.ID = V.UserID
LEFT JOIN Rozpocty R ON U.ID = R.UserID
GROUP BY U.ID, U.Jmeno, R.Rozpocet;
