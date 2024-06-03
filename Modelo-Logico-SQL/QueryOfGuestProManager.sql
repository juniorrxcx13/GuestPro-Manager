# SISTEMA DE GERENCIAMENTO DE HOTÉIS
# Adilson Junior, Thiago Lima e Maria Clara

# 4 grupos de consultas

# G1. Operadores Agregados (MIN, MAX, AVG, COUNT)
	
	# Quantidade total de reservas feitas.
	SELECT COUNT(*) AS Total_de_Reservas
	FROM Reserva;

	# Média de avaliação das reservas registradas
	select AVG(R.Avaliacao)
	from Reserva R;

# G2. 2 tabelas, 3 tabelas, 4 tabelas
    
    # Quais quartos estão ocupados
	SELECT NumeroQuarto as 'Quartos Ocupados'
	FROM Reserva;
	 
	# Encontre todas as reservas associadas a um quarto específico.
	SELECT *
	FROM Reserva
	WHERE NumeroQuarto = 101;
    
	# Liste todas as reservas e seus serviços associados.
	SELECT R.*, S.Tipo
	FROM Reserva R, Contem C, Servico S
    WHERE R.ID = C.IDReserva AND S.ID = C.IDServico;
     
	# Calcular o valor total pago por cada hóspede
	SELECT H.Nome, SUM(R.Valor) AS Total_Pago
	FROM hospede H, Reserva R
	WHERE H.CPF = R.CPFHospede
    GROUP BY H.nome;
    
	#Consulta que mostra o nome dos cozinheiros, sua especialidade e seu departamento
	SELECT F.Nome AS Nome_Cozinheiro, D.Nome AS Departamento, C.Especialidade
	FROM Funcionario F, Cozinheiro C, Departamento D
	WHERE F.Registro = C.RegistroFuncionario AND F.ID_Departamento = D.ID;
    
    # Mostrar os comentários feitos pelos hóspedes e os quartos que eles ocuparam 
    SELECT H.nome AS 'Nome_Hospede', C.descricao AS 'Descricao_comentario', Q.numero AS 'Numero_quarto'
    FROM Hospede H, Comentario C, Quarto Q, Reserva R
    WHERE H.CPF = R.CPFHospede AND H.CPF = C.CPF_Hospede AND R.NumeroQuarto = Q.Numero;
    
# G3. 2 aninhadas

	# selecionar todos os quartos disponíveis no hotel
	SELECT *
	FROM Quarto
	WHERE Numero NOT IN (
		SELECT NumeroQuarto
		FROM Reserva
	);
    
	#Mostre o nome do hospede e o número do quarto cuja avaliação da reserva está acima da média
	Select H.nome, Q.numero
	From Hospede H, Quarto Q, Reserva R
	Where H.CPF = R.CPFHospede and Q.numero = R.NumeroQuarto and R.avaliacao > (Select AVG(R2.avaliacao) from Reserva R2);

# G4. Having, Group By
