CREATE TABLE `item` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `item` (`title`) VALUES
('foo'),
('bar'),
('baz');