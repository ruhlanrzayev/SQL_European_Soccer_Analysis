-- =====================================================
-- Question 4: Team Wins, Draws and Losses
-- =====================================================
-- Goal: Find each team's total wins, draws and losses
-- across all seasons combined.
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
    COUNT(CASE WHEN result = 'Loss' THEN 1 END) AS losses
FROM team
JOIN all_matches ON team.team_api_id = all_matches.team_api_id
GROUP BY team.team_long_name
ORDER BY wins DESC;


/*

-------------------------------------------------
- Real Madrid and Barcelona dominate the top of the
  wins list, reflecting their consistent dominance
  in Spanish football over the dataset period
- The UNION ALL approach was necessary here because
  each team appears in the match table twice — once
  as home and once as away — so both sides had to be
  captured and combined before counting results
- CASE WHEN logic was used to label each match result
  from both the home and away perspective correctly
-------------------------------------------------

RESULT: 
[
  {
    "team_long_name": "FC Barcelona",
    "wins": "234",
    "draws": "43",
    "losses": "27"
  },
  {
    "team_long_name": "Real Madrid CF",
    "wins": "228",
    "draws": "36",
    "losses": "40"
  },
  {
    "team_long_name": "Celtic",
    "wins": "218",
    "draws": "50",
    "losses": "36"
  },
  {
    "team_long_name": "FC Bayern Munich",
    "wins": "193",
    "draws": "44",
    "losses": "35"
  },
  {
    "team_long_name": "Manchester United",
    "wins": "192",
    "draws": "57",
    "losses": "55"
  },
  {
    "team_long_name": "Juventus",
    "wins": "189",
    "draws": "66",
    "losses": "46"
  },
  {
    "team_long_name": "SL Benfica",
    "wins": "185",
    "draws": "36",
    "losses": "27"
  },
  {
    "team_long_name": "FC Porto",
    "wins": "183",
    "draws": "42",
    "losses": "23"
  },
  {
    "team_long_name": "Ajax",
    "wins": "181",
    "draws": "59",
    "losses": "32"
  },
  {
    "team_long_name": "FC Basel",
    "wins": "180",
    "draws": "64",
    "losses": "42"
  },
  {
    "team_long_name": "PSV",
    "wins": "178",
    "draws": "47",
    "losses": "47"
  },
  {
    "team_long_name": "Chelsea",
    "wins": "176",
    "draws": "70",
    "losses": "58"
  },
  {
    "team_long_name": "Paris Saint-Germain",
    "wins": "175",
    "draws": "76",
    "losses": "53"
  },
  {
    "team_long_name": "Manchester City",
    "wins": "175",
    "draws": "61",
    "losses": "68"
  },
  {
    "team_long_name": "Arsenal",
    "wins": "170",
    "draws": "73",
    "losses": "61"
  },
  {
    "team_long_name": "Atlético Madrid",
    "wins": "167",
    "draws": "59",
    "losses": "78"
  },
  {
    "team_long_name": "Roma",
    "wins": "162",
    "draws": "73",
    "losses": "68"
  },
  {
    "team_long_name": "Borussia Dortmund",
    "wins": "157",
    "draws": "62",
    "losses": "53"
  },
  {
    "team_long_name": "Inter",
    "wins": "154",
    "draws": "73",
    "losses": "76"
  },
  {
    "team_long_name": "Milan",
    "wins": "154",
    "draws": "79",
    "losses": "70"
  },
  {
    "team_long_name": "Napoli",
    "wins": "153",
    "draws": "77",
    "losses": "71"
  },
  {
    "team_long_name": "Olympique Lyonnais",
    "wins": "153",
    "draws": "80",
    "losses": "71"
  },
  {
    "team_long_name": "Tottenham Hotspur",
    "wins": "151",
    "draws": "74",
    "losses": "79"
  },
  {
    "team_long_name": "Liverpool",
    "wins": "150",
    "draws": "76",
    "losses": "78"
  },
  {
    "team_long_name": "LOSC Lille",
    "wins": "147",
    "draws": "92",
    "losses": "65"
  },
  {
    "team_long_name": "FC Twente",
    "wins": "144",
    "draws": "71",
    "losses": "57"
  },
  {
    "team_long_name": "Sporting CP",
    "wins": "144",
    "draws": "60",
    "losses": "44"
  },
  {
    "team_long_name": "Olympique de Marseille",
    "wins": "143",
    "draws": "90",
    "losses": "71"
  },
  {
    "team_long_name": "BSC Young Boys",
    "wins": "142",
    "draws": "69",
    "losses": "75"
  },
  {
    "team_long_name": "Valencia CF",
    "wins": "142",
    "draws": "74",
    "losses": "88"
  },
  {
    "team_long_name": "AZ",
    "wins": "140",
    "draws": "53",
    "losses": "79"
  },
  {
    "team_long_name": "Sevilla FC",
    "wins": "139",
    "draws": "65",
    "losses": "100"
  },
  {
    "team_long_name": "Feyenoord",
    "wins": "139",
    "draws": "63",
    "losses": "70"
  },
  {
    "team_long_name": "Bayer 04 Leverkusen",
    "wins": "137",
    "draws": "66",
    "losses": "69"
  },
  {
    "team_long_name": "Legia Warszawa",
    "wins": "137",
    "draws": "50",
    "losses": "53"
  },
  {
    "team_long_name": "RSC Anderlecht",
    "wins": "136",
    "draws": "49",
    "losses": "27"
  },
  {
    "team_long_name": "Fiorentina",
    "wins": "132",
    "draws": "75",
    "losses": "93"
  },
  {
    "team_long_name": "Lazio",
    "wins": "131",
    "draws": "65",
    "losses": "105"
  },
  {
    "team_long_name": "FC Schalke 04",
    "wins": "127",
    "draws": "57",
    "losses": "88"
  },
  {
    "team_long_name": "Girondins de Bordeaux",
    "wins": "126",
    "draws": "99",
    "losses": "79"
  },
  {
    "team_long_name": "SC Braga",
    "wins": "126",
    "draws": "56",
    "losses": "66"
  },
  {
    "team_long_name": "Lech Poznań",
    "wins": "124",
    "draws": "60",
    "losses": "56"
  },
  {
    "team_long_name": "Club Brugge KV",
    "wins": "123",
    "draws": "40",
    "losses": "49"
  },
  {
    "team_long_name": "Motherwell",
    "wins": "122",
    "draws": "62",
    "losses": "120"
  },
  {
    "team_long_name": "Athletic Club de Bilbao",
    "wins": "122",
    "draws": "71",
    "losses": "111"
  },
  {
    "team_long_name": "AS Saint-Étienne",
    "wins": "121",
    "draws": "82",
    "losses": "101"
  },
  {
    "team_long_name": "Everton",
    "wins": "121",
    "draws": "100",
    "losses": "83"
  },
  {
    "team_long_name": "FC Zürich",
    "wins": "120",
    "draws": "69",
    "losses": "97"
  },
  {
    "team_long_name": "Aberdeen",
    "wins": "120",
    "draws": "75",
    "losses": "109"
  },
  {
    "team_long_name": "VfL Wolfsburg",
    "wins": "117",
    "draws": "67",
    "losses": "88"
  },
  {
    "team_long_name": "Dundee United",
    "wins": "115",
    "draws": "83",
    "losses": "106"
  },
  {
    "team_long_name": "Grasshopper Club Zürich",
    "wins": "115",
    "draws": "67",
    "losses": "104"
  },
  {
    "team_long_name": "Udinese",
    "wins": "115",
    "draws": "76",
    "losses": "111"
  },
  {
    "team_long_name": "Villarreal CF",
    "wins": "112",
    "draws": "71",
    "losses": "83"
  },
  {
    "team_long_name": "Stade Rennais FC",
    "wins": "111",
    "draws": "91",
    "losses": "102"
  },
  {
    "team_long_name": "Montpellier Hérault SC",
    "wins": "110",
    "draws": "67",
    "losses": "89"
  },
  {
    "team_long_name": "KAA Gent",
    "wins": "109",
    "draws": "55",
    "losses": "54"
  },
  {
    "team_long_name": "FC Groningen",
    "wins": "109",
    "draws": "62",
    "losses": "101"
  },
  {
    "team_long_name": "Borussia Mönchengladbach",
    "wins": "109",
    "draws": "62",
    "losses": "101"
  },
  {
    "team_long_name": "Rangers",
    "wins": "108",
    "draws": "25",
    "losses": "19"
  },
  {
    "team_long_name": "Wisła Kraków",
    "wins": "108",
    "draws": "64",
    "losses": "68"
  },
  {
    "team_long_name": "SC Heerenveen",
    "wins": "107",
    "draws": "72",
    "losses": "93"
  },
  {
    "team_long_name": "Málaga CF",
    "wins": "106",
    "draws": "78",
    "losses": "120"
  },
  {
    "team_long_name": "Standard de Liège",
    "wins": "106",
    "draws": "42",
    "losses": "64"
  },
  {
    "team_long_name": "Genoa",
    "wins": "106",
    "draws": "79",
    "losses": "117"
  },
  {
    "team_long_name": "OGC Nice",
    "wins": "106",
    "draws": "81",
    "losses": "117"
  },
  {
    "team_long_name": "FC Luzern",
    "wins": "105",
    "draws": "74",
    "losses": "107"
  },
  {
    "team_long_name": "FC Utrecht",
    "wins": "105",
    "draws": "70",
    "losses": "97"
  },
  {
    "team_long_name": "Vitesse",
    "wins": "105",
    "draws": "71",
    "losses": "96"
  },
  {
    "team_long_name": "FC Sion",
    "wins": "104",
    "draws": "69",
    "losses": "113"
  },
  {
    "team_long_name": "Toulouse FC",
    "wins": "103",
    "draws": "90",
    "losses": "111"
  },
  {
    "team_long_name": "Heart of Midlothian",
    "wins": "101",
    "draws": "66",
    "losses": "99"
  },
  {
    "team_long_name": "VfB Stuttgart",
    "wins": "99",
    "draws": "61",
    "losses": "112"
  },
  {
    "team_long_name": "St. Johnstone FC",
    "wins": "98",
    "draws": "69",
    "losses": "99"
  },
  {
    "team_long_name": "Stoke City",
    "wins": "98",
    "draws": "86",
    "losses": "120"
  },
  {
    "team_long_name": "FC Lorient",
    "wins": "97",
    "draws": "91",
    "losses": "116"
  },
  {
    "team_long_name": "RCD Espanyol",
    "wins": "97",
    "draws": "73",
    "losses": "134"
  },
  {
    "team_long_name": "KRC Genk",
    "wins": "97",
    "draws": "55",
    "losses": "60"
  },
  {
    "team_long_name": "Inverness Caledonian Thistle",
    "wins": "96",
    "draws": "69",
    "losses": "101"
  },
  {
    "team_long_name": "AS Monaco",
    "wins": "95",
    "draws": "75",
    "losses": "58"
  },
  {
    "team_long_name": "CD Nacional",
    "wins": "94",
    "draws": "65",
    "losses": "89"
  },
  {
    "team_long_name": "Polonia Bytom",
    "wins": "94",
    "draws": "87",
    "losses": "119"
  },
  {
    "team_long_name": "Getafe CF",
    "wins": "94",
    "draws": "71",
    "losses": "139"
  },
  {
    "team_long_name": "Heracles Almelo",
    "wins": "93",
    "draws": "61",
    "losses": "118"
  },
  {
    "team_long_name": "Hamburger SV",
    "wins": "93",
    "draws": "66",
    "losses": "113"
  },
  {
    "team_long_name": "Ruch Chorzów",
    "wins": "92",
    "draws": "57",
    "losses": "91"
  },
  {
    "team_long_name": "Vitória Guimarães",
    "wins": "92",
    "draws": "61",
    "losses": "95"
  },
  {
    "team_long_name": "Palermo",
    "wins": "91",
    "draws": "68",
    "losses": "107"
  },
  {
    "team_long_name": "Hannover 96",
    "wins": "91",
    "draws": "57",
    "losses": "124"
  },
  {
    "team_long_name": "SV Werder Bremen",
    "wins": "89",
    "draws": "76",
    "losses": "107"
  },
  {
    "team_long_name": "Śląsk Wrocław",
    "wins": "89",
    "draws": "80",
    "losses": "71"
  },
  {
    "team_long_name": "1. FSV Mainz 05",
    "wins": "88",
    "draws": "65",
    "losses": "85"
  },
  {
    "team_long_name": "Jagiellonia Białystok",
    "wins": "87",
    "draws": "64",
    "losses": "89"
  },
  {
    "team_long_name": "Chievo Verona",
    "wins": "87",
    "draws": "87",
    "losses": "129"
  },
  {
    "team_long_name": "TSG 1899 Hoffenheim",
    "wins": "87",
    "draws": "76",
    "losses": "109"
  },
  {
    "team_long_name": "Aston Villa",
    "wins": "86",
    "draws": "88",
    "losses": "130"
  },
  {
    "team_long_name": "Kilmarnock",
    "wins": "86",
    "draws": "76",
    "losses": "142"
  },
  {
    "team_long_name": "CS Marítimo",
    "wins": "85",
    "draws": "66",
    "losses": "97"
  },
  {
    "team_long_name": "Sampdoria",
    "wins": "84",
    "draws": "81",
    "losses": "101"
  },
  {
    "team_long_name": "Real Sociedad",
    "wins": "84",
    "draws": "59",
    "losses": "85"
  },
  {
    "team_long_name": "Newcastle United",
    "wins": "82",
    "draws": "65",
    "losses": "119"
  },
  {
    "team_long_name": "KV Kortrijk",
    "wins": "82",
    "draws": "50",
    "losses": "80"
  },
  {
    "team_long_name": "FC Paços de Ferreira",
    "wins": "80",
    "draws": "75",
    "losses": "93"
  },
  {
    "team_long_name": "West Ham United",
    "wins": "80",
    "draws": "74",
    "losses": "112"
  },
  {
    "team_long_name": "Atalanta",
    "wins": "79",
    "draws": "69",
    "losses": "115"
  },
  {
    "team_long_name": "KV Mechelen",
    "wins": "79",
    "draws": "52",
    "losses": "81"
  },
  {
    "team_long_name": "ADO Den Haag",
    "wins": "79",
    "draws": "74",
    "losses": "119"
  },
  {
    "team_long_name": "SV Zulte-Waregem",
    "wins": "78",
    "draws": "62",
    "losses": "72"
  },
  {
    "team_long_name": "Lechia Gdańsk",
    "wins": "78",
    "draws": "67",
    "losses": "95"
  },
  {
    "team_long_name": "Sunderland",
    "wins": "78",
    "draws": "92",
    "losses": "134"
  },
  {
    "team_long_name": "Cagliari",
    "wins": "76",
    "draws": "74",
    "losses": "114"
  },
  {
    "team_long_name": "West Bromwich Albion",
    "wins": "75",
    "draws": "73",
    "losses": "118"
  },
  {
    "team_long_name": "Rio Ave FC",
    "wins": "75",
    "draws": "69",
    "losses": "104"
  },
  {
    "team_long_name": "Parma",
    "wins": "74",
    "draws": "63",
    "losses": "89"
  },
  {
    "team_long_name": "Sporting Lokeren",
    "wins": "74",
    "draws": "68",
    "losses": "70"
  },
  {
    "team_long_name": "Eintracht Frankfurt",
    "wins": "72",
    "draws": "63",
    "losses": "103"
  },
  {
    "team_long_name": "FC St. Gallen",
    "wins": "72",
    "draws": "50",
    "losses": "94"
  },
  {
    "team_long_name": "Fulham",
    "wins": "71",
    "draws": "62",
    "losses": "95"
  },
  {
    "team_long_name": "NAC Breda",
    "wins": "71",
    "draws": "58",
    "losses": "109"
  },
  {
    "team_long_name": "Roda JC Kerkrade",
    "wins": "71",
    "draws": "59",
    "losses": "108"
  },
  {
    "team_long_name": "FC Thun",
    "wins": "71",
    "draws": "68",
    "losses": "75"
  },
  {
    "team_long_name": "Levante UD",
    "wins": "69",
    "draws": "56",
    "losses": "103"
  },
  {
    "team_long_name": "FC Sochaux-Montbéliard",
    "wins": "69",
    "draws": "57",
    "losses": "102"
  },
  {
    "team_long_name": "Korona Kielce",
    "wins": "69",
    "draws": "64",
    "losses": "77"
  },
  {
    "team_long_name": "N.E.C.",
    "wins": "68",
    "draws": "72",
    "losses": "98"
  },
  {
    "team_long_name": "Bologna",
    "wins": "68",
    "draws": "79",
    "losses": "116"
  },
  {
    "team_long_name": "CA Osasuna",
    "wins": "67",
    "draws": "64",
    "losses": "97"
  },
  {
    "team_long_name": "Catania",
    "wins": "67",
    "draws": "63",
    "losses": "94"
  },
  {
    "team_long_name": "RCD Mallorca",
    "wins": "67",
    "draws": "44",
    "losses": "79"
  },
  {
    "team_long_name": "Rayo Vallecano",
    "wins": "66",
    "draws": "28",
    "losses": "96"
  },
  {
    "team_long_name": "Valenciennes FC",
    "wins": "65",
    "draws": "69",
    "losses": "94"
  },
  {
    "team_long_name": "Piast Gliwice",
    "wins": "65",
    "draws": "42",
    "losses": "73"
  },
  {
    "team_long_name": "Hertha BSC Berlin",
    "wins": "65",
    "draws": "49",
    "losses": "90"
  },
  {
    "team_long_name": "Hibernian",
    "wins": "65",
    "draws": "62",
    "losses": "101"
  },
  {
    "team_long_name": "GKS Bełchatów",
    "wins": "62",
    "draws": "49",
    "losses": "69"
  },
  {
    "team_long_name": "RC Deportivo de La Coruña",
    "wins": "62",
    "draws": "74",
    "losses": "92"
  },
  {
    "team_long_name": "Swansea City",
    "wins": "62",
    "draws": "52",
    "losses": "76"
  },
  {
    "team_long_name": "SC Freiburg",
    "wins": "62",
    "draws": "54",
    "losses": "88"
  },
  {
    "team_long_name": "Cracovia",
    "wins": "61",
    "draws": "53",
    "losses": "96"
  },
  {
    "team_long_name": "St. Mirren",
    "wins": "61",
    "draws": "74",
    "losses": "131"
  },
  {
    "team_long_name": "Southampton",
    "wins": "60",
    "draws": "40",
    "losses": "52"
  },
  {
    "team_long_name": "P. Warszawa",
    "wins": "60",
    "draws": "38",
    "losses": "52"
  },
  {
    "team_long_name": "1. FC Köln",
    "wins": "60",
    "draws": "54",
    "losses": "90"
  },
  {
    "team_long_name": "Zagłębie Lubin",
    "wins": "59",
    "draws": "51",
    "losses": "70"
  },
  {
    "team_long_name": "Vitória Setúbal",
    "wins": "58",
    "draws": "65",
    "losses": "125"
  },
  {
    "team_long_name": "KSV Cercle Brugge",
    "wins": "58",
    "draws": "34",
    "losses": "90"
  },
  {
    "team_long_name": "Torino",
    "wins": "57",
    "draws": "59",
    "losses": "74"
  },
  {
    "team_long_name": "SM Caen",
    "wins": "56",
    "draws": "53",
    "losses": "81"
  },
  {
    "team_long_name": "Hamilton Academical FC",
    "wins": "56",
    "draws": "44",
    "losses": "90"
  },
  {
    "team_long_name": "Académica de Coimbra",
    "wins": "56",
    "draws": "82",
    "losses": "110"
  },
  {
    "team_long_name": "Real Betis Balompié",
    "wins": "56",
    "draws": "47",
    "losses": "87"
  },
  {
    "team_long_name": "AS Nancy-Lorraine",
    "wins": "56",
    "draws": "53",
    "losses": "81"
  },
  {
    "team_long_name": "FC Augsburg",
    "wins": "55",
    "draws": "45",
    "losses": "70"
  },
  {
    "team_long_name": "Sporting Charleroi",
    "wins": "55",
    "draws": "42",
    "losses": "85"
  },
  {
    "team_long_name": "Real Sporting de Gijón",
    "wins": "54",
    "draws": "44",
    "losses": "92"
  },
  {
    "team_long_name": "KVC Westerlo",
    "wins": "54",
    "draws": "46",
    "losses": "82"
  },
  {
    "team_long_name": "RC Celta de Vigo",
    "wins": "54",
    "draws": "35",
    "losses": "63"
  },
  {
    "team_long_name": "AJ Auxerre",
    "wins": "53",
    "draws": "50",
    "losses": "49"
  },
  {
    "team_long_name": "Granada CF",
    "wins": "52",
    "draws": "43",
    "losses": "95"
  },
  {
    "team_long_name": "SC Bastia",
    "wins": "51",
    "draws": "37",
    "losses": "64"
  },
  {
    "team_long_name": "Wigan Athletic",
    "wins": "50",
    "draws": "52",
    "losses": "88"
  },
  {
    "team_long_name": "Ross County FC",
    "wins": "50",
    "draws": "35",
    "losses": "67"
  },
  {
    "team_long_name": "Estoril Praia",
    "wins": "50",
    "draws": "36",
    "losses": "42"
  },
  {
    "team_long_name": "1. FC Nürnberg",
    "wins": "49",
    "draws": "43",
    "losses": "78"
  },
  {
    "team_long_name": "PEC Zwolle",
    "wins": "49",
    "draws": "33",
    "losses": "54"
  },
  {
    "team_long_name": "Widzew Łódź",
    "wins": "48",
    "draws": "52",
    "losses": "80"
  },
  {
    "team_long_name": "UD Almería",
    "wins": "48",
    "draws": "46",
    "losses": "96"
  },
  {
    "team_long_name": "Évian Thonon Gaillard FC",
    "wins": "45",
    "draws": "36",
    "losses": "71"
  },
  {
    "team_long_name": "FC Nantes",
    "wins": "45",
    "draws": "44",
    "losses": "63"
  },
  {
    "team_long_name": "Stade de Reims",
    "wins": "44",
    "draws": "42",
    "losses": "66"
  },
  {
    "team_long_name": "Willem II",
    "wins": "44",
    "draws": "41",
    "losses": "119"
  },
  {
    "team_long_name": "Bolton Wanderers",
    "wins": "43",
    "draws": "33",
    "losses": "76"
  },
  {
    "team_long_name": "Real Zaragoza",
    "wins": "43",
    "draws": "34",
    "losses": "75"
  },
  {
    "team_long_name": "Podbeskidzie Bielsko-Biała",
    "wins": "42",
    "draws": "49",
    "losses": "59"
  },
  {
    "team_long_name": "Blackburn Rovers",
    "wins": "42",
    "draws": "39",
    "losses": "71"
  },
  {
    "team_long_name": "Pogoń Szczecin",
    "wins": "42",
    "draws": "43",
    "losses": "35"
  },
  {
    "team_long_name": "Beerschot AC",
    "wins": "40",
    "draws": "42",
    "losses": "70"
  },
  {
    "team_long_name": "Norwich City",
    "wins": "39",
    "draws": "41",
    "losses": "72"
  },
  {
    "team_long_name": "En Avant de Guingamp",
    "wins": "37",
    "draws": "24",
    "losses": "53"
  },
  {
    "team_long_name": "Sassuolo",
    "wins": "37",
    "draws": "33",
    "losses": "44"
  },
  {
    "team_long_name": "Racing Santander",
    "wins": "37",
    "draws": "47",
    "losses": "68"
  },
  {
    "team_long_name": "CF Os Belenenses",
    "wins": "37",
    "draws": "53",
    "losses": "68"
  },
  {
    "team_long_name": "Siena",
    "wins": "37",
    "draws": "38",
    "losses": "75"
  },
  {
    "team_long_name": "Real Valladolid",
    "wins": "37",
    "draws": "47",
    "losses": "68"
  },
  {
    "team_long_name": "Crystal Palace",
    "wins": "37",
    "draws": "24",
    "losses": "53"
  },
  {
    "team_long_name": "Neuchâtel Xamax",
    "wins": "36",
    "draws": "31",
    "losses": "59"
  },
  {
    "team_long_name": "FC Aarau",
    "wins": "35",
    "draws": "34",
    "losses": "75"
  },
  {
    "team_long_name": "Leicester City",
    "wins": "34",
    "draws": "20",
    "losses": "22"
  },
  {
    "team_long_name": "RKC Waalwijk",
    "wins": "34",
    "draws": "27",
    "losses": "75"
  },
  {
    "team_long_name": "Partick Thistle F.C.",
    "wins": "32",
    "draws": "34",
    "losses": "48"
  },
  {
    "team_long_name": "S.C. Olhanense",
    "wins": "32",
    "draws": "55",
    "losses": "63"
  },
  {
    "team_long_name": "Hull City",
    "wins": "32",
    "draws": "41",
    "losses": "79"
  },
  {
    "team_long_name": "Hellas Verona",
    "wins": "32",
    "draws": "32",
    "losses": "50"
  },
  {
    "team_long_name": "Sint-Truidense VV",
    "wins": "31",
    "draws": "27",
    "losses": "60"
  },
  {
    "team_long_name": "Dundee FC",
    "wins": "29",
    "draws": "36",
    "losses": "49"
  },
  {
    "team_long_name": "KV Oostende",
    "wins": "29",
    "draws": "14",
    "losses": "23"
  },
  {
    "team_long_name": "VVV-Venlo",
    "wins": "29",
    "draws": "28",
    "losses": "79"
  },
  {
    "team_long_name": "FC Arouca",
    "wins": "28",
    "draws": "29",
    "losses": "41"
  },
  {
    "team_long_name": "Excelsior",
    "wins": "27",
    "draws": "35",
    "losses": "74"
  },
  {
    "team_long_name": "Stade Brestois 29",
    "wins": "27",
    "draws": "35",
    "losses": "52"
  },
  {
    "team_long_name": "De Graafschap",
    "wins": "27",
    "draws": "34",
    "losses": "75"
  },
  {
    "team_long_name": "Royal Excel Mouscron",
    "wins": "26",
    "draws": "22",
    "losses": "46"
  },
  {
    "team_long_name": "RC Lens",
    "wins": "26",
    "draws": "34",
    "losses": "54"
  },
  {
    "team_long_name": "Gil Vicente FC",
    "wins": "26",
    "draws": "35",
    "losses": "63"
  },
  {
    "team_long_name": "AC Bellinzona",
    "wins": "25",
    "draws": "25",
    "losses": "58"
  },
  {
    "team_long_name": "RAEC Mons",
    "wins": "25",
    "draws": "24",
    "losses": "45"
  },
  {
    "team_long_name": "Wolverhampton Wanderers",
    "wins": "25",
    "draws": "28",
    "losses": "61"
  },
  {
    "team_long_name": "Moreirense FC",
    "wins": "25",
    "draws": "28",
    "losses": "45"
  },
  {
    "team_long_name": "Lecce",
    "wins": "24",
    "draws": "33",
    "losses": "54"
  },
  {
    "team_long_name": "Waasland-Beveren",
    "wins": "24",
    "draws": "21",
    "losses": "51"
  },
  {
    "team_long_name": "SC Cambuur",
    "wins": "24",
    "draws": "26",
    "losses": "52"
  },
  {
    "team_long_name": "União de Leiria, SAD",
    "wins": "23",
    "draws": "20",
    "losses": "47"
  },
  {
    "team_long_name": "FC Lausanne-Sports",
    "wins": "23",
    "draws": "18",
    "losses": "65"
  },
  {
    "team_long_name": "Oud-Heverlee Leuven",
    "wins": "22",
    "draws": "28",
    "losses": "40"
  },
  {
    "team_long_name": "Lierse SK",
    "wins": "22",
    "draws": "43",
    "losses": "61"
  },
  {
    "team_long_name": "Queens Park Rangers",
    "wins": "22",
    "draws": "26",
    "losses": "66"
  },
  {
    "team_long_name": "AC Ajaccio",
    "wins": "22",
    "draws": "40",
    "losses": "52"
  },
  {
    "team_long_name": "Naval 1° de Maio",
    "wins": "22",
    "draws": "22",
    "losses": "46"
  },
  {
    "team_long_name": "Birmingham City",
    "wins": "21",
    "draws": "26",
    "losses": "29"
  },
  {
    "team_long_name": "Empoli",
    "wins": "20",
    "draws": "28",
    "losses": "28"
  },
  {
    "team_long_name": "SC Beira Mar",
    "wins": "20",
    "draws": "25",
    "losses": "45"
  },
  {
    "team_long_name": "Arka Gdynia",
    "wins": "20",
    "draws": "26",
    "losses": "44"
  },
  {
    "team_long_name": "Servette FC",
    "wins": "20",
    "draws": "14",
    "losses": "36"
  },
  {
    "team_long_name": "SD Eibar",
    "wins": "20",
    "draws": "18",
    "losses": "38"
  },
  {
    "team_long_name": "Elche CF",
    "wins": "20",
    "draws": "21",
    "losses": "35"
  },
  {
    "team_long_name": "Zawisza Bydgoszcz",
    "wins": "19",
    "draws": "14",
    "losses": "27"
  },
  {
    "team_long_name": "FC Vaduz",
    "wins": "19",
    "draws": "32",
    "losses": "57"
  },
  {
    "team_long_name": "Cesena",
    "wins": "19",
    "draws": "30",
    "losses": "61"
  },
  {
    "team_long_name": "Bari",
    "wins": "18",
    "draws": "20",
    "losses": "38"
  },
  {
    "team_long_name": "Le Mans FC",
    "wins": "18",
    "draws": "18",
    "losses": "40"
  },
  {
    "team_long_name": "Go Ahead Eagles",
    "wins": "17",
    "draws": "14",
    "losses": "37"
  },
  {
    "team_long_name": "Leixões SC",
    "wins": "17",
    "draws": "15",
    "losses": "28"
  },
  {
    "team_long_name": "Portsmouth",
    "wins": "17",
    "draws": "18",
    "losses": "41"
  },
  {
    "team_long_name": "1. FC Kaiserslautern",
    "wins": "17",
    "draws": "18",
    "losses": "33"
  },
  {
    "team_long_name": "Boavista FC",
    "wins": "17",
    "draws": "16",
    "losses": "35"
  },
  {
    "team_long_name": "Górnik Łęczna",
    "wins": "16",
    "draws": "17",
    "losses": "27"
  },
  {
    "team_long_name": "Burnley",
    "wins": "15",
    "draws": "18",
    "losses": "43"
  },
  {
    "team_long_name": "Grenoble Foot 38",
    "wins": "15",
    "draws": "22",
    "losses": "39"
  },
  {
    "team_long_name": "Odra Wodzisław",
    "wins": "15",
    "draws": "14",
    "losses": "31"
  },
  {
    "team_long_name": "Falkirk",
    "wins": "15",
    "draws": "24",
    "losses": "37"
  },
  {
    "team_long_name": "Sparta Rotterdam",
    "wins": "15",
    "draws": "16",
    "losses": "37"
  },
  {
    "team_long_name": "VfL Bochum",
    "wins": "13",
    "draws": "21",
    "losses": "34"
  },
  {
    "team_long_name": "Angers SCO",
    "wins": "13",
    "draws": "11",
    "losses": "14"
  },
  {
    "team_long_name": "Livorno",
    "wins": "13",
    "draws": "15",
    "losses": "48"
  },
  {
    "team_long_name": "Watford",
    "wins": "12",
    "draws": "9",
    "losses": "17"
  },
  {
    "team_long_name": "UD Las Palmas",
    "wins": "12",
    "draws": "8",
    "losses": "18"
  },
  {
    "team_long_name": "KSV Roeselare",
    "wins": "12",
    "draws": "12",
    "losses": "38"
  },
  {
    "team_long_name": "ES Troyes AC",
    "wins": "11",
    "draws": "22",
    "losses": "43"
  },
  {
    "team_long_name": "Bournemouth",
    "wins": "11",
    "draws": "9",
    "losses": "18"
  },
  {
    "team_long_name": "FC Ingolstadt 04",
    "wins": "10",
    "draws": "10",
    "losses": "14"
  },
  {
    "team_long_name": "CD Numancia",
    "wins": "10",
    "draws": "5",
    "losses": "23"
  },
  {
    "team_long_name": "Blackpool",
    "wins": "10",
    "draws": "9",
    "losses": "19"
  },
  {
    "team_long_name": "Dijon FCO",
    "wins": "9",
    "draws": "9",
    "losses": "20"
  },
  {
    "team_long_name": "FCV Dender EH",
    "wins": "9",
    "draws": "8",
    "losses": "17"
  },
  {
    "team_long_name": "Hércules Club de Fútbol",
    "wins": "9",
    "draws": "8",
    "losses": "21"
  },
  {
    "team_long_name": "SV Darmstadt 98",
    "wins": "9",
    "draws": "11",
    "losses": "14"
  },
  {
    "team_long_name": "CD Tenerife",
    "wins": "9",
    "draws": "9",
    "losses": "20"
  },
  {
    "team_long_name": "Carpi",
    "wins": "9",
    "draws": "11",
    "losses": "18"
  },
  {
    "team_long_name": "Lugano",
    "wins": "9",
    "draws": "8",
    "losses": "19"
  },
  {
    "team_long_name": "GFC Ajaccio",
    "wins": "8",
    "draws": "13",
    "losses": "17"
  },
  {
    "team_long_name": "FC St. Pauli",
    "wins": "8",
    "draws": "5",
    "losses": "21"
  },
  {
    "team_long_name": "Amadora",
    "wins": "8",
    "draws": "10",
    "losses": "12"
  },
  {
    "team_long_name": "RC Recreativo",
    "wins": "8",
    "draws": "9",
    "losses": "21"
  },
  {
    "team_long_name": "Xerez Club Deportivo",
    "wins": "8",
    "draws": "10",
    "losses": "20"
  },
  {
    "team_long_name": "Termalica Bruk-Bet Nieciecza",
    "wins": "8",
    "draws": "9",
    "losses": "13"
  },
  {
    "team_long_name": "Frosinone",
    "wins": "8",
    "draws": "7",
    "losses": "23"
  },
  {
    "team_long_name": "Karlsruher SC",
    "wins": "8",
    "draws": "5",
    "losses": "21"
  },
  {
    "team_long_name": "Tondela",
    "wins": "8",
    "draws": "6",
    "losses": "20"
  },
  {
    "team_long_name": "FC Energie Cottbus",
    "wins": "8",
    "draws": "6",
    "losses": "20"
  },
  {
    "team_long_name": "Le Havre AC",
    "wins": "7",
    "draws": "5",
    "losses": "26"
  },
  {
    "team_long_name": "FC Volendam",
    "wins": "7",
    "draws": "8",
    "losses": "19"
  },
  {
    "team_long_name": "FC Metz",
    "wins": "7",
    "draws": "9",
    "losses": "22"
  },
  {
    "team_long_name": "SC Paderborn 07",
    "wins": "7",
    "draws": "10",
    "losses": "17"
  },
  {
    "team_long_name": "Fortuna Düsseldorf",
    "wins": "7",
    "draws": "9",
    "losses": "18"
  },
  {
    "team_long_name": "Middlesbrough",
    "wins": "7",
    "draws": "11",
    "losses": "20"
  },
  {
    "team_long_name": "Uniao da Madeira",
    "wins": "7",
    "draws": "8",
    "losses": "19"
  },
  {
    "team_long_name": "Cardiff City",
    "wins": "7",
    "draws": "9",
    "losses": "22"
  },
  {
    "team_long_name": "US Boulogne Cote D'Opale",
    "wins": "7",
    "draws": "10",
    "losses": "21"
  },
  {
    "team_long_name": "Tubize",
    "wins": "7",
    "draws": "6",
    "losses": "21"
  },
  {
    "team_long_name": "Brescia",
    "wins": "7",
    "draws": "11",
    "losses": "20"
  },
  {
    "team_long_name": "Portimonense",
    "wins": "6",
    "draws": "7",
    "losses": "17"
  },
  {
    "team_long_name": "Eintracht Braunschweig",
    "wins": "6",
    "draws": "7",
    "losses": "21"
  },
  {
    "team_long_name": "Novara",
    "wins": "6",
    "draws": "11",
    "losses": "19"
  },
  {
    "team_long_name": "Reading",
    "wins": "6",
    "draws": "10",
    "losses": "22"
  },
  {
    "team_long_name": "Pescara",
    "wins": "6",
    "draws": "4",
    "losses": "28"
  },
  {
    "team_long_name": "Reggio Calabria",
    "wins": "6",
    "draws": "13",
    "losses": "19"
  },
  {
    "team_long_name": "FC Penafiel",
    "wins": "5",
    "draws": "7",
    "losses": "22"
  },
  {
    "team_long_name": "KAS Eupen",
    "wins": "5",
    "draws": "8",
    "losses": "17"
  },
  {
    "team_long_name": "Feirense",
    "wins": "5",
    "draws": "9",
    "losses": "16"
  },
  {
    "team_long_name": "Trofense",
    "wins": "5",
    "draws": "8",
    "losses": "17"
  },
  {
    "team_long_name": "Dunfermline Athletic",
    "wins": "5",
    "draws": "10",
    "losses": "23"
  },
  {
    "team_long_name": "FC Dordrecht",
    "wins": "4",
    "draws": "8",
    "losses": "22"
  },
  {
    "team_long_name": "SpVgg Greuther Fürth",
    "wins": "4",
    "draws": "9",
    "losses": "21"
  },
  {
    "team_long_name": "DSC Arminia Bielefeld",
    "wins": "4",
    "draws": "16",
    "losses": "14"
  },
  {
    "team_long_name": "AC Arles-Avignon",
    "wins": "3",
    "draws": "11",
    "losses": "24"
  },
  {
    "team_long_name": "Córdoba CF",
    "wins": "3",
    "draws": "11",
    "losses": "24"
  }
]
*/