-- =====================================================
-- Question 5: Team Win Rate (min. 100 matches)
-- =====================================================
-- Goal: Find which teams have the highest win rate (%)
-- across all matches, filtering out teams with fewer
-- than 100 matches to avoid small sample size bias.
-- Tables used: match, team
-- =====================================================

-- Create temporary table (CTEs) for collect all matches result
WITH all_matches AS (
    SELECT 
        home_team_api_id AS team_api_id,
        CASE
            WHEN home_team_goal > away_team_goal THEN 'Win'
            WHEN home_team_goal = away_team_goal THEN 'Draw'
            ELSE 'Loss'
        END AS result
    FROM match

    UNION ALL

    SELECT
        away_team_api_id AS team_api_id,
        CASE
            WHEN away_team_goal > home_team_goal THEN 'Win'
            WHEN away_team_goal = home_team_goal THEN 'Draw'
            ELSE 'Loss'
        END AS result
    FROM match
)

SELECT
    team.team_long_name,
    COUNT(CASE WHEN result = 'Win' THEN 1 END) AS wins,
    COUNT(CASE WHEN result = 'Draw' THEN 1 END) AS draws,
    COUNT(CASE WHEN result = 'Loss' THEN 1 END) AS losses,
    COUNT(*) AS total_matches,
    CONCAT(ROUND((COUNT(CASE WHEN result = 'Win' THEN 1 END) * 100.0) / COUNT(*), 1), '%') AS win_percentage
FROM team
JOIN all_matches ON team.team_api_id = all_matches.team_api_id
GROUP BY team.team_long_name
HAVING COUNT(*) >= 100
ORDER BY win_percentage  DESC
LIMIT 20;



/*

------------------------------------------------------
- FC Barcelona has the highest win rate in the entire
  dataset at 77.0% — winning 234 out of 304 matches,
  reflecting their dominant era under Pep Guardiola
  and Luis Enrique during 2008-2016
- Real Madrid follow closely at 75.0%, meaning the
  top 2 spots are locked by El Clasico rivals — the
  gap between them and 3rd place (SL Benfica 74.6%)
  is surprisingly small
- SL Benfica and FC Porto both appearing in top 4 is
  a surprise — Portuguese league dominance is often
  underrated compared to bigger European leagues
- Celtic's 71.7% win rate with 304 matches is
  remarkable — they dominated Scotland Premier League
  consistently throughout the entire dataset period
- FC Bayern Munich at 71.0% with 272 matches confirms
  their Bundesliga dominance, especially during their
  historic treble-winning 2012-2013 season
- Manchester United (63.2%) ranks higher than Chelsea
  (57.9%) and Manchester City (57.6%), reflecting
  Sir Alex Ferguson's final years at the club before
  his 2013 retirement
- Paris Saint-Germain and Manchester City sharing
  exactly 57.6% shows how closely matched the
  spending power of new-money clubs was in this era
------------------------------------------------------


RESULT: 

[
  {
    "team_long_name": "FC Barcelona",
    "wins": "234",
    "draws": "43",
    "losses": "27",
    "total_matches": "304",
    "win_percentage": "77.0%"
  },
  {
    "team_long_name": "Real Madrid CF",
    "wins": "228",
    "draws": "36",
    "losses": "40",
    "total_matches": "304",
    "win_percentage": "75.0%"
  },
  {
    "team_long_name": "SL Benfica",
    "wins": "185",
    "draws": "36",
    "losses": "27",
    "total_matches": "248",
    "win_percentage": "74.6%"
  },
  {
    "team_long_name": "FC Porto",
    "wins": "183",
    "draws": "42",
    "losses": "23",
    "total_matches": "248",
    "win_percentage": "73.8%"
  },
  {
    "team_long_name": "Celtic",
    "wins": "218",
    "draws": "50",
    "losses": "36",
    "total_matches": "304",
    "win_percentage": "71.7%"
  },
  {
    "team_long_name": "Rangers",
    "wins": "108",
    "draws": "25",
    "losses": "19",
    "total_matches": "152",
    "win_percentage": "71.1%"
  },
  {
    "team_long_name": "FC Bayern Munich",
    "wins": "193",
    "draws": "44",
    "losses": "35",
    "total_matches": "272",
    "win_percentage": "71.0%"
  },
  {
    "team_long_name": "Ajax",
    "wins": "181",
    "draws": "59",
    "losses": "32",
    "total_matches": "272",
    "win_percentage": "66.5%"
  },
  {
    "team_long_name": "PSV",
    "wins": "178",
    "draws": "47",
    "losses": "47",
    "total_matches": "272",
    "win_percentage": "65.4%"
  },
  {
    "team_long_name": "RSC Anderlecht",
    "wins": "136",
    "draws": "49",
    "losses": "27",
    "total_matches": "212",
    "win_percentage": "64.2%"
  },
  {
    "team_long_name": "Manchester United",
    "wins": "192",
    "draws": "57",
    "losses": "55",
    "total_matches": "304",
    "win_percentage": "63.2%"
  },
  {
    "team_long_name": "FC Basel",
    "wins": "180",
    "draws": "64",
    "losses": "42",
    "total_matches": "286",
    "win_percentage": "62.9%"
  },
  {
    "team_long_name": "Juventus",
    "wins": "189",
    "draws": "66",
    "losses": "46",
    "total_matches": "301",
    "win_percentage": "62.8%"
  },
  {
    "team_long_name": "Sporting CP",
    "wins": "144",
    "draws": "60",
    "losses": "44",
    "total_matches": "248",
    "win_percentage": "58.1%"
  },
  {
    "team_long_name": "Club Brugge KV",
    "wins": "123",
    "draws": "40",
    "losses": "49",
    "total_matches": "212",
    "win_percentage": "58.0%"
  },
  {
    "team_long_name": "Chelsea",
    "wins": "176",
    "draws": "70",
    "losses": "58",
    "total_matches": "304",
    "win_percentage": "57.9%"
  },
  {
    "team_long_name": "Borussia Dortmund",
    "wins": "157",
    "draws": "62",
    "losses": "53",
    "total_matches": "272",
    "win_percentage": "57.7%"
  },
  {
    "team_long_name": "Paris Saint-Germain",
    "wins": "175",
    "draws": "76",
    "losses": "53",
    "total_matches": "304",
    "win_percentage": "57.6%"
  },
  {
    "team_long_name": "Manchester City",
    "wins": "175",
    "draws": "61",
    "losses": "68",
    "total_matches": "304",
    "win_percentage": "57.6%"
  },
  {
    "team_long_name": "Legia Warszawa",
    "wins": "137",
    "draws": "50",
    "losses": "53",
    "total_matches": "240",
    "win_percentage": "57.1%"
  }
]
*/