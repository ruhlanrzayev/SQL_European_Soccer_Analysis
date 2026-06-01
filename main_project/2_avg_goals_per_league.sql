-- =====================================================
-- Question 2: Average Goals Per League
-- =====================================================
-- Goal: Find which leagues produce the most goals per
-- match on average, to identify the most attacking
-- and entertaining leagues in the dataset.
-- Tables used: match, league
-- =====================================================
SELECT 
    league.name,
    ROUND(AVG(match.home_team_goal + match.away_team_goal), 2) AS average_goal
FROM 
    league
JOIN match ON league.id = match.league_id
GROUP BY
    league.name
ORDER BY 
    average_goal DESC


/*

----------------------------------------------
- The Netherlands Eredivisie is the highest scoring league
  with 3.08 average goals per match, well known for its
  attacking and open style of football
- Germany Bundesliga (2.90) and Spain La Liga (2.77) rank
  in the top 3 and top 5 respectively, reflecting their
  reputation for attacking football
- Surprisingly, the England Premier League (2.71) ranks
  only 6th despite being the most watched league in the
  world - quantity of goals doesn't match its popularity
- France Ligue 1 (2.44) and Poland Ekstraklasa (2.43) sit
  at the bottom, suggesting a more defensive style of play
  in these leagues
- Italy Serie A (2.62) ranking 8th aligns with its historic
  reputation as a tactically defensive league
- The difference between the highest (3.08) and lowest
  (2.43) is 0.65 goals per match — significant over a
  full season of 30+ matches
----------------------------------------------

RESULT : 
[
  {
    "name": "Netherlands Eredivisie",
    "average_goal": "3.08"
  },
  {
    "name": "Switzerland Super League",
    "average_goal": "2.93"
  },
  {
    "name": "Germany 1. Bundesliga",
    "average_goal": "2.90"
  },
  {
    "name": "Belgium Jupiler League",
    "average_goal": "2.80"
  },
  {
    "name": "Spain LIGA BBVA",
    "average_goal": "2.77"
  },
  {
    "name": "England Premier League",
    "average_goal": "2.71"
  },
  {
    "name": "Scotland Premier League",
    "average_goal": "2.63"
  },
  {
    "name": "Italy Serie A",
    "average_goal": "2.62"
  },
  {
    "name": "Portugal Liga ZON Sagres",
    "average_goal": "2.53"
  },
  {
    "name": "France Ligue 1",
    "average_goal": "2.44"
  },
  {
    "name": "Poland Ekstraklasa",
    "average_goal": "2.43"
  }
]
*/