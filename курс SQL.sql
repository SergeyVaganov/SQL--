USE [master]
GO


IF db_id('Project_List') is null
BEGIN
	CREATE DATABASE [Project_List];
END
GO


USE [Project_List];
GO


IF object_id('woker_groups') is not null
BEGIN
	DROP TABLE [dbo].[woker_groups];
END;
GO
IF object_id('progress_task') is not null
BEGIN
	DROP TABLE [dbo].[progress_task];
END;
GO
IF object_id('tasks') is not null
BEGIN
	DROP TABLE [dbo].[tasks];
END;
GO
IF object_id('groups') is not null
BEGIN
	DROP TABLE [dbo].[groups];
END;
GO
IF object_id('progress') is not null
BEGIN
	DROP TABLE [dbo].[progress];
END;
GO
IF object_id('roles') is not null
BEGIN
	DROP TABLE [dbo].[roles];
END;
GO
IF object_id('wokers') is not null
BEGIN
	DROP TABLE [dbo].[wokers];
END;
GO
IF object_id('position') is not null
BEGIN
	DROP TABLE [dbo].[position];
END;
GO
IF object_id('office') is not null
BEGIN
	DROP TABLE [dbo].[office];
END;
GO



IF object_id('seq_position') is null
BEGIN
	CREATE SEQUENCE [dbo].[seq_position]
	AS INT
	START WITH 1 INCREMENT BY 1
END;
GO
IF object_id('seq_office') is null
BEGIN
	CREATE SEQUENCE [dbo].[seq_office]
	AS INT
	START WITH 1 INCREMENT BY 1
END;
GO
IF object_id('seq_wokers') is null
BEGIN
	CREATE SEQUENCE [dbo].[seq_wokers]
	AS INT
	START WITH 1 INCREMENT BY 1
END;
GO
IF object_id('seq_groups') is null
BEGIN
	CREATE SEQUENCE [dbo].[seq_groups]
	AS INT
	START WITH 1 INCREMENT BY 1
END;
GO

IF object_id('seq_roles') is null
BEGIN
	CREATE SEQUENCE [dbo].[seq_roles]
	AS INT
	START WITH 1 INCREMENT BY 1
END;
GO
IF object_id('seq_woker_groups') is null
BEGIN
	CREATE SEQUENCE [dbo].[seq_woker_groups]
	AS INT
	START WITH 1 INCREMENT BY 1
END;
GO
IF object_id('seq_tasks') is null
BEGIN
	CREATE SEQUENCE [dbo].[seq_tasks]
	AS INT
	START WITH 1 INCREMENT BY 1
END;
GO
IF object_id('seq_progress') is null
BEGIN
	CREATE SEQUENCE [dbo].[seq_progress]
	AS INT
	START WITH 1 INCREMENT BY 1
END;
GO
IF object_id('seq_progress_task') is null
BEGIN
	CREATE SEQUENCE [dbo].[seq_progress_task]
	AS INT
	START WITH 1 INCREMENT BY 1
END;
GO




CREATE TABLE [position] (
	id integer NOT NULL PRIMARY KEY,
	name varchar(50) NOT NULL,
)
GO

CREATE TABLE [office] (
	id integer NOT NULL PRIMARY KEY,
	name varchar(50) NOT NULL,
)
GO

 CREATE TABLE [wokers] (
	id integer NOT NULL PRIMARY KEY ,
	Name varchar(50) NOT NULL,
	SurName varchar(50) NOT NULL,
	id_position integer NULL FOREIGN KEY (id_position) REFERENCES position(id) ON UPDATE CASCADE ON DELETE SET NULL,
	id_office integer NULL FOREIGN KEY (id_office) REFERENCES office(id) ON UPDATE CASCADE ON DELETE SET NULL,
	dismissed date NULL default(NULL), 
)
GO

CREATE TABLE [groups] (
	id integer NOT NULL PRIMARY KEY,
	Name varchar(50) NOT NULL,
	id_creator integer NOT NULL FOREIGN KEY (id_creator) REFERENCES wokers(id) ON UPDATE CASCADE,
)
GO

CREATE TABLE [roles] (
	id integer NOT NULL PRIMARY KEY,
	Name varchar(50) NOT NULL,
)
GO

CREATE TABLE [woker_groups] (
	id integer NOT NULL PRIMARY KEY,
	id_woker integer NOT NULL FOREIGN KEY (id_woker) REFERENCES wokers(id),
	id_group integer NOT NULL FOREIGN KEY (id_group) REFERENCES groups(id),
	id_role integer NOT NULL FOREIGN KEY (id_role) REFERENCES roles(id)
)
GO

CREATE TABLE [tasks] (
	id integer NOT NULL PRIMARY KEY,
	Name varchar(50) NOT NULL,
	id_group integer NOT NULL FOREIGN KEY (id_group) REFERENCES groups(id),
	id_creator integer NOT NULL FOREIGN KEY (id_creator) REFERENCES wokers(id),
	start date NOT NULL,
	finish date NOT NULL,
	closed date NULL default (null),
	description varchar(MAX) NULL default (NULL),
)
GO

CREATE TABLE [progress] (
	id integer NOT NULL PRIMARY KEY,
	Name varchar(50) NOT NULL,
)
GO

CREATE TABLE [progress_task] (
	id integer NOT NULL PRIMARY KEY,
	id_task integer NOT NULL FOREIGN KEY (id_task) REFERENCES tasks(id) ON DELETE CASCADE,
	id_woker integer NOT NULL FOREIGN KEY (id_woker) REFERENCES wokers(id),
	start date NOT NULL,
	finish date NOT NULL,
	id_progress integer NOT NULL FOREIGN KEY (id_progress) REFERENCES progress(id),
	closed date NULL default (null),
	description varchar(MAX) NULL default (NULL),
)
GO


