--Create database SpotifyDB;
use SpotifyDB;

CREATE TABLE Country (
    id UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT PK_Country PRIMARY KEY
        CONSTRAINT DF_Country_Id DEFAULT NEWID(),

    name NVARCHAR(100) NOT NULL
);


CREATE TABLE [User] (
    id UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT PK_User PRIMARY KEY
        CONSTRAINT DF_User_Id DEFAULT NEWID(),

    email NVARCHAR(255) NOT NULL,

    country_id UNIQUEIDENTIFIER NOT NULL,

    CONSTRAINT UQ_User_Email UNIQUE (email),

    CONSTRAINT FK_User_Country
        FOREIGN KEY (country_id)
        REFERENCES Country(id)
);


CREATE TABLE Artist (
    id UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT PK_Artist PRIMARY KEY
        CONSTRAINT DF_Artist_Id DEFAULT NEWID(),

    name NVARCHAR(150) NOT NULL,

    pseudonym NVARCHAR(150) NULL,

    country_id UNIQUEIDENTIFIER NOT NULL,

    CONSTRAINT FK_Artist_Country
        FOREIGN KEY (country_id)
        REFERENCES Country(id)
);


CREATE TABLE Track (
    id UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT PK_Track PRIMARY KEY
        CONSTRAINT DF_Track_Id DEFAULT NEWID(),

    title NVARCHAR(200) NOT NULL,

    artist_id UNIQUEIDENTIFIER NOT NULL,

    duration INT NOT NULL,

    CONSTRAINT CK_Track_Duration
        CHECK (duration > 0),

    CONSTRAINT FK_Track_Artist
        FOREIGN KEY (artist_id)
        REFERENCES Artist(id)
);


CREATE TABLE Album (
    id UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT PK_Album PRIMARY KEY
        CONSTRAINT DF_Album_Id DEFAULT NEWID(),

    artist_id UNIQUEIDENTIFIER NOT NULL,

    [date] DATE NOT NULL,
    
    title NVARCHAR(200) NOT NULL,

    CONSTRAINT FK_Album_Artist
        FOREIGN KEY (artist_id)
        REFERENCES Artist(id)
);


CREATE TABLE Playlist (
    id UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT PK_Playlist PRIMARY KEY
        CONSTRAINT DF_Playlist_Id DEFAULT NEWID(),

    title NVARCHAR(200) NOT NULL,

    user_id UNIQUEIDENTIFIER NOT NULL,

    CONSTRAINT FK_Playlist_User
        FOREIGN KEY (user_id)
        REFERENCES [User](id)
);


CREATE TABLE History (
    id UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT PK_History PRIMARY KEY
        CONSTRAINT DF_History_Id DEFAULT NEWID(),

    user_id UNIQUEIDENTIFIER NOT NULL,

    track_id UNIQUEIDENTIFIER NOT NULL,

    [date] DATETIME2 NOT NULL
        CONSTRAINT DF_History_Date DEFAULT SYSDATETIME(),

    CONSTRAINT FK_History_User
        FOREIGN KEY (user_id)
        REFERENCES [User](id),

    CONSTRAINT FK_History_Track
        FOREIGN KEY (track_id)
        REFERENCES Track(id)
);


CREATE TABLE PlaylistTracks (
    id UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT PK_PlaylistTracks PRIMARY KEY
        CONSTRAINT DF_PlaylistTracks_Id DEFAULT NEWID(),

    playlist_id UNIQUEIDENTIFIER NOT NULL,

    track_id UNIQUEIDENTIFIER NOT NULL,

    CONSTRAINT UQ_PlaylistTracks
        UNIQUE (playlist_id, track_id),

    CONSTRAINT FK_PlaylistTracks_Playlist
        FOREIGN KEY (playlist_id)
        REFERENCES Playlist(id),

    CONSTRAINT FK_PlaylistTracks_Track
        FOREIGN KEY (track_id)
        REFERENCES Track(id)
);


CREATE TABLE AlbumTracks (
    id UNIQUEIDENTIFIER NOT NULL
        CONSTRAINT PK_AlbumTracks PRIMARY KEY
        CONSTRAINT DF_AlbumTracks_Id DEFAULT NEWID(),

    album_id UNIQUEIDENTIFIER NOT NULL,

    track_id UNIQUEIDENTIFIER NOT NULL,

    CONSTRAINT UQ_AlbumTracks
        UNIQUE (album_id, track_id),

    CONSTRAINT FK_AlbumTracks_Album
        FOREIGN KEY (album_id)
        REFERENCES Album(id),

    CONSTRAINT FK_AlbumTracks_Track
        FOREIGN KEY (track_id)
        REFERENCES Track(id)
);