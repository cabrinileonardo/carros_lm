# 🚗 carros_lm — Banco de dados de uma revenda de veículos (MySQL)

Atividade da disciplina **Fundamentos de Banco de Dados I** (Engenharia da Computação · Uniara).
Modelagem e criação de um banco relacional para uma revenda de carros, com dados de exemplo.

## Modelo

| Tabela | Descrição | Relacionamentos |
|---|---|---|
| `clientes` | Pessoas físicas e jurídicas (CPF/CNPJ) | — |
| `cargos` | Cargos dos funcionários | — |
| `funcionarios` | Vendedores e gestores | `cargos` |
| `marcas` | Montadoras | — |
| `modelos` | Modelo e ano | `marcas` |
| `veiculos` | Estoque: placa, chassi, km, custo, preço e status | `modelos` |
| `vendas` | Venda de um veículo a um cliente por um funcionário | `veiculos`, `clientes`, `funcionarios` |
| `pagamentos` | Uma venda pode ter vários pagamentos (Pix, financiamento…) | `vendas` |

## Regras de negócio no modelo

- `placa` e `chassi` são **únicos**
- `vendas.id_veiculo` é **UNIQUE**: o mesmo veículo não pode ser vendido duas vezes
- Status com valor padrão: veículo `Disponivel` e pagamento `Pendente`
- Chaves estrangeiras garantem a integridade entre as tabelas

## Como executar

Abra `carros_lm.sql` no **MySQL Workbench** (ou no cliente `mysql`) e execute o script inteiro.
Ele cria o banco `carros_lm`, as tabelas e insere os dados de exemplo.

## Conceitos praticados

DDL (`CREATE DATABASE`, `CREATE TABLE`) · chaves primárias e estrangeiras · `AUTO_INCREMENT` · `UNIQUE` e `DEFAULT` · DML (`INSERT`)

---

Projeto acadêmico · Leonardo Cabrini Mauro · [LinkedIn](https://www.linkedin.com/in/leonardo-cabrini-mauro-79b292355/)
