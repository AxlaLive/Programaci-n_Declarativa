INSERT INTO CambioMoneda (IdMoneda, Fecha, Cambio)
VALUES (58, '2025-11-18', 4525.75)
ON CONFLICT (IdMoneda, Fecha)
DO UPDATE SET 
    Cambio = EXCLUDED.Cambio;


SELECT id, moneda, sigla
FROM Moneda;


SELECT *
FROM CambioMoneda
WHERE IdMoneda = 58
  AND Fecha = '2025-11-18';
