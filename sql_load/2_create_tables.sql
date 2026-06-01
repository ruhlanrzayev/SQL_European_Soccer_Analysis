-- Create country table
CREATE TABLE public.country
(
    id INT PRIMARY KEY,
    name TEXT
);

-- Create league table
CREATE TABLE public.league
(
    id INT PRIMARY KEY,
    country_id INT,
    name TEXT,
    FOREIGN KEY (country_id) REFERENCES public.country (id)
);

-- Create team table
CREATE TABLE public.team
(
    id INT PRIMARY KEY,
    team_api_id INT,
    team_fifa_api_id INT,
    team_long_name TEXT,
    team_short_name TEXT
);

-- Create match table
CREATE TABLE public.match
(
    id INT PRIMARY KEY,
    country_id INT,
    league_id INT,
    season TEXT,
    stage INT,
    date TEXT,
    match_api_id INT,
    home_team_api_id INT,
    away_team_api_id INT,
    home_team_goal INT,
    away_team_goal INT,
    home_player_X1 TEXT, home_player_X2 TEXT, home_player_X3 TEXT, home_player_X4 TEXT,
    home_player_X5 TEXT, home_player_X6 TEXT, home_player_X7 TEXT, home_player_X8 TEXT,
    home_player_X9 TEXT, home_player_X10 TEXT, home_player_X11 TEXT,
    away_player_X1 TEXT, away_player_X2 TEXT, away_player_X3 TEXT, away_player_X4 TEXT,
    away_player_X5 TEXT, away_player_X6 TEXT, away_player_X7 TEXT, away_player_X8 TEXT,
    away_player_X9 TEXT, away_player_X10 TEXT, away_player_X11 TEXT,
    home_player_Y1 TEXT, home_player_Y2 TEXT, home_player_Y3 TEXT, home_player_Y4 TEXT,
    home_player_Y5 TEXT, home_player_Y6 TEXT, home_player_Y7 TEXT, home_player_Y8 TEXT,
    home_player_Y9 TEXT, home_player_Y10 TEXT, home_player_Y11 TEXT,
    away_player_Y1 TEXT, away_player_Y2 TEXT, away_player_Y3 TEXT, away_player_Y4 TEXT,
    away_player_Y5 TEXT, away_player_Y6 TEXT, away_player_Y7 TEXT, away_player_Y8 TEXT,
    away_player_Y9 TEXT, away_player_Y10 TEXT, away_player_Y11 TEXT,
    home_player_1 TEXT, home_player_2 TEXT, home_player_3 TEXT, home_player_4 TEXT,
    home_player_5 TEXT, home_player_6 TEXT, home_player_7 TEXT, home_player_8 TEXT,
    home_player_9 TEXT, home_player_10 TEXT, home_player_11 TEXT,
    away_player_1 TEXT, away_player_2 TEXT, away_player_3 TEXT, away_player_4 TEXT,
    away_player_5 TEXT, away_player_6 TEXT, away_player_7 TEXT, away_player_8 TEXT,
    away_player_9 TEXT, away_player_10 TEXT, away_player_11 TEXT,
    goal TEXT, shoton TEXT, shotoff TEXT, foulcommit TEXT, card TEXT,
    "cross" TEXT, corner TEXT, possession TEXT,
    B365H TEXT, B365D TEXT, B365A TEXT,
    BWH TEXT, BWD TEXT, BWA TEXT,
    IWH TEXT, IWD TEXT, IWA TEXT,
    LBH TEXT, LBD TEXT, LBA TEXT,
    PSH TEXT, PSD TEXT, PSA TEXT,
    WHH TEXT, WHD TEXT, WHA TEXT,
    SJH TEXT, SJD TEXT, SJA TEXT,
    VCH TEXT, VCD TEXT, VCA TEXT,
    GBH TEXT, GBD TEXT, GBA TEXT,
    BSH TEXT, BSD TEXT, BSA TEXT,
    FOREIGN KEY (country_id) REFERENCES public.country (id),
    FOREIGN KEY (league_id) REFERENCES public.league (id)
);


-- Set ownership of the tables to the postgres user
ALTER TABLE public.country OWNER to postgres;
ALTER TABLE public.league OWNER to postgres;
ALTER TABLE public.team OWNER to postgres;
ALTER TABLE public.match OWNER to postgres;

-- Create indexes on foreign key columns for better performance
CREATE INDEX idx_country_id ON public.league (country_id);
CREATE INDEX idx_league_id ON public.match (league_id);
CREATE INDEX idx_country_id_match ON public.match (country_id);
CREATE INDEX idx_home_team ON public.match (home_team_api_id);
CREATE INDEX idx_away_team ON public.match (away_team_api_id);