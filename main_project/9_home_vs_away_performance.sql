-- =====================================================
-- Question 9: Home vs Away Performance
-- =====================================================
-- Goal: Find which teams rely most heavily on home
-- advantage by comparing their average goals scored at
-- home vs away. A big difference means a team struggles
-- when traveling.
-- Tables used: match, team
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

-- Find the difference for all teams
SELECT 
    team.team_long_name,
    home_goals.home_goals AS home_goals,
    away_goals.away_goals AS away_goals,
    CASE
        WHEN home_goals > away_goals THEN home_goals - away_goals
        WHEN away_goals > home_goals THEN away_goals - home_goals
        ELSE home_goals - away_goals
    END AS home_vs_away_performance,
    CASE
        WHEN home_goals > away_goals THEN 'Home Best'
        WHEN away_goals > home_goals THEN 'Away Best'
        ELSE 'Equal'
    END AS which_one_best
FROM team JOIN home_goals ON (team.team_api_id = home_goals.team_api_id)
JOIN away_goals ON (team.team_api_id = away_goals.team_api_id)
ORDER BY home_vs_away_performance DESC



/*

----------------------------------------------
- Real Madrid CF dominates with a 167 goal difference
  between home (505) and away (338), showing extreme
  reliance on home advantage — one of the largest gaps
  in the entire dataset
- FC Barcelona follows at 141 goal difference, but their
  away performance (354 goals) is still strong compared
  to other elite teams, suggesting they travel better
  than Real Madrid despite the large gap
- Manchester City (124 gap) and Atlético Madrid (118 gap)
  show the Spanish league's teams heavily depend on their
  home fortress — La Liga appears to have the strongest
  home advantage effect overall
- The bottom of the list reveals surprising perfectly
  balanced teams: Hertha BSC Berlin (119 home = 119 away),
  Angers SCO (20 = 20), and Watford (20 = 20) perform
  identically at home and away — extremely rare
- Two outliers exist: SV Darmstadt 98 (23 away > 15 home)
  and SpVgg Greuther Fürth (16 away > 10 home) actually
  perform BETTER away than at home, suggesting tactical
  shifts or injury patterns reversed for away matches
- Most top European teams show home advantages between
  50-170 goals, confirming the massive advantage of
  playing in familiar stadiums with supporter backing
----------------------------------------------

RESULT : 

[
  {
    "team_long_name": "Real Madrid CF",
    "home_goals": "505",
    "away_goals": "338",
    "home_vs_away_performance": "167",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Barcelona",
    "home_goals": "495",
    "away_goals": "354",
    "home_vs_away_performance": "141",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Manchester City",
    "home_goals": "365",
    "away_goals": "241",
    "home_vs_away_performance": "124",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Atlético Madrid",
    "home_goals": "321",
    "away_goals": "203",
    "home_vs_away_performance": "118",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Valencia CF",
    "home_goals": "299",
    "away_goals": "185",
    "home_vs_away_performance": "114",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Bayern Munich",
    "home_goals": "382",
    "away_goals": "271",
    "home_vs_away_performance": "111",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "BSC Young Boys",
    "home_goals": "319",
    "away_goals": "210",
    "home_vs_away_performance": "109",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Genoa",
    "home_goals": "249",
    "away_goals": "143",
    "home_vs_away_performance": "106",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Palermo",
    "home_goals": "225",
    "away_goals": "126",
    "home_vs_away_performance": "99",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Paris Saint-Germain",
    "home_goals": "332",
    "away_goals": "236",
    "home_vs_away_performance": "96",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Manchester United",
    "home_goals": "338",
    "away_goals": "244",
    "home_vs_away_performance": "94",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Feyenoord",
    "home_goals": "291",
    "away_goals": "198",
    "home_vs_away_performance": "93",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Sevilla FC",
    "home_goals": "285",
    "away_goals": "193",
    "home_vs_away_performance": "92",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Napoli",
    "home_goals": "303",
    "away_goals": "211",
    "home_vs_away_performance": "92",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "LOSC Lille",
    "home_goals": "270",
    "away_goals": "180",
    "home_vs_away_performance": "90",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "PSV",
    "home_goals": "370",
    "away_goals": "282",
    "home_vs_away_performance": "88",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Stoke City",
    "home_goals": "204",
    "away_goals": "118",
    "home_vs_away_performance": "86",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Athletic Club de Bilbao",
    "home_goals": "250",
    "away_goals": "165",
    "home_vs_away_performance": "85",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "VfL Wolfsburg",
    "home_goals": "274",
    "away_goals": "189",
    "home_vs_away_performance": "85",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Chelsea",
    "home_goals": "333",
    "away_goals": "250",
    "home_vs_away_performance": "83",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Celtic",
    "home_goals": "389",
    "away_goals": "306",
    "home_vs_away_performance": "83",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Utrecht",
    "home_goals": "245",
    "away_goals": "163",
    "home_vs_away_performance": "82",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Olympique Lyonnais",
    "home_goals": "289",
    "away_goals": "208",
    "home_vs_away_performance": "81",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Fulham",
    "home_goals": "173",
    "away_goals": "92",
    "home_vs_away_performance": "81",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Borussia Mönchengladbach",
    "home_goals": "242",
    "away_goals": "161",
    "home_vs_away_performance": "81",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "SC Braga",
    "home_goals": "239",
    "away_goals": "159",
    "home_vs_away_performance": "80",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Schalke 04",
    "home_goals": "252",
    "away_goals": "174",
    "home_vs_away_performance": "78",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Hannover 96",
    "home_goals": "218",
    "away_goals": "141",
    "home_vs_away_performance": "77",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Everton",
    "home_goals": "258",
    "away_goals": "181",
    "home_vs_away_performance": "77",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "AS Saint-Étienne",
    "home_goals": "223",
    "away_goals": "148",
    "home_vs_away_performance": "75",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "SL Benfica",
    "home_goals": "321",
    "away_goals": "247",
    "home_vs_away_performance": "74",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Newcastle United",
    "home_goals": "199",
    "away_goals": "125",
    "home_vs_away_performance": "74",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Ajax",
    "home_goals": "360",
    "away_goals": "287",
    "home_vs_away_performance": "73",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "RCD Espanyol",
    "home_goals": "205",
    "away_goals": "133",
    "home_vs_away_performance": "72",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Villarreal CF",
    "home_goals": "218",
    "away_goals": "146",
    "home_vs_away_performance": "72",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Thun",
    "home_goals": "175",
    "away_goals": "104",
    "home_vs_away_performance": "71",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Juventus",
    "home_goals": "307",
    "away_goals": "236",
    "home_vs_away_performance": "71",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Legia Warszawa",
    "home_goals": "240",
    "away_goals": "169",
    "home_vs_away_performance": "71",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Twente",
    "home_goals": "289",
    "away_goals": "220",
    "home_vs_away_performance": "69",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Basel",
    "home_goals": "344",
    "away_goals": "275",
    "home_vs_away_performance": "69",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Sion",
    "home_goals": "220",
    "away_goals": "151",
    "home_vs_away_performance": "69",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Roma",
    "home_goals": "299",
    "away_goals": "231",
    "home_vs_away_performance": "68",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Valenciennes FC",
    "home_goals": "162",
    "away_goals": "94",
    "home_vs_away_performance": "68",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Heracles Almelo",
    "home_goals": "235",
    "away_goals": "168",
    "home_vs_away_performance": "67",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Málaga CF",
    "home_goals": "222",
    "away_goals": "155",
    "home_vs_away_performance": "67",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "RSC Anderlecht",
    "home_goals": "247",
    "away_goals": "180",
    "home_vs_away_performance": "67",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "AZ",
    "home_goals": "279",
    "away_goals": "213",
    "home_vs_away_performance": "66",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Jagiellonia Białystok",
    "home_goals": "176",
    "away_goals": "111",
    "home_vs_away_performance": "65",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Inter",
    "home_goals": "280",
    "away_goals": "216",
    "home_vs_away_performance": "64",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "SC Heerenveen",
    "home_goals": "267",
    "away_goals": "203",
    "home_vs_away_performance": "64",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "West Ham United",
    "home_goals": "195",
    "away_goals": "131",
    "home_vs_away_performance": "64",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Sampdoria",
    "home_goals": "190",
    "away_goals": "128",
    "home_vs_away_performance": "62",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "KRC Genk",
    "home_goals": "205",
    "away_goals": "143",
    "home_vs_away_performance": "62",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Korona Kielce",
    "home_goals": "149",
    "away_goals": "88",
    "home_vs_away_performance": "61",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Lazio",
    "home_goals": "239",
    "away_goals": "178",
    "home_vs_away_performance": "61",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Heart of Midlothian",
    "home_goals": "189",
    "away_goals": "128",
    "home_vs_away_performance": "61",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Groningen",
    "home_goals": "225",
    "away_goals": "165",
    "home_vs_away_performance": "60",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Getafe CF",
    "home_goals": "202",
    "away_goals": "143",
    "home_vs_away_performance": "59",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "KV Kortrijk",
    "home_goals": "163",
    "away_goals": "104",
    "home_vs_away_performance": "59",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Catania",
    "home_goals": "155",
    "away_goals": "96",
    "home_vs_away_performance": "59",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Willem II",
    "home_goals": "140",
    "away_goals": "82",
    "home_vs_away_performance": "58",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Lech Poznań",
    "home_goals": "215",
    "away_goals": "157",
    "home_vs_away_performance": "58",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Bayer 04 Leverkusen",
    "home_goals": "270",
    "away_goals": "213",
    "home_vs_away_performance": "57",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Luzern",
    "home_goals": "239",
    "away_goals": "182",
    "home_vs_away_performance": "57",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Liverpool",
    "home_goals": "294",
    "away_goals": "237",
    "home_vs_away_performance": "57",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Standard de Liège",
    "home_goals": "199",
    "away_goals": "142",
    "home_vs_away_performance": "57",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Udinese",
    "home_goals": "236",
    "away_goals": "179",
    "home_vs_away_performance": "57",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Atalanta",
    "home_goals": "170",
    "away_goals": "113",
    "home_vs_away_performance": "57",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "RCD Mallorca",
    "home_goals": "147",
    "away_goals": "91",
    "home_vs_away_performance": "56",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Eintracht Frankfurt",
    "home_goals": "176",
    "away_goals": "120",
    "home_vs_away_performance": "56",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Real Sociedad",
    "home_goals": "186",
    "away_goals": "130",
    "home_vs_away_performance": "56",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "OGC Nice",
    "home_goals": "198",
    "away_goals": "144",
    "home_vs_away_performance": "54",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Cracovia",
    "home_goals": "144",
    "away_goals": "91",
    "home_vs_away_performance": "53",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Cagliari",
    "home_goals": "181",
    "away_goals": "128",
    "home_vs_away_performance": "53",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Polonia Bytom",
    "home_goals": "149",
    "away_goals": "96",
    "home_vs_away_performance": "53",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Motherwell",
    "home_goals": "228",
    "away_goals": "175",
    "home_vs_away_performance": "53",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Girondins de Bordeaux",
    "home_goals": "228",
    "away_goals": "176",
    "home_vs_away_performance": "52",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Southampton",
    "home_goals": "134",
    "away_goals": "82",
    "home_vs_away_performance": "52",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Fiorentina",
    "home_goals": "246",
    "away_goals": "194",
    "home_vs_away_performance": "52",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "VVV-Venlo",
    "home_goals": "101",
    "away_goals": "51",
    "home_vs_away_performance": "50",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Lorient",
    "home_goals": "214",
    "away_goals": "164",
    "home_vs_away_performance": "50",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Beerschot AC",
    "home_goals": "112",
    "away_goals": "62",
    "home_vs_away_performance": "50",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Toulouse FC",
    "home_goals": "194",
    "away_goals": "145",
    "home_vs_away_performance": "49",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Levante UD",
    "home_goals": "145",
    "away_goals": "96",
    "home_vs_away_performance": "49",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "West Bromwich Albion",
    "home_goals": "177",
    "away_goals": "128",
    "home_vs_away_performance": "49",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Porto",
    "home_goals": "295",
    "away_goals": "246",
    "home_vs_away_performance": "49",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Club Brugge KV",
    "home_goals": "235",
    "away_goals": "186",
    "home_vs_away_performance": "49",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Bologna",
    "home_goals": "155",
    "away_goals": "108",
    "home_vs_away_performance": "47",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "RC Deportivo de La Coruña",
    "home_goals": "144",
    "away_goals": "97",
    "home_vs_away_performance": "47",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Milan",
    "home_goals": "271",
    "away_goals": "225",
    "home_vs_away_performance": "46",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "NAC Breda",
    "home_goals": "170",
    "away_goals": "124",
    "home_vs_away_performance": "46",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Olympique de Marseille",
    "home_goals": "254",
    "away_goals": "208",
    "home_vs_away_performance": "46",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "SV Zulte-Waregem",
    "home_goals": "176",
    "away_goals": "130",
    "home_vs_away_performance": "46",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Borussia Dortmund",
    "home_goals": "298",
    "away_goals": "253",
    "home_vs_away_performance": "45",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Vitesse",
    "home_goals": "234",
    "away_goals": "189",
    "home_vs_away_performance": "45",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "PEC Zwolle",
    "home_goals": "124",
    "away_goals": "80",
    "home_vs_away_performance": "44",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "TSG 1899 Hoffenheim",
    "home_goals": "222",
    "away_goals": "178",
    "home_vs_away_performance": "44",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Stade Rennais FC",
    "home_goals": "205",
    "away_goals": "162",
    "home_vs_away_performance": "43",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "CA Osasuna",
    "home_goals": "137",
    "away_goals": "95",
    "home_vs_away_performance": "42",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "CD Nacional",
    "home_goals": "187",
    "away_goals": "145",
    "home_vs_away_performance": "42",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "ADO Den Haag",
    "home_goals": "204",
    "away_goals": "162",
    "home_vs_away_performance": "42",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Sochaux-Montbéliard",
    "home_goals": "144",
    "away_goals": "102",
    "home_vs_away_performance": "42",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Montpellier Hérault SC",
    "home_goals": "193",
    "away_goals": "151",
    "home_vs_away_performance": "42",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Roda JC Kerkrade",
    "home_goals": "192",
    "away_goals": "151",
    "home_vs_away_performance": "41",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Neuchâtel Xamax",
    "home_goals": "106",
    "away_goals": "65",
    "home_vs_away_performance": "41",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Paços de Ferreira",
    "home_goals": "166",
    "away_goals": "126",
    "home_vs_away_performance": "40",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "UD Almería",
    "home_goals": "121",
    "away_goals": "81",
    "home_vs_away_performance": "40",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Arsenal",
    "home_goals": "306",
    "away_goals": "267",
    "home_vs_away_performance": "39",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Grasshopper Club Zürich",
    "home_goals": "234",
    "away_goals": "195",
    "home_vs_away_performance": "39",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "KV Mechelen",
    "home_goals": "162",
    "away_goals": "123",
    "home_vs_away_performance": "39",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "N.E.C.",
    "home_goals": "174",
    "away_goals": "136",
    "home_vs_away_performance": "38",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Real Sporting de Gijón",
    "home_goals": "119",
    "away_goals": "81",
    "home_vs_away_performance": "38",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "GKS Bełchatów",
    "home_goals": "114",
    "away_goals": "76",
    "home_vs_away_performance": "38",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "SV Werder Bremen",
    "home_goals": "230",
    "away_goals": "193",
    "home_vs_away_performance": "37",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "SC Bastia",
    "home_goals": "101",
    "away_goals": "64",
    "home_vs_away_performance": "37",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Sporting CP",
    "home_goals": "224",
    "away_goals": "187",
    "home_vs_away_performance": "37",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Swansea City",
    "home_goals": "135",
    "away_goals": "98",
    "home_vs_away_performance": "37",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "KAA Gent",
    "home_goals": "213",
    "away_goals": "177",
    "home_vs_away_performance": "36",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Sunderland",
    "home_goals": "184",
    "away_goals": "149",
    "home_vs_away_performance": "35",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Śląsk Wrocław",
    "home_goals": "176",
    "away_goals": "142",
    "home_vs_away_performance": "34",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Widzew Łódź",
    "home_goals": "77",
    "away_goals": "45",
    "home_vs_away_performance": "32",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "De Graafschap",
    "home_goals": "81",
    "away_goals": "49",
    "home_vs_away_performance": "32",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Norwich City",
    "home_goals": "96",
    "away_goals": "64",
    "home_vs_away_performance": "32",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Vitória Setúbal",
    "home_goals": "135",
    "away_goals": "103",
    "home_vs_away_performance": "32",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Académica de Coimbra",
    "home_goals": "136",
    "away_goals": "104",
    "home_vs_away_performance": "32",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Real Zaragoza",
    "home_goals": "95",
    "away_goals": "64",
    "home_vs_away_performance": "31",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Rayo Vallecano",
    "home_goals": "139",
    "away_goals": "108",
    "home_vs_away_performance": "31",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Lechia Gdańsk",
    "home_goals": "155",
    "away_goals": "124",
    "home_vs_away_performance": "31",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "KVC Westerlo",
    "home_goals": "124",
    "away_goals": "93",
    "home_vs_away_performance": "31",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "RKC Waalwijk",
    "home_goals": "92",
    "away_goals": "61",
    "home_vs_away_performance": "31",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Kilmarnock",
    "home_goals": "188",
    "away_goals": "158",
    "home_vs_away_performance": "30",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Rangers",
    "home_goals": "177",
    "away_goals": "147",
    "home_vs_away_performance": "30",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC St. Gallen",
    "home_goals": "153",
    "away_goals": "123",
    "home_vs_away_performance": "30",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Évian Thonon Gaillard FC",
    "home_goals": "105",
    "away_goals": "75",
    "home_vs_away_performance": "30",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Parma",
    "home_goals": "151",
    "away_goals": "121",
    "home_vs_away_performance": "30",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Tottenham Hotspur",
    "home_goals": "255",
    "away_goals": "226",
    "home_vs_away_performance": "29",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "AJ Auxerre",
    "home_goals": "98",
    "away_goals": "70",
    "home_vs_away_performance": "28",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "En Avant de Guingamp",
    "home_goals": "75",
    "away_goals": "47",
    "home_vs_away_performance": "28",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Portsmouth",
    "home_goals": "50",
    "away_goals": "22",
    "home_vs_away_performance": "28",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Stade de Reims",
    "home_goals": "98",
    "away_goals": "70",
    "home_vs_away_performance": "28",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Arka Gdynia",
    "home_goals": "52",
    "away_goals": "25",
    "home_vs_away_performance": "27",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Bolton Wanderers",
    "home_goals": "104",
    "away_goals": "77",
    "home_vs_away_performance": "27",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Dundee United",
    "home_goals": "232",
    "away_goals": "206",
    "home_vs_away_performance": "26",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Excelsior",
    "home_goals": "90",
    "away_goals": "64",
    "home_vs_away_performance": "26",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Piast Gliwice",
    "home_goals": "115",
    "away_goals": "89",
    "home_vs_away_performance": "26",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "RC Celta de Vigo",
    "home_goals": "105",
    "away_goals": "79",
    "home_vs_away_performance": "26",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "CS Marítimo",
    "home_goals": "171",
    "away_goals": "145",
    "home_vs_away_performance": "26",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "St. Johnstone FC",
    "home_goals": "167",
    "away_goals": "141",
    "home_vs_away_performance": "26",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Sint-Truidense VV",
    "home_goals": "70",
    "away_goals": "45",
    "home_vs_away_performance": "25",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Górnik Łęczna",
    "home_goals": "43",
    "away_goals": "18",
    "home_vs_away_performance": "25",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "KSV Cercle Brugge",
    "home_goals": "119",
    "away_goals": "94",
    "home_vs_away_performance": "25",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Sporting Charleroi",
    "home_goals": "113",
    "away_goals": "88",
    "home_vs_away_performance": "25",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Aarau",
    "home_goals": "89",
    "away_goals": "64",
    "home_vs_away_performance": "25",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Lierse SK",
    "home_goals": "69",
    "away_goals": "44",
    "home_vs_away_performance": "25",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Zagłębie Lubin",
    "home_goals": "116",
    "away_goals": "91",
    "home_vs_away_performance": "25",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Estoril Praia",
    "home_goals": "96",
    "away_goals": "71",
    "home_vs_away_performance": "25",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Nantes",
    "home_goals": "79",
    "away_goals": "56",
    "home_vs_away_performance": "23",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Aston Villa",
    "home_goals": "179",
    "away_goals": "156",
    "home_vs_away_performance": "23",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "VfB Stuttgart",
    "home_goals": "219",
    "away_goals": "196",
    "home_vs_away_performance": "23",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "RAEC Mons",
    "home_goals": "76",
    "away_goals": "53",
    "home_vs_away_performance": "23",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Augsburg",
    "home_goals": "112",
    "away_goals": "89",
    "home_vs_away_performance": "23",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "1. FC Nürnberg",
    "home_goals": "108",
    "away_goals": "85",
    "home_vs_away_performance": "23",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "KV Oostende",
    "home_goals": "62",
    "away_goals": "40",
    "home_vs_away_performance": "22",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "1. FSV Mainz 05",
    "home_goals": "171",
    "away_goals": "149",
    "home_vs_away_performance": "22",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Polonia Bytom",
    "home_goals": "55",
    "away_goals": "33",
    "home_vs_away_performance": "22",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Oud-Heverlee Leuven",
    "home_goals": "74",
    "away_goals": "52",
    "home_vs_away_performance": "22",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Granada CF",
    "home_goals": "100",
    "away_goals": "79",
    "home_vs_away_performance": "21",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "SC Freiburg",
    "home_goals": "133",
    "away_goals": "112",
    "home_vs_away_performance": "21",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Blackburn Rovers",
    "home_goals": "98",
    "away_goals": "77",
    "home_vs_away_performance": "21",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Stade Brestois 29",
    "home_goals": "60",
    "away_goals": "39",
    "home_vs_away_performance": "21",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Metz",
    "home_goals": "26",
    "away_goals": "5",
    "home_vs_away_performance": "21",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Hellas Verona",
    "home_goals": "83",
    "away_goals": "62",
    "home_vs_away_performance": "21",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "AC Bellinzona",
    "home_goals": "74",
    "away_goals": "54",
    "home_vs_away_performance": "20",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Sporting Lokeren",
    "home_goals": "149",
    "away_goals": "130",
    "home_vs_away_performance": "19",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "AS Monaco",
    "home_goals": "153",
    "away_goals": "134",
    "home_vs_away_performance": "19",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Pogoń Szczecin",
    "home_goals": "85",
    "away_goals": "67",
    "home_vs_away_performance": "18",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Real Valladolid",
    "home_goals": "94",
    "away_goals": "76",
    "home_vs_away_performance": "18",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Livorno",
    "home_goals": "42",
    "away_goals": "24",
    "home_vs_away_performance": "18",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Hércules Club de Fútbol",
    "home_goals": "27",
    "away_goals": "9",
    "home_vs_away_performance": "18",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "CF Os Belenenses",
    "home_goals": "83",
    "away_goals": "65",
    "home_vs_away_performance": "18",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Dundee FC",
    "home_goals": "72",
    "away_goals": "55",
    "home_vs_away_performance": "17",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "St. Mirren",
    "home_goals": "137",
    "away_goals": "120",
    "home_vs_away_performance": "17",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Ruch Chorzów",
    "home_goals": "148",
    "away_goals": "132",
    "home_vs_away_performance": "16",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Volendam",
    "home_goals": "27",
    "away_goals": "11",
    "home_vs_away_performance": "16",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Reggio Calabria",
    "home_goals": "23",
    "away_goals": "7",
    "home_vs_away_performance": "16",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Hamilton Academical FC",
    "home_goals": "100",
    "away_goals": "85",
    "home_vs_away_performance": "15",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Leixões SC",
    "home_goals": "35",
    "away_goals": "20",
    "home_vs_away_performance": "15",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "SC Cambuur",
    "home_goals": "67",
    "away_goals": "52",
    "home_vs_away_performance": "15",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "RC Lens",
    "home_goals": "61",
    "away_goals": "46",
    "home_vs_away_performance": "15",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Lecce",
    "home_goals": "68",
    "away_goals": "53",
    "home_vs_away_performance": "15",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Rio Ave FC",
    "home_goals": "131",
    "away_goals": "117",
    "home_vs_away_performance": "14",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Hull City",
    "home_goals": "79",
    "away_goals": "65",
    "home_vs_away_performance": "14",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Royal Excel Mouscron",
    "home_goals": "28",
    "away_goals": "14",
    "home_vs_away_performance": "14",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Zürich",
    "home_goals": "241",
    "away_goals": "227",
    "home_vs_away_performance": "14",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Hibernian",
    "home_goals": "136",
    "away_goals": "123",
    "home_vs_away_performance": "13",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Partick Thistle F.C.",
    "home_goals": "74",
    "away_goals": "61",
    "home_vs_away_performance": "13",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Sparta Rotterdam",
    "home_goals": "44",
    "away_goals": "32",
    "home_vs_away_performance": "12",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Hamburger SV",
    "home_goals": "178",
    "away_goals": "166",
    "home_vs_away_performance": "12",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Gil Vicente FC",
    "home_goals": "61",
    "away_goals": "49",
    "home_vs_away_performance": "12",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Vitória Guimarães",
    "home_goals": "156",
    "away_goals": "144",
    "home_vs_away_performance": "12",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Leicester City",
    "home_goals": "63",
    "away_goals": "51",
    "home_vs_away_performance": "12",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "CD Tenerife",
    "home_goals": "26",
    "away_goals": "14",
    "home_vs_away_performance": "12",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Wigan Athletic",
    "home_goals": "106",
    "away_goals": "94",
    "home_vs_away_performance": "12",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "AC Ajaccio",
    "home_goals": "64",
    "away_goals": "52",
    "home_vs_away_performance": "12",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Uniao da Madeira",
    "home_goals": "19",
    "away_goals": "8",
    "home_vs_away_performance": "11",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "SC Paderborn 07",
    "home_goals": "21",
    "away_goals": "10",
    "home_vs_away_performance": "11",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Grenoble Foot 38",
    "home_goals": "33",
    "away_goals": "22",
    "home_vs_away_performance": "11",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Ingolstadt 04",
    "home_goals": "22",
    "away_goals": "11",
    "home_vs_away_performance": "11",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Zawisza Bydgoszcz",
    "home_goals": "43",
    "away_goals": "32",
    "home_vs_away_performance": "11",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Royal Excel Mouscron",
    "home_goals": "41",
    "away_goals": "30",
    "home_vs_away_performance": "11",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Arouca",
    "home_goals": "56",
    "away_goals": "45",
    "home_vs_away_performance": "11",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "VfL Bochum",
    "home_goals": "41",
    "away_goals": "31",
    "home_vs_away_performance": "10",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Brescia",
    "home_goals": "22",
    "away_goals": "12",
    "home_vs_away_performance": "10",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Empoli",
    "home_goals": "48",
    "away_goals": "38",
    "home_vs_away_performance": "10",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "KSV Roeselare",
    "home_goals": "36",
    "away_goals": "26",
    "home_vs_away_performance": "10",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "SC Beira Mar",
    "home_goals": "51",
    "away_goals": "42",
    "home_vs_away_performance": "9",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Tubize",
    "home_goals": "22",
    "away_goals": "13",
    "home_vs_away_performance": "9",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Carpi",
    "home_goals": "23",
    "away_goals": "14",
    "home_vs_away_performance": "9",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Torino",
    "home_goals": "125",
    "away_goals": "116",
    "home_vs_away_performance": "9",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Inverness Caledonian Thistle",
    "home_goals": "177",
    "away_goals": "168",
    "home_vs_away_performance": "9",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Boavista FC",
    "home_goals": "30",
    "away_goals": "21",
    "home_vs_away_performance": "9",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "SD Eibar",
    "home_goals": "46",
    "away_goals": "37",
    "home_vs_away_performance": "9",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "GFC Ajaccio",
    "home_goals": "23",
    "away_goals": "14",
    "home_vs_away_performance": "9",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Fortuna Düsseldorf",
    "home_goals": "24",
    "away_goals": "15",
    "home_vs_away_performance": "9",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Termalica Bruk-Bet Nieciecza",
    "home_goals": "21",
    "away_goals": "12",
    "home_vs_away_performance": "9",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Energie Cottbus",
    "home_goals": "19",
    "away_goals": "11",
    "home_vs_away_performance": "8",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Go Ahead Eagles",
    "home_goals": "41",
    "away_goals": "33",
    "home_vs_away_performance": "8",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Dijon FCO",
    "home_goals": "23",
    "away_goals": "15",
    "home_vs_away_performance": "8",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "P. Warszawa",
    "home_goals": "96",
    "away_goals": "88",
    "home_vs_away_performance": "8",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "CD Numancia",
    "home_goals": "23",
    "away_goals": "15",
    "home_vs_away_performance": "8",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Bari",
    "home_goals": "42",
    "away_goals": "34",
    "home_vs_away_performance": "8",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Cardiff City",
    "home_goals": "20",
    "away_goals": "12",
    "home_vs_away_performance": "8",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "SV Darmstadt 98",
    "home_goals": "15",
    "away_goals": "23",
    "home_vs_away_performance": "8",
    "which_one_best": "Away Best"
  },
  {
    "team_long_name": "Odra Wodzisław",
    "home_goals": "29",
    "away_goals": "21",
    "home_vs_away_performance": "8",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Burnley",
    "home_goals": "39",
    "away_goals": "31",
    "home_vs_away_performance": "8",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Aberdeen",
    "home_goals": "186",
    "away_goals": "179",
    "home_vs_away_performance": "7",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Real Betis Balompié",
    "home_goals": "116",
    "away_goals": "109",
    "home_vs_away_performance": "7",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Portimonense",
    "home_goals": "18",
    "away_goals": "11",
    "home_vs_away_performance": "7",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "US Boulogne Cote D'Opale",
    "home_goals": "19",
    "away_goals": "12",
    "home_vs_away_performance": "7",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC St. Pauli",
    "home_goals": "21",
    "away_goals": "14",
    "home_vs_away_performance": "7",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "AC Arles-Avignon",
    "home_goals": "14",
    "away_goals": "7",
    "home_vs_away_performance": "7",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Eintracht Braunschweig",
    "home_goals": "18",
    "away_goals": "11",
    "home_vs_away_performance": "7",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Middlesbrough",
    "home_goals": "17",
    "away_goals": "11",
    "home_vs_away_performance": "6",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Vaduz",
    "home_goals": "53",
    "away_goals": "47",
    "home_vs_away_performance": "6",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Karlsruher SC",
    "home_goals": "18",
    "away_goals": "12",
    "home_vs_away_performance": "6",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Dordrecht",
    "home_goals": "15",
    "away_goals": "9",
    "home_vs_away_performance": "6",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Amadora",
    "home_goals": "16",
    "away_goals": "10",
    "home_vs_away_performance": "6",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Wolverhampton Wanderers",
    "home_goals": "62",
    "away_goals": "56",
    "home_vs_away_performance": "6",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "SpVgg Greuther Fürth",
    "home_goals": "10",
    "away_goals": "16",
    "home_vs_away_performance": "6",
    "which_one_best": "Away Best"
  },
  {
    "team_long_name": "1. FC Köln",
    "home_goals": "116",
    "away_goals": "110",
    "home_vs_away_performance": "6",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Queens Park Rangers",
    "home_goals": "60",
    "away_goals": "55",
    "home_vs_away_performance": "5",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Waasland-Beveren",
    "home_goals": "50",
    "away_goals": "55",
    "home_vs_away_performance": "5",
    "which_one_best": "Away Best"
  },
  {
    "team_long_name": "Moreirense FC",
    "home_goals": "53",
    "away_goals": "48",
    "home_vs_away_performance": "5",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Blackpool",
    "home_goals": "30",
    "away_goals": "25",
    "home_vs_away_performance": "5",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Servette FC",
    "home_goals": "41",
    "away_goals": "36",
    "home_vs_away_performance": "5",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Lausanne-Sports",
    "home_goals": "52",
    "away_goals": "47",
    "home_vs_away_performance": "5",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "UD Las Palmas",
    "home_goals": "25",
    "away_goals": "20",
    "home_vs_away_performance": "5",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "ES Troyes AC",
    "home_goals": "38",
    "away_goals": "33",
    "home_vs_away_performance": "5",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FC Penafiel",
    "home_goals": "17",
    "away_goals": "12",
    "home_vs_away_performance": "5",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "União de Leiria, SAD",
    "home_goals": "45",
    "away_goals": "40",
    "home_vs_away_performance": "5",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Sassuolo",
    "home_goals": "73",
    "away_goals": "68",
    "home_vs_away_performance": "5",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Dunfermline Athletic",
    "home_goals": "22",
    "away_goals": "18",
    "home_vs_away_performance": "4",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Cesena",
    "home_goals": "51",
    "away_goals": "47",
    "home_vs_away_performance": "4",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Novara",
    "home_goals": "19",
    "away_goals": "15",
    "home_vs_away_performance": "4",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Lugano",
    "home_goals": "25",
    "away_goals": "21",
    "home_vs_away_performance": "4",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Widzew Łódź",
    "home_goals": "27",
    "away_goals": "23",
    "home_vs_away_performance": "4",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Falkirk",
    "home_goals": "36",
    "away_goals": "32",
    "home_vs_away_performance": "4",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Tondela",
    "home_goals": "15",
    "away_goals": "19",
    "home_vs_away_performance": "4",
    "which_one_best": "Away Best"
  },
  {
    "team_long_name": "Le Havre AC",
    "home_goals": "17",
    "away_goals": "13",
    "home_vs_away_performance": "4",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Wisła Kraków",
    "home_goals": "168",
    "away_goals": "164",
    "home_vs_away_performance": "4",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Reading",
    "home_goals": "23",
    "away_goals": "20",
    "home_vs_away_performance": "3",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Naval 1° de Maio",
    "home_goals": "37",
    "away_goals": "34",
    "home_vs_away_performance": "3",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Crystal Palace",
    "home_goals": "58",
    "away_goals": "61",
    "home_vs_away_performance": "3",
    "which_one_best": "Away Best"
  },
  {
    "team_long_name": "Pescara",
    "home_goals": "15",
    "away_goals": "12",
    "home_vs_away_performance": "3",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Chievo Verona",
    "home_goals": "144",
    "away_goals": "141",
    "home_vs_away_performance": "3",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "AS Nancy-Lorraine",
    "home_goals": "103",
    "away_goals": "100",
    "home_vs_away_performance": "3",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "DSC Arminia Bielefeld",
    "home_goals": "16",
    "away_goals": "13",
    "home_vs_away_performance": "3",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Trofense",
    "home_goals": "14",
    "away_goals": "11",
    "home_vs_away_performance": "3",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "FCV Dender EH",
    "home_goals": "21",
    "away_goals": "23",
    "home_vs_away_performance": "2",
    "which_one_best": "Away Best"
  },
  {
    "team_long_name": "SM Caen",
    "home_goals": "109",
    "away_goals": "111",
    "home_vs_away_performance": "2",
    "which_one_best": "Away Best"
  },
  {
    "team_long_name": "Córdoba CF",
    "home_goals": "12",
    "away_goals": "10",
    "home_vs_away_performance": "2",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Racing Santander",
    "home_goals": "81",
    "away_goals": "79",
    "home_vs_away_performance": "2",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Xerez Club Deportivo",
    "home_goals": "20",
    "away_goals": "18",
    "home_vs_away_performance": "2",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Ross County FC",
    "home_goals": "97",
    "away_goals": "95",
    "home_vs_away_performance": "2",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "KAS Eupen",
    "home_goals": "15",
    "away_goals": "13",
    "home_vs_away_performance": "2",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "1. FC Kaiserslautern",
    "home_goals": "37",
    "away_goals": "35",
    "home_vs_away_performance": "2",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "S.C. Olhanense",
    "home_goals": "70",
    "away_goals": "68",
    "home_vs_away_performance": "2",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Feirense",
    "home_goals": "13",
    "away_goals": "14",
    "home_vs_away_performance": "1",
    "which_one_best": "Away Best"
  },
  {
    "team_long_name": "Podbeskidzie Bielsko-Biała",
    "home_goals": "85",
    "away_goals": "84",
    "home_vs_away_performance": "1",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Frosinone",
    "home_goals": "18",
    "away_goals": "17",
    "home_vs_away_performance": "1",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Elche CF",
    "home_goals": "32",
    "away_goals": "33",
    "home_vs_away_performance": "1",
    "which_one_best": "Away Best"
  },
  {
    "team_long_name": "Siena",
    "home_goals": "75",
    "away_goals": "74",
    "home_vs_away_performance": "1",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Birmingham City",
    "home_goals": "38",
    "away_goals": "37",
    "home_vs_away_performance": "1",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Bournemouth",
    "home_goals": "23",
    "away_goals": "22",
    "home_vs_away_performance": "1",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Le Mans FC",
    "home_goals": "40",
    "away_goals": "39",
    "home_vs_away_performance": "1",
    "which_one_best": "Home Best"
  },
  {
    "team_long_name": "Angers SCO",
    "home_goals": "20",
    "away_goals": "20",
    "home_vs_away_performance": "0",
    "which_one_best": "Equal"
  },
  {
    "team_long_name": "RC Recreativo",
    "home_goals": "17",
    "away_goals": "17",
    "home_vs_away_performance": "0",
    "which_one_best": "Equal"
  },
  {
    "team_long_name": "Hertha BSC Berlin",
    "home_goals": "119",
    "away_goals": "119",
    "home_vs_away_performance": "0",
    "which_one_best": "Equal"
  },
  {
    "team_long_name": "Watford",
    "home_goals": "20",
    "away_goals": "20",
    "home_vs_away_performance": "0",
    "which_one_best": "Equal"
  }
]

*/