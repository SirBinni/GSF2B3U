-- Deami 1
DROP TRIGGER IF EXISTS Check_teams;
DELIMITER $$
CREATE TRIGGER Check_teams
BEFORE INSERT ON Games
FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(255);	 
     IF (NEW.homeTeam = NEW.awayTeam) THEN		
            SET msg = CONCAT('homeTeam cannot be same as awayTeam', CAST(NEW.awayTeam AS CHAR));			
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
     end IF;
END $$
DELIMITER ;

INSERT INTO Games(gameID,gameKickoff,homeTeam,awayTeam,homeGoals,awayGoals,resultMark,bettingDeadline)VALUES(1,'2017-04-08 00:00:00',200,200,NULL,NULL,NULL,NULL);

DROP TRIGGER IF EXISTS Check_teams_update;
DELIMITER $$
CREATE TRIGGER Check_teams_update
BEFORE UPDATE ON Games
FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(255);	 
     IF (NEW.homeTeam = NEW.awayTeam || OLD.homeTeam = OLD.awayTeam) THEN		
            SET msg = CONCAT('homeTeam cannot be same as awayTeam ', CAST(NEW.awayTeam AS CHAR));			
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
     end IF;
END $$
DELIMITER ;

UPDATE Games
SET homeTeam=206
WHERE gameID=2;


-- Daemi 2
DROP TRIGGER IF EXISTS Check_numbers_insert;
DELIMITER $$
CREATE TRIGGER Check_numbers_insert
BEFORE INSERT ON Games
FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(255);	 
     IF (NEW.homeTeam < 0 || NEW.awayTeam < 0) THEN		
            SET msg = CONCAT('Number cannot be negative ', CAST(NEW.awayTeam AS CHAR));			
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
     end IF;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS Check_numbers_update;
DELIMITER $$
CREATE TRIGGER Check_numbers_update
BEFORE UPDATE ON Games
FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(255);	 
     IF (NEW.homeTeam < 0 || NEW.awayTeam < 0) THEN		
            SET msg = CONCAT('Number cannot be negative ', CAST(NEW.awayTeam AS CHAR));			
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
     end IF;
END $$
DELIMITER ;

-- Daemi 3 -vantar update!


DROP TRIGGER IF EXISTS Check_bets_insert;
DELIMITER $$
CREATE TRIGGER Check_bets_insert
BEFORE INSERT ON TicketBets
FOR EACH ROW
BEGIN
	DECLARE msg VARCHAR(255);	 
     IF (NEW.betMark <> 1 && NEW.betMark <> 'X' && NEW.betMark <> 2) THEN		
            SET msg = CONCAT('Only 1, X or 2 allowed - you typed = ', CAST(NEW.betMark AS CHAR));			
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
     end IF;
END $$
DELIMITER ;





