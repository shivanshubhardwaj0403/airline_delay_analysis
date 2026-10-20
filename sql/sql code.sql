use airline_delay

-- average delay per airline 

SELECT AIRLINE, AVG(DEPARTURE_DELAY) AS avg_delay
FROM flights
GROUP BY AIRLINE
ORDER BY avg_delay DESC

-- top 10 worst routes (highest delay)

SELECT top 10 ORIGIN_AIRPORT, DESTINATION_AIRPORT,
       AVG(DEPARTURE_DELAY) AS avg_delay
FROM flights
GROUP BY ORIGIN_AIRPORT, DESTINATION_AIRPORT
ORDER BY avg_delay DESC

-- delay reason analysis ( TOTAL IMPACT)

SELECT SUM(AIR_SYSTEM_DELAY) AS system_delay,
SUM(SECURITY_DELAY) AS security_delay,
SUM(AIRLINE_DELAY) AS airline_delay,
SUM(LATE_AIRCRAFT_DELAY) AS late_aircraft_delay,
SUM(WEATHER_DELAY) AS weather_delay
FROM flights

    
ALTER TABLE flights
ALTER COLUMN AIRLINE_DELAY INT;

ALTER TABLE flights
ALTER COLUMN AIR_SYSTEM_DELAY INT;

ALTER TABLE flights
ALTER COLUMN SECURITY_DELAY INT;

ALTER TABLE flights
ALTER COLUMN LATE_AIRCRAFT_DELAY INT;

ALTER TABLE flights
ALTER COLUMN WEATHER_DELAY INT;

-- month wise delay trend

SELECT FORMAT(DATEFROMPARTS(2026,Month, 1), 'MMM') as MONTH, AVG(DEPARTURE_DELAY) AS avg_delay
FROM flights
GROUP BY month
ORDER BY MONTH asc

-- day of week analysis

SELECT FORMAT(DATEFROMPARTS(2026, 9, day_of_week), 'ddd') AS days , AVG(DEPARTURE_DELAY) AS avg_delay
FROM flights
GROUP BY DAY_OF_WEEK
ORDER BY avg_delay DESC;

--delay vs on-time flights count

SELECT 
CASE 
WHEN DEPARTURE_DELAY > 0 THEN 'Delayed'
ELSE 'On Time'
END AS status,
COUNT(*) AS total_flights
FROM flights
GROUP BY 
CASE 
 WHEN DEPARTURE_DELAY > 0 THEN 'Delayed'
  ELSE 'On Time'
    END;

-- cancellation rate 

SELECT 
(COUNT(CASE WHEN CANCELLED = 1 THEN 1 END) * 100.0 / COUNT(*)) AS cancellation_rate
FROM flights;

-- average delay per airport ( origin)

select top 10 ORIGIN_AIRPORT, AVG(DEPARTURE_DELAY) AS avg_delay
FROM flights
GROUP BY ORIGIN_AIRPORT
ORDER BY avg_delay DESC

-- airline delay propability

SELECT AIRLINE,
AVG(CASE 
WHEN DEPARTURE_DELAY > 0 THEN 1.0 
ELSE 0.0 
END) AS delay_probability
FROM flights
GROUP BY AIRLINE
ORDER BY delay_probability DESC;

-- distance vs delay 

SELECT 
CASE 
WHEN DISTANCE < 500 THEN 'Short'
WHEN DISTANCE BETWEEN 500 AND 1500 THEN 'Medium'
ELSE 'Long'
END AS distance_category,
AVG(DEPARTURE_DELAY) AS avg_delay
FROM flights
GROUP BY CASE 
    WHEN DISTANCE < 500 THEN 'Short'
    WHEN DISTANCE BETWEEN 500 AND 1500 THEN 'Medium'
    ELSE 'Long'
END ;

SELECT FORMAT(DATEFROMPARTS(2026,Month, 1), 'MMM') as MONTH, AIRLINE, AVG(DEPARTURE_DELAY) AS avg_delay
FROM flights
GROUP BY FORMAT(DATEFROMPARTS(2026,Month, 1), 'MMM'),AIRLINE
order by avg_delay desc;