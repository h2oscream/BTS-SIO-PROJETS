-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 25 mai 2021 à 14:14
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `vaepointet`
--

-- --------------------------------------------------------

--
-- Structure de la table `calendrier`
--

DROP TABLE IF EXISTS `calendrier`;
CREATE TABLE IF NOT EXISTS `calendrier` (
  `dateC` date NOT NULL,
  `commentaire` varchar(1000) NOT NULL,
  PRIMARY KEY (`dateC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `calendrier`
--

INSERT INTO `calendrier` (`dateC`, `commentaire`) VALUES
('2021-05-19', ''),
('2021-05-20', '');

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateC` date NOT NULL,
  `heure` time NOT NULL,
  `recap` tinyint(1) NOT NULL,
  `contenant` tinyint(1) NOT NULL,
  `commentaire` longtext NOT NULL,
  `total` float NOT NULL,
  `idUtilisateurs` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Commande_Utilisateurs_FK` (`idUtilisateurs`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `lignes`
--

DROP TABLE IF EXISTS `lignes`;
CREATE TABLE IF NOT EXISTS `lignes` (
  `dateCalendrierPlat` date NOT NULL,
  `idPlat` int(11) NOT NULL,
  `quantite` int(11) NOT NULL,
  PRIMARY KEY (`dateCalendrierPlat`,`idPlat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `parametres`
--

DROP TABLE IF EXISTS `parametres`;
CREATE TABLE IF NOT EXISTS `parametres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `motBienvenue` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `plat`
--

DROP TABLE IF EXISTS `plat`;
CREATE TABLE IF NOT EXISTS `plat` (
  `dateCalendrier` date NOT NULL,
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `nombreCuisine` int(11) NOT NULL,
  `nombreRestant` int(11) NOT NULL,
  `prix` float NOT NULL,
  `description` longtext NOT NULL,
  `type` char(1) NOT NULL COMMENT 'e:entr?e p:plat d:dessert',
  PRIMARY KEY (`dateCalendrier`,`id`),
  KEY `dateCalendrier` (`dateCalendrier`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `plat`
--

INSERT INTO `plat` (`dateCalendrier`, `id`, `nom`, `nombreCuisine`, `nombreRestant`, `prix`, `description`, `type`) VALUES
('2021-05-19', 3, 'poisson', 5, 3, 7.5, 'poisson carpe', 'p'),
('2021-05-20', 1, 'poulet', 2, 1, 4.5, 'poulet curry', 'p'),
('2021-05-20', 2, 'riz', 4, 2, 5, 'riz jaune', 'p');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `mail` varchar(50) NOT NULL,
  `motDePasse` varchar(100) NOT NULL,
  `login` varchar(50) NOT NULL,
  `administrateur` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id`, `nom`, `prenom`, `mail`, `motDePasse`, `login`, `administrateur`) VALUES
(1, 'admin', 'admin', 'admin@gmail.com', '$2y$10$YZbHxR5hffHzbeP09MWp1.6.Fya6HN5MTzZ.IINgDNXVm10hrvsFa', 'admin', 1),
(2, 'dietmann', 'loic', 'loic.dietmann@gmail.com', '', '', 0);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `Commande_Utilisateurs_FK` FOREIGN KEY (`idUtilisateurs`) REFERENCES `utilisateurs` (`id`);

--
-- Contraintes pour la table `lignes`
--
ALTER TABLE `lignes`
  ADD CONSTRAINT `lignes_Plat0_FK` FOREIGN KEY (`dateCalendrierPlat`,`idPlat`) REFERENCES `plat` (`dateCalendrier`, `id`);

--
-- Contraintes pour la table `plat`
--
ALTER TABLE `plat`
  ADD CONSTRAINT `Plat_Calendrier_FK` FOREIGN KEY (`dateCalendrier`) REFERENCES `calendrier` (`dateC`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
