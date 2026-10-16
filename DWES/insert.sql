use SpotifyDB;

Insert into Country(name) values ('Ireland');

insert into Artist(name, pseudonym,country_id) values ('U2','U2',(select id from Country));

insert into track(title,duration,artist_id) values('Rattle and hum',320,(Select id from artist))
  
insert into track(title,duration,artist_id) values('Sunday bloody sunday',212,(Select id from artist))