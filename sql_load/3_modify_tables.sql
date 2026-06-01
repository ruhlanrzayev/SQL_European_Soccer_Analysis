COPY public.country
FROM 'C:\Users\colla\OneDrive\Desktop\SQL Projects\SQL_European_Soccer_Analysis\csv_files\Country.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

COPY public.league
FROM 'C:\Users\colla\OneDrive\Desktop\SQL Projects\SQL_European_Soccer_Analysis\csv_files\League.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

COPY public.team
FROM 'C:\Users\colla\OneDrive\Desktop\SQL Projects\SQL_European_Soccer_Analysis\csv_files\Team.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');

COPY public.match
FROM 'C:\Users\colla\OneDrive\Desktop\SQL Projects\SQL_European_Soccer_Analysis\csv_files\Match.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');