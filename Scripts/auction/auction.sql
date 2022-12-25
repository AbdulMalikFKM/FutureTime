CREATE TABLE IF NOT EXISTS `auction` (
  `id` int(11) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `lastbidder` int(11) NOT NULL,
  `bidprice` int(11) NOT NULL,
  `minincrease` text NOT NULL,
  `buyout` int(11) NOT NULL,
  `vin` int(11) DEFAULT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;