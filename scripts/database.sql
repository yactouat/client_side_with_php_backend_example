CREATE TABLE `item` (
  `id` int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `title` varchar(255) NOT NULL,
  `image_url` varchar(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `item` (`title`, `image_url`) VALUES
('foo', 'https://picsum.photos/200'),
('bar', 'https://picsum.photos/200'),
('baz', 'https://picsum.photos/200');