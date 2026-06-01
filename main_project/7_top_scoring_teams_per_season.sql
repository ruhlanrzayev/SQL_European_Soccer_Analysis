-- =====================================================
-- Question 7: Top Scoring Teams Per Season
-- =====================================================
-- Goal: Find which teams scored the most total goals
-- in a single season, combining both home and away
-- goals together.
-- Tables used: match, team
-- =====================================================

SELECT
    team.team_long_name,
    match.season,
    SUM(home_team_goal) + SUM(away_team_goal) AS total_goals
FROM match JOIN team ON team.team_api_id = match.home_team_api_id
OR team.team_api_id = match.away_team_api_id
GROUP BY
    team.team_long_name, match.season
ORDER BY 
    total_goals DESC
LIMIT 20;


/*

--------------------------------------------------
- Real Madrid CF dominates this list appearing 5 times
  in the top 20, with their peak being 156 goals in
  2014/2015 — the highest single season total in the
  entire dataset
- FC Barcelona appear 4 times, making El Clasico rivals
  Real Madrid and Barcelona responsible for 9 of the
  top 20 highest scoring season performances
- Liverpool's 151 goals in 2013/2014 is surprising —
  this was Luis Suarez's legendary season where he
  scored 31 league goals, nearly taking them to the
  Premier League title
- Polonia Bytom appearing with 150 goals is a major
  outlier — a small Polish club ranking 5th overall
  suggests the Polish Ekstraklasa had very high scoring
  matches in 2010/2011
- TSG Hoffenheim (142 goals) and SC Heerenveen (138
  goals) are unexpected names in the top 20, showing
  that smaller league teams can outscore famous clubs
  when their league style favors attacking football
- The Netherlands Eredivisie and Poland Ekstraklasa
  both have multiple surprise entries, which directly
  connects back to Q2 where both leagues ranked among
  the highest for average goals per match
--------------------------------------------------

RESULT: 

[
  {
    "team_long_name": "Real Madrid CF",
    "season": "2014/2015",
    "total_goals": "156"
  },
  {
    "team_long_name": "FC Barcelona",
    "season": "2012/2013",
    "total_goals": "155"
  },
  {
    "team_long_name": "Real Madrid CF",
    "season": "2011/2012",
    "total_goals": "153"
  },
  {
    "team_long_name": "Liverpool",
    "season": "2013/2014",
    "total_goals": "151"
  },
  {
    "team_long_name": "Polonia Bytom",
    "season": "2010/2011",
    "total_goals": "150"
  },
  {
    "team_long_name": "PSV",
    "season": "2012/2013",
    "total_goals": "146"
  },
  {
    "team_long_name": "Real Madrid CF",
    "season": "2012/2013",
    "total_goals": "145"
  },
  {
    "team_long_name": "Real Madrid CF",
    "season": "2015/2016",
    "total_goals": "144"
  },
  {
    "team_long_name": "FC Barcelona",
    "season": "2011/2012",
    "total_goals": "143"
  },
  {
    "team_long_name": "TSG 1899 Hoffenheim",
    "season": "2013/2014",
    "total_goals": "142"
  },
  {
    "team_long_name": "Real Madrid CF",
    "season": "2013/2014",
    "total_goals": "142"
  },
  {
    "team_long_name": "FC Barcelona",
    "season": "2015/2016",
    "total_goals": "141"
  },
  {
    "team_long_name": "FC Barcelona",
    "season": "2008/2009",
    "total_goals": "140"
  },
  {
    "team_long_name": "Manchester City",
    "season": "2013/2014",
    "total_goals": "139"
  },
  {
    "team_long_name": "SC Heerenveen",
    "season": "2011/2012",
    "total_goals": "138"
  },
  {
    "team_long_name": "Real Madrid CF",
    "season": "2009/2010",
    "total_goals": "137"
  },
  {
    "team_long_name": "Atlético Madrid",
    "season": "2008/2009",
    "total_goals": "137"
  },
  {
    "team_long_name": "FC Basel",
    "season": "2009/2010",
    "total_goals": "136"
  },
  {
    "team_long_name": "N.E.C.",
    "season": "2013/2014",
    "total_goals": "136"
  },
  {
    "team_long_name": "Chelsea",
    "season": "2009/2010",
    "total_goals": "135"
  }
]
*/