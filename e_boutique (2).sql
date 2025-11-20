-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 17 nov. 2025 à 10:55
-- Version du serveur : 8.0.39
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `e_boutique`
--

-- --------------------------------------------------------

--
-- Structure de la table `cart`
--

CREATE TABLE `cart` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL
) ;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `nom` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `nom`) VALUES
(7, 'Accessoires'),
(6, 'Chaussures'),
(3, 'Enfant'),
(1, 'Femme'),
(2, 'Homme'),
(8, 'Luxe & Créateurs'),
(4, 'Soldes'),
(9, 'Sport'),
(5, 'Vêtements');

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

CREATE TABLE `messages` (
  `id` int NOT NULL,
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `message` text NOT NULL,
  `date_envoi` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `lu` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `messages`
--

INSERT INTO `messages` (`id`, `sender_id`, `receiver_id`, `message`, `date_envoi`, `lu`) VALUES
(1, 2, 1, 'oe c ca vient d\'ou', '2025-03-13 11:41:42', 0),
(2, 2, 1, 'nn', '2025-03-18 19:06:52', 0),
(3, 3, 2, 'c\'est combien', '2025-03-19 10:37:29', 1),
(4, 2, 3, '30', '2025-03-19 10:37:52', 1),
(5, 2, 3, 'J\'ai fait une offre de 0,10 € pour votre article \"nantes\".\n\nMessage: c&#039;est d&#039;occasion c&#039;est pas fou', '2025-04-09 10:03:56', 1),
(6, 3, 2, 'Contre-offre : 0,12 € pour \"nantes\".', '2025-04-09 10:04:30', 1),
(7, 2, 3, 'J\'ai fait une offre de 0,09 € pour votre article \"nantes\".\n\nMessage: NUL', '2025-04-09 10:13:37', 1),
(8, 3, 2, 'Contre-offre : 0,12 € pour \"nantes\".', '2025-04-09 10:14:05', 1),
(9, 2, 2, 'J\'ai accepté votre offre de 0,12 € pour \"nantes\". Finalisez le paiement ici : checkoutdirect.php?offre_id=3', '2025-04-09 10:14:30', 0),
(10, 2, 3, 'L\'acheteur a finalisé le paiement de l’offre #3 pour \"nantes\" au prix de 0,12 €.', '2025-04-09 10:14:39', 1),
(11, 3, 2, 'J\'ai fait une offre de 30,00 € pour votre article \"bonjour\".\n\nMessage: NUL', '2025-04-09 10:17:11', 1),
(12, 2, 3, 'J\'ai refusé votre offre de 30,00 € pour \"bonjour\".', '2025-04-09 10:17:39', 1),
(13, 3, 2, 'pk?', '2025-04-09 10:38:52', 1);

-- --------------------------------------------------------

--
-- Structure de la table `offres`
--

CREATE TABLE `offres` (
  `id` int NOT NULL,
  `produit_id` int NOT NULL,
  `acheteur_id` int NOT NULL,
  `vendeur_id` int NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  `message` text,
  `statut` enum('en_attente','acceptee','refusee','contre_offre') DEFAULT 'en_attente',
  `date_creation` datetime NOT NULL,
  `message_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `offres`
--

INSERT INTO `offres` (`id`, `produit_id`, `acheteur_id`, `vendeur_id`, `montant`, `message`, `statut`, `date_creation`, `message_id`) VALUES
(1, 91, 2, 3, 0.12, 'c&#039;est d&#039;occasion c&#039;est pas fou', 'contre_offre', '2025-04-09 12:03:56', 5),
(2, 91, 2, 3, 0.09, 'NUL', 'en_attente', '2025-04-09 12:13:37', 7),
(3, 91, 2, 3, 0.12, NULL, 'acceptee', '2025-04-09 12:14:05', 8),
(4, 92, 3, 2, 30.00, 'NUL', 'refusee', '2025-04-09 12:17:11', 11);

-- --------------------------------------------------------

--
-- Structure de la table `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `acheteur_id` int NOT NULL,
  `date_commande` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `statut` enum('en_preparation','expediee','en_livraison','livree','annulee') DEFAULT 'en_preparation',
  `numero_commande` varchar(50) NOT NULL,
  `adresse_livraison` text NOT NULL,
  `methode_paiement` varchar(50) NOT NULL,
  `montant_total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `orders`
--

INSERT INTO `orders` (`id`, `acheteur_id`, `date_commande`, `statut`, `numero_commande`, `adresse_livraison`, `methode_paiement`, `montant_total`) VALUES
(2, 2, '2025-03-26 11:07:49', 'livree', 'CMD-1742987269-2', '4 Avenue Felix goilerey, Conflans Ste Honorine, 78700, France', 'carte_credit', 79.99),
(3, 2, '2025-03-26 11:18:47', 'annulee', 'CMD-1742987927-2', '4 Avenue Felix goilerey, Conflans Ste Honorine, 78700, France', 'carte_credit', 90.99),
(4, 2, '2025-04-02 08:56:49', 'annulee', 'CMD17435842097186', '4 Avenue Felix goilerey', 'carte', 0.14),
(5, 3, '2025-04-02 09:25:30', 'en_livraison', 'CMD17435859304325', 'RUe de nantes', 'carte', 0.26),
(6, 2, '2025-04-09 10:14:39', 'livree', 'CMD-1744193679-2', '4 Avenue Felix goilerey, Conflans Ste Honorine, 78700, France', 'carte_credit', 0.12),
(7, 2, '2025-11-11 15:13:40', 'en_preparation', 'CMD17628740207504', '4 Avenue Felix goilerey', 'carte', 90.99),
(8, 5, '2025-11-12 21:32:00', 'en_preparation', 'CMD17629831207653', 'Hollywood', 'carte', 85.98),
(9, 6, '2025-11-12 21:36:08', 'en_preparation', 'CMD17629833689902', 'Elysee', 'carte', 104.99),
(10, 7, '2025-11-14 09:18:07', 'en_preparation', 'CMD17631118878235', 'Andresy', 'carte', 54.00),
(11, 9, '2025-11-14 21:36:13', 'en_preparation', 'CMD17631561734266', '20', 'carte', 59.99);

-- --------------------------------------------------------

--
-- Structure de la table `order_products`
--

CREATE TABLE `order_products` (
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantite` int NOT NULL,
  `prix_unitaire` decimal(10,2) NOT NULL
) ;

--
-- Déchargement des données de la table `order_products`
--

INSERT INTO `order_products` (`order_id`, `product_id`, `quantite`, `prix_unitaire`) VALUES
(2, 84, 1, 79.99),
(3, 89, 1, 90.99),
(4, 91, 1, 0.14),
(5, 90, 1, 0.26),
(6, 91, 1, 0.12),
(7, 89, 1, 90.99),
(8, 77, 1, 15.99),
(8, 80, 1, 69.99),
(9, 78, 1, 79.99),
(9, 93, 1, 25.00),
(10, 94, 1, 54.00),
(11, 71, 1, 59.99);

-- --------------------------------------------------------

--
-- Structure de la table `order_steps`
--

CREATE TABLE `order_steps` (
  `id` int NOT NULL,
  `order_id` int NOT NULL,
  `etape_nom` varchar(100) NOT NULL,
  `date_etape` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `statut` enum('en_attente','complete') DEFAULT 'en_attente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `order_steps`
--

INSERT INTO `order_steps` (`id`, `order_id`, `etape_nom`, `date_etape`, `statut`) VALUES
(1, 2, 'Commande confirmée', '2025-03-26 11:07:49', 'complete'),
(2, 2, 'En préparation', '2025-03-26 11:07:49', 'en_attente'),
(3, 2, 'Expédiée', '2025-03-26 11:07:49', 'en_attente'),
(4, 2, 'En livraison', '2025-03-26 11:07:49', 'en_attente'),
(5, 2, 'Livrée', '2025-03-26 11:07:49', 'en_attente'),
(6, 3, 'Commande confirmée', '2025-03-26 11:18:47', 'complete'),
(7, 3, 'En préparation', '2025-03-26 11:18:47', 'complete'),
(8, 3, 'Expédiée', '2025-03-26 11:33:46', 'en_attente'),
(9, 3, 'En livraison', '2025-03-26 11:33:46', 'en_attente'),
(10, 3, 'Livrée', '2025-03-26 11:33:46', 'en_attente'),
(11, 3, 'Commande annulée', '2025-03-26 11:33:46', 'complete'),
(12, 4, 'Commande confirmée', '2025-04-02 08:56:49', 'complete'),
(13, 4, 'En préparation', '2025-04-02 08:56:49', 'complete'),
(14, 4, 'Expédiée', '2025-04-02 08:57:03', 'en_attente'),
(15, 4, 'En livraison', '2025-04-02 08:57:03', 'en_attente'),
(16, 4, 'Livrée', '2025-04-02 08:57:03', 'en_attente'),
(17, 4, 'Commande annulée', '2025-04-02 08:57:03', 'complete'),
(18, 5, 'Commande confirmée', '2025-04-09 08:55:51', 'complete'),
(19, 5, 'En préparation', '2025-04-09 08:55:51', 'complete'),
(20, 5, 'Expédiée', '2025-04-09 08:55:51', 'complete'),
(21, 5, 'En livraison', '2025-04-09 08:55:51', 'complete'),
(22, 5, 'Livrée', '2025-04-09 08:55:51', 'en_attente'),
(28, 6, 'Commande confirmée', '2025-04-09 10:15:12', 'complete'),
(29, 6, 'En préparation', '2025-04-09 10:15:12', 'complete'),
(30, 6, 'Expédiée', '2025-04-09 10:15:12', 'complete'),
(31, 6, 'En livraison', '2025-04-09 10:15:12', 'complete'),
(32, 6, 'Livrée', '2025-04-09 10:15:12', 'complete'),
(33, 7, 'Commande confirmée', '2025-11-11 15:13:40', 'complete'),
(34, 7, 'En préparation', '2025-11-11 15:13:41', 'complete'),
(35, 7, 'Expédiée', '2025-11-11 15:13:41', 'en_attente'),
(36, 7, 'En livraison', '2025-11-11 15:13:41', 'en_attente'),
(37, 7, 'Livrée', '2025-11-11 15:13:41', 'en_attente'),
(38, 8, 'Commande confirmée', '2025-11-12 21:32:00', 'complete'),
(39, 8, 'En préparation', '2025-11-12 21:32:00', 'complete'),
(40, 8, 'Expédiée', '2025-11-12 21:32:00', 'en_attente'),
(41, 8, 'En livraison', '2025-11-12 21:32:00', 'en_attente'),
(42, 8, 'Livrée', '2025-11-12 21:32:00', 'en_attente'),
(43, 9, 'Commande confirmée', '2025-11-12 21:36:08', 'complete'),
(44, 9, 'En préparation', '2025-11-12 21:36:08', 'complete'),
(45, 9, 'Expédiée', '2025-11-12 21:36:08', 'en_attente'),
(46, 9, 'En livraison', '2025-11-12 21:36:08', 'en_attente'),
(47, 9, 'Livrée', '2025-11-12 21:36:08', 'en_attente'),
(48, 10, 'Commande confirmée', '2025-11-14 09:18:07', 'complete'),
(49, 10, 'En préparation', '2025-11-14 09:18:07', 'complete'),
(50, 10, 'Expédiée', '2025-11-14 09:18:07', 'en_attente'),
(51, 10, 'En livraison', '2025-11-14 09:18:07', 'en_attente'),
(52, 10, 'Livrée', '2025-11-14 09:18:07', 'en_attente'),
(53, 11, 'Commande confirmée', '2025-11-14 21:36:13', 'complete'),
(54, 11, 'En préparation', '2025-11-14 21:36:13', 'complete'),
(55, 11, 'Expédiée', '2025-11-14 21:36:13', 'en_attente'),
(56, 11, 'En livraison', '2025-11-14 21:36:13', 'en_attente'),
(57, 11, 'Livrée', '2025-11-14 21:36:13', 'en_attente');

-- --------------------------------------------------------

--
-- Structure de la table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `titre` varchar(255) NOT NULL,
  `description` text,
  `prix` decimal(10,2) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `categorie_id` int DEFAULT NULL,
  `vendeur_id` int DEFAULT NULL,
  `date_publication` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) DEFAULT 'disponible'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `products`
--

INSERT INTO `products` (`id`, `titre`, `description`, `prix`, `image_url`, `categorie_id`, `vendeur_id`, `date_publication`, `status`) VALUES
(69, 'Bonnet Cthulhu', 'Bonnet vert avec motif Cthulhu', 15.99, 'image/bonnet-cthulhu.jpg', 7, 1, '2025-03-12 12:25:55', 'vendu'),
(70, 'Bottes', 'Bottes en cuir marron', 79.99, 'image/botte.jpg', 6, 1, '2025-03-12 12:25:55', 'vendu'),
(71, 'Chaussure', 'Chaussure de sport', 59.99, 'image/chaussure.jpg', 6, 1, '2025-03-12 12:25:55', 'vendu'),
(72, 'Chaussure 2', 'Chaussure de ville', 69.99, 'image/chaussure2.jpg', 6, 1, '2025-03-12 12:25:55', 'vendu'),
(73, 'Pantalon Léopard', 'Pantalon avec motif léopard', 39.99, 'image/pantalon_leopard.jpg', 5, 1, '2025-03-12 12:25:55', 'vendu'),
(74, 'T-shirt', 'T-shirt avec motif', 24.99, 'image/t-shirt.jpg', 5, 1, '2025-03-12 12:25:55', 'vendu'),
(77, 'Bonnet Cthulhu', 'Bonnet vert avec motif Cthulhu', 15.99, 'image/bonnet-cthulhu.jpg', 7, 1, '2025-03-18 19:06:24', 'vendu'),
(78, 'Bottes', 'Bottes en cuir marron', 79.99, 'image/botte.jpg', 6, 1, '2025-03-18 19:06:24', 'vendu'),
(79, 'Chaussure', 'Chaussure de sport', 59.99, 'image/chaussure.jpg', 6, 1, '2025-03-18 19:06:24', 'disponible'),
(80, 'Chaussure 2', 'Chaussure de ville', 69.99, 'image/chaussure2.jpg', 6, 1, '2025-03-18 19:06:24', 'vendu'),
(81, 'Pantalon Léopard', 'Pantalon avec motif léopard', 39.99, 'image/pantalon_leopard.jpg', 5, 1, '2025-03-18 19:06:24', 'disponible'),
(82, 'T-shirt', 'T-shirt avec motif', 24.99, 'image/t-shirt.jpg', 5, 1, '2025-03-18 19:06:24', 'disponible'),
(83, 'Bonnet Cthulhu', 'Bonnet vert avec motif Cthulhu', 15.99, 'image/bonnet-cthulhu.jpg', 7, 1, '2025-03-19 10:44:11', 'disponible'),
(84, 'Bottes', 'Bottes en cuir marron', 79.99, 'image/botte.jpg', 6, 1, '2025-03-19 10:44:11', 'vendu'),
(85, 'Chaussure', 'Chaussure de sport', 59.99, 'image/chaussure.jpg', 6, 1, '2025-03-19 10:44:11', 'disponible'),
(86, 'Chaussure 2', 'Chaussure de ville', 69.99, 'image/chaussure2.jpg', 6, 1, '2025-03-19 10:44:11', 'disponible'),
(87, 'Pantalon Léopard', 'Pantalon avec motif léopard', 39.99, 'image/pantalon_leopard.jpg', 5, 1, '2025-03-19 10:44:11', 'disponible'),
(88, 'T-shirt', 'T-shirt avec motif', 24.99, 'image/t-shirt.jpg', 5, 1, '2025-03-19 10:44:11', 'disponible'),
(89, 'Amine gouiri', '9 de l om algerien', 90.99, 'image/Gouiri.jpg', 9, 1, '2025-03-19 10:44:11', 'vendu'),
(90, 'gouiri', 'joueur de fou', 0.26, 'images/produits/90/Gi0Jru5WQAAcbLP.jpg', 9, 2, '2025-04-01 16:40:50', 'vendu'),
(91, 'nantes', 'nantes', 0.14, 'images/produits/91/téléchargé.jpg', 9, 3, '2025-04-02 08:55:48', 'vendu'),
(92, 'bonjour', 'B J', 34.00, 'images/produits/92/romain.bmp', 4, 2, '2025-04-09 10:16:32', 'disponible'),
(93, 'Gastambide', 'Franck Gastambide', 25.00, 'images/produits/93/gastatant.webp', 9, 4, '2025-11-11 15:36:42', 'vendu'),
(94, 'Riles', 'Fc26', 54.00, 'images/produits/94/G2lfCIEWoAANTzI.png', 7, 5, '2025-11-12 21:31:40', 'vendu'),
(95, 'lebron', 'timberwolves', 154.00, 'images/produits/95/Gp2TSP9WEAAmDzj.jpg', 9, 6, '2025-11-12 21:35:51', 'disponible'),
(96, 'Comptabilité', 'Exercice de Compta L2', 17.00, 'images/produits/96/image0.jpeg', 8, 7, '2025-11-14 09:17:47', 'disponible'),
(97, 'Theoreme de Newton', 'exo maths simple', 5.00, 'images/produits/97/Capture d’écran_19-6-2024_105342_.jpeg', 3, 8, '2025-11-14 09:24:56', 'disponible'),
(98, 'Fibonacci', 'Suite de Fibonacco', 15.00, 'images/produits/98/Capture d’écran_18-6-2024_103614_.jpeg', 8, 10, '2025-11-17 09:14:25', 'disponible');

-- --------------------------------------------------------

--
-- Structure de la table `product_categories`
--

CREATE TABLE `product_categories` (
  `product_id` int NOT NULL,
  `category_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `signalements`
--

CREATE TABLE `signalements` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `reported_by_id` int NOT NULL,
  `raison` text NOT NULL,
  `date_signalement` datetime DEFAULT CURRENT_TIMESTAMP,
  `statut` enum('en_attente','traite') DEFAULT 'en_attente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `nom` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `adresse` text,
  `telephone` varchar(20) DEFAULT NULL,
  `role` enum('vendeur','acheteur') NOT NULL DEFAULT 'acheteur',
  `date_inscription` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `prenom` varchar(50) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `sexe` enum('Homme','Femme','Autre','Non spécifié') NOT NULL DEFAULT 'Non spécifié',
  `admin_status` enum('normal','admin','banned') DEFAULT 'normal'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `email`, `mot_de_passe`, `adresse`, `telephone`, `role`, `date_inscription`, `prenom`, `age`, `sexe`, `admin_status`) VALUES
(1, 'THIERRY', 'romainthierryOM@gmail.com', '$2y$10$lKPqrnlOoC0JlCqU8uMleezYn.Bp/J6rqK8fXbKKr1XBmT6oEm.K2', NULL, NULL, 'acheteur', '2025-02-17 10:33:14', NULL, NULL, 'Homme', 'normal'),
(2, 'romdeux', '43010388@parisnanterre.fr', '$2y$10$TS7PLz3BmrFmO/KkScyMduy2mRI80rN47wqm9gNU1xfkE0ur2ZE6W', '4 Avenue Felix goilerey', '+33668598137', 'acheteur', '2025-02-17 10:34:00', 'Romai', 18, 'Homme', 'admin'),
(3, 'canuT', '430103888@parisnanterre.fr', '$2y$10$w//gkJu5MmZ3NBnQ0h.T6Os0MJHYE8Hq9sOc9g2eaAN1W9corsGF6', 'RUe de nantes', '', 'acheteur', '2025-03-19 10:35:23', 'raphael', 35, 'Homme', 'admin'),
(4, 'Admin', 'Admin@gmail.com', '$2y$10$C/SQufqH27EXP.ywIC8XTOCiiGkIGbtHfcCu9d4164sPff96X.3DG', '5 Rue de La paix Paris', NULL, 'acheteur', '2025-11-11 15:34:50', 'Admin', 30, 'Femme', 'admin'),
(5, 'grande', 'Ariana@gmail.com', '$2y$10$YxXnpHIRsEzHelXNH0/hOeZgVvS9RPGPuzQzVLsXBQjKPzXQMGZjS', 'Hollywood', NULL, 'acheteur', '2025-11-12 21:29:22', 'Ariana', 30, 'Femme', 'normal'),
(6, 'Macron', 'brigitte@gmail.com', '$2y$10$TMMCo9seXaEbIRkhN3GJYOohhjDIDdiJQ8IUkZ8yj3FxcbJPMPR7G', 'Elysee', NULL, 'acheteur', '2025-11-12 21:32:44', 'Brigitte', 76, 'Femme', 'normal'),
(7, 'Halzoun', 'Ilan@gmail.com', '$2y$10$ssatwSShs6pTd1g8vcZKwupqYN/ReWoDBjzGRKBKVy.34ElE4YXFG', 'Andresy', NULL, 'acheteur', '2025-11-14 09:16:15', 'Ilan', 20, 'Homme', 'normal'),
(8, 'Meulle', 'meulle@gmail.com', '$2y$10$E3KDmyd/ahdiRFE9r0oZSuuC3zIH2cQrzNb2CiiIG4rHheRMbej5i', 'Jules Ferry', NULL, 'acheteur', '2025-11-14 09:23:44', 'Alice', 45, 'Femme', 'normal'),
(9, 'leveaux', 'simon@gmail.com', '$2y$10$Fz5IKdKEHbPTMZ9TDyrx4upN6/UeDOxUKX6H1WVLnp9.pZpg.8Lku', '20', NULL, 'acheteur', '2025-11-14 21:33:45', 'simon ', 20, 'Autre', 'normal'),
(10, 'nuentsa', 'terrel@gmail.com', '$2y$10$rTFQlEp.z8rhDLtFhLObM.aNcJbgZ5NG49eJPN9IeLiInaqwrHnKi', 'Montrouge', NULL, 'acheteur', '2025-11-17 09:12:10', 'Terrel', 18, 'Homme', 'normal');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nom` (`nom`);

--
-- Index pour la table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Index pour la table `offres`
--
ALTER TABLE `offres`
  ADD PRIMARY KEY (`id`),
  ADD KEY `produit_id` (`produit_id`),
  ADD KEY `acheteur_id` (`acheteur_id`),
  ADD KEY `vendeur_id` (`vendeur_id`),
  ADD KEY `message_id` (`message_id`);

--
-- Index pour la table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `acheteur_id` (`acheteur_id`);

--
-- Index pour la table `order_products`
--
ALTER TABLE `order_products`
  ADD PRIMARY KEY (`order_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Index pour la table `order_steps`
--
ALTER TABLE `order_steps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Index pour la table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categorie_id` (`categorie_id`),
  ADD KEY `vendeur_id` (`vendeur_id`);

--
-- Index pour la table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`product_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Index pour la table `signalements`
--
ALTER TABLE `signalements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `reported_by_id` (`reported_by_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `offres`
--
ALTER TABLE `offres`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `order_steps`
--
ALTER TABLE `order_steps`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT pour la table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT pour la table `signalements`
--
ALTER TABLE `signalements`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `offres`
--
ALTER TABLE `offres`
  ADD CONSTRAINT `offres_ibfk_1` FOREIGN KEY (`produit_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `offres_ibfk_2` FOREIGN KEY (`acheteur_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `offres_ibfk_3` FOREIGN KEY (`vendeur_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `offres_ibfk_4` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`);

--
-- Contraintes pour la table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`acheteur_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `order_products`
--
ALTER TABLE `order_products`
  ADD CONSTRAINT `order_products_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `order_steps`
--
ALTER TABLE `order_steps`
  ADD CONSTRAINT `order_steps_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`categorie_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`vendeur_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `product_categories`
--
ALTER TABLE `product_categories`
  ADD CONSTRAINT `product_categories_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `signalements`
--
ALTER TABLE `signalements`
  ADD CONSTRAINT `signalements_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `signalements_ibfk_2` FOREIGN KEY (`reported_by_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
