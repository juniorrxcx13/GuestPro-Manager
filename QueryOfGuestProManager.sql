# selecionar todos os quartos disponíveis no hotel
SELECT *
FROM Quarto
WHERE Numero NOT IN (
    SELECT NumeroQuarto
    FROM Reserva
);
 
# mostrar todas as reservas feitas
SELECT *
FROM Reserva;
 
# descobrir quais quartos estão ocupados
SELECT NumeroQuarto as 'Quartos Ocupados'
FROM Reserva;
 
# Liste todas as reservas e seus serviços associados.
SELECT r.*, s.Tipo
FROM Reserva r
JOIN Contem c ON r.ID = c.IDReserva
JOIN Servico s ON c.IDServico = s.ID;
 
# Descubra quais quartos têm serviço de café da manhã.
SELECT DISTINCT r.NumeroQuarto
FROM Reserva r
JOIN Contem c ON r.ID = c.IDReserva
JOIN Servico s ON c.IDServico = s.ID
WHERE s.Tipo = 'Café da Manhã';
 
# Encontre todas as reservas feitas em um determinado mês (mês de Maio).
SELECT *
FROM Reserva
WHERE MONTH(DataR) = 5;
 
# Encontre todas as reservas associadas a um quarto específico.
SELECT *
FROM Reserva
WHERE NumeroQuarto = 101;
 
# Descubra a quantidade total de reservas feitas.
SELECT COUNT(*) AS Total_de_Reservas
FROM Reserva;