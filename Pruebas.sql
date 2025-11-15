SELECT 
    id, 
    moneda, 
    sigla
FROM 
    moneda
ORDER BY 
    id;

SELECT 
    COUNT(*) AS totalregistroscambio
FROM 
    cambiomoneda;
SELECT 
    m.sigla,
    COUNT(cm.idmoneda) AS registros_por_moneda
FROM 
    cambiomoneda cm
        JOIN moneda m 
            ON cm.idmoneda = m.id
GROUP BY 
    m.sigla
ORDER BY 
    m.sigla;
SELECT 
    cm.idmoneda, 
    m.sigla, 
    cm.fecha, 
    cm.cambio
FROM 
    cambiomoneda cm
        JOIN moneda m 
            ON cm.idmoneda = m.id
ORDER BY 
    cm.fecha DESC, 
    cm.idmoneda 
LIMIT 100;