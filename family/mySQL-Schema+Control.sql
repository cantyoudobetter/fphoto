-- MySQL Database Schema Setup for Family Photo Site
-- Michael Bordelon

-- Table structure for table 'family'
--

CREATE TABLE family (
  familyid int(11) NOT NULL auto_increment,
  description varchar(50) default NULL,
  isactive tinyint(4) NOT NULL default '0',
  secret varchar(25) default NULL,
  secretquestion varchar(255) default NULL,
  authmail varchar(50) NOT NULL default '',
  messageoftheday varchar(255) default NULL,
  backcolor varchar(10) default NULL,
  fontcolor varchar(10) default NULL,
  fontname varchar(10) default NULL,
  PRIMARY KEY  (familyid)
) TYPE=MyISAM;


--
-- Table structure for table 'photo'
--

CREATE TABLE photo (
  photoid int(11) NOT NULL auto_increment,
  sectionid int(11) default NULL,
  photoname varchar(50) default NULL,
  thumbname varchar(50) default NULL,
  sortorder int(10) default NULL,
  PRIMARY KEY  (photoid)
) TYPE=MyISAM;


--
-- Table structure for table 'photonote'
--

CREATE TABLE photonote (
  photonoteid int(11) unsigned NOT NULL auto_increment,
  note varchar(100) NOT NULL default '',
  photoid int(11) unsigned NOT NULL default '0',
  userid int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (photonoteid)
) TYPE=MyISAM;


--
-- Table structure for table 'section'
--

CREATE TABLE section (
  sectionid int(11) NOT NULL auto_increment,
  familyid int(11) default NULL,
  longdescription varchar(255) NOT NULL default '',
  shortdescription varchar(100) NOT NULL default '',
  sortorder int(11) NOT NULL default '0',
  PRIMARY KEY  (sectionid)
) TYPE=MyISAM;

--
-- Table structure for table 'user'
--

CREATE TABLE user (
  userid int(11) NOT NULL auto_increment,
  username varchar(50) default NULL,
  password varchar(50) default NULL,
  usertypeid tinyint(4) NOT NULL default '0',
  name varchar(100) NOT NULL default '',
  email varchar(50) default NULL,
  notify tinyint(4) NOT NULL default '1',
  PRIMARY KEY  (userid)
) TYPE=MyISAM;

--
-- Table structure for table 'userfamilyxref'
--

CREATE TABLE userfamilyxref (
  userid int(11) default NULL,
  familyid int(11) default NULL,
  xrefid int(11) NOT NULL auto_increment,
  PRIMARY KEY  (xrefid)
) TYPE=MyISAM;


--
-- Table structure for table 'usertype'
--

CREATE TABLE usertype (
  usertypeid tinyint(4) NOT NULL default '0',
  description varchar(25) default NULL,
  PRIMARY KEY  (usertypeid)
) TYPE=MyISAM;


INSERT INTO usertype VALUES (0,'admin');
INSERT INTO usertype VALUES (1,'viewer');

