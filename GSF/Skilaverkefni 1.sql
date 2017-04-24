-- Daemi 2
delimiter $$
drop procedure if exists ResetPassword $$

create procedure ResetPassword
(
    user_name varchar(15)
)
begin
    start transaction;
		update Members
        set userPass = 'NewResettedPassword'
        where userName = user_name;
    commit;
end $$
delimiter ;

-- Daemi 3
delimiter $$
drop procedure if exists NewTeam $$

create procedure NewTeam
(
	team_name varchar(125),
    short_name varchar(45),
    country_code varchar(2)
)
begin
    start transaction;
		insert into Teams(teamName,shortName,countryCode)
		values(team_name,short_name,country_code);
    commit;
end $$
delimiter ;

-- Daemi 4
delimiter $$
drop procedure if exists NewGroup $$

create procedure NewGroup
(
	group_name varchar(55),
    supports_team INT(11)
)
begin
    start transaction;
		insert into Groups(groupName,supportsTeam)
		values(group_name,supports_team);
    commit;
end $$
delimiter ;

-- Daemi 5
delimiter $$
drop function if exists NumberOfTeams $$

create function NumberOfTeams()
returns int
begin
    declare teamCount int;
    set teamCount = (select count(*) from Teams);
    return teamCount;
end $$
delimiter ;

-- Daemi 6
delimiter $$
drop function if exists GameExists $$

create function GameExists(game_kickOff datetime, home_team int(11), away_team int(11))
returns boolean
begin
    declare tempCount int;
    declare result boolean;
    
    set tempCount = (select count(*) from Games where (homeTeam = home_team) AND (awayTeam = away_team) AND (gameKickoff = game_kickOff));
    
    if (tempCount > 0) then
        set result = true;
    else
        set result = false;
    end if;
    
    return result;
end $$
delimiter ;

-- Daemi 7
-- Tók password út. Viljum ekki sýna það 
drop view if exists AllMembers;

create view AllMembers(MemberID,FirstName,LastName,UserName,Email,Joined)
as
select memberID,firstName,lastName,userName,email,joined
from Members;

-- Daemi 8
