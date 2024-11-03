-- チャンネル
CREATE TABLE Channels (
    ChannelID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ChannelName VARCHAR(20) NOT NULL
);

-- 番組
CREATE TABLE Programs (
    ProgramID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ProgramTitle VARCHAR(50) NOT NULL,
    ProgramDetails VARCHAR(100)
);

-- ジャンル
CREATE TABLE Genres (
    GenreID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    GenreName VARCHAR(20) NOT NULL
);

-- シーズン
CREATE TABLE Seasons (
    SeasonID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ProgramID INT NOT NULL,
    SeasonNumber INT NOT NULL,
    FOREIGN KEY (ProgramID) REFERENCES Programs(ProgramID) -- 外部キー設定
);

-- 番組ジャンル(つなぎ合わせる)
CREATE TABLE ProgramGenres (
    ProgramGenreID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ProgramID INT NOT NULL,
    GenreID INT NOT NULL,
    -- 外部キー設定
    FOREIGN KEY (ProgramID) REFERENCES Programs(ProgramID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

-- エピソード
CREATE TABLE Episodes (
    EpisodeID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    SeasonID INT, -- 単発エピソードに対応するためNULLを許可
    EpisodeNumber INT NOT NULL,
    EpisodeTitle VARCHAR(50) NOT NULL,
    EpisodeDetails VARCHAR(100),
    ViewingTime TIME NOT NULL,
    ReleaseDate DATE NOT NULL,
    -- 外部キー設定
    FOREIGN KEY (SeasonID) REFERENCES Seasons(SeasonID)
);

-- 番組放送
CREATE TABLE ProgramBroadcasts (
    ProgramBroadcastID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ProgramID INT NOT NULL,
    ChannelID INT NOT NULL,
    EpisodeID INT NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL,
    -- 外部キー設定
    FOREIGN KEY (ProgramID) REFERENCES Programs(ProgramID),
    FOREIGN KEY (ChannelID) REFERENCES Channels(ChannelID),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID)
);

-- 視聴数
CREATE TABLE Views (
    ViewID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ProgramBroadcastID INT NOT NULL,
    Views BIGINT(20) NOT NULL,
    -- 外部キー設定
    FOREIGN KEY (ProgramBroadcastID) REFERENCES ProgramBroadcasts(ProgramBroadcastID)
);
