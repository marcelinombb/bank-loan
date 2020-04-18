-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Versão do servidor: 10.4.11-MariaDB
-- versão do PHP: 7.4.4

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
  `surname` varchar(50) DEFAULT NULL,
  `cpf` varchar(11) NOT NULL,
  `pass` varchar(32) NOT NULL DEFAULT 0,
  `ordenado` decimal(8,2) UNSIGNED NOT NULL DEFAULT 0,
  `token` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
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
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `delay_cost` decimal(8,2) UNSIGNED NOT NULL DEFAULT 0,
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

