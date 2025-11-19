DO $$
DECLARE
    monedas_a_simular INT[] := ARRAY[1, 2, 3, 4]; 
    fecha_inicio DATE := current_date - INTERVAL '2 months';
    fecha_fin DATE := current_date - INTERVAL '1 day';
    current_date_loop DATE;
    moneda_id INT;
    tasa_base NUMERIC;
    tasa_final NUMERIC;
    registros_afectados INT := 0; 
BEGIN
    current_date_loop := fecha_inicio;
    WHILE current_date_loop <= fecha_fin LOOP
        FOREACH moneda_id IN ARRAY monedas_a_simular LOOP
            IF moneda_id IN (1, 2) THEN 
                tasa_base := (RANDOM() * 2.0) + 0.5; 
            ELSE 
                tasa_base := (RANDOM() * 50.0) + 100.0; 
            END IF;
            tasa_final := ROUND(tasa_base, 4);
            INSERT INTO cambiomoneda
                (idmoneda, fecha, cambio) 
            VALUES
                (moneda_id, current_date_loop, tasa_final)
            ON CONFLICT (idmoneda, fecha)
                DO UPDATE SET cambio = EXCLUDED.cambio; 
            registros_afectados := registros_afectados + 1; 
        END LOOP;
        current_date_loop := current_date_loop + INTERVAL '1 day';
    END LOOP;
END $$;