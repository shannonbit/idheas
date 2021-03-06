SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `idheasIkari` DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci ;
SHOW WARNINGS;
USE `idheasIkari` ;

-- -----------------------------------------------------
-- Table `idheasIkari`.`actores`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`actores` (
  `actorId` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  `apellidosSiglas` VARCHAR(60) NULL ,
  `tipoActorId` INT NULL ,
  `foto` MEDIUMBLOB NULL ,
  `codigoPostal` VARCHAR(15) NULL ,
  `estadoActivo` TINYINT(1) NULL DEFAULT 1 ,
  PRIMARY KEY (`actorId`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`estadoCivil`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`estadoCivil` (
  `estadoCivilId` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(35) NULL ,
  `notas` VARCHAR(1500) NULL ,
  PRIMARY KEY (`estadoCivilId`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`ocupacionesCatalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`ocupacionesCatalogo` (
  `ocupacionId` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(250) NULL ,
  `notas` VARCHAR(3000) NULL ,
  `tipoActorId` VARCHAR(45) NULL ,
  PRIMARY KEY (`ocupacionId`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`gruposIndigenas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`gruposIndigenas` (
  `grupoIndigenaId` INT NOT NULL AUTO_INCREMENT ,
  `paisId` INT NULL ,
  `descripcion` VARCHAR(45) NULL ,
  `notas` VARCHAR(200) NULL ,
  PRIMARY KEY (`grupoIndigenaId`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`infoGralActor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`infoGralActor` (
  `generoId` INT NULL ,
  `edad` INT NULL ,
  `nacionalidadId` INT NULL ,
  `hijos` INT NULL ,
  `escolaridadId` INT NULL ,
  `espaniol` ENUM('Si','No') NULL ,
  `actores_actorId` INT NOT NULL ,
  `estadoCivil_estadoCivilId` INT NOT NULL ,
  `ocupacionesCatalogo_ultimaOcupacionId` INT NOT NULL ,
  `gruposIndigenas_grupoIndigenaId` INT NOT NULL ,
  INDEX `fk_infoGralActor_actores1_idx` (`actores_actorId` ASC) ,
  INDEX `fk_infoGralActor_estadoCivil1_idx` (`estadoCivil_estadoCivilId` ASC) ,
  INDEX `fk_infoGralActor_ocupacionesCatalogo1_idx` (`ocupacionesCatalogo_ultimaOcupacionId` ASC) ,
  INDEX `fk_infoGralActor_gruposIndigenas1_idx` (`gruposIndigenas_grupoIndigenaId` ASC) ,
  CONSTRAINT `fk_infoGralActor_actores1`
    FOREIGN KEY (`actores_actorId` )
    REFERENCES `idheasIkari`.`actores` (`actorId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_infoGralActor_estadoCivil1`
    FOREIGN KEY (`estadoCivil_estadoCivilId` )
    REFERENCES `idheasIkari`.`estadoCivil` (`estadoCivilId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_infoGralActor_ocupacionesCatalogo1`
    FOREIGN KEY (`ocupacionesCatalogo_ultimaOcupacionId` )
    REFERENCES `idheasIkari`.`ocupacionesCatalogo` (`ocupacionId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_infoGralActor_gruposIndigenas1`
    FOREIGN KEY (`gruposIndigenas_grupoIndigenaId` )
    REFERENCES `idheasIkari`.`gruposIndigenas` (`grupoIndigenaId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`paisesCatalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`paisesCatalogo` (
  `paisId` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(60) NULL ,
  PRIMARY KEY (`paisId`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`estadosCatalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`estadosCatalogo` (
  `estadoId` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(60) NULL ,
  `paises_paisId` INT NOT NULL ,
  PRIMARY KEY (`estadoId`) ,
  INDEX `fk_estados_paises1_idx` (`paises_paisId` ASC) ,
  CONSTRAINT `fk_estados_paises1`
    FOREIGN KEY (`paises_paisId` )
    REFERENCES `idheasIkari`.`paisesCatalogo` (`paisId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`municipiosCatalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`municipiosCatalogo` (
  `municipioId` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(60) NULL ,
  `estados_estadoId` INT NOT NULL ,
  PRIMARY KEY (`municipioId`) ,
  INDEX `fk_municipios_estados1_idx` (`estados_estadoId` ASC) ,
  CONSTRAINT `fk_municipios_estados1`
    FOREIGN KEY (`estados_estadoId` )
    REFERENCES `idheasIkari`.`estadosCatalogo` (`estadoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`datosDeNacimiento`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`datosDeNacimiento` (
  `fechaNacimiento` DATE NULL ,
  `actores_actorId` INT NOT NULL ,
  `paisesCatalogo_paisId` INT NOT NULL ,
  `estadosCatalogo_estadoId` INT NOT NULL ,
  `municipiosCatalogo_municipioId` INT NOT NULL ,
  INDEX `fk_datosDeNacimiento_actores1_idx` (`actores_actorId` ASC) ,
  UNIQUE INDEX `actores_actorId_UNIQUE` (`actores_actorId` ASC) ,
  INDEX `fk_datosDeNacimiento_paisesCatalogo1_idx` (`paisesCatalogo_paisId` ASC) ,
  INDEX `fk_datosDeNacimiento_estadosCatalogo1_idx` (`estadosCatalogo_estadoId` ASC) ,
  INDEX `fk_datosDeNacimiento_municipiosCatalogo1_idx` (`municipiosCatalogo_municipioId` ASC) ,
  CONSTRAINT `fk_datosDeNacimiento_actores1`
    FOREIGN KEY (`actores_actorId` )
    REFERENCES `idheasIkari`.`actores` (`actorId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_datosDeNacimiento_paisesCatalogo1`
    FOREIGN KEY (`paisesCatalogo_paisId` )
    REFERENCES `idheasIkari`.`paisesCatalogo` (`paisId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_datosDeNacimiento_estadosCatalogo1`
    FOREIGN KEY (`estadosCatalogo_estadoId` )
    REFERENCES `idheasIkari`.`estadosCatalogo` (`estadoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_datosDeNacimiento_municipiosCatalogo1`
    FOREIGN KEY (`municipiosCatalogo_municipioId` )
    REFERENCES `idheasIkari`.`municipiosCatalogo` (`municipioId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`alias`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`alias` (
  `aliasId` INT NOT NULL AUTO_INCREMENT ,
  `alias` VARCHAR(20) NULL ,
  `actores_actorId` INT NOT NULL ,
  PRIMARY KEY (`aliasId`) ,
  INDEX `fk_alias_actores1_idx` (`actores_actorId` ASC) ,
  CONSTRAINT `fk_alias_actores1`
    FOREIGN KEY (`actores_actorId` )
    REFERENCES `idheasIkari`.`actores` (`actorId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`infoContacto`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`infoContacto` (
  `telefono` VARCHAR(20) NULL ,
  `telefonoMovil` VARCHAR(30) NULL ,
  `correoE` VARCHAR(40) NULL ,
  `fax` VARCHAR(40) NULL ,
  `actores_actorId` INT NOT NULL ,
  INDEX `fk_infoContacto_actores1_idx` (`actores_actorId` ASC) ,
  UNIQUE INDEX `actores_actorId_UNIQUE` (`actores_actorId` ASC) ,
  CONSTRAINT `fk_infoContacto_actores1`
    FOREIGN KEY (`actores_actorId` )
    REFERENCES `idheasIkari`.`actores` (`actorId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`infoGralActores`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`infoGralActores` (
  `tipoActorColectivoId` INT NULL ,
  `actividad` VARCHAR(100) NULL ,
  `paginaWeb` VARCHAR(150) NULL ,
  `actores_actorId` INT NOT NULL ,
  INDEX `fk_infoGralActores_actores1_idx` (`actores_actorId` ASC) ,
  UNIQUE INDEX `actores_actorId_UNIQUE` (`actores_actorId` ASC) ,
  CONSTRAINT `fk_infoGralActores_actores1`
    FOREIGN KEY (`actores_actorId` )
    REFERENCES `idheasIkari`.`actores` (`actorId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`casos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`casos` (
  `casoId` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(50) NOT NULL ,
  `personasAfectadas` INT NULL ,
  `fechaInicial` DATE NULL ,
  `fechaTermino` DATE NULL ,
  `estadoActivo` TINYINT(1) NULL DEFAULT 1 ,
  PRIMARY KEY (`casoId`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`nivelConfiabilidadCatalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`nivelConfiabilidadCatalogo` (
  `nivelConfiabilidadId` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `notas` VARCHAR(45) NULL ,
  PRIMARY KEY (`nivelConfiabilidadId`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`idiomaCatalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`idiomaCatalogo` (
  `idiomaId` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(45) NULL ,
  PRIMARY KEY (`idiomaId`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`infoAdicional`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`infoAdicional` (
  `nombreFuente` VARCHAR(40) NULL ,
  `descripcion` VARCHAR(3000) NULL ,
  `infoAdicionalFuenteDocumental` VARCHAR(3000) NULL ,
  `fechaPublicacion` DATE NULL ,
  `tipofuenteId` INT NULL ,
  `url` VARCHAR(150) NULL ,
  `fechaAcceso` DATE NULL ,
  `comentarios` VARCHAR(3000) NULL ,
  `observaciones` VARCHAR(3000) NULL ,
  `casos_casoId` INT NOT NULL ,
  `nivelConfiabilidadCatalogo_nivelConfiabilidadId` INT NOT NULL ,
  `idiomaCatalogo_idiomaId` INT NOT NULL ,
  INDEX `fk_infoAdicional_casos1_idx` (`casos_casoId` ASC) ,
  INDEX `fk_infoAdicional_nivelConfiabilidadCatalogo1_idx` (`nivelConfiabilidadCatalogo_nivelConfiabilidadId` ASC) ,
  INDEX `fk_infoAdicional_idiomaCatalogo1_idx` (`idiomaCatalogo_idiomaId` ASC) ,
  CONSTRAINT `fk_infoAdicional_casos1`
    FOREIGN KEY (`casos_casoId` )
    REFERENCES `idheasIkari`.`casos` (`casoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_infoAdicional_nivelConfiabilidadCatalogo1`
    FOREIGN KEY (`nivelConfiabilidadCatalogo_nivelConfiabilidadId` )
    REFERENCES `idheasIkari`.`nivelConfiabilidadCatalogo` (`nivelConfiabilidadId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_infoAdicional_idiomaCatalogo1`
    FOREIGN KEY (`idiomaCatalogo_idiomaId` )
    REFERENCES `idheasIkari`.`idiomaCatalogo` (`idiomaId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`intervenciones`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`intervenciones` (
  `intervencionId` INT NOT NULL AUTO_INCREMENT ,
  `tipoIntervencionId` INT NULL ,
  `IntervencionNId` INT NULL ,
  `fecha` DATE NULL ,
  `impacto` VARCHAR(3000) NULL ,
  `respuesta` VARCHAR(3000) NULL ,
  `interventorId` INT NULL ,
  `receptorId` INT NULL ,
  `casos_casoId` INT NOT NULL ,
  PRIMARY KEY (`intervencionId`) ,
  INDEX `fk_intervenciones_casos1_idx` (`casos_casoId` ASC) ,
  CONSTRAINT `fk_intervenciones_casos1`
    FOREIGN KEY (`casos_casoId` )
    REFERENCES `idheasIkari`.`casos` (`casoId` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`intervenidos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`intervenidos` (
  `intervenidoId` INT NOT NULL ,
  `relacionId` INT NULL ,
  `tipoRelacionId` INT NULL ,
  `comentarios` VARCHAR(3000) NULL ,
  `observaciones` VARCHAR(3000) NULL ,
  `intervenciones_intervencionId` INT NOT NULL ,
  INDEX `fk_intervenidos_intervenciones1_idx` (`intervenciones_intervencionId` ASC) ,
  PRIMARY KEY (`intervenidoId`) ,
  CONSTRAINT `fk_intervenidos_intervenciones1`
    FOREIGN KEY (`intervenciones_intervencionId` )
    REFERENCES `idheasIkari`.`intervenciones` (`intervencionId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`fuenteInfoPersonal`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`fuenteInfoPersonal` (
  `caosId` INT NOT NULL ,
  `actorId` INT NULL ,
  `tipoFuenteId` INT NULL ,
  `fecha` DATE NULL ,
  `idiomaId` INT NULL ,
  `nivelConfiabilidadId` INT NULL ,
  `actorRepotado` INT NULL )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`nucleoCaso`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`nucleoCaso` (
  `fechaInicio` DATE NULL ,
  `fechaTermino` DATE NULL ,
  `noPersonasAfectadas` INT NULL ,
  `casos_casoId` INT NOT NULL ,
  `municipiosCatalogo_municipioId` INT NOT NULL ,
  `estadosCatalogo_estadoId` INT NOT NULL ,
  `paisesCatalogo_paisId` INT NOT NULL ,
  INDEX `fk_nucleoCaso_casos1_idx` (`casos_casoId` ASC) ,
  INDEX `fk_nucleoCaso_municipiosCatalogo1_idx` (`municipiosCatalogo_municipioId` ASC) ,
  INDEX `fk_nucleoCaso_estadosCatalogo1_idx` (`estadosCatalogo_estadoId` ASC) ,
  INDEX `fk_nucleoCaso_paisesCatalogo1_idx` (`paisesCatalogo_paisId` ASC) ,
  CONSTRAINT `fk_nucleoCaso_casos1`
    FOREIGN KEY (`casos_casoId` )
    REFERENCES `idheasIkari`.`casos` (`casoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nucleoCaso_municipiosCatalogo1`
    FOREIGN KEY (`municipiosCatalogo_municipioId` )
    REFERENCES `idheasIkari`.`municipiosCatalogo` (`municipioId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nucleoCaso_estadosCatalogo1`
    FOREIGN KEY (`estadosCatalogo_estadoId` )
    REFERENCES `idheasIkari`.`estadosCatalogo` (`estadoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nucleoCaso_paisesCatalogo1`
    FOREIGN KEY (`paisesCatalogo_paisId` )
    REFERENCES `idheasIkari`.`paisesCatalogo` (`paisId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`lugares`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`lugares` (
  `lugarId` INT NOT NULL AUTO_INCREMENT ,
  `casos_casoId` INT NOT NULL ,
  `paisesCatalogo_paisId` INT NOT NULL ,
  `estadosCatalogo_estadoId` INT NOT NULL ,
  `municipiosCatalogo_municipioId` INT NOT NULL ,
  INDEX `fk_lugares_casos1_idx` (`casos_casoId` ASC) ,
  INDEX `fk_lugares_paisesCatalogo1_idx` (`paisesCatalogo_paisId` ASC) ,
  INDEX `fk_lugares_estadosCatalogo1_idx` (`estadosCatalogo_estadoId` ASC) ,
  INDEX `fk_lugares_municipiosCatalogo1_idx` (`municipiosCatalogo_municipioId` ASC) ,
  PRIMARY KEY (`lugarId`) ,
  CONSTRAINT `fk_lugares_casos1`
    FOREIGN KEY (`casos_casoId` )
    REFERENCES `idheasIkari`.`casos` (`casoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lugares_paisesCatalogo1`
    FOREIGN KEY (`paisesCatalogo_paisId` )
    REFERENCES `idheasIkari`.`paisesCatalogo` (`paisId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lugares_estadosCatalogo1`
    FOREIGN KEY (`estadosCatalogo_estadoId` )
    REFERENCES `idheasIkari`.`estadosCatalogo` (`estadoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lugares_municipiosCatalogo1`
    FOREIGN KEY (`municipiosCatalogo_municipioId` )
    REFERENCES `idheasIkari`.`municipiosCatalogo` (`municipioId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`fichas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`fichas` (
  `fichaId` INT NOT NULL AUTO_INCREMENT ,
  `titulo` VARCHAR(100) NULL ,
  `fecha` DATE NULL ,
  `comentarios` VARCHAR(3000) NULL ,
  `casos_casoId` INT NOT NULL ,
  PRIMARY KEY (`fichaId`) ,
  INDEX `fk_fichas_casos1_idx` (`casos_casoId` ASC) ,
  CONSTRAINT `fk_fichas_casos1`
    FOREIGN KEY (`casos_casoId` )
    REFERENCES `idheasIkari`.`casos` (`casoId` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`infoMigratoria`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`infoMigratoria` (
  `actores_actorId` INT NOT NULL ,
  `paisTransitoId` INT NULL ,
  `paisDestinoId` INT NULL ,
  `intCruceDestino` INT NULL ,
  `intCruceTransito` INT NULL ,
  `expCruceDestino` INT NULL ,
  `expCruceTransito` INT NULL ,
  `motivoViaje` VARCHAR(40) NULL ,
  `tipoEstanciaId` INT NULL ,
  `realizaViaje` ENUM('Solo','Acompanado') NULL ,
  `comentarios` VARCHAR(3000) NULL ,
  PRIMARY KEY (`actores_actorId`) ,
  CONSTRAINT `fk_infoMigratoria_actores1`
    FOREIGN KEY (`actores_actorId` )
    REFERENCES `idheasIkari`.`actores` (`actorId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`registro`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`registro` (
  `nombreRegistro` VARCHAR(1500) NULL ,
  `fichas_fichaId` INT NOT NULL ,
  INDEX `fk_registro_fichas1_idx` (`fichas_fichaId` ASC) ,
  CONSTRAINT `fk_registro_fichas1`
    FOREIGN KEY (`fichas_fichaId` )
    REFERENCES `idheasIkari`.`fichas` (`fichaId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`infoCaso`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`infoCaso` (
  `casos_casoId` INT NOT NULL ,
  `descripcion` VARCHAR(3000) NULL ,
  `resumen` VARCHAR(3000) NULL ,
  `observaciones` VARCHAR(3000) NULL ,
  PRIMARY KEY (`casos_casoId`) ,
  UNIQUE INDEX `casos_casoId_UNIQUE` (`casos_casoId` ASC) ,
  CONSTRAINT `fk_infoCaso_casos1`
    FOREIGN KEY (`casos_casoId` )
    REFERENCES `idheasIkari`.`casos` (`casoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`relacionCasos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`relacionCasos` (
  `relacionId` INT NOT NULL ,
  `tipoRelacionId` INT NULL ,
  `casoIdB` INT NULL ,
  `comentarios` VARCHAR(3000) NULL ,
  `observaciones` VARCHAR(3000) NULL ,
  `casos_casoId` INT NOT NULL ,
  PRIMARY KEY (`relacionId`) ,
  INDEX `fk_relacionCasos_casos1_idx` (`casos_casoId` ASC) ,
  CONSTRAINT `fk_relacionCasos_casos1`
    FOREIGN KEY (`casos_casoId` )
    REFERENCES `idheasIkari`.`casos` (`casoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`casoActor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`casoActor` (
  `actores_actorId` INT NOT NULL ,
  `casos_casoId` INT NOT NULL ,
  `tipoRelacionId` INT NULL ,
  PRIMARY KEY (`actores_actorId`, `casos_casoId`) ,
  INDEX `fk_actores_has_casos_casos1_idx` (`casos_casoId` ASC) ,
  INDEX `fk_actores_has_casos_actores1_idx` (`actores_actorId` ASC) ,
  CONSTRAINT `fk_actores_has_casos_actores1`
    FOREIGN KEY (`actores_actorId` )
    REFERENCES `idheasIkari`.`actores` (`actorId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_actores_has_casos_casos1`
    FOREIGN KEY (`casos_casoId` )
    REFERENCES `idheasIkari`.`casos` (`casoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`actos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`actos` (
  `actoId` INT NOT NULL AUTO_INCREMENT ,
  `actoViolatorioId` INT NULL ,
  `actoViolatorioNivel` INT NULL ,
  `casos_casoId` INT NOT NULL ,
  PRIMARY KEY (`actoId`) ,
  INDEX `fk_actos_casos1_idx` (`casos_casoId` ASC) ,
  CONSTRAINT `fk_actos_casos1`
    FOREIGN KEY (`casos_casoId` )
    REFERENCES `idheasIkari`.`casos` (`casoId` )
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`derechoAfectado`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`derechoAfectado` (
  `derechoAfectadoCasoId` INT NOT NULL AUTO_INCREMENT ,
  `fechaInicial` DATE NULL ,
  `fechaTermino` DATE NULL ,
  `noVictimas` INT NULL ,
  `actos_actoId` INT NOT NULL ,
  INDEX `fk_derechoAfectado_actos1_idx` (`actos_actoId` ASC) ,
  PRIMARY KEY (`derechoAfectadoCasoId`) ,
  CONSTRAINT `fk_derechoAfectado_actos1`
    FOREIGN KEY (`actos_actoId` )
    REFERENCES `idheasIkari`.`actos` (`actoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`tipoActorColectivo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`tipoActorColectivo` (
  `tipoActorColectivoId` INT NOT NULL ,
  `descripcion` VARCHAR(60) NULL ,
  `notas` VARCHAR(1500) NULL ,
  PRIMARY KEY (`tipoActorColectivoId`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`relacionActoresCatalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`relacionActoresCatalogo` (
  `tipoRelacionId` INT NOT NULL ,
  `nombre` VARCHAR(45) NULL ,
  `descripcion` VARCHAR(1500) NULL ,
  `nivel2` VARCHAR(1500) NULL ,
  `notas` VARCHAR(1500) NULL ,
  `tipoDeRelacionId` VARCHAR(45) NULL ,
  PRIMARY KEY (`tipoRelacionId`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`victimas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`victimas` (
  `actorId` INT NOT NULL ,
  `estatusVictimaId` INT NULL ,
  `comentarios` VARCHAR(3000) NULL ,
  `actos_actoId` INT NOT NULL ,
  PRIMARY KEY (`actorId`) ,
  INDEX `fk_victimas_actos1_idx` (`actos_actoId` ASC) ,
  CONSTRAINT `fk_victimas_actos1`
    FOREIGN KEY (`actos_actoId` )
    REFERENCES `idheasIkari`.`actos` (`actoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`estatusPerpetradorCatalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`estatusPerpetradorCatalogo` (
  `estatusPerpetradorId` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(60) NULL ,
  `notas` VARCHAR(3000) NULL ,
  PRIMARY KEY (`estatusPerpetradorId`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`perpetradores`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`perpetradores` (
  `perpetradorId` INT NOT NULL ,
  `tipoPerpetradorId` INT NULL ,
  `tipoPerpetradorNivel` INT NULL ,
  `tipoLugarId` INT NULL ,
  `gradoInvolucramientoid` INT NULL ,
  `nivelInvolugramientoId` INT NULL ,
  `estatusPerpetradorCatalogo_estatusPerpetradorId` INT NOT NULL ,
  `victimas_actorId` INT NOT NULL ,
  PRIMARY KEY (`perpetradorId`) ,
  INDEX `fk_perpetradorCaso_estatusPerpetradorCatalogo1_idx` (`estatusPerpetradorCatalogo_estatusPerpetradorId` ASC) ,
  INDEX `fk_perpetradores_victimas1_idx` (`victimas_actorId` ASC) ,
  CONSTRAINT `fk_perpetradorCaso_estatusPerpetradorCatalogo1`
    FOREIGN KEY (`estatusPerpetradorCatalogo_estatusPerpetradorId` )
    REFERENCES `idheasIkari`.`estatusPerpetradorCatalogo` (`estatusPerpetradorId` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_perpetradores_victimas1`
    FOREIGN KEY (`victimas_actorId` )
    REFERENCES `idheasIkari`.`victimas` (`actorId` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`actosPerpetrador`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`actosPerpetrador` (
  `actorId` INT NOT NULL ,
  `ubicacion` VARCHAR(3000) NULL ,
  `tipoLugarId` INT NULL ,
  `nivelTipoLugarId` INT NULL ,
  `actoId` INT NULL ,
  `actoNId` INT NULL ,
  `paisesCatalogo_paisId` INT NOT NULL ,
  `estadosCatalogo_estadoId` INT NOT NULL ,
  `municipiosCatalogo_municipioId` INT NOT NULL ,
  `perpetradores_perpetradorId` INT NOT NULL ,
  PRIMARY KEY (`actorId`) ,
  INDEX `fk_actosPerpetrador_paisesCatalogo1_idx` (`paisesCatalogo_paisId` ASC) ,
  INDEX `fk_actosPerpetrador_estadosCatalogo1_idx` (`estadosCatalogo_estadoId` ASC) ,
  INDEX `fk_actosPerpetrador_municipiosCatalogo1_idx` (`municipiosCatalogo_municipioId` ASC) ,
  INDEX `fk_actosPerpetrador_perpetradores1_idx` (`perpetradores_perpetradorId` ASC) ,
  CONSTRAINT `fk_actosPerpetrador_paisesCatalogo1`
    FOREIGN KEY (`paisesCatalogo_paisId` )
    REFERENCES `idheasIkari`.`paisesCatalogo` (`paisId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_actosPerpetrador_estadosCatalogo1`
    FOREIGN KEY (`estadosCatalogo_estadoId` )
    REFERENCES `idheasIkari`.`estadosCatalogo` (`estadoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_actosPerpetrador_municipiosCatalogo1`
    FOREIGN KEY (`municipiosCatalogo_municipioId` )
    REFERENCES `idheasIkari`.`municipiosCatalogo` (`municipioId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_actosPerpetrador_perpetradores1`
    FOREIGN KEY (`perpetradores_perpetradorId` )
    REFERENCES `idheasIkari`.`perpetradores` (`perpetradorId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`estatusVictimaCatalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`estatusVictimaCatalogo` (
  `estatusVictimaId` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(60) NULL ,
  `notas` VARCHAR(1500) NULL ,
  PRIMARY KEY (`estatusVictimaId`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`actosN1Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`actosN1Catalogo` (
  `actoId` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `notas` VARCHAR(3000) NULL ,
  PRIMARY KEY (`actoId`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`actosN2Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`actosN2Catalogo` (
  `actoN2Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `notas` VARCHAR(3000) NULL ,
  `actosN1Catalogo_actoId` INT NOT NULL ,
  PRIMARY KEY (`actoN2Id`) ,
  INDEX `fk_actosN2Catalogo_actosN1Catalogo1_idx` (`actosN1Catalogo_actoId` ASC) ,
  CONSTRAINT `fk_actosN2Catalogo_actosN1Catalogo1`
    FOREIGN KEY (`actosN1Catalogo_actoId` )
    REFERENCES `idheasIkari`.`actosN1Catalogo` (`actoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`actosN3Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`actosN3Catalogo` (
  `actoN3Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `notas` VARCHAR(3000) NULL ,
  `actosN2Catalogo_actoN2Id` INT NOT NULL ,
  PRIMARY KEY (`actoN3Id`) ,
  INDEX `fk_actosN3Catalogo_actosN2Catalogo1_idx` (`actosN2Catalogo_actoN2Id` ASC) ,
  CONSTRAINT `fk_actosN3Catalogo_actosN2Catalogo1`
    FOREIGN KEY (`actosN2Catalogo_actoN2Id` )
    REFERENCES `idheasIkari`.`actosN2Catalogo` (`actoN2Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`actosN4Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`actosN4Catalogo` (
  `actoN4Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `notas` VARCHAR(3000) NULL ,
  `actosN3Catalogo_actoN3Id` INT NOT NULL ,
  PRIMARY KEY (`actoN4Id`) ,
  INDEX `fk_actosN4Catalogo_actosN3Catalogo1_idx` (`actosN3Catalogo_actoN3Id` ASC) ,
  CONSTRAINT `fk_actosN4Catalogo_actosN3Catalogo1`
    FOREIGN KEY (`actosN3Catalogo_actoN3Id` )
    REFERENCES `idheasIkari`.`actosN3Catalogo` (`actoN3Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`tipoLugarN1Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`tipoLugarN1Catalogo` (
  `tipoLugarId` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  PRIMARY KEY (`tipoLugarId`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`tipoLugarN2Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`tipoLugarN2Catalogo` (
  `tipoLugarN2Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `tipoLugarN1Catalogo_tipoLugarId` INT NOT NULL ,
  PRIMARY KEY (`tipoLugarN2Id`) ,
  INDEX `fk_tipoLugarN2Catalogo_tipoLugarN1Catalogo1_idx` (`tipoLugarN1Catalogo_tipoLugarId` ASC) ,
  CONSTRAINT `fk_tipoLugarN2Catalogo_tipoLugarN1Catalogo1`
    FOREIGN KEY (`tipoLugarN1Catalogo_tipoLugarId` )
    REFERENCES `idheasIkari`.`tipoLugarN1Catalogo` (`tipoLugarId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`tipoLugarN3Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`tipoLugarN3Catalogo` (
  `tipoLugarN3Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `tipoLugarN2Catalogo_tipoLugarN2Id` INT NOT NULL ,
  PRIMARY KEY (`tipoLugarN3Id`) ,
  INDEX `fk_tipoLugarN3Catalogo_tipoLugarN2Catalogo1_idx` (`tipoLugarN2Catalogo_tipoLugarN2Id` ASC) ,
  CONSTRAINT `fk_tipoLugarN3Catalogo_tipoLugarN2Catalogo1`
    FOREIGN KEY (`tipoLugarN2Catalogo_tipoLugarN2Id` )
    REFERENCES `idheasIkari`.`tipoLugarN2Catalogo` (`tipoLugarN2Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`relacionActores`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`relacionActores` (
  `relacionActoresIdId` INT NOT NULL AUTO_INCREMENT ,
  `actorRelacionadoId` INT NULL ,
  `tipoRelacionIndividualColectivoId` INT NULL ,
  `tipoRelacionId` INT NOT NULL ,
  `actores_actorId` INT NOT NULL ,
  `fechaInicial` DATE NULL ,
  `fechaTermino` DATE NULL ,
  PRIMARY KEY (`relacionActoresIdId`) ,
  INDEX `fk_relacionActores_actores1_idx` (`actores_actorId` ASC) ,
  INDEX `fk_relacionActores_relacionActoresCatalogo1_idx` (`tipoRelacionId` ASC) ,
  CONSTRAINT `fk_relacionActores_actores1`
    FOREIGN KEY (`actores_actorId` )
    REFERENCES `idheasIkari`.`actores` (`actorId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_relacionActores_relacionActoresCatalogo1`
    FOREIGN KEY (`tipoRelacionId` )
    REFERENCES `idheasIkari`.`relacionActoresCatalogo` (`tipoRelacionId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`casos_has_actores`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`casos_has_actores` (
  `casos_casoId` INT NOT NULL ,
  `actores_actorId` INT NOT NULL ,
  PRIMARY KEY (`casos_casoId`, `actores_actorId`) ,
  INDEX `fk_casos_has_actores_actores1_idx` (`actores_actorId` ASC) ,
  INDEX `fk_casos_has_actores_casos1_idx` (`casos_casoId` ASC) ,
  CONSTRAINT `fk_casos_has_actores_casos1`
    FOREIGN KEY (`casos_casoId` )
    REFERENCES `idheasIkari`.`casos` (`casoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_casos_has_actores_actores1`
    FOREIGN KEY (`actores_actorId` )
    REFERENCES `idheasIkari`.`actores` (`actorId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`tipoFuenteCatalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`tipoFuenteCatalogo` (
  `tipoFuenteId` INT NOT NULL ,
  `descripcion` VARCHAR(45) NULL ,
  `notas` VARCHAR(1500) NULL ,
  `selectorTipoFuente` VARCHAR(45) NULL ,
  PRIMARY KEY (`tipoFuenteId`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`tipoIntervencionN1Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`tipoIntervencionN1Catalogo` (
  `tipoIntervencionN1Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  PRIMARY KEY (`tipoIntervencionN1Id`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`tipoIntervencionN2Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`tipoIntervencionN2Catalogo` (
  `tipoIntervencionN2Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `tipoIntervencionN1Catalogo_tipoIntervencionN1Id` INT NOT NULL ,
  PRIMARY KEY (`tipoIntervencionN2Id`) ,
  INDEX `fk_tipoIntervencionN2Catalogo_tipoIntervencionN1Catalogo1_idx` (`tipoIntervencionN1Catalogo_tipoIntervencionN1Id` ASC) ,
  CONSTRAINT `fk_tipoIntervencionN2Catalogo_tipoIntervencionN1Catalogo1`
    FOREIGN KEY (`tipoIntervencionN1Catalogo_tipoIntervencionN1Id` )
    REFERENCES `idheasIkari`.`tipoIntervencionN1Catalogo` (`tipoIntervencionN1Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`tipoIntervencionN3Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`tipoIntervencionN3Catalogo` (
  `tipoIntervencionN3Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `tipoIntervencionN2Catalogo_tipoIntervencionN2Id` INT NOT NULL ,
  PRIMARY KEY (`tipoIntervencionN3Id`) ,
  INDEX `fk_tipoIntervencionN3Catalogo_tipoIntervencionN2Catalogo1_idx` (`tipoIntervencionN2Catalogo_tipoIntervencionN2Id` ASC) ,
  CONSTRAINT `fk_tipoIntervencionN3Catalogo_tipoIntervencionN2Catalogo1`
    FOREIGN KEY (`tipoIntervencionN2Catalogo_tipoIntervencionN2Id` )
    REFERENCES `idheasIkari`.`tipoIntervencionN2Catalogo` (`tipoIntervencionN2Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`tipoIntervencionN4Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`tipoIntervencionN4Catalogo` (
  `tipoIntervencionN4Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `tipoIntervencionN3Catalogo_tipoIntervencionN3Id` INT NOT NULL ,
  PRIMARY KEY (`tipoIntervencionN4Id`) ,
  INDEX `fk_tipoIntervencionN4Catalogo_tipoIntervencionN3Catalogo1_idx` (`tipoIntervencionN3Catalogo_tipoIntervencionN3Id` ASC) ,
  CONSTRAINT `fk_tipoIntervencionN4Catalogo_tipoIntervencionN3Catalogo1`
    FOREIGN KEY (`tipoIntervencionN3Catalogo_tipoIntervencionN3Id` )
    REFERENCES `idheasIkari`.`tipoIntervencionN3Catalogo` (`tipoIntervencionN3Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`direccionActor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`direccionActor` (
  `direccionId` INT NOT NULL AUTO_INCREMENT ,
  `direccion` VARCHAR(200) NULL ,
  `tipoDireccionId` INT NULL ,
  `actores_actorId` INT NOT NULL ,
  `paisesCatalogo_paisId` INT NOT NULL ,
  `estadosCatalogo_estadoId` INT NOT NULL ,
  `municipiosCatalogo_municipioId` INT NOT NULL ,
  PRIMARY KEY (`direccionId`) ,
  INDEX `fk_direccionActor_actores1_idx` (`actores_actorId` ASC) ,
  INDEX `fk_direccionActor_paisesCatalogo1_idx` (`paisesCatalogo_paisId` ASC) ,
  INDEX `fk_direccionActor_estadosCatalogo1_idx` (`estadosCatalogo_estadoId` ASC) ,
  INDEX `fk_direccionActor_municipiosCatalogo1_idx` (`municipiosCatalogo_municipioId` ASC) ,
  CONSTRAINT `fk_direccionActor_actores1`
    FOREIGN KEY (`actores_actorId` )
    REFERENCES `idheasIkari`.`actores` (`actorId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_direccionActor_paisesCatalogo1`
    FOREIGN KEY (`paisesCatalogo_paisId` )
    REFERENCES `idheasIkari`.`paisesCatalogo` (`paisId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_direccionActor_estadosCatalogo1`
    FOREIGN KEY (`estadosCatalogo_estadoId` )
    REFERENCES `idheasIkari`.`estadosCatalogo` (`estadoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_direccionActor_municipiosCatalogo1`
    FOREIGN KEY (`municipiosCatalogo_municipioId` )
    REFERENCES `idheasIkari`.`municipiosCatalogo` (`municipioId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`actorReportado`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`actorReportado` (
  `actorId` INT NOT NULL ,
  `intervenciones_intervencionId` INT NOT NULL ,
  PRIMARY KEY (`actorId`) ,
  INDEX `fk_actorReportado_intervenciones1_idx` (`intervenciones_intervencionId` ASC) ,
  CONSTRAINT `fk_actorReportado_intervenciones1`
    FOREIGN KEY (`intervenciones_intervencionId` )
    REFERENCES `idheasIkari`.`intervenciones` (`intervencionId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`derechosAfectadosN1Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`derechosAfectadosN1Catalogo` (
  `derechoAfectadoN1Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `notas` VARCHAR(3000) NULL ,
  PRIMARY KEY (`derechoAfectadoN1Id`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`derechosAfectadosN2Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`derechosAfectadosN2Catalogo` (
  `derechoAfectadoN2Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `notas` VARCHAR(3000) NULL ,
  `derechosAfectadosN1Catalogo_derechoAfectadoN1Id` INT NOT NULL ,
  PRIMARY KEY (`derechoAfectadoN2Id`) ,
  INDEX `fk_derechosAfectadosN2Catalogo_derechosAfectadosN1Catalogo1_idx` (`derechosAfectadosN1Catalogo_derechoAfectadoN1Id` ASC) ,
  CONSTRAINT `fk_derechosAfectadosN2Catalogo_derechosAfectadosN1Catalogo1`
    FOREIGN KEY (`derechosAfectadosN1Catalogo_derechoAfectadoN1Id` )
    REFERENCES `idheasIkari`.`derechosAfectadosN1Catalogo` (`derechoAfectadoN1Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`derechosAfectadosN3Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`derechosAfectadosN3Catalogo` (
  `derechoAfectadoN3Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `notas` VARCHAR(3000) NULL ,
  `derechosAfectadosN2Catalogo_derechoAfectadoN2Id` INT NOT NULL ,
  PRIMARY KEY (`derechoAfectadoN3Id`) ,
  INDEX `fk_derechosAfectadosN3Catalogo_derechosAfectadosN2Catalogo1_idx` (`derechosAfectadosN2Catalogo_derechoAfectadoN2Id` ASC) ,
  CONSTRAINT `fk_derechosAfectadosN3Catalogo_derechosAfectadosN2Catalogo1`
    FOREIGN KEY (`derechosAfectadosN2Catalogo_derechoAfectadoN2Id` )
    REFERENCES `idheasIkari`.`derechosAfectadosN2Catalogo` (`derechoAfectadoN2Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`derechosAfectadosN4Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`derechosAfectadosN4Catalogo` (
  `derechoAfectadoN4Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `notas` VARCHAR(3000) NULL ,
  `derechosAfectadosN3Catalogo_derechoAfectadoN3Id` INT NOT NULL ,
  PRIMARY KEY (`derechoAfectadoN4Id`) ,
  INDEX `fk_derechosAfectadosN4Catalogo_derechosAfectadosN3Catalogo1_idx` (`derechosAfectadosN3Catalogo_derechoAfectadoN3Id` ASC) ,
  CONSTRAINT `fk_derechosAfectadosN4Catalogo_derechosAfectadosN3Catalogo1`
    FOREIGN KEY (`derechosAfectadosN3Catalogo_derechoAfectadoN3Id` )
    REFERENCES `idheasIkari`.`derechosAfectadosN3Catalogo` (`derechoAfectadoN3Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`actosN1Catalogo_has_derechosAfactadosN1Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`actosN1Catalogo_has_derechosAfactadosN1Catalogo` (
  `actosN1Catalogo_actoId` INT NOT NULL ,
  `derechosAfactadosN1Catalogo_derechoAfectadoN1Id` INT NOT NULL ,
  PRIMARY KEY (`actosN1Catalogo_actoId`, `derechosAfactadosN1Catalogo_derechoAfectadoN1Id`) ,
  INDEX `fk_actosN1Catalogo_has_derechosAfactadosN1Catalogo_derechos_idx` (`derechosAfactadosN1Catalogo_derechoAfectadoN1Id` ASC) ,
  INDEX `fk_actosN1Catalogo_has_derechosAfactadosN1Catalogo_actosN1C_idx` (`actosN1Catalogo_actoId` ASC) ,
  CONSTRAINT `fk_actosN1Catalogo_has_derechosAfactadosN1Catalogo_actosN1Cat1`
    FOREIGN KEY (`actosN1Catalogo_actoId` )
    REFERENCES `idheasIkari`.`actosN1Catalogo` (`actoId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_actosN1Catalogo_has_derechosAfactadosN1Catalogo_derechosAf1`
    FOREIGN KEY (`derechosAfactadosN1Catalogo_derechoAfectadoN1Id` )
    REFERENCES `idheasIkari`.`derechosAfectadosN1Catalogo` (`derechoAfectadoN1Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`gradoInvolucramientoN1Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`gradoInvolucramientoN1Catalogo` (
  `gradoInvolucramientoN1Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `notas` VARCHAR(3000) NULL ,
  PRIMARY KEY (`gradoInvolucramientoN1Id`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`gradoInvolucramientoN2Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`gradoInvolucramientoN2Catalogo` (
  `gradoInvolucramientoN2Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `notas` VARCHAR(300) NULL ,
  `gradoInvolucramientoN1Catalogo_gradoInvolucramientoN1Id` INT NOT NULL ,
  PRIMARY KEY (`gradoInvolucramientoN2Id`) ,
  INDEX `fk_gradoInvolucramientoN2Catalogo_gradoInvolucramientoN1Cat_idx` (`gradoInvolucramientoN1Catalogo_gradoInvolucramientoN1Id` ASC) ,
  CONSTRAINT `fk_gradoInvolucramientoN2Catalogo_gradoInvolucramientoN1Catal1`
    FOREIGN KEY (`gradoInvolucramientoN1Catalogo_gradoInvolucramientoN1Id` )
    REFERENCES `idheasIkari`.`gradoInvolucramientoN1Catalogo` (`gradoInvolucramientoN1Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`tipoPerpetradorN1Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`tipoPerpetradorN1Catalogo` (
  `tipoPerpetradorN1Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `notas` VARCHAR(3000) NULL ,
  PRIMARY KEY (`tipoPerpetradorN1Id`) )
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`tipoPerpetradorN2Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`tipoPerpetradorN2Catalogo` (
  `tipoPerpetradorN2Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `notas` VARCHAR(3000) NULL ,
  `tipoPerpetradorN1Catalogo_tipoPerpetradorN1Id` INT NOT NULL ,
  PRIMARY KEY (`tipoPerpetradorN2Id`) ,
  INDEX `fk_tipoPerpetradorN2Catalogo_tipoPerpetradorN1Catalogo1_idx` (`tipoPerpetradorN1Catalogo_tipoPerpetradorN1Id` ASC) ,
  CONSTRAINT `fk_tipoPerpetradorN2Catalogo_tipoPerpetradorN1Catalogo1`
    FOREIGN KEY (`tipoPerpetradorN1Catalogo_tipoPerpetradorN1Id` )
    REFERENCES `idheasIkari`.`tipoPerpetradorN1Catalogo` (`tipoPerpetradorN1Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`tipoPerpetradorN3Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`tipoPerpetradorN3Catalogo` (
  `tipoPerpetradorN3Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `notas` VARCHAR(3000) NULL ,
  `tipoPerpetradorN2Catalogo_tipoPerpetradorN2Id` INT NOT NULL ,
  PRIMARY KEY (`tipoPerpetradorN3Id`) ,
  INDEX `fk_tipoPerpetradorN3Catalogo_tipoPerpetradorN2Catalogo1_idx` (`tipoPerpetradorN2Catalogo_tipoPerpetradorN2Id` ASC) ,
  CONSTRAINT `fk_tipoPerpetradorN3Catalogo_tipoPerpetradorN2Catalogo1`
    FOREIGN KEY (`tipoPerpetradorN2Catalogo_tipoPerpetradorN2Id` )
    REFERENCES `idheasIkari`.`tipoPerpetradorN2Catalogo` (`tipoPerpetradorN2Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`tipoPerpetradorN4Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`tipoPerpetradorN4Catalogo` (
  `tipoPerpetradorN4Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `notas` VARCHAR(3000) NULL ,
  `tipoPerpetradorN3Catalogo_tipoPerpetradorN3Id` INT NOT NULL ,
  PRIMARY KEY (`tipoPerpetradorN4Id`) ,
  INDEX `fk_tipoPerpetradorN4Catalogo_tipoPerpetradorN3Catalogo1_idx` (`tipoPerpetradorN3Catalogo_tipoPerpetradorN3Id` ASC) ,
  CONSTRAINT `fk_tipoPerpetradorN4Catalogo_tipoPerpetradorN3Catalogo1`
    FOREIGN KEY (`tipoPerpetradorN3Catalogo_tipoPerpetradorN3Id` )
    REFERENCES `idheasIkari`.`tipoPerpetradorN3Catalogo` (`tipoPerpetradorN3Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`tipoPerpetradorN5Catalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`tipoPerpetradorN5Catalogo` (
  `tipoPerpetradorN5Id` INT NOT NULL AUTO_INCREMENT ,
  `descripcion` VARCHAR(100) NULL ,
  `notas` VARCHAR(3000) NULL ,
  `tipoPerpetradorN4Catalogo_tipoPerpetradorN4Id` INT NOT NULL ,
  PRIMARY KEY (`tipoPerpetradorN5Id`) ,
  INDEX `fk_tipoPerpetradorN5Catalogo_tipoPerpetradorN4Catalogo1_idx` (`tipoPerpetradorN4Catalogo_tipoPerpetradorN4Id` ASC) ,
  CONSTRAINT `fk_tipoPerpetradorN5Catalogo_tipoPerpetradorN4Catalogo1`
    FOREIGN KEY (`tipoPerpetradorN4Catalogo_tipoPerpetradorN4Id` )
    REFERENCES `idheasIkari`.`tipoPerpetradorN4Catalogo` (`tipoPerpetradorN4Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `idheasIkari`.`nacionalidadesCatalogo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `idheasIkari`.`nacionalidadesCatalogo` (
  `nacionalidadId` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(60) NULL ,
  `generoNacionalidad` INT NULL ,
  PRIMARY KEY (`nacionalidadId`) )
ENGINE = InnoDB;

SHOW WARNINGS;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
