use [Project_List];
go

DELETE FROM [dbo].[progress_task];
go
DELETE FROM [dbo].[woker_groups];
go
DELETE FROM [dbo].[tasks];
go
DELETE FROM [dbo].[groups];
go
DELETE FROM [dbo].[progress];
go
DELETE FROM [dbo].[roles];
go
DELETE FROM [dbo].[wokers];
go
DELETE FROM [dbo].[position];
go
DELETE FROM [dbo].[office];
go



ALTER SEQUENCE [dbo].[seq_groups]
RESTART WITH 1
go
ALTER SEQUENCE [dbo].[seq_office]
RESTART WITH 1
go
ALTER SEQUENCE [dbo].[seq_position]
RESTART WITH 1
go
ALTER SEQUENCE [dbo].[seq_progress]
RESTART WITH 1
go
ALTER SEQUENCE [dbo].[seq_progress_task]
RESTART WITH 1
go
ALTER SEQUENCE [dbo].[seq_roles]
RESTART WITH 1
go
ALTER SEQUENCE [dbo].[seq_tasks]
RESTART WITH 1
go
ALTER SEQUENCE [dbo].[seq_woker_groups]
RESTART WITH 1
go
ALTER SEQUENCE [dbo].[seq_wokers]
RESTART WITH 1
go


INSERT INTO [dbo].[position] VALUES 
(NEXT VALUE FOR [dbo].[seq_position], '��������' ), 
(NEXT VALUE FOR [dbo].[seq_position], '���������' ), 
(NEXT VALUE FOR [dbo].[seq_position], '�������' ), 
(NEXT VALUE FOR [dbo].[seq_position], '�������' )
GO

INSERT INTO [dbo].[office] VALUES 
(NEXT VALUE FOR [dbo].[seq_office], '����' ), 
(NEXT VALUE FOR [dbo].[seq_office], '���' ), 
(NEXT VALUE FOR [dbo].[seq_office], '����������' ) 
GO

INSERT INTO [dbo].[progress] VALUES 
(NEXT VALUE FOR [dbo].[seq_progress], '������� �������' ),
(NEXT VALUE FOR [dbo].[seq_progress], '���������' ),
(NEXT VALUE FOR [dbo].[seq_progress], '���������� 25%' ),
(NEXT VALUE FOR [dbo].[seq_progress], '���������� 50%' ),
(NEXT VALUE FOR [dbo].[seq_progress], '���������� 75%' ),
(NEXT VALUE FOR [dbo].[seq_progress], '�������' )
GO

INSERT INTO [dbo].[roles] VALUES
(NEXT VALUE FOR [dbo].[seq_roles], '�������������' ),
(NEXT VALUE FOR [dbo].[seq_roles], '�����������' )
GO

INSERT INTO [dbo].[wokers] VALUES
(NEXT VALUE FOR [dbo].[seq_wokers], '���', '�����',1,1, null ),
(NEXT VALUE FOR [dbo].[seq_wokers], '�������', '������',2,3 , null),
(NEXT VALUE FOR [dbo].[seq_wokers], '�����', '�������',2,3, null ),
(NEXT VALUE FOR [dbo].[seq_wokers], '����', '������',3,2, null ),
(NEXT VALUE FOR [dbo].[seq_wokers], '����', '������',3,1 , null),
(NEXT VALUE FOR [dbo].[seq_wokers], '����1', '�������1',4,2, null ),
(NEXT VALUE FOR [dbo].[seq_wokers], '����2', '�������2',4,2, null ),
(NEXT VALUE FOR [dbo].[seq_wokers], '����3', '�������3',4,2, null ),
(NEXT VALUE FOR [dbo].[seq_wokers], '����4', '�������4',4,2 , null)
GO

INSERT INTO [dbo].[groups] VALUES
(NEXT VALUE FOR [dbo].[seq_groups], '������� ����� �����������', 1 ),
(NEXT VALUE FOR [dbo].[seq_groups], '����� ���������', 1 ),
(NEXT VALUE FOR [dbo].[seq_groups], '���������� ������', 5 ),
(NEXT VALUE FOR [dbo].[seq_groups], '��������� ���������', 2 ),
(NEXT VALUE FOR [dbo].[seq_groups], '���������� ����', 1 )
GO

INSERT INTO [dbo].[woker_groups] VALUES
(NEXT VALUE FOR [dbo].[seq_woker_groups],1,1,1),
(NEXT VALUE FOR [dbo].[seq_woker_groups],5,2,1),
(NEXT VALUE FOR [dbo].[seq_woker_groups],4,3,1),
(NEXT VALUE FOR [dbo].[seq_woker_groups],3,4,1),
(NEXT VALUE FOR [dbo].[seq_woker_groups],4,5,1),
(NEXT VALUE FOR [dbo].[seq_woker_groups],2,1,2),
(NEXT VALUE FOR [dbo].[seq_woker_groups],3,1,2),
(NEXT VALUE FOR [dbo].[seq_woker_groups],4,2,2),
(NEXT VALUE FOR [dbo].[seq_woker_groups],1,2,2),
(NEXT VALUE FOR [dbo].[seq_woker_groups],6,3,2),
(NEXT VALUE FOR [dbo].[seq_woker_groups],1,3,2),
(NEXT VALUE FOR [dbo].[seq_woker_groups],2,4,2),
(NEXT VALUE FOR [dbo].[seq_woker_groups],6,5,2),
(NEXT VALUE FOR [dbo].[seq_woker_groups],7,5,2),
(NEXT VALUE FOR [dbo].[seq_woker_groups],8,5,2),
(NEXT VALUE FOR [dbo].[seq_woker_groups],9,5,2)
GO

INSERT INTO [dbo].[tasks] VALUES
(NEXT VALUE FOR [dbo].[seq_tasks],'����� �������',1,1,'2020-12-05','2021-01-01',null, null),
(NEXT VALUE FOR [dbo].[seq_tasks],'���������� �������� �1',2,1,'2020-10-01','2021-02-01',null, null),
(NEXT VALUE FOR [dbo].[seq_tasks],'���������� �������� �2',2,1,'2020-11-01','2021-02-01',null, null),
(NEXT VALUE FOR [dbo].[seq_tasks],'������ ������ ���',3,5,'2020-12-01','2021-03-01',null, null),
(NEXT VALUE FOR [dbo].[seq_tasks],'��������� ���������',4,2,'2020-12-05','2020-12-10',null, null),
(NEXT VALUE FOR [dbo].[seq_tasks],'7 ������ ������',5,5,'2020-10-01','2020-10-10','2020-10-10', null)
GO

INSERT INTO [dbo].[progress_task] VALUES
(NEXT VALUE FOR [dbo].[seq_progress_task],1,1,'2020-12-05','2021-01-01',2, null, null),
(NEXT VALUE FOR [dbo].[seq_progress_task],1,2,'2020-12-05','2021-01-01',4, null, null),
(NEXT VALUE FOR [dbo].[seq_progress_task],1,3,'2020-12-05','2021-01-01',5, null, null),
(NEXT VALUE FOR [dbo].[seq_progress_task],2,5,'2020-10-01','2021-02-01',3,null, null),
(NEXT VALUE FOR [dbo].[seq_progress_task],2,4,'2020-10-01','2021-02-01',6,null , null),
(NEXT VALUE FOR [dbo].[seq_progress_task],2,1,'2020-10-01','2021-02-01',1,null, null),
(NEXT VALUE FOR [dbo].[seq_progress_task],3,5,'2020-11-01','2021-02-01',3,null, null ),
(NEXT VALUE FOR [dbo].[seq_progress_task],3,4,'2020-12-01','2020-12-30',6, null, null),
(NEXT VALUE FOR [dbo].[seq_progress_task],3,1,'2020-11-01','2021-02-01',1,null, null ),
(NEXT VALUE FOR [dbo].[seq_progress_task],4,4,'2020-12-01','2021-03-01',2,null, null ),
(NEXT VALUE FOR [dbo].[seq_progress_task],4,6,'2021-01-01','2021-03-01',1,null, null ),
(NEXT VALUE FOR [dbo].[seq_progress_task],4,1,'2020-12-01','2021-03-01',1,null , null),
(NEXT VALUE FOR [dbo].[seq_progress_task],5,3,'2020-12-05','2020-12-10',6, '2020-12-10', null),
(NEXT VALUE FOR [dbo].[seq_progress_task],5,2,'2020-12-05','2020-12-10',6,'2020-12-10', null),
(NEXT VALUE FOR [dbo].[seq_progress_task],6,4,'2020-10-01','2020-10-10',6, '2020-10-10', null),
(NEXT VALUE FOR [dbo].[seq_progress_task],6,6,'2020-10-01','2020-10-10',6,'2020-10-10', null),
(NEXT VALUE FOR [dbo].[seq_progress_task],6,7,'2020-10-01','2020-10-10',6,'2020-10-10', null),
(NEXT VALUE FOR [dbo].[seq_progress_task],6,8,'2020-10-01','2020-10-10',6,'2020-10-10', null)
go