-- =====================================================
-- Question 1: Home vs Away Goals by Team
-- =====================================================
-- Goal: Find which teams scored the most goals overall,
-- broken down by home and away performance.
-- Tables used: match, league
-- =====================================================

-- CTE 1: Calculate total goals scored at home for each team
WITH home_goals AS (
    SELECT 
        home_team_api_id AS team_api_id,
        SUM(home_team_goal) AS home_goals
    FROM match
    GROUP BY home_team_api_id
), 
-- CTE 2: Calculate total goals scored away for each team
away_goals AS (
    SELECT
        away_team_api_id AS team_api_id,
        SUM(away_team_goal) AS away_goals
    FROM match
    GROUP BY away_team_api_id
)

-- Final: Join both CTEs with team table to get team names,
-- combine home and away goals into a single total_goals column
SELECT
    team_long_name,
    home_goals.home_goals,
    away_goals.away_goals,
    home_goals.home_goals + away_goals.away_goals AS total_goals
FROM team 
JOIN home_goals ON team.team_api_id = home_goals.team_api_id
JOIN away_goals ON team.team_api_id = away_goals.team_api_id
ORDER BY total_goals DESC
LIMIT 10;

/*
RESULT: 
[
  {
    "team_long_name": "FC Barcelona",
    "home_goals": "495",
    "away_goals": "354",
    "total_goals": "849"
  },
  {
    "team_long_name": "Real Madrid CF",
    "home_goals": "505",
    "away_goals": "338",
    "total_goals": "843"
  },
  {
    "team_long_name": "Celtic",
    "home_goals": "389",
    "away_goals": "306",
    "total_goals": "695"
  },
  {
    "team_long_name": "FC Bayern Munich",
    "home_goals": "382",
    "away_goals": "271",
    "total_goals": "653"
  },
  {
    "team_long_name": "PSV",
    "home_goals": "370",
    "away_goals": "282",
    "total_goals": "652"
  },
  {
    "team_long_name": "Ajax",
    "home_goals": "360",
    "away_goals": "287",
    "total_goals": "647"
  },
  {
    "team_long_name": "FC Basel",
    "home_goals": "344",
    "away_goals": "275",
    "total_goals": "619"
  },
  {
    "team_long_name": "Manchester City",
    "home_goals": "365",
    "away_goals": "241",
    "total_goals": "606"
  },
  {
    "team_long_name": "Chelsea",
    "home_goals": "333",
    "away_goals": "250",
    "total_goals": "583"
  },
  {
    "team_long_name": "Manchester United",
    "home_goals": "338",
    "away_goals": "244",
    "total_goals": "582"
  }
]
*/