DROP SCHEMA IF EXISTS `Northwind_ETL` ;
CREATE SCHEMA IF NOT EXISTS `Northwind_ETL` DEFAULT CHARACTER SET UTF8MB4 ;
USE `Northwind_ETL` ;

-- -----------------------------------------------------
-- Table `Northwind_ETL`.`Dimension_Date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Northwind_ETL`.`Dimension_Date` (
  `DateDim_id` INT(11) NOT NULL AUTO_INCREMENT,
  `day_date` DATETIME DEFAULT NULL,
  `datestring_long` VARCHAR(50) NULL DEFAULT NULL,
  `weekday_name` VARCHAR(50) NULL DEFAULT NULL,
  `month_name` VARCHAR(50) NULL DEFAULT NULL,
  `day_of_month` Int(11) NULL DEFAULT NULL,
  `day_of_week` Int(11) NULL DEFAULT NULL,
  `day_of_year` Int(11) NULL DEFAULT NULL,
  `number_of_month` Int(11) NULL DEFAULT NULL,
  `week_of_year` Int(11) NULL DEFAULT NULL,
  `year` Int(50) NULL DEFAULT NULL,
  `is_weekend` VARCHAR(10) NULL DEFAULT NULL,
PRIMARY KEY (`DateDim_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = UTF8MB4;

-- -----------------------------------------------------
-- Table `Northwind_ETL`.`Dimension_Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Northwind_ETL`.`Dimension_Customer` (
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
-- Table `Northwind_ETL`.`Dimension_Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Northwind_ETL`.`Dimension_Product` (
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
-- Table `Northwind_ETL`.`Dimension_Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Northwind_ETL`.`Dimension_Employee` (
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
-- Table `Northwind_ETL`.`FactTable_Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Northwind_ETL`.`FactTable_Orders` (
  `FactTable_id` INT(11) NOT NULL AUTO_INCREMENT,
  `order_id` INT(11) NOT NULL,
  `employee_id` INT(11) NOT NULL,
  `customer_id` INT(11) NOT NULL,
  `product_id` INT(11) NOT NULL,
  `orderdate_id` INT(11) DEFAULT NULL,
  `shipdate_id` INT(11) DEFAULT NULL,
  `shipping_fee` decimal(19,4) DEFAULT '0.0000',
  `payment_method` varchar(50) DEFAULT NULL,
  `quantity` INT(11) DEFAULT NULL,
  `discount` decimal(10,4) DEFAULT '0.0000',
  PRIMARY KEY (`FactTable_id`),
  INDEX `customer_id` (`customer_id` ASC),
  INDEX `employee_id` (`employee_id` ASC),
  INDEX `order_id` (`order_id` ASC),
  CONSTRAINT `fk_Factorders_customers`
    FOREIGN KEY (`customer_id`) 
    REFERENCES `Dimension_Customer`(`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factorders_employees`
    FOREIGN KEY (`employee_id`) 
    REFERENCES `Dimension_Employee`(`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factorders_orderdate`
    FOREIGN KEY (`orderdate_id`) 
    REFERENCES `Dimension_Date`(`DateDim_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factorders_products`
    FOREIGN KEY (`product_id`) 
    REFERENCES `Dimension_Product`(`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,  
  CONSTRAINT `fk_Factorders_shipdate`
    FOREIGN KEY (`shipdate_id`) 
    REFERENCES `Dimension_Date`(`DateDim_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION) 
ENGINE=InnoDB 
DEFAULT CHARACTER SET = UTF8MB4;
