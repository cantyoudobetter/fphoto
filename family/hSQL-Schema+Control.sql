-- HSQL Database Schema Setup for Family Photo Site
-- Michael Bordelon

-- Table structure for table 'family'
--

CREATE TABLE family (
  familyid int(11) NOT NULL IDENTITY,
  description varchar(50),
  isactive tinyint(4) default '0' NOT NULL,
  secret varchar(25),
  secretquestion varchar(255),
  authmail varchar(50) default '' NOT NULL,
  messageoftheday varchar(255),
  backcolor varchar(10),
  fontcolor varchar(10),
  fontname varchar(10) 
);


--
-- Table structure for table 'photo'
--

CREATE TABLE photo (
  photoid int(11) NOT NULL IDENTITY,
  sectionid int(11),
  photoname varchar(50),
  thumbname varchar(50),
  sortorder int(10)
);


--
-- Table structure for table 'photonote'
--

CREATE TABLE photonote (
  photonoteid int(11) NOT NULL IDENTITY,
  note varchar(100) default '' NOT NULL,
  photoid int(11) default '0' NOT NULL,
  userid int(11)  default '0' NOT NULL
) ;


--
-- Table structure for table 'section'
--

CREATE TABLE section (
  sectionid int(11) NOT NULL IDENTITY,
  familyid int(11) ,
  longdescription varchar(255) default '' NOT NULL,
  shortdescription varchar(100) default '' NOT NULL,
  sortorder int(11)  default '0' NOT NULL
) ;

--
-- Table structure for table 'user'
--

CREATE TABLE user (
  userid int(11) NOT NULL IDENTITY,
  username varchar(50) ,
  password varchar(50) ,
  usertypeid tinyint(4) default '0' NOT NULL,
  name varchar(100) default '' NOT NULL,
  email varchar(50),
  notify tinyint(4) default '1' NOT NULL
); 
--
-- Table structure for table 'userfamilyxref'
--

CREATE TABLE userfamilyxref (
  userid int(11),
  familyid int(11),
  xrefid int(11) NOT NULL IDENTITY
); 


--
-- Table structure for table 'usertype'
--

CREATE TABLE usertype (
  usertypeid tinyint(4) default '0' NOT NULL,
  description varchar(25)
); 


INSERT INTO usertype VALUES (0,'admin');
INSERT INTO usertype VALUES (1,'viewer');

