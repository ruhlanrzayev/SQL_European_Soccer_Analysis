-- =====================================================
-- Question 10: All-Time League Table
-- =====================================================
-- Goal: Build a complete, professional-looking league
-- standings table for one league of your choice.
-- Output: team name, matches played, wins, draws,
-- losses, goals scored, goals conceded, goal
-- difference, and total points.
-- Tables used: match, team, league
-- =====================================================

-- Create temporary table (CTEs) for collect all matches result
WITH all_matches AS (
    SELECT 
        home_team_api_id AS team_api_id,
        league_id,
        CASE
            WHEN home_team_goal > away_team_goal THEN 'Win'
            WHEN home_team_goal = away_team_goal THEN 'Draw'
            ELSE 'Loss'
        END AS result
    FROM match

    UNION ALL

    SELECT
        away_team_api_id AS team_api_id,
        league_id,
        CASE
            WHEN away_team_goal > home_team_goal THEN 'Win'
            WHEN away_team_goal = home_team_goal THEN 'Draw'
            ELSE 'Loss'
        END AS result
    FROM match
),
home_goals AS (
    SELECT 
        home_team_api_id AS team_api_id,
        league_id,
        SUM(home_team_goal) AS home_goals
    FROM match
    GROUP BY home_team_api_id, league_id
), 
away_goals AS (
    SELECT
        away_team_api_id AS team_api_id,
        league_id,
        SUM(away_team_goal) AS away_goals
    FROM match
    GROUP BY away_team_api_id, league_id
),
home_conceded AS (
    SELECT
        away_team_api_id AS team_api_id,
        league_id,
        SUM(home_team_goal) AS home_conceded
    FROM match
    GROUP BY away_team_api_id, league_id
),
away_conceded AS (
    SELECT
        home_team_api_id AS team_api_id,
        league_id,
        SUM(away_team_goal) AS away_conceded
    FROM match
    GROUP BY home_team_api_id, league_id
)

SELECT 
    league.name,
    team.team_long_name,
    COUNT(*) AS matches_played,
    COUNT(CASE WHEN result = 'Win' THEN 1 END) AS wins,
    COUNT(CASE WHEN result = 'Draw' THEN 1 END) AS draws,
    COUNT(CASE WHEN result = 'Loss' THEN 1 END) AS losses,
    COALESCE(home_goals.home_goals, 0) + COALESCE(away_goals.away_goals, 0) AS goals_scored,
    COALESCE(home_conceded.home_conceded, 0) + COALESCE(away_conceded.away_conceded, 0) AS goals_conceded,
    (COALESCE(home_goals.home_goals, 0) + COALESCE(away_goals.away_goals, 0)) - (COALESCE(home_conceded.home_conceded, 0) + COALESCE(away_conceded.away_conceded, 0)) AS goal_difference,
    (COUNT(CASE WHEN result = 'Win' THEN 1 END) * 3) + (COUNT(CASE WHEN result = 'Draw' THEN 1 END) * 1) AS total_points
FROM team
JOIN all_matches ON team.team_api_id = all_matches.team_api_id
JOIN home_goals ON team.team_api_id = home_goals.team_api_id AND all_matches.league_id = home_goals.league_id
JOIN away_goals ON team.team_api_id = away_goals.team_api_id AND all_matches.league_id = away_goals.league_id
JOIN home_conceded ON team.team_api_id = home_conceded.team_api_id AND all_matches.league_id = home_conceded.league_id
JOIN away_conceded ON team.team_api_id = away_conceded.team_api_id AND all_matches.league_id = away_conceded.league_id
JOIN league ON all_matches.league_id = league.id
WHERE league.name = 'England Premier League'
GROUP BY league.name, team.team_long_name, home_goals.home_goals, away_goals.away_goals, home_conceded.home_conceded, away_conceded.away_conceded
ORDER BY total_points DESC, goal_difference DESC;



/*

------------------------------------------------------------
- Manchester United dominates the all-time Premier League
  standings with 633 points from 304 matches (192 wins,
  57 draws, 55 losses) — an average of 2.08 points per
  match across the entire dataset period
- Chelsea (598 points) and Manchester City (586 points)
  follow closely, showing the "Big Three" of English
  football have been remarkably consistent over 2008-2016
- Arsenal's 583 points places them 4th, continuing their
  status as a top 4 fixture in English football throughout
  the period, despite some inconsistent seasons
- The goal difference column reveals Manchester United's
  defensive strength — their +302 goal difference is the
  largest gap, meaning they score heavily and defend well
- Newer entrants to the league show dramatically fewer
  matches: Reading, Cardiff City, Blackpool, and
  Middlesbrough all have only 38 matches, indicating they
  were relegated during the dataset period
- The bottom teams (Reading 28 points, Cardiff 30 points,
  Middlesbrough 32 points from just 38 matches) show
  relegation-level performance — teams struggling to avoid
  the drop typically earn 30-35 points in a 38-match season
- Leicester City's 122 points from 76 matches stands out
  as an oddity — appearing halfway through the season
  suggests they were promoted mid-dataset, explaining their
  limited match count
- This table perfectly captures the competitive hierarchy
  of English Premier League football during 2008-2016,
  with elite clubs pulling away from mid-table and
  struggling teams cycling in and out via promotion/
  relegation
------------------------------------------------------------

RESULT: 

[
  {
    "name": "England Premier League",
    "team_long_name": "Manchester United",
    "matches_played": "304",
    "wins": "192",
    "draws": "57",
    "losses": "55",
    "goals_scored": "582",
    "goals_conceded": "280",
    "goal_difference": "302",
    "total_points": "633"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Chelsea",
    "matches_played": "304",
    "wins": "176",
    "draws": "70",
    "losses": "58",
    "goals_scored": "583",
    "goals_conceded": "286",
    "goal_difference": "297",
    "total_points": "598"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Manchester City",
    "matches_played": "304",
    "wins": "175",
    "draws": "61",
    "losses": "68",
    "goals_scored": "606",
    "goals_conceded": "307",
    "goal_difference": "299",
    "total_points": "586"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Arsenal",
    "matches_played": "304",
    "wins": "170",
    "draws": "73",
    "losses": "61",
    "goals_scored": "573",
    "goals_conceded": "320",
    "goal_difference": "253",
    "total_points": "583"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Tottenham Hotspur",
    "matches_played": "304",
    "wins": "151",
    "draws": "74",
    "losses": "79",
    "goals_scored": "481",
    "goals_conceded": "358",
    "goal_difference": "123",
    "total_points": "527"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Liverpool",
    "matches_played": "304",
    "wins": "150",
    "draws": "76",
    "losses": "78",
    "goals_scored": "531",
    "goals_conceded": "337",
    "goal_difference": "194",
    "total_points": "526"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Everton",
    "matches_played": "304",
    "wins": "121",
    "draws": "100",
    "losses": "83",
    "goals_scored": "439",
    "goals_conceded": "355",
    "goal_difference": "84",
    "total_points": "463"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Stoke City",
    "matches_played": "304",
    "wins": "98",
    "draws": "86",
    "losses": "120",
    "goals_scored": "322",
    "goals_conceded": "401",
    "goal_difference": "-79",
    "total_points": "380"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Aston Villa",
    "matches_played": "304",
    "wins": "86",
    "draws": "88",
    "losses": "130",
    "goals_scored": "335",
    "goals_conceded": "462",
    "goal_difference": "-127",
    "total_points": "346"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Sunderland",
    "matches_played": "304",
    "wins": "78",
    "draws": "92",
    "losses": "134",
    "goals_scored": "333",
    "goals_conceded": "441",
    "goal_difference": "-108",
    "total_points": "326"
  },
  {
    "name": "England Premier League",
    "team_long_name": "West Ham United",
    "matches_played": "266",
    "wins": "80",
    "draws": "74",
    "losses": "112",
    "goals_scored": "326",
    "goals_conceded": "383",
    "goal_difference": "-57",
    "total_points": "314"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Newcastle United",
    "matches_played": "266",
    "wins": "82",
    "draws": "65",
    "losses": "119",
    "goals_scored": "324",
    "goals_conceded": "422",
    "goal_difference": "-98",
    "total_points": "311"
  },
  {
    "name": "England Premier League",
    "team_long_name": "West Bromwich Albion",
    "matches_played": "266",
    "wins": "75",
    "draws": "73",
    "losses": "118",
    "goals_scored": "305",
    "goals_conceded": "405",
    "goal_difference": "-100",
    "total_points": "298"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Fulham",
    "matches_played": "228",
    "wins": "71",
    "draws": "62",
    "losses": "95",
    "goals_scored": "265",
    "goals_conceded": "319",
    "goal_difference": "-54",
    "total_points": "275"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Swansea City",
    "matches_played": "190",
    "wins": "62",
    "draws": "52",
    "losses": "76",
    "goals_scored": "233",
    "goals_conceded": "257",
    "goal_difference": "-24",
    "total_points": "238"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Southampton",
    "matches_played": "152",
    "wins": "60",
    "draws": "40",
    "losses": "52",
    "goals_scored": "216",
    "goals_conceded": "180",
    "goal_difference": "36",
    "total_points": "220"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Wigan Athletic",
    "matches_played": "190",
    "wins": "50",
    "draws": "52",
    "losses": "88",
    "goals_scored": "200",
    "goals_conceded": "320",
    "goal_difference": "-120",
    "total_points": "202"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Blackburn Rovers",
    "matches_played": "152",
    "wins": "42",
    "draws": "39",
    "losses": "71",
    "goals_scored": "175",
    "goals_conceded": "252",
    "goal_difference": "-77",
    "total_points": "165"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Bolton Wanderers",
    "matches_played": "152",
    "wins": "43",
    "draws": "33",
    "losses": "76",
    "goals_scored": "181",
    "goals_conceded": "253",
    "goal_difference": "-72",
    "total_points": "162"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Norwich City",
    "matches_played": "152",
    "wins": "39",
    "draws": "41",
    "losses": "72",
    "goals_scored": "160",
    "goals_conceded": "253",
    "goal_difference": "-93",
    "total_points": "158"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Hull City",
    "matches_played": "152",
    "wins": "32",
    "draws": "41",
    "losses": "79",
    "goals_scored": "144",
    "goals_conceded": "243",
    "goal_difference": "-99",
    "total_points": "137"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Crystal Palace",
    "matches_played": "114",
    "wins": "37",
    "draws": "24",
    "losses": "53",
    "goals_scored": "119",
    "goals_conceded": "150",
    "goal_difference": "-31",
    "total_points": "135"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Leicester City",
    "matches_played": "76",
    "wins": "34",
    "draws": "20",
    "losses": "22",
    "goals_scored": "114",
    "goals_conceded": "91",
    "goal_difference": "23",
    "total_points": "122"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Wolverhampton Wanderers",
    "matches_played": "114",
    "wins": "25",
    "draws": "28",
    "losses": "61",
    "goals_scored": "118",
    "goals_conceded": "204",
    "goal_difference": "-86",
    "total_points": "103"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Queens Park Rangers",
    "matches_played": "114",
    "wins": "22",
    "draws": "26",
    "losses": "66",
    "goals_scored": "115",
    "goals_conceded": "199",
    "goal_difference": "-84",
    "total_points": "92"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Birmingham City",
    "matches_played": "76",
    "wins": "21",
    "draws": "26",
    "losses": "29",
    "goals_scored": "75",
    "goals_conceded": "105",
    "goal_difference": "-30",
    "total_points": "89"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Portsmouth",
    "matches_played": "76",
    "wins": "17",
    "draws": "18",
    "losses": "41",
    "goals_scored": "72",
    "goals_conceded": "123",
    "goal_difference": "-51",
    "total_points": "69"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Burnley",
    "matches_played": "76",
    "wins": "15",
    "draws": "18",
    "losses": "43",
    "goals_scored": "70",
    "goals_conceded": "135",
    "goal_difference": "-65",
    "total_points": "63"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Watford",
    "matches_played": "38",
    "wins": "12",
    "draws": "9",
    "losses": "17",
    "goals_scored": "40",
    "goals_conceded": "50",
    "goal_difference": "-10",
    "total_points": "45"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Bournemouth",
    "matches_played": "38",
    "wins": "11",
    "draws": "9",
    "losses": "18",
    "goals_scored": "45",
    "goals_conceded": "67",
    "goal_difference": "-22",
    "total_points": "42"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Blackpool",
    "matches_played": "38",
    "wins": "10",
    "draws": "9",
    "losses": "19",
    "goals_scored": "55",
    "goals_conceded": "78",
    "goal_difference": "-23",
    "total_points": "39"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Middlesbrough",
    "matches_played": "38",
    "wins": "7",
    "draws": "11",
    "losses": "20",
    "goals_scored": "28",
    "goals_conceded": "57",
    "goal_difference": "-29",
    "total_points": "32"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Cardiff City",
    "matches_played": "38",
    "wins": "7",
    "draws": "9",
    "losses": "22",
    "goals_scored": "32",
    "goals_conceded": "74",
    "goal_difference": "-42",
    "total_points": "30"
  },
  {
    "name": "England Premier League",
    "team_long_name": "Reading",
    "matches_played": "38",
    "wins": "6",
    "draws": "10",
    "losses": "22",
    "goals_scored": "43",
    "goals_conceded": "73",
    "goal_difference": "-30",
    "total_points": "28"
  }
]

*/