-- =====================================================
-- Question 3: Top 10 Highest Scoring Matches
-- =====================================================
-- Goal: Find the 10 most high-scoring individual matches
-- in the dataset, showing which teams played and how
-- many goals were scored in total.
-- Tables used: match, team, league
-- =====================================================

SELECT 
    league.name,
    home_team.team_long_name AS home_team,
    away_team.team_long_name AS away_team,
    match.home_team_goal,
    match.away_team_goal,
    match.home_team_goal + match.away_team_goal AS total_goals
FROM match
JOIN team AS home_team ON match.home_team_api_id = home_team.team_api_id
JOIN team AS away_team ON match.away_team_api_id = away_team.team_api_id
JOIN league ON match.league_id = league.id
ORDER BY total_goals DESC
LIMIT 10;


/*
----------------------------------------------------
- The highest scoring match ever in the dataset was a
  remarkable 6-6 draw between Motherwell and Hibernian
  in the Scotland Premier League, tied with Real Madrid's
  10-2 demolition of Rayo Vallecano
- England Premier League appears 4 times in the top 10,
  suggesting it produces the most high-scoring individual
  matches despite not having the highest average (Q2)
- FC Bayern Munich's 9-2 win over Hamburger SV and
  Tottenham's 9-1 win over Wigan show that some high
  scoring matches are heavily one-sided thrashings rather
  than open, competitive games
- The 6-6 Motherwell vs Hibernian draw is a standout result
  — a completely equal and chaotic match, the rarest outcome
  in football
- PSV's 10-0 win over Feyenoord in the Eredivisie is the
  most dominant single performance in the top 10, which
  also connects back to Q2 where Eredivisie ranked as the
  highest scoring league overall
- France Ligue 1 appearing with a 5-5 draw is surprising
  given it ranked last in average goals per match in Q2
----------------------------------------------------

RESULT: 
[
  {
    "name": "Scotland Premier League",
    "home_team": "Motherwell",
    "away_team": "Hibernian",
    "home_team_goal": 6,
    "away_team_goal": 6,
    "total_goals": 12
  },
  {
    "name": "Spain LIGA BBVA",
    "home_team": "Real Madrid CF",
    "away_team": "Rayo Vallecano",
    "home_team_goal": 10,
    "away_team_goal": 2,
    "total_goals": 12
  },
  {
    "name": "Germany 1. Bundesliga",
    "home_team": "FC Bayern Munich",
    "away_team": "Hamburger SV",
    "home_team_goal": 9,
    "away_team_goal": 2,
    "total_goals": 11
  },
  {
    "name": "England Premier League",
    "home_team": "West Bromwich Albion",
    "away_team": "Manchester United",
    "home_team_goal": 5,
    "away_team_goal": 5,
    "total_goals": 10
  },
  {
    "name": "England Premier League",
    "home_team": "Manchester United",
    "away_team": "Arsenal",
    "home_team_goal": 8,
    "away_team_goal": 2,
    "total_goals": 10
  },
  {
    "name": "Netherlands Eredivisie",
    "home_team": "FC Utrecht",
    "away_team": "Ajax",
    "home_team_goal": 6,
    "away_team_goal": 4,
    "total_goals": 10
  },
  {
    "name": "England Premier League",
    "home_team": "Arsenal",
    "away_team": "Newcastle United",
    "home_team_goal": 7,
    "away_team_goal": 3,
    "total_goals": 10
  },
  {
    "name": "England Premier League",
    "home_team": "Tottenham Hotspur",
    "away_team": "Wigan Athletic",
    "home_team_goal": 9,
    "away_team_goal": 1,
    "total_goals": 10
  },
  {
    "name": "France Ligue 1",
    "home_team": "Olympique Lyonnais",
    "away_team": "Olympique de Marseille",
    "home_team_goal": 5,
    "away_team_goal": 5,
    "total_goals": 10
  },
  {
    "name": "Netherlands Eredivisie",
    "home_team": "PSV",
    "away_team": "Feyenoord",
    "home_team_goal": 10,
    "away_team_goal": 0,
    "total_goals": 10
  }
]
*/