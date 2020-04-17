-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 17-Abr-2020 às 21:02
-- Versão do servidor: 10.4.11-MariaDB
-- versão do PHP: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `bank`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `address`
--

CREATE TABLE `address` (
  `id` int(10) UNSIGNED NOT NULL,
  `uf` varchar(2) NOT NULL,
  `city` varchar(100) NOT NULL,
  `district` varchar(100) NOT NULL,
  `street` varchar(100) NOT NULL,
  `zipcode` varchar(45) NOT NULL,
  `bank_id` int(10) UNSIGNED DEFAULT NULL,
  `client_id` int(10) UNSIGNED DEFAULT NULL,
  `manager_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `bank`
--

CREATE TABLE `bank` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `cnpj` varchar(14) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `client`
--

CREATE TABLE `client` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `pass` varchar(32) NOT NULL,
  `ordenado` decimal(8,2) UNSIGNED NOT NULL,
  `token` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `client`
--

INSERT INTO `client` (`id`, `name`, `surname`, `cpf`, `pass`, `ordenado`, `token`) VALUES
(1, 'Teste', 'Teste', '123', '202cb962ac59075b964b07152d234b70', '12500.00', 'bf44a632755dc550520817e1fbb0fcdb');

-- --------------------------------------------------------

--
-- Estrutura da tabela `contact`
--

CREATE TABLE `contact` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(14) NOT NULL,
  `client_id` int(10) UNSIGNED DEFAULT NULL,
  `manager_id` int(10) UNSIGNED DEFAULT NULL,
  `bank_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `loan`
--

CREATE TABLE `loan` (
  `id` int(10) UNSIGNED NOT NULL,
  `amount` decimal(8,2) UNSIGNED NOT NULL,
  `parcel_number` tinyint(2) UNSIGNED NOT NULL,
  `loan_type` tinyint(1) UNSIGNED NOT NULL,
  `remaining_amount` decimal(8,2) UNSIGNED NOT NULL,
  `loan_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(1) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `log`
--

CREATE TABLE `log` (
  `id` int(10) UNSIGNED NOT NULL,
  `first_acess` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_access` timestamp NOT NULL DEFAULT current_timestamp(),
  `client_id` int(10) UNSIGNED DEFAULT NULL,
  `manager_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `manager`
--

CREATE TABLE `manager` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `pass` varchar(32) NOT NULL,
  `secret_key` varchar(4) NOT NULL,
  `bank_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `parcel`
--

CREATE TABLE `parcel` (
  `id` int(10) UNSIGNED NOT NULL,
  `value` decimal(8,2) UNSIGNED NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL,
  `delay_cost` decimal(8,2) UNSIGNED NOT NULL,
  `due_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `payday` timestamp NOT NULL DEFAULT current_timestamp(),
  `loan_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `record`
--

CREATE TABLE `record` (
  `client_id` int(10) UNSIGNED NOT NULL,
  `bank_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_address_bank_idx` (`bank_id`),
  ADD KEY `fk_address_client_idx` (`client_id`),
  ADD KEY `fk_address_manager_idx` (`manager_id`);

--
-- Índices para tabela `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cnpj_UNIQUE` (`cnpj`);

--
-- Índices para tabela `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cpf_UNIQUE` (`cpf`);

--
-- Índices para tabela `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_contact_client_idx` (`client_id`),
  ADD KEY `fk_contact_manager_idx` (`manager_id`),
  ADD KEY `fk_contact_bank_idx` (`bank_id`);

--
-- Índices para tabela `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_loan_client_idx` (`client_id`);

--
-- Índices para tabela `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_log_client_idx` (`client_id`),
  ADD KEY `fk_log_manager_idx` (`manager_id`);

--
-- Índices para tabela `manager`
--
ALTER TABLE `manager`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cpf_UNIQUE` (`cpf`),
  ADD UNIQUE KEY `secret_key` (`secret_key`),
  ADD KEY `fk_manager_bank_idx` (`bank_id`);

--
-- Índices para tabela `parcel`
--
ALTER TABLE `parcel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_parcel_loan_idx` (`loan_id`);

--
-- Índices para tabela `record`
--
ALTER TABLE `record`
  ADD PRIMARY KEY (`client_id`,`bank_id`),
  ADD KEY `fk_record_bank_idx` (`bank_id`),
  ADD KEY `fk_record_client_idx` (`client_id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `client`
--
ALTER TABLE `client`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `loan`
--
ALTER TABLE `loan`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `log`
--
ALTER TABLE `log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `manager`
--
ALTER TABLE `manager`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `parcel`
--
ALTER TABLE `parcel`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `fk_address_bank` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_address_client` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_address_manager` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `contact`
--
ALTER TABLE `contact`
  ADD CONSTRAINT `fk_contact_bank` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_contact_client` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_contact_manager` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `fk_loan_client` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `fk_log_client` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_log_manager` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `manager`
--
ALTER TABLE `manager`
  ADD CONSTRAINT `fk_manager_bank` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `parcel`
--
ALTER TABLE `parcel`
  ADD CONSTRAINT `fk_parcel_loan` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `record`
--
ALTER TABLE `record`
  ADD CONSTRAINT `fk_record_bank` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_record_cliente` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
