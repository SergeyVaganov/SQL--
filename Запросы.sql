--Просмотр таблиц

use [Project_List];
go

IF object_id('WOKER_LIST') is not null
BEGIN
	DROP PROCEDURE [WOKER_LIST];
END;
go

IF object_id('GROUP_STRUCTUR') is not null
BEGIN
	DROP PROCEDURE [GROUP_STRUCTUR];
END;
go

IF object_id('GROUP_LIST') is not null
BEGIN
	DROP PROCEDURE [GROUP_LIST];
END;
go

IF object_id('TASK_ALL_LIST') is not null
BEGIN
	DROP PROCEDURE [TASK_ALL_LIST];
END;
go

IF object_id('TASK_LIST_NOT_CLOSED') is not null
BEGIN
	DROP PROCEDURE [TASK_LIST_NOT_CLOSED];
END;
go

IF object_id('TASK_PROGRESS') is not null
	DROP PROCEDURE  [TASK_PROGRESS];
go

IF object_id('INSERT_GROUP') is not null
	DROP PROCEDURE  [INSERT_GROUP];
go

IF object_id('INSERT_GROUP_STRUCTUR') is not null
	DROP PROCEDURE  [INSERT_GROUP_STRUCTUR];
go

IF object_id('INSERT_TASK') is not null
	DROP PROCEDURE  [INSERT_TASK];
go

IF object_id('INSERT_TASK_WOKER') is not null
	DROP PROCEDURE  [INSERT_TASK_WOKER];
go

IF object_id('INSERT_WOKER') is not null
	DROP PROCEDURE  [INSERT_WOKER];
go

IF object_id('INSERT_POSITION') is not null
	DROP PROCEDURE  [INSERT_POSITION];
go

IF object_id('INSERT_OFFICE') is not null
	DROP PROCEDURE  [INSERT_OFFICE];
go

IF object_id('INSERT_ROLES') is not null
	DROP PROCEDURE  [INSERT_ROLES];
go

IF object_id('INSERT_PROGRESS') is not null
	DROP PROCEDURE  [INSERT_PROGRESS];
go


IF object_id('UPDATE_PROGRESS') is not null
	DROP PROCEDURE [UPDATE_PROGRESS];
go

IF object_id('CLOSED_TASK') is not null
	DROP PROCEDURE [CLOSED_TASK];
go

IF object_id('CLOSED_PROGRESS') is not null
	DROP PROCEDURE [CLOSED_PROGRESS];
go


IF object_id('GROUP_CHANGE_ROLE') is not null
	DROP PROCEDURE [GROUP_CHANGE_ROLE];
go


IF object_id('WOKER_DISSMIS') is not null
	DROP PROCEDURE [WOKER_DISSMIS];
go












CREATE PROCEDURE WOKER_LIST -- Список сотрудников
AS
BEGIN
SELECT w.name +' '+ w.SurName AS 'ФИО', p.name AS 'Должность', o.name AS 'Место работы' 
FROM [dbo].[wokers] AS w
JOIN [dbo].[position] as p ON w.id_position = p.id
JOIN [dbo].[office] as o ON w.id_office =  o.id
END
GO



CREATE PROCEDURE GROUP_STRUCTUR @name_group varchar(50) --Состав групп
AS
BEGIN
SELECT g.name AS 'Имя группы', w.name+' '+w.SurName AS 'ФИО', p.name AS 'Должность', r.name AS 'Роль в группе' 
FROM [dbo].[groups] AS g
JOIN [dbo].[woker_groups] AS wg ON wg.id_group = g.id
JOIN [dbo].[wokers] AS w ON wg.id_woker = w.id
JOIN [dbo].[position] AS p ON w.id_position = p.id
JOIN [dbo].[roles] AS r ON wg.id_role = r.id
WHERE g.name = @name_group
END
GO


CREATE PROCEDURE GROUP_LIST -- Список групп
AS
BEGIN
SELECT g.name AS 'Группа', count (wg.id) AS 'Число участников',
	(SELECT wokers.SurName FROM [dbo].[wokers] WHERE wokers.id = avg(g.id_creator)) AS 'Создал группу',
	(SELECT w_1.SurName FROM [dbo].[wokers] AS w_1 
		JOIN [dbo].[woker_groups] AS wg_1 ON w_1.id = wg_1.id_woker
		JOIN [dbo].[roles] AS r_1 ON r_1.id = wg_1.id_role
		JOIN [dbo].[groups] AS g_1 ON g_1.id = wg_1.id_group 
		WHERE g_1.id = avg(g.id) AND r_1.name = 'Ответственный' 
	) AS  'Ответственный'
FROM[dbo].[groups] AS g 
JOIN [dbo].[woker_groups] AS wg ON wg.id_group = g.id
GROUP BY g.name
END
go



CREATE PROCEDURE TASK_ALL_LIST -- Список всех задач
AS
BEGIN
SELECT t.name AS 'Задача', g.name AS 'Группа', w.name +' '+w.SurName AS 'ФИО ответственного', 
t.start AS 'Дата начала', t.finish AS 'Дата окончания', 
(SELECT wokers.SurName FROM [dbo].[wokers] WHERE wokers.id = t.id_creator) AS 'Создал задачу'
FROM [dbo].[tasks] AS t
JOIN [dbo].[groups] AS g ON t.id_group = g.id
JOIN [dbo].[woker_groups] AS wg ON wg.id_group = g.id
JOIN [dbo].[wokers] AS w ON w.id = wg.id_woker 
JOIN [dbo].[roles] AS r ON r.id = wg.id_role
WHERE r.name = 'Ответственный' AND t.closed is null
END
go

CREATE PROCEDURE TASK_PROGRESS @name_task varchar(50) --Выполнение индивидуальных заданий в задаче
AS
BEGIN
SELECT t.name AS 'Задание', w.name+' '+w.SurName AS 'ФИО сотрудника', p.name AS 'Стадия выполнения', 
tp.start AS 'Дата начала работ', tp.finish AS 'Дата планируемого окончания', tp.closed AS'Дата приёма выполненных работ', 
tp.description AS 'Описание работ'  
FROM [dbo].[tasks] AS t
JOIN [dbo].[progress_task] AS tp ON tp.id_task = t.id
JOIN [dbo].[wokers] AS w ON tp.id_woker = w.id
JOIN [dbo].[progress] AS p ON tp.id_progress = p.id
WHERE t.name = @name_task
END
GO



CREATE PROCEDURE TASK_LIST_NOT_CLOSED -- Список просроченных (не закрытых) задач
AS
BEGIN
SELECT t.name AS 'Задача', g.name AS 'Группа', w.name +' '+w.SurName AS 'ФИО ответственного', 
t.start AS 'Дата начала', t.finish AS 'Дата окончания', 
	(SELECT wokers.SurName FROM [dbo].[wokers] WHERE wokers.id = t.id_creator) AS 'Создал задачу', t.description AS 'Описание'
FROM [dbo].[tasks] AS t
JOIN [dbo].[groups] AS g ON t.id_group = g.id
JOIN [dbo].[woker_groups] AS wg ON wg.id_group = g.id
JOIN [dbo].[wokers] AS w ON w.id = wg.id_woker 
JOIN [dbo].[roles] AS r ON r.id = wg.id_role
WHERE r.name = 'Ответственный' 
AND t.closed is null
AND t.finish<GETDATE()
END
go


CREATE PROCEDURE INSERT_GROUP @name varchar(50), @id_creator int
AS 
BEGIN
INSERT INTO [dbo].[groups] VALUES 
(NEXT VALUE FOR [dbo].[seq_groups], @name, @id_creator )
END
GO

CREATE PROCEDURE INSERT_GROUP_STRUCTUR @id_woker int, @id_group int, @id_role int 
AS 
BEGIN
INSERT INTO [dbo].[woker_groups] VALUES 
(NEXT VALUE FOR [dbo].[seq_woker_groups],@id_woker,@id_group,@id_role)
END
GO

CREATE PROCEDURE INSERT_TASK @name varchar(50), @id_group int, @id_creator int, @start date,
@finish date, @closed date, @description varchar(MAX)
AS 
BEGIN
INSERT INTO [dbo].[tasks] VALUES 
(NEXT VALUE FOR [dbo].[seq_tasks], @name, @id_group, @id_creator,@start, @finish ,@closed, @description)
END
GO

CREATE PROCEDURE INSERT_TASK_WOKER @name varchar(50), @id_task int, @id_woker int, @start date,
@finish date, @id_progress int, @closed date, @description varchar(MAX)
AS 
BEGIN
INSERT INTO [dbo].[progress_task] VALUES 
(NEXT VALUE FOR [dbo].[seq_progress_task],@id_task, @id_woker,@start, @finish,@id_progress, @closed, @description)
END
GO

CREATE PROCEDURE INSERT_WOKER @name varchar(50), @surname varchar(50), @id_position int, @id_office int, @dismissed date
AS 
BEGIN
INSERT INTO [dbo].[wokers] VALUES 
(NEXT VALUE FOR [dbo].[seq_wokers], @name, @surname, @id_position, @id_office, @dismissed)
END
GO


CREATE PROCEDURE INSERT_POSITION @name varchar(50)
AS 
BEGIN
INSERT INTO [dbo].[position] VALUES 
(NEXT VALUE FOR [dbo].[seq_position], @name)
END
GO

CREATE PROCEDURE INSERT_OFFICE @name varchar(50)
AS 
BEGIN
INSERT INTO [dbo].[office] VALUES 
(NEXT VALUE FOR [dbo].[seq_office], @name)
END
GO

CREATE PROCEDURE INSERT_ROLES @name varchar(50)
AS 
BEGIN
INSERT INTO [dbo].[roles] VALUES 
(NEXT VALUE FOR [dbo].[seq_roles], @name)
END
GO

CREATE PROCEDURE INSERT_PROGRESS @name varchar(50)
AS 
BEGIN
INSERT INTO [dbo].[progress] VALUES 
(NEXT VALUE FOR [dbo].[seq_progress], @name)
END
GO

CREATE PROCEDURE UPDATE_PROGRESS @id_woker int, @id_task int, @new_progress int, @text_add varchar(MAX)
AS
BEGIN
DECLARE @text varchar(MAX)
SET @text = (SELECT [description] FROM [dbo].[progress_task]
where [id_task]=@id_task AND [id_woker] = @id_woker)
UPDATE [dbo].[progress_task] set [id_progress] = @new_progress,
[description] = CONCAT(@text, @text_add)
where [id_task]=@id_task AND [id_woker] = @id_woker
END
GO

CREATE PROCEDURE CLOSED_TASK @id_task int, @date_closed date
AS
BEGIN
UPDATE [dbo].[tasks] set [closed] = @date_closed
where [id] = @id_task
END
GO


CREATE PROCEDURE CLOSED_PROGRESS @id_task_progress int, @date_closed date
AS
BEGIN
UPDATE [dbo].[progress_task] set [closed] = @date_closed
where [id] = @id_task_progress
END
GO


CREATE PROCEDURE GROUP_CHANGE_ROLE @id_group int, @id_woker int, @id_role int
AS
BEGIN
UPDATE[dbo].[woker_groups] set [id_role]=@id_role
where [id_group] = @id_group AND id_woker = @id_woker
END
GO

CREATE PROCEDURE WOKER_DISSMIS @id_woker int, @date_dissmis date
AS
BEGIN
UPDATE[dbo].[wokers] set [dismissed] = @date_dissmis
where [id] = @id_woker
END
GO