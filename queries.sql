-- Consultas

-- comunas de las que más viajes parten (Esta consulta alimenta al reporte de Power BI)
SELECT e.comuna, COUNT(*) AS cant_viajes
FROM viajes v
JOIN estaciones e ON v.id_estacion_origen = e.id_estacion
GROUP BY e.comuna
ORDER BY cant_viajes DESC;

-- comunas que mas viajes reciben (Esta consulta alimenta al reporte de Power BI)
SELECT e.comuna, COUNT(*) AS cant_viajes
FROM viajes v
JOIN estaciones e ON v.id_estacion_destino = e.id_estacion
GROUP BY e.comuna
ORDER BY cant_viajes DESC;


-- relacion entre la edad de los usuarios y la cantidad de viajes que realizaron (Esta consulta alimenta al reporte de Power BI)
SELECT
	CASE
		WHEN u.edad < 18 THEN 'Menor de 18'
		WHEN u.edad >= 18 AND u.edad <= 29 THEN '18-29'
		WHEN u.edad >= 30 AND u.edad <= 39 THEN '30-39'
		WHEN u.edad >= 40 AND u.edad <= 49 THEN '40-49'
		WHEN u.edad >= 50 AND u.edad <= 59 THEN '50-59'
		WHEN u.edad >= 60 AND u.edad <= 69 THEN '60-69'
		ELSE '70+'
	END AS rango_edad,
	COUNT(*) AS cant_viajes
FROM viajes v
JOIN usuarios u ON v.id_usuario = u.id_usuario
GROUP BY rango_edad;

-- relacion entre la cantidad de viajes realizados y la fecha de alta de los usuarios
SELECT 
	EXTRACT(YEAR FROM u.fecha_alta) AS anio_alta,
	COUNT(*) AS cant_viajes
FROM usuarios u
JOIN viajes v ON u.id_usuario = v.id_usuario
GROUP BY anio_alta
ORDER BY cant_viajes DESC;


-- relacion entre la duracion de los viajes y el modelo de la bicicleta
SELECT 
	modelo_bicicleta, 
	MIN(duracion_segundos) / 60 AS duracion_minima_minutos,
	MAX(duracion_segundos) / 60 AS duracion_maxima_minutos,
	ROUND(AVG(duracion_segundos) / 60, 2) AS duracion_promedio_minutos,
	SUM(duracion_segundos) / 60 AS duracion_total_minutos
FROM viajes
GROUP BY modelo_bicicleta; 


-- usuarios más activos durante el 2023
SELECT u.id_usuario, COUNT(*) AS cant_viajes
FROM usuarios u
JOIN viajes v ON u.id_usuario = v.id_usuario
GROUP BY u.id_usuario
ORDER BY cant_viajes DESC
LIMIT 100;


-- viajes entre estaciones (Esta consulta alimenta al reporte de Power BI)
SELECT 
	e_origen.nombre AS estacion_origen,
	e_destino.nombre AS estacion_destino,
	COUNT(*) AS cant_viajes,
	ROUND(AVG(v.duracion_segundos) / 60, 2) AS duracion_promedio_minutos
FROM viajes v
JOIN estaciones e_origen ON v.id_estacion_origen = e_origen.id_estacion
JOIN estaciones e_destino ON v.id_estacion_destino = e_destino.id_estacion
GROUP BY e_origen.nombre, e_destino.nombre
ORDER BY cant_viajes DESC;
