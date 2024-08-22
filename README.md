# Projeto: Otimização de Consultas SQL no Banco de Dados Company

## Descrição do Projeto
Este projeto tem como objetivo otimizar o desempenho de consultas SQL no banco de dados "Company" por meio da criação de índices estratégicos. As consultas são projetadas para responder a perguntas comuns sobre os dados do banco, como o número de funcionários por departamento, a localização dos departamentos por cidade e a relação de empregados por departamento.

## Consultas Otimizadas e Índices Criados

### 1. Qual o departamento com maior número de pessoas?
```sql
SELECT d.Dname, COUNT(e.Ssn) AS NumFuncionarios
FROM employee e
JOIN departament d ON e.Dno = d.Dnumber
GROUP BY d.Dname
ORDER BY NumFuncionarios DESC
LIMIT 1;
```
Índice Criado: CREATE INDEX idx_employee_dno ON employee(Dno);

Motivo: O índice na coluna Dno da tabela employee melhora significativamente o desempenho ao contar o número de funcionários por departamento, pois permite uma busca mais rápida por essa coluna.

### 2. Quais são os departamentos por cidade?
```sql
SELECT d.Dname, dl.Dlocation
FROM departament d
JOIN dept_locations dl ON d.Dnumber = dl.Dnumber;
```
Índice Criado: CREATE INDEX idx_dept_locations_dnumber ON dept_locations(Dnumber);

Motivo: O índice na coluna Dnumber da tabela dept_locations otimiza a junção entre as tabelas departament e dept_locations, tornando a consulta mais eficiente ao buscar as localizações dos departamentos.

### 3. Relação de empregados por departamento
```sql
SELECT d.Dname, e.Fname, e.Lname
FROM employee e
JOIN departament d ON e.Dno = d.Dnumber
ORDER BY d.Dname, e.Lname;
```
Índice Criado: CREATE INDEX idx_employee_dno_name ON employee(Dno, Lname);

Motivo: Um índice composto nas colunas Dno e Lname da tabela employee é utilizado para melhorar o desempenho na ordenação dos resultados por departamento e sobrenome do empregado.

## Considerações Finais
Os índices foram criados com o objetivo de otimizar consultas específicas, levando em consideração as colunas mais acessadas e relevantes para as operações realizadas. A criação de índices pode impactar positivamente o desempenho das consultas, mas deve ser cuidadosamente planejada para evitar degradação de performance em operações de inserção, atualização e exclusão.
