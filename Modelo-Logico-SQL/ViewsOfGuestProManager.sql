#Mostre os detalhes das reservas, incluindo o nome do hóspede, o número do quarto, o valor pago, o estado do pagamento, e os serviços associados à reserva
CREATE VIEW Detalhes_Reservas AS
SELECT 
    R.ID AS ReservaID,
    H.Nome AS NomeHospede,
    Q.Numero AS NumeroQuarto,
    R.Valor AS ValorReserva,
    R.Pagamento AS EstadoPagamento,
    GROUP_CONCAT(S.Tipo ORDER BY S.Tipo SEPARATOR ', ') AS Servicos
FROM 
    Reserva R
JOIN 
    Hospede H ON R.CPFHospede = H.CPF
JOIN 
    Quarto Q ON R.NumeroQuarto = Q.Numero
LEFT JOIN 
    Contem C ON R.ID = C.IDReserva
LEFT JOIN 
    Servico S ON C.IDServico = S.ID
GROUP BY 
    R.ID, H.Nome, Q.Numero, R.Valor, R.Pagamento;
    
Select *
from Detalhes_Reservas;

#Mostre os detalhes dos funcionários e os serviços que eles realizaram, junto com o departamento ao qual pertencem.
CREATE VIEW Info_FuncionariosServicos AS
SELECT 
    F.Registro AS RegistroFuncionario,
    F.Nome AS NomeFuncionario,
    F.Email AS EmailFuncionario,
    F.Telefone AS TelefoneFuncionario,
    D.Nome AS NomeDepartamento,
    S.Tipo AS TipoServico,
    R.DataS AS DataServico
FROM 
    Funcionario F
JOIN 
    Departamento D ON F.ID_Departamento = D.ID
LEFT JOIN 
    Realiza R ON F.Registro = R.IDRegistro
LEFT JOIN 
    Servico S ON R.IDServico = S.ID
ORDER BY 
    F.Registro, R.DataS;
    
Select *
from Info_FuncionariosServicos;

#Mostre o número e a capacidade dos quartos e se eles estão disponíveis ou ocupados
CREATE VIEW Ocupacao_Quartos AS
SELECT 
    Q.Numero AS NumeroQuarto,
    Q.Capacidade AS CapacidadeQuarto,
    CASE
        WHEN R.DataR IS NOT NULL THEN 'Ocupado'
        ELSE 'Disponível'
    END AS StatusQuarto
FROM 
    Quarto Q
LEFT JOIN 
    Reserva R ON Q.Numero = R.NumeroQuarto
ORDER BY 
    Q.Numero, R.DataR;
