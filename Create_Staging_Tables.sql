-- DROP SCHEMA IF EXISTS `Northwind_ETL` ;
-- SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
-- SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
-- SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `Northwind_ETL` DEFAULT CHARACTER SET UTF8MB4 ;

USE `Northwind_ETL` ;

-- -----------------------------------------------------
-- Table `Northwind_ETL`.`staging_customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Northwind_ETL`.`staging_customers` (
  `customer_id` INT(11) NOT NULL,
  `company` VARCHAR(50) NULL DEFAULT NULL,
  `last_name` VARCHAR(50) NULL DEFAULT NULL,
  `first_name` VARCHAR(50) NULL DEFAULT NULL,
  `job_title` VARCHAR(50) NULL DEFAULT NULL,
  `city` VARCHAR(50) NULL DEFAULT NULL,
  `state_province` VARCHAR(50) NULL DEFAULT NULL,
  `country_region` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `city` (`city` ASC),
  INDEX `company` (`company` ASC),
  INDEX `first_name` (`first_name` ASC),
  INDEX `last_name` (`last_name` ASC),
  INDEX `state_province` (`state_province` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;


-- -----------------------------------------------------
-- Table `Northwind_ETL`.`staging_employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Northwind_ETL`.`staging_employees` (
  `employee_id` INT(11) NOT NULL,
  `last_name` VARCHAR(50) NULL DEFAULT NULL,
  `first_name` VARCHAR(50) NULL DEFAULT NULL,
  `job_title` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `first_name` (`first_name` ASC),
  INDEX `last_name` (`last_name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- Table `Northwind_ETL`.`staging_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Northwind_ETL`.`staging_orders` (
  `order_id` INT(11) NOT NULL,
  `employee_id` INT(11) NULL DEFAULT NULL,
  `customer_id` INT(11) NULL DEFAULT NULL,
  `order_date` DATETIME NULL DEFAULT NULL,
  `shipped_date` DATETIME NULL DEFAULT NULL,
  `shipping_fee` DECIMAL(19,4) NULL DEFAULT '0.0000',
  `payment_type` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `customer_id` (`customer_id` ASC),
  INDEX `employee_id` (`employee_id` ASC),
  INDEX `order_id` (`order_id` ASC),
  CONSTRAINT `fk_orders_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Northwind_ETL`.`staging_customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_employees1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Northwind_ETL`.`staging_employees` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;


-- -----------------------------------------------------
-- Table `Northwind_ETL`.`products_staging`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Northwind_ETL`.`staging_products` (
  `product_id` INT(11) NOT NULL,
  `product_code` varchar(25) DEFAULT NULL,
  `product_name` varchar(50) DEFAULT NULL,
  `standard_cost` decimal(19,4) DEFAULT '0.0000',
  `list_price` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`product_id`)) 
ENGINE=InnoDB 
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- Table `Northwind_ETL`.`staging_order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Northwind_ETL`.`staging_order_details` (
  `staging_id` INT(11) NOT NULL,
  `order_id` INT(11) NOT NULL,
  `product_id` INT(11) NULL DEFAULT NULL,
  `quantity` DECIMAL(18,4) NOT NULL DEFAULT '0.0000',
  `unit_price` DECIMAL(19,4) NULL DEFAULT '0.0000',
  `discount` DOUBLE NOT NULL DEFAULT '0',
  PRIMARY KEY (`staging_id`),
  INDEX `staging_id` (`staging_id` ASC),
  INDEX `product_id` (`product_id` ASC),
  INDEX `fk_order_details_orders1` (`order_id` ASC),
  CONSTRAINT `fk_order_details_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `Northwind_ETL`.`staging_orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_details_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `Northwind_ETL`.`staging_products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
