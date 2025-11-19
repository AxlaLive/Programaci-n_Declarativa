CREATE OR REPLACE FUNCTION funcion_AsegurarMoneda(
    p_moneda VARCHAR,    
    p_sigla VARCHAR,      
    p_simbolo VARCHAR,    
    p_emisor VARCHAR      
)
RETURNS INTEGER 
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_moneda INTEGER;
BEGIN
    SELECT Id INTO v_id_moneda
    FROM Moneda
    WHERE Sigla = p_sigla;
    IF v_id_moneda IS NULL THEN
        INSERT INTO Moneda (Moneda, Sigla, Simbolo, Emisor)
        VALUES (p_moneda, p_sigla, p_simbolo, p_emisor)
        RETURNING Id INTO v_id_moneda; 
        RAISE NOTICE 'Moneda agregada: % (%) - ID: %', p_moneda, p_sigla, v_id_moneda;
    END IF;
    RETURN v_id_moneda;
END;
$$;

-- Intentar agregar una moneda que ya exista
SELECT funcion_AsegurarMoneda('Dólar Estadounidense', 'USD', '$', 'Reserva Federal'); 
-- Intentar agregar una nueva moneda 
SELECT funcion_AsegurarMoneda('Yen Japonés', 'JPY', '¥', 'Banco de Japón'); 
-- Consulta de verificación final
SELECT id, Moneda, Sigla FROM Moneda WHERE Sigla IN ('USD', 'JPY');