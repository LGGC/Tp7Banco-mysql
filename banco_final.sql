-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-08-2022 a las 02:22:55
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `banco_final`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_AddNewClient` (IN `_tipo_cliente` VARCHAR(30), IN `_numeroDocumento_cliente` VARCHAR(30), IN `_fechaRegistro_cliente` DATE)   BEGIN 
INSERT INTO clientes (tipo_cliente,numeroDocumento_cliente,fechaRegistro_cliente) VALUES (_tipo_cliente,_numeroDocumento_cliente, CURRENT_DATE());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SearchClientByDate` (IN `fechaIncio` DATE, IN `fechaFinal` DATE)   BEGIN 
SELECT *
FROM clientes
WHERE FechaRegistro_cliente BETWEEN fechaIncio AND fechaFinal;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SearchPaquete` (IN `apellido` VARCHAR(30))   BEGIN 
SELECT clientes.nombre_cliente
FROM clientes
INNER JOIN campañas
ON campañas.id_cliente = clientes.id_cliente
INNER JOIN productos
ON productos.id_producto=campañas.id_producto
INNER JOIN paquetes
ON paquetes.id_producto=productos.id_producto
WHERE clientes.apellido_cliente = apellido;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SearchProductByType` (IN `tipoProducto` VARCHAR(30))   BEGIN 
SELECT COUNT(Id_producto)
FROM productos
WHERE tipo_producto = tipoProducto;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `campañas`
--

CREATE TABLE `campañas` (
  `id_campaña` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `campañas`
--

INSERT INTO `campañas` (`id_campaña`, `id_producto`, `id_cliente`) VALUES
(1, 1, 1),
(2, 2, 3),
(3, 3, 5),
(4, 8, 34);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `tipo_cliente` varchar(30) DEFAULT NULL,
  `numeroDocumento_cliente` int(11) DEFAULT NULL,
  `fechaRegistro_cliente` date DEFAULT NULL,
  `alias_cliente` varchar(30) DEFAULT NULL,
  `apellido_cliente` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `tipo_cliente`, `numeroDocumento_cliente`, `fechaRegistro_cliente`, `alias_cliente`, `apellido_cliente`) VALUES
(1, 'fisica', 654321, '2021-08-20', 'pedro', 'haro'),
(2, 'fisica', 23456, '2023-08-29', 'Jeremías', 'Durán'),
(3, 'fisica', 1432645, '2022-08-29', 'Pelayo', 'Urrutia'),
(4, 'fisica', 3124, '2022-08-29', 'Alfredo', 'Abril'),
(5, 'fisica', 3256235, '2022-08-29', 'Alejandro', 'Martinez'),
(6, 'fisica', 7743323, '2022-08-29', 'Eulalia', 'adan'),
(7, 'juridica', 23456543, '2021-06-20', 'Haro Burguers', NULL),
(8, 'juridica', 847293, '2021-06-15', 'pizza hut', NULL),
(9, 'fisica', 488923, '2021-06-11', NULL, NULL),
(10, 'fisica', 990051, '2021-06-04', NULL, NULL),
(34, 'fisica', 30435252, '2022-08-30', 'lash', 'mana');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paquetes`
--

CREATE TABLE `paquetes` (
  `id_paquete` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `esCrediticio_paquete` varchar(30) DEFAULT NULL,
  `nombre_paquete` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `paquetes`
--

INSERT INTO `paquetes` (`id_paquete`, `id_producto`, `esCrediticio_paquete`, `nombre_paquete`) VALUES
(1, 1, 'si', ''),
(2, 3, 'no', ''),
(3, 8, 'si', 'paqueteMagico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

CREATE TABLE `prestamos` (
  `id_prestamo` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `id_raiz` int(11) NOT NULL,
  `tipo_prestamo` varchar(30) DEFAULT NULL,
  `monto_prestamo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `prestamos`
--

INSERT INTO `prestamos` (`id_prestamo`, `id_producto`, `id_raiz`, `tipo_prestamo`, `monto_prestamo`) VALUES
(1, 1, 1, 'prendario', 0),
(2, 2, 2, 'prendario', 2),
(3, 3, 3, 'personal', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `tipo_producto` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `tipo_producto`) VALUES
(1, 'prestamo'),
(2, 'prestamo'),
(3, 'prestamo'),
(4, 'prestamo'),
(5, 'prestamo'),
(6, 'paquete'),
(7, 'paquete'),
(8, 'paquete');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `raices`
--

CREATE TABLE `raices` (
  `id_raiz` int(11) NOT NULL,
  `id_solicitud` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `fechaSolicitud_raiz` date DEFAULT NULL,
  `fechaAprobacion_raiz` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `raices`
--

INSERT INTO `raices` (`id_raiz`, `id_solicitud`, `id_producto`, `fechaSolicitud_raiz`, `fechaAprobacion_raiz`) VALUES
(1, 1, 1, NULL, '2020-06-24'),
(2, 2, 2, NULL, '2020-05-24'),
(3, 3, 3, NULL, '2020-08-25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rechazos`
--

CREATE TABLE `rechazos` (
  `id_rechazo` int(11) NOT NULL,
  `id_solicitud` int(11) DEFAULT NULL,
  `fecha_rechazo` date DEFAULT NULL,
  `fecha_solicitud` date DEFAULT NULL,
  `motivo_rechazo` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `restricciones`
--

CREATE TABLE `restricciones` (
  `id_restriccion` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `motivo_restriccion` varchar(30) DEFAULT NULL,
  `fechaVigencia_restriccion` date DEFAULT NULL,
  `estadoRestriccion_restriccion` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes`
--

CREATE TABLE `solicitudes` (
  `id_solicitud` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `fecha_solicitud` date DEFAULT NULL,
  `estado_solicitud` varchar(30) DEFAULT NULL,
  `tipo_solicitud` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `solicitudes`
--

INSERT INTO `solicitudes` (`id_solicitud`, `id_cliente`, `id_producto`, `fecha_solicitud`, `estado_solicitud`, `tipo_solicitud`) VALUES
(1, 1, 1, NULL, NULL, NULL),
(2, 3, 3, NULL, NULL, NULL),
(3, 2, 2, NULL, NULL, NULL),
(4, 9, 4, NULL, NULL, NULL),
(5, 10, 5, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarjetas`
--

CREATE TABLE `tarjetas` (
  `numero_tarjeta` int(11) NOT NULL,
  `id_paquete` int(11) DEFAULT NULL,
  `nombre_tarjeta` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tarjetas`
--

INSERT INTO `tarjetas` (`numero_tarjeta`, `id_paquete`, `nombre_tarjeta`) VALUES
(156156, 3, 'tarjeta1'),
(512652, 3, 'tarjeta2'),
(556265, 3, 'tarjeta3');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `campañas`
--
ALTER TABLE `campañas`
  ADD PRIMARY KEY (`id_campaña`),
  ADD KEY `fk_Clientes_Campañas` (`id_cliente`),
  ADD KEY `fk_Productos_Campañas` (`id_producto`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `paquetes`
--
ALTER TABLE `paquetes`
  ADD PRIMARY KEY (`id_paquete`),
  ADD KEY `fk_Paquetes_Productos` (`id_producto`);

--
-- Indices de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD PRIMARY KEY (`id_prestamo`),
  ADD KEY `fk_productos_prestamos` (`id_producto`),
  ADD KEY `fk_raices_prestamos` (`id_raiz`) USING BTREE;

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `raices`
--
ALTER TABLE `raices`
  ADD PRIMARY KEY (`id_raiz`),
  ADD KEY `fk_Solicitudes_Raices` (`id_solicitud`);

--
-- Indices de la tabla `rechazos`
--
ALTER TABLE `rechazos`
  ADD PRIMARY KEY (`id_rechazo`),
  ADD KEY `fk_Solicitudes_Rechazos` (`id_solicitud`);

--
-- Indices de la tabla `restricciones`
--
ALTER TABLE `restricciones`
  ADD PRIMARY KEY (`id_restriccion`),
  ADD KEY `fk_Clientes_Restricciones` (`id_cliente`);

--
-- Indices de la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD PRIMARY KEY (`id_solicitud`),
  ADD KEY `fk_Clientes_Solicitudes` (`id_cliente`),
  ADD KEY `fk_Productos_Solicitudes` (`id_producto`);

--
-- Indices de la tabla `tarjetas`
--
ALTER TABLE `tarjetas`
  ADD PRIMARY KEY (`numero_tarjeta`),
  ADD KEY `fk_Paquetes_Tarjetas` (`id_paquete`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `campañas`
--
ALTER TABLE `campañas`
  MODIFY `id_campaña` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `paquetes`
--
ALTER TABLE `paquetes`
  MODIFY `id_paquete` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `id_prestamo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `raices`
--
ALTER TABLE `raices`
  MODIFY `id_raiz` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `rechazos`
--
ALTER TABLE `rechazos`
  MODIFY `id_rechazo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `restricciones`
--
ALTER TABLE `restricciones`
  MODIFY `id_restriccion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  MODIFY `id_solicitud` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `tarjetas`
--
ALTER TABLE `tarjetas`
  MODIFY `numero_tarjeta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4156157;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `campañas`
--
ALTER TABLE `campañas`
  ADD CONSTRAINT `fk_Clientes_Campañas` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `fk_Productos_Campañas` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `paquetes`
--
ALTER TABLE `paquetes`
  ADD CONSTRAINT `fk_Paquetes_Productos` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD CONSTRAINT `fk_productos_prestamos` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  ADD CONSTRAINT `fk_raices` FOREIGN KEY (`id_raiz`) REFERENCES `raices` (`id_raiz`);

--
-- Filtros para la tabla `rechazos`
--
ALTER TABLE `rechazos`
  ADD CONSTRAINT `fk_Solicitudes_Rechazos` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitudes` (`id_solicitud`);

--
-- Filtros para la tabla `restricciones`
--
ALTER TABLE `restricciones`
  ADD CONSTRAINT `fk_Clientes_Restricciones` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`);

--
-- Filtros para la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD CONSTRAINT `fk_Clientes_Solicitudes` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  ADD CONSTRAINT `fk_Productos_Solicitudes` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`);

--
-- Filtros para la tabla `tarjetas`
--
ALTER TABLE `tarjetas`
  ADD CONSTRAINT `fk_Paquetes_Tarjetas` FOREIGN KEY (`id_paquete`) REFERENCES `paquetes` (`id_paquete`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
