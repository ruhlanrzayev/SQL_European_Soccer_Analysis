-- =====================================================
-- Question 6: Goals Trend By Season
-- =====================================================
-- Goal: Find how average goals per match changed
-- season by season across all leagues. Identify
-- whether European football became more or less
-- attacking between 2008 and 2016.
-- Tables used: match
-- =====================================================

SELECT
    season,
    ROUND(AVG(home_team_goal + away_team_goal), 2) AS average_goal
FROM 
    match
GROUP BY
    season
ORDER BY
    season


/*

-------------------------------------------
- Average goals per match steadily increased from
  2.61 in 2008/2009 to a peak of 2.77 in 2012/2013,
  suggesting European football became more attacking
  over this period
- 2012/2013 and 2013/2014 share the highest average
  of 2.77 — this era coincides with some of the most
  entertaining football in recent history, including
  Bayern Munich's treble and Barcelona's dominance
- 2014/2015 saw a notable dip back to 2.68, suggesting
  a tactical shift towards more defensive football
  across European leagues in that season
- By 2015/2016 the average recovered to 2.75, showing
  the dip was temporary rather than a long term trend
- Overall the 8 season range is narrow (2.61 to 2.77),
  a difference of only 0.16 goals per match — meaning
  European football's attacking output was remarkably
  consistent across this entire period
-------------------------------------------

RESULT: 

[
  {
    "season": "2008/2009",
    "average_goal": "2.61"
  },
  {
    "season": "2009/2010",
    "average_goal": "2.67"
  },
  {
    "season": "2010/2011",
    "average_goal": "2.68"
  },
  {
    "season": "2011/2012",
    "average_goal": "2.72"
  },
  {
    "season": "2012/2013",
    "average_goal": "2.77"
  },
  {
    "season": "2013/2014",
    "average_goal": "2.77"
  },
  {
    "season": "2014/2015",
    "average_goal": "2.68"
  },
  {
    "season": "2015/2016",
    "average_goal": "2.75"
  }
]

*/