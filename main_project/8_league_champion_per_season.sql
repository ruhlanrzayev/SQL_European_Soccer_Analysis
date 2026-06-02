-- =====================================================
-- Question 8: League Champion Per Season
-- =====================================================
-- Goal: Find which team won each league in each season,
-- using the official points system (win = 3, draw = 1,
-- loss = 0).
-- Tables used: match, team, league
-- =====================================================

WITH team_season_points AS (
    SELECT
        home_team_api_id AS team_api_id,
        league_id,
        season,
        SUM(CASE WHEN home_team_goal > away_team_goal THEN 3 ELSE 0 END) +
        SUM(CASE WHEN home_team_goal = away_team_goal THEN 1 ELSE 0 END) AS home_points
    FROM match
    GROUP BY home_team_api_id, league_id, season
    
    UNION ALL
    
    SELECT
        away_team_api_id AS team_api_id,
        league_id,
        season,
        SUM(CASE WHEN away_team_goal > home_team_goal THEN 3 ELSE 0 END) +
        SUM(CASE WHEN away_team_goal = home_team_goal THEN 1 ELSE 0 END) AS away_points
    FROM match
    GROUP BY away_team_api_id, league_id, season
),
combined_points AS (
    SELECT
        team_api_id,
        league_id,
        season,
        SUM(home_points) AS total_points
    FROM team_season_points
    GROUP BY team_api_id, league_id, season
),
ranked AS (
    SELECT
        *,
        RANK() OVER (PARTITION BY season, league_id ORDER BY total_points DESC) AS rank
    FROM combined_points
)

SELECT 
    ranked.season,
    league.name AS league_name,
    team.team_long_name,
    ranked.total_points
FROM ranked
JOIN team ON ranked.team_api_id = team.team_api_id
JOIN league ON ranked.league_id = league.id
WHERE rank = 1
ORDER BY ranked.season DESC, league.name;


/*

--------------------------------------------------
- FC Barcelona dominated Spanish football, winning La
  Liga in 2008/2009, 2009/2010, 2010/2011, and
  2012/2013 — showing a dynasty across 4 seasons with
  points ranging from 87-100
- FC Bayern Munich proved dominant in Germany, winning
  the Bundesliga in 2012/2013, 2014/2015, 2015/2016,
  with consistent point totals (79-91 points)
- The 2011/2012 England Premier League saw a dramatic
  tie: Manchester United and Manchester City both
  finished with 89 points — a historic moment that
  highlighted the intensity of the Big Two rivalry
- Leicester City's 2015/2016 Premier League title with
  81 points was achieved with dramatically fewer points
  than other seasons, reflecting the chaos of that
  legendary title-winning year when the odds were 5000-1
- Juventus showed remarkable consistency in Italy,
  winning Serie A 5 times across the dataset period
  (2012/2013, 2013/2014, 2014/2015, 2015/2016) with
  points ranging from 79-102
- FC Basel dominated the Swiss league, winning 4
  championships across the dataset — showing smaller
  leagues can have dominant dynasties just like the
  "Big Five" European leagues
- Celtic and Rangers split Scotland Premier League
  dominance, with Celtic clearly stronger (won
  2012/2013, 2013/2014, 2014/2015, 2015/2016 with
  79-99 points) while Rangers only won 2010/2011
--------------------------------------------------

RESULT : 

[
  {
    "season": "2015/2016",
    "league_name": "Belgium Jupiler League",
    "team_long_name": "Club Brugge KV",
    "total_points": "64"
  },
  {
    "season": "2015/2016",
    "league_name": "England Premier League",
    "team_long_name": "Leicester City",
    "total_points": "81"
  },
  {
    "season": "2015/2016",
    "league_name": "France Ligue 1",
    "team_long_name": "Paris Saint-Germain",
    "total_points": "96"
  },
  {
    "season": "2015/2016",
    "league_name": "Germany 1. Bundesliga",
    "team_long_name": "FC Bayern Munich",
    "total_points": "88"
  },
  {
    "season": "2015/2016",
    "league_name": "Italy Serie A",
    "team_long_name": "Juventus",
    "total_points": "91"
  },
  {
    "season": "2015/2016",
    "league_name": "Netherlands Eredivisie",
    "team_long_name": "PSV",
    "total_points": "84"
  },
  {
    "season": "2015/2016",
    "league_name": "Poland Ekstraklasa",
    "team_long_name": "Legia Warszawa",
    "total_points": "60"
  },
  {
    "season": "2015/2016",
    "league_name": "Portugal Liga ZON Sagres",
    "team_long_name": "SL Benfica",
    "total_points": "88"
  },
  {
    "season": "2015/2016",
    "league_name": "Scotland Premier League",
    "team_long_name": "Celtic",
    "total_points": "86"
  },
  {
    "season": "2015/2016",
    "league_name": "Spain LIGA BBVA",
    "team_long_name": "FC Barcelona",
    "total_points": "91"
  },
  {
    "season": "2015/2016",
    "league_name": "Switzerland Super League",
    "team_long_name": "FC Basel",
    "total_points": "83"
  },
  {
    "season": "2014/2015",
    "league_name": "Belgium Jupiler League",
    "team_long_name": "Club Brugge KV",
    "total_points": "61"
  },
  {
    "season": "2014/2015",
    "league_name": "England Premier League",
    "team_long_name": "Chelsea",
    "total_points": "87"
  },
  {
    "season": "2014/2015",
    "league_name": "France Ligue 1",
    "team_long_name": "Paris Saint-Germain",
    "total_points": "83"
  },
  {
    "season": "2014/2015",
    "league_name": "Germany 1. Bundesliga",
    "team_long_name": "FC Bayern Munich",
    "total_points": "79"
  },
  {
    "season": "2014/2015",
    "league_name": "Italy Serie A",
    "team_long_name": "Juventus",
    "total_points": "87"
  },
  {
    "season": "2014/2015",
    "league_name": "Netherlands Eredivisie",
    "team_long_name": "PSV",
    "total_points": "88"
  },
  {
    "season": "2014/2015",
    "league_name": "Poland Ekstraklasa",
    "team_long_name": "Legia Warszawa",
    "total_points": "56"
  },
  {
    "season": "2014/2015",
    "league_name": "Portugal Liga ZON Sagres",
    "team_long_name": "SL Benfica",
    "total_points": "85"
  },
  {
    "season": "2014/2015",
    "league_name": "Scotland Premier League",
    "team_long_name": "Celtic",
    "total_points": "92"
  },
  {
    "season": "2014/2015",
    "league_name": "Spain LIGA BBVA",
    "team_long_name": "FC Barcelona",
    "total_points": "94"
  },
  {
    "season": "2014/2015",
    "league_name": "Switzerland Super League",
    "team_long_name": "FC Basel",
    "total_points": "78"
  },
  {
    "season": "2013/2014",
    "league_name": "Belgium Jupiler League",
    "team_long_name": "KV Oostende",
    "total_points": "14"
  },
  {
    "season": "2013/2014",
    "league_name": "England Premier League",
    "team_long_name": "Manchester City",
    "total_points": "86"
  },
  {
    "season": "2013/2014",
    "league_name": "France Ligue 1",
    "team_long_name": "Paris Saint-Germain",
    "total_points": "89"
  },
  {
    "season": "2013/2014",
    "league_name": "Germany 1. Bundesliga",
    "team_long_name": "FC Bayern Munich",
    "total_points": "90"
  },
  {
    "season": "2013/2014",
    "league_name": "Italy Serie A",
    "team_long_name": "Juventus",
    "total_points": "102"
  },
  {
    "season": "2013/2014",
    "league_name": "Netherlands Eredivisie",
    "team_long_name": "Ajax",
    "total_points": "71"
  },
  {
    "season": "2013/2014",
    "league_name": "Poland Ekstraklasa",
    "team_long_name": "Legia Warszawa",
    "total_points": "63"
  },
  {
    "season": "2013/2014",
    "league_name": "Portugal Liga ZON Sagres",
    "team_long_name": "SL Benfica",
    "total_points": "74"
  },
  {
    "season": "2013/2014",
    "league_name": "Scotland Premier League",
    "team_long_name": "Celtic",
    "total_points": "99"
  },
  {
    "season": "2013/2014",
    "league_name": "Spain LIGA BBVA",
    "team_long_name": "Atlético Madrid",
    "total_points": "90"
  },
  {
    "season": "2013/2014",
    "league_name": "Switzerland Super League",
    "team_long_name": "FC Basel",
    "total_points": "72"
  },
  {
    "season": "2012/2013",
    "league_name": "Belgium Jupiler League",
    "team_long_name": "RSC Anderlecht",
    "total_points": "67"
  },
  {
    "season": "2012/2013",
    "league_name": "England Premier League",
    "team_long_name": "Manchester United",
    "total_points": "89"
  },
  {
    "season": "2012/2013",
    "league_name": "France Ligue 1",
    "team_long_name": "Paris Saint-Germain",
    "total_points": "83"
  },
  {
    "season": "2012/2013",
    "league_name": "Germany 1. Bundesliga",
    "team_long_name": "FC Bayern Munich",
    "total_points": "91"
  },
  {
    "season": "2012/2013",
    "league_name": "Italy Serie A",
    "team_long_name": "Juventus",
    "total_points": "87"
  },
  {
    "season": "2012/2013",
    "league_name": "Netherlands Eredivisie",
    "team_long_name": "Ajax",
    "total_points": "76"
  },
  {
    "season": "2012/2013",
    "league_name": "Poland Ekstraklasa",
    "team_long_name": "Legia Warszawa",
    "total_points": "67"
  },
  {
    "season": "2012/2013",
    "league_name": "Portugal Liga ZON Sagres",
    "team_long_name": "FC Porto",
    "total_points": "78"
  },
  {
    "season": "2012/2013",
    "league_name": "Scotland Premier League",
    "team_long_name": "Celtic",
    "total_points": "79"
  },
  {
    "season": "2012/2013",
    "league_name": "Spain LIGA BBVA",
    "team_long_name": "FC Barcelona",
    "total_points": "100"
  },
  {
    "season": "2012/2013",
    "league_name": "Switzerland Super League",
    "team_long_name": "FC Basel",
    "total_points": "72"
  },
  {
    "season": "2011/2012",
    "league_name": "Belgium Jupiler League",
    "team_long_name": "RSC Anderlecht",
    "total_points": "67"
  },
  {
    "season": "2011/2012",
    "league_name": "England Premier League",
    "team_long_name": "Manchester United",
    "total_points": "89"
  },
  {
    "season": "2011/2012",
    "league_name": "England Premier League",
    "team_long_name": "Manchester City",
    "total_points": "89"
  },
  {
    "season": "2011/2012",
    "league_name": "France Ligue 1",
    "team_long_name": "Montpellier Hérault SC",
    "total_points": "82"
  },
  {
    "season": "2011/2012",
    "league_name": "Germany 1. Bundesliga",
    "team_long_name": "Borussia Dortmund",
    "total_points": "81"
  },
  {
    "season": "2011/2012",
    "league_name": "Italy Serie A",
    "team_long_name": "Juventus",
    "total_points": "79"
  },
  {
    "season": "2011/2012",
    "league_name": "Netherlands Eredivisie",
    "team_long_name": "Ajax",
    "total_points": "76"
  },
  {
    "season": "2011/2012",
    "league_name": "Poland Ekstraklasa",
    "team_long_name": "Śląsk Wrocław",
    "total_points": "56"
  },
  {
    "season": "2011/2012",
    "league_name": "Portugal Liga ZON Sagres",
    "team_long_name": "FC Porto",
    "total_points": "75"
  },
  {
    "season": "2011/2012",
    "league_name": "Scotland Premier League",
    "team_long_name": "Celtic",
    "total_points": "93"
  },
  {
    "season": "2011/2012",
    "league_name": "Spain LIGA BBVA",
    "team_long_name": "Real Madrid CF",
    "total_points": "100"
  },
  {
    "season": "2011/2012",
    "league_name": "Switzerland Super League",
    "team_long_name": "FC Basel",
    "total_points": "74"
  },
  {
    "season": "2010/2011",
    "league_name": "Belgium Jupiler League",
    "team_long_name": "RSC Anderlecht",
    "total_points": "65"
  },
  {
    "season": "2010/2011",
    "league_name": "England Premier League",
    "team_long_name": "Manchester United",
    "total_points": "80"
  },
  {
    "season": "2010/2011",
    "league_name": "France Ligue 1",
    "team_long_name": "LOSC Lille",
    "total_points": "76"
  },
  {
    "season": "2010/2011",
    "league_name": "Germany 1. Bundesliga",
    "team_long_name": "Borussia Dortmund",
    "total_points": "75"
  },
  {
    "season": "2010/2011",
    "league_name": "Italy Serie A",
    "team_long_name": "Milan",
    "total_points": "82"
  },
  {
    "season": "2010/2011",
    "league_name": "Netherlands Eredivisie",
    "team_long_name": "Ajax",
    "total_points": "73"
  },
  {
    "season": "2010/2011",
    "league_name": "Poland Ekstraklasa",
    "team_long_name": "Wisła Kraków",
    "total_points": "56"
  },
  {
    "season": "2010/2011",
    "league_name": "Portugal Liga ZON Sagres",
    "team_long_name": "FC Porto",
    "total_points": "84"
  },
  {
    "season": "2010/2011",
    "league_name": "Scotland Premier League",
    "team_long_name": "Rangers",
    "total_points": "93"
  },
  {
    "season": "2010/2011",
    "league_name": "Spain LIGA BBVA",
    "team_long_name": "FC Barcelona",
    "total_points": "96"
  },
  {
    "season": "2010/2011",
    "league_name": "Switzerland Super League",
    "team_long_name": "FC Basel",
    "total_points": "73"
  },
  {
    "season": "2009/2010",
    "league_name": "Belgium Jupiler League",
    "team_long_name": "RSC Anderlecht",
    "total_points": "69"
  },
  {
    "season": "2009/2010",
    "league_name": "England Premier League",
    "team_long_name": "Chelsea",
    "total_points": "86"
  },
  {
    "season": "2009/2010",
    "league_name": "France Ligue 1",
    "team_long_name": "Olympique de Marseille",
    "total_points": "78"
  },
  {
    "season": "2009/2010",
    "league_name": "Germany 1. Bundesliga",
    "team_long_name": "FC Bayern Munich",
    "total_points": "70"
  },
  {
    "season": "2009/2010",
    "league_name": "Italy Serie A",
    "team_long_name": "Inter",
    "total_points": "82"
  },
  {
    "season": "2009/2010",
    "league_name": "Netherlands Eredivisie",
    "team_long_name": "FC Twente",
    "total_points": "86"
  },
  {
    "season": "2009/2010",
    "league_name": "Poland Ekstraklasa",
    "team_long_name": "Lech Poznań",
    "total_points": "65"
  },
  {
    "season": "2009/2010",
    "league_name": "Portugal Liga ZON Sagres",
    "team_long_name": "SL Benfica",
    "total_points": "76"
  },
  {
    "season": "2009/2010",
    "league_name": "Scotland Premier League",
    "team_long_name": "Rangers",
    "total_points": "87"
  },
  {
    "season": "2009/2010",
    "league_name": "Spain LIGA BBVA",
    "team_long_name": "FC Barcelona",
    "total_points": "99"
  },
  {
    "season": "2009/2010",
    "league_name": "Switzerland Super League",
    "team_long_name": "FC Basel",
    "total_points": "80"
  },
  {
    "season": "2008/2009",
    "league_name": "Belgium Jupiler League",
    "team_long_name": "RSC Anderlecht",
    "total_points": "77"
  },
  {
    "season": "2008/2009",
    "league_name": "Belgium Jupiler League",
    "team_long_name": "Standard de Liège",
    "total_points": "77"
  },
  {
    "season": "2008/2009",
    "league_name": "England Premier League",
    "team_long_name": "Manchester United",
    "total_points": "90"
  },
  {
    "season": "2008/2009",
    "league_name": "France Ligue 1",
    "team_long_name": "Girondins de Bordeaux",
    "total_points": "80"
  },
  {
    "season": "2008/2009",
    "league_name": "Germany 1. Bundesliga",
    "team_long_name": "VfL Wolfsburg",
    "total_points": "69"
  },
  {
    "season": "2008/2009",
    "league_name": "Italy Serie A",
    "team_long_name": "Inter",
    "total_points": "84"
  },
  {
    "season": "2008/2009",
    "league_name": "Netherlands Eredivisie",
    "team_long_name": "AZ",
    "total_points": "80"
  },
  {
    "season": "2008/2009",
    "league_name": "Poland Ekstraklasa",
    "team_long_name": "Wisła Kraków",
    "total_points": "64"
  },
  {
    "season": "2008/2009",
    "league_name": "Portugal Liga ZON Sagres",
    "team_long_name": "FC Porto",
    "total_points": "70"
  },
  {
    "season": "2008/2009",
    "league_name": "Scotland Premier League",
    "team_long_name": "Rangers",
    "total_points": "86"
  },
  {
    "season": "2008/2009",
    "league_name": "Spain LIGA BBVA",
    "team_long_name": "FC Barcelona",
    "total_points": "87"
  },
  {
    "season": "2008/2009",
    "league_name": "Switzerland Super League",
    "team_long_name": "FC Zürich",
    "total_points": "79"
  }
]

*/