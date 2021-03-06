USE [DBSOTREMI]
GO
/****** Object:  UserDefinedFunction [dbo].[ColumnsDateName]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ColumnsDateName](
@startdate datetime,
@enddate datetime)
returns nvarchar(max)
as

begin

declare @vi_startdate datetime,
@vi_enddate datetime,
@vi_columnsdataname nvarchar(max),
@vi_string nvarchar(200),
@vi_i int;

set @vi_i = 1;

set @vi_startdate = @startdate;
set @vi_enddate = @enddate;

SET @vi_columnsdataname = '';

begin

 while (@vi_startdate<=@vi_enddate)
	begin

	set @vi_string = CAST([dbo].[fnFormatDate](@vi_startdate,'DD/MM') as char(5));

	SET @vi_columnsdataname = @vi_columnsdataname + ' ISNULL(' + QUOTENAME(@vi_string + '-1')+ ',0) AS '+ QUOTENAME(@vi_string + '-1') + 
	',ISNULL('+ QUOTENAME(@vi_string+'-2')+ ',0) AS '+ QUOTENAME(@vi_string+'-2') +
	',ISNULL('+ QUOTENAME(@vi_string+'-3')+ ',0) AS '+ QUOTENAME(@vi_string+'-3')+','; 
				  	 
	 SET @vi_startdate = @vi_startdate + 1;
	 set @vi_i = @vi_i +1;
	end


	set @vi_columnsdataname = left(@vi_columnsdataname,len(@vi_columnsdataname)-1);
	
	return @vi_columnsdataname;
end
end
GO
/****** Object:  UserDefinedFunction [dbo].[ColumnsDateNamePivot]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ColumnsDateNamePivot](
@startdate datetime,
@enddate datetime)
returns nvarchar(max)
as

begin

declare @vi_startdate datetime,
@vi_enddate datetime,
@vi_columnsdataname nvarchar(max),
@vi_string nvarchar(200),
@vi_i int;

set @vi_i = 1;

set @vi_startdate = @startdate;
set @vi_enddate = @enddate;

SET @vi_columnsdataname = '';

begin

 while (@vi_startdate<=@vi_enddate)
	begin

	set @vi_string = CAST([dbo].[fnFormatDate](@vi_startdate,'DD/MM') as char(5));

	SET @vi_columnsdataname = @vi_columnsdataname + QUOTENAME(@vi_string + '-1')+ ',' + 
	QUOTENAME(@vi_string+'-2')+ ',' +	 QUOTENAME(@vi_string+'-3')+ ','; 
				  	 
	 SET @vi_startdate = @vi_startdate + 1;
	 set @vi_i = @vi_i +1;
	end


	set @vi_columnsdataname = left(@vi_columnsdataname,len(@vi_columnsdataname)-1);
	
	return @vi_columnsdataname;
end
end
GO
/****** Object:  UserDefinedFunction [dbo].[fnFormatDate]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnFormatDate] (@Datetime DATETIME, @FormatMask VARCHAR(32))
RETURNS VARCHAR(32)
AS
BEGIN
    DECLARE @StringDate VARCHAR(32)
    SET @StringDate = @FormatMask
    IF (CHARINDEX ('YYYY',@StringDate) > 0)
       SET @StringDate = REPLACE(@StringDate, 'YYYY',
                         DATENAME(YY, @Datetime))
    IF (CHARINDEX ('YY',@StringDate) > 0)
       SET @StringDate = REPLACE(@StringDate, 'YY',
                         RIGHT(DATENAME(YY, @Datetime),2))
    IF (CHARINDEX ('Month',@StringDate) > 0)
       SET @StringDate = REPLACE(@StringDate, 'Month',
                         DATENAME(MM, @Datetime))
    IF (CHARINDEX ('MON',@StringDate COLLATE SQL_Latin1_General_CP1_CS_AS)>0)
       SET @StringDate = REPLACE(@StringDate, 'MON',
                         LEFT(UPPER(DATENAME(MM, @Datetime)),3))
    IF (CHARINDEX ('Mon',@StringDate) > 0)
       SET @StringDate = REPLACE(@StringDate, 'Mon',
                                     LEFT(DATENAME(MM, @Datetime),3))
    IF (CHARINDEX ('MM',@StringDate) > 0)
       SET @StringDate = REPLACE(@StringDate, 'MM',
                  RIGHT('0'+CONVERT(VARCHAR,DATEPART(MM, @Datetime)),2))
    IF (CHARINDEX ('M',@StringDate) > 0)
       SET @StringDate = REPLACE(@StringDate, 'M',
                         CONVERT(VARCHAR,DATEPART(MM, @Datetime)))
    IF (CHARINDEX ('DD',@StringDate) > 0)
       SET @StringDate = REPLACE(@StringDate, 'DD',
                         RIGHT('0'+DATENAME(DD, @Datetime),2))
    IF (CHARINDEX ('D',@StringDate) > 0)
       SET @StringDate = REPLACE(@StringDate, 'D',
                                     DATENAME(DD, @Datetime))   
RETURN @StringDate
END

GO
/****** Object:  UserDefinedFunction [dbo].[RowSumTotal]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[RowSumTotal](
@startdate datetime,
@enddate datetime)
returns nvarchar(max)
as

begin

declare @vi_startdate datetime,
@vi_enddate datetime,
@vi_columnsdataname nvarchar(max),
@vi_string nvarchar(200),
@vi_i int;

set @vi_i = 1;

set @vi_startdate = @startdate;
set @vi_enddate = @enddate;

SET @vi_columnsdataname = '';

begin

 while (@vi_startdate<=@vi_enddate)
	begin

	set @vi_string = CAST([dbo].[fnFormatDate](@vi_startdate,'DD/MM') as char(5));

	SET @vi_columnsdataname = @vi_columnsdataname + ' SUM(ISNULL(' + QUOTENAME(@vi_string + '-1')+ ',0)) AS '+ QUOTENAME(@vi_string + '-1') + 
	',SUM(ISNULL('+ QUOTENAME(@vi_string+'-2')+ ',0)) AS '+ QUOTENAME(@vi_string+'-2') +
	',SUM(ISNULL('+ QUOTENAME(@vi_string+'-3')+ ',0)) AS '+ QUOTENAME(@vi_string+'-3')+','; 
				  	 
	 SET @vi_startdate = @vi_startdate + 1;
	 set @vi_i = @vi_i +1;
	end


	set @vi_columnsdataname = left(@vi_columnsdataname,len(@vi_columnsdataname)-1);
	
	return @vi_columnsdataname;
end
end
GO
/****** Object:  UserDefinedFunction [dbo].[SumTotalA]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SumTotalA](
@startdate datetime,
@enddate datetime,
@total bit)
returns nvarchar(max)
as

begin

declare @vi_startdate datetime,
@vi_enddate datetime,
@vi_columnsdataname nvarchar(max),
@vi_string nvarchar(200),
@vi_i int;

set @vi_i = 1;

set @vi_startdate = @startdate;
set @vi_enddate = @enddate;

SET @vi_columnsdataname = '';

begin

 while (@vi_startdate<=@vi_enddate)
	begin

	set @vi_string = CAST([dbo].[fnFormatDate](@vi_startdate,'DD/MM') as char(5));

	SET @vi_columnsdataname = @vi_columnsdataname + QUOTENAME(@vi_string + '-2')+ '+ ';
				  	 
	 SET @vi_startdate = @vi_startdate + 1;
	 set @vi_i = @vi_i +1;
	end


	set @vi_columnsdataname = left(@vi_columnsdataname,len(@vi_columnsdataname)-1);

	if ( @total = 1)
	begin
	 set @vi_columnsdataname = 'sum(ISNULL('+ @vi_columnsdataname+',0)) AS TA';
	end
	else
	begin
	 SET   @vi_columnsdataname = 'ISNULL('+@vi_columnsdataname+',0) AS TA';
	end
	
	return @vi_columnsdataname ;
	end
end

GO
/****** Object:  UserDefinedFunction [dbo].[SumTotalC]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SumTotalC](
@startdate datetime,
@enddate datetime,
@total bit )
returns nvarchar(max)
as

begin

declare @vi_startdate datetime,
@vi_enddate datetime,
@vi_columnsdataname nvarchar(max),
@vi_string nvarchar(200),
@vi_i int;

set @vi_i = 1;

set @vi_startdate = @startdate;
set @vi_enddate = @enddate;

SET @vi_columnsdataname = '';

begin

 while (@vi_startdate<=@vi_enddate)
	begin

	set @vi_string = CAST([dbo].[fnFormatDate](@vi_startdate,'DD/MM') as char(5));

	SET @vi_columnsdataname = @vi_columnsdataname + QUOTENAME(@vi_string + '-3')+ '+ ';
				  	 
	 SET @vi_startdate = @vi_startdate + 1;
	 set @vi_i = @vi_i +1;
	end


	set @vi_columnsdataname = left(@vi_columnsdataname,len(@vi_columnsdataname)-1);

	if ( @total = 1)
	begin
	 set @vi_columnsdataname = 'sum(ISNULL('+ @vi_columnsdataname+',0)) AS TC';
	end
	else
	begin
	 SET   @vi_columnsdataname = 'ISNULL('+ @vi_columnsdataname+',0) AS TC';
	end
	
	return @vi_columnsdataname ;

end
end
GO
/****** Object:  UserDefinedFunction [dbo].[SumTotalD]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SumTotalD](
@startdate datetime,
@enddate datetime,
@total bit)
returns nvarchar(max)
as

begin

declare @vi_startdate datetime,
@vi_enddate datetime,
@vi_columnsdataname nvarchar(max),
@vi_string nvarchar(200),
@vi_i int;

set @vi_i = 1;

set @vi_startdate = @startdate;
set @vi_enddate = @enddate;

SET @vi_columnsdataname = '';

begin

 while (@vi_startdate<=@vi_enddate)
	begin

	set @vi_string = CAST([dbo].[fnFormatDate](@vi_startdate,'DD/MM') as char(5));

	SET @vi_columnsdataname = @vi_columnsdataname + QUOTENAME(@vi_string + '-1')+ '+ ';
				  	 
	 SET @vi_startdate = @vi_startdate + 1;
	 set @vi_i = @vi_i +1;
	end


	set @vi_columnsdataname = left(@vi_columnsdataname,len(@vi_columnsdataname)-1);

	if ( @total = 1)
	begin
	 set @vi_columnsdataname = 'sum( ISNULL('+ @vi_columnsdataname+',0)) AS TD';
	end
	else
	begin
	 SET   @vi_columnsdataname = 'ISNULL('+@vi_columnsdataname+',0) AS TD';
	end
	
	return @vi_columnsdataname ;

end
end

GO
/****** Object:  Table [dbo].[Area]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Area](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [area_pk] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CurrencyType]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CurrencyType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](40) NOT NULL,
	[Symbol] [nvarchar](4) NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [currencytype_pk] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonId] [int] NOT NULL,
	[PositionId] [int] NULL,
	[JoinDate] [datetime] NULL,
	[Salary] [decimal](18, 2) NULL,
	[AreaId] [int] NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [employee_pk] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Person]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PaternalName] [nvarchar](50) NULL,
	[MaternalName] [nvarchar](50) NULL,
	[Names] [nvarchar](50) NULL,
	[BusinessName] [nvarchar](255) NULL,
	[Ruc] [nvarchar](15) NULL,
	[Dni] [nvarchar](15) NULL,
	[HomePhone] [nvarchar](15) NULL,
	[MobilePhone] [nvarchar](15) NULL,
	[Email] [nvarchar](100) NULL,
	[Address] [nvarchar](255) NULL,
	[BirthDate] [datetime] NULL,
	[TypePersonId] [int] NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [person_pk] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Personas]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas](
	[Id_Persona] [int] NULL,
	[Per_RazonSocial] [nvarchar](255) NULL,
	[Per_Ruc] [nvarchar](15) NULL,
	[Per_Dni] [nvarchar](15) NULL,
	[Per_TlfFijo] [nvarchar](30) NULL,
	[Per_TlfMovil] [nvarchar](30) NULL,
	[Per_Email] [nvarchar](40) NULL,
	[Per_Direccion] [nvarchar](255) NULL,
	[Per_Fecha] [datetime] NULL,
	[Per_Tipo] [nvarchar](2) NULL,
	[Per_Saldo] [float] NULL,
	[Per_Sueldo] [float] NULL,
	[CARGO] [nvarchar](255) NULL,
	[AREA] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Service]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Prece] [decimal](18, 2) NOT NULL,
	[CurrencyTypeId] [int] NOT NULL,
	[Active] [bit] NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [service_pk] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServiceItem]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceItem](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ServiceId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[ServiceItemDate] [datetime] NOT NULL,
	[Payment] [decimal](18, 2) NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [serviceitem_pk] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Area] ON 

INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (1, N'Administración', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (2, N'Almacen Mina', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (3, N'Comercial', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (4, N'Contabilidad', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (5, N'Directorio', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (6, N'Gastos Operativos', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (7, N'Gerencia General', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (8, N'Izaje B4', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (9, N'Logística', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (10, N'Mantenimiento', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (11, N'Obras Civiles', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (12, N'Pad', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (13, N'Santa Rosa', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (14, N'Seguridad e Higiene Minera', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (15, N'Vigilancia', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (16, N'Zona 23', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (17, N'Visitas Mina', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (18, N'Comedor Planta', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (19, N'Otros (Sin Área Definida)', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (20, N'Resguardo', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (21, N'Administración', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (22, N'Almacen Mina', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (23, N'Comercial', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (24, N'Contabilidad', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (25, N'Directorio', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (26, N'Gastos Operativos', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (27, N'Gerencia General', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (28, N'Izaje B4', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (29, N'Logística', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (30, N'Mantenimiento', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (31, N'Obras Civiles', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (32, N'Pad', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (33, N'Santa Rosa', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (34, N'Seguridad e Higiene Minera', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (35, N'Vigilancia', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (36, N'Zona 23', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (37, N'Visitas Mina', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (38, N'Comedor Planta', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (39, N'Otros (Sin Área Definida)', 1)
INSERT [dbo].[Area] ([Id], [Name], [Status]) VALUES (40, N'Resguardo', 1)
SET IDENTITY_INSERT [dbo].[Area] OFF
SET IDENTITY_INSERT [dbo].[CurrencyType] ON 

INSERT [dbo].[CurrencyType] ([Id], [Name], [Symbol], [Status]) VALUES (1, N'Soles', N'S/.', 1)
INSERT [dbo].[CurrencyType] ([Id], [Name], [Symbol], [Status]) VALUES (2, N'Dolares', N'$', 1)
INSERT [dbo].[CurrencyType] ([Id], [Name], [Symbol], [Status]) VALUES (3, N'Soles', N'S/.', 1)
INSERT [dbo].[CurrencyType] ([Id], [Name], [Symbol], [Status]) VALUES (4, N'Dolares', N'$', 1)
SET IDENTITY_INSERT [dbo].[CurrencyType] OFF
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (1, 1, NULL, CAST(N'2016-04-15 04:30:00.603' AS DateTime), NULL, 1, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (2, 2, NULL, CAST(N'2016-04-15 04:30:00.607' AS DateTime), NULL, 1, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (3, 3, NULL, CAST(N'2016-04-15 04:30:00.607' AS DateTime), NULL, 1, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (4, 4, NULL, CAST(N'2016-04-15 04:30:00.607' AS DateTime), NULL, 2, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (5, 5, NULL, CAST(N'2016-04-15 04:30:00.607' AS DateTime), NULL, 3, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (6, 6, NULL, CAST(N'2016-04-15 04:30:00.607' AS DateTime), NULL, 3, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (7, 7, NULL, CAST(N'2016-04-15 04:30:00.607' AS DateTime), NULL, 3, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (8, 8, NULL, CAST(N'2016-04-15 04:30:00.610' AS DateTime), NULL, 3, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (9, 9, NULL, CAST(N'2016-04-15 04:30:00.610' AS DateTime), NULL, 3, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (10, 10, NULL, CAST(N'2016-04-15 04:30:00.610' AS DateTime), NULL, 4, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (11, 11, NULL, CAST(N'2016-04-15 04:30:00.610' AS DateTime), NULL, 4, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (12, 12, NULL, CAST(N'2016-04-15 04:30:00.610' AS DateTime), NULL, 4, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (13, 13, NULL, CAST(N'2016-04-15 04:30:00.610' AS DateTime), NULL, 4, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (14, 14, NULL, CAST(N'2016-04-15 04:30:00.610' AS DateTime), NULL, 5, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (15, 15, NULL, CAST(N'2016-04-15 04:30:00.610' AS DateTime), NULL, 5, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (16, 16, NULL, CAST(N'2016-04-15 04:30:00.610' AS DateTime), NULL, 5, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (17, 17, NULL, CAST(N'2016-04-15 04:30:00.610' AS DateTime), NULL, 5, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (18, 18, NULL, CAST(N'2016-04-15 04:30:00.610' AS DateTime), NULL, 5, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (19, 19, NULL, CAST(N'2016-04-15 04:30:00.610' AS DateTime), NULL, 5, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (20, 20, NULL, CAST(N'2016-04-15 04:30:00.610' AS DateTime), NULL, 6, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (21, 21, NULL, CAST(N'2016-04-15 04:30:00.610' AS DateTime), NULL, 6, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (22, 22, NULL, CAST(N'2016-04-15 04:30:00.613' AS DateTime), NULL, 6, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (23, 23, NULL, CAST(N'2016-04-15 04:30:00.613' AS DateTime), NULL, 6, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (24, 24, NULL, CAST(N'2016-04-15 04:30:00.613' AS DateTime), NULL, 6, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (25, 25, NULL, CAST(N'2016-04-15 04:30:00.613' AS DateTime), NULL, 6, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (26, 26, NULL, CAST(N'2016-04-15 04:30:00.613' AS DateTime), NULL, 6, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (27, 27, NULL, CAST(N'2016-04-15 04:30:00.613' AS DateTime), NULL, 6, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (28, 28, NULL, CAST(N'2016-04-15 04:30:00.613' AS DateTime), NULL, 6, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (29, 29, NULL, CAST(N'2016-04-15 04:30:00.613' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (30, 30, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (31, 31, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (32, 32, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (33, 33, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (34, 34, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (35, 35, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (36, 36, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (37, 37, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (38, 38, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (39, 39, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (40, 40, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (41, 41, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (42, 42, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (43, 43, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (44, 44, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (45, 45, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (46, 46, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (47, 47, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (48, 48, NULL, CAST(N'2016-04-15 04:30:00.637' AS DateTime), NULL, 8, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (49, 49, NULL, CAST(N'2016-04-15 04:30:00.640' AS DateTime), NULL, 9, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (50, 50, NULL, CAST(N'2016-04-15 04:30:00.640' AS DateTime), NULL, 9, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (51, 51, NULL, CAST(N'2016-04-15 04:30:00.640' AS DateTime), NULL, 9, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (52, 52, NULL, CAST(N'2016-04-15 04:30:00.640' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (53, 53, NULL, CAST(N'2016-04-15 04:30:00.640' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (54, 54, NULL, CAST(N'2016-04-15 04:30:00.640' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (55, 55, NULL, CAST(N'2016-04-15 04:30:00.640' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (56, 56, NULL, CAST(N'2016-04-15 04:30:00.640' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (57, 57, NULL, CAST(N'2016-04-15 04:30:00.640' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (58, 58, NULL, CAST(N'2016-04-15 04:30:00.643' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (59, 59, NULL, CAST(N'2016-04-15 04:30:00.643' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (60, 60, NULL, CAST(N'2016-04-15 04:30:00.643' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (61, 61, NULL, CAST(N'2016-04-15 04:30:00.643' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (62, 62, NULL, CAST(N'2016-04-15 04:30:00.643' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (63, 63, NULL, CAST(N'2016-04-15 04:30:00.643' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (64, 64, NULL, CAST(N'2016-04-15 04:30:00.647' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (65, 65, NULL, CAST(N'2016-04-15 04:30:00.647' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (66, 66, NULL, CAST(N'2016-04-15 04:30:00.647' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (67, 67, NULL, CAST(N'2016-04-15 04:30:00.647' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (68, 68, NULL, CAST(N'2016-04-15 04:30:00.647' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (69, 69, NULL, CAST(N'2016-04-15 04:30:00.647' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (70, 70, NULL, CAST(N'2016-04-15 04:30:00.647' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (71, 71, NULL, CAST(N'2016-04-15 04:30:00.647' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (72, 72, NULL, CAST(N'2016-04-15 04:30:00.647' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (73, 73, NULL, CAST(N'2016-04-15 04:30:00.647' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (74, 74, NULL, CAST(N'2016-04-15 04:30:00.650' AS DateTime), NULL, 10, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (75, 75, NULL, CAST(N'2016-04-15 04:30:00.650' AS DateTime), NULL, 12, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (76, 76, NULL, CAST(N'2016-04-15 04:30:00.650' AS DateTime), NULL, 12, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (77, 77, NULL, CAST(N'2016-04-15 04:30:00.657' AS DateTime), NULL, 12, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (78, 78, NULL, CAST(N'2016-04-15 04:30:00.657' AS DateTime), NULL, 12, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (79, 79, NULL, CAST(N'2016-04-15 04:30:00.657' AS DateTime), NULL, 12, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (80, 80, NULL, CAST(N'2016-04-15 04:30:00.660' AS DateTime), NULL, 12, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (81, 81, NULL, CAST(N'2016-04-15 04:30:00.660' AS DateTime), NULL, 12, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (82, 82, NULL, CAST(N'2016-04-15 04:30:00.660' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (83, 83, NULL, CAST(N'2016-04-15 04:30:00.660' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (84, 84, NULL, CAST(N'2016-04-15 04:30:00.660' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (85, 85, NULL, CAST(N'2016-04-15 04:30:00.660' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (86, 86, NULL, CAST(N'2016-04-15 04:30:00.660' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (87, 87, NULL, CAST(N'2016-04-15 04:30:00.660' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (88, 88, NULL, CAST(N'2016-04-15 04:30:00.660' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (89, 89, NULL, CAST(N'2016-04-15 04:30:00.660' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (90, 90, NULL, CAST(N'2016-04-15 04:30:00.660' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (91, 91, NULL, CAST(N'2016-04-15 04:30:00.663' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (92, 92, NULL, CAST(N'2016-04-15 04:30:00.663' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (93, 93, NULL, CAST(N'2016-04-15 04:30:00.663' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (94, 94, NULL, CAST(N'2016-04-15 04:30:00.663' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (95, 95, NULL, CAST(N'2016-04-15 04:30:00.663' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (96, 96, NULL, CAST(N'2016-04-15 04:30:00.667' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (97, 97, NULL, CAST(N'2016-04-15 04:30:00.667' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (98, 98, NULL, CAST(N'2016-04-15 04:30:00.667' AS DateTime), NULL, 13, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (99, 99, NULL, CAST(N'2016-04-15 04:30:00.667' AS DateTime), NULL, 14, 1)
GO
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (100, 100, NULL, CAST(N'2016-04-15 04:30:00.667' AS DateTime), NULL, 14, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (101, 101, NULL, CAST(N'2016-04-15 04:30:00.667' AS DateTime), NULL, 14, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (102, 102, NULL, CAST(N'2016-04-15 04:30:00.667' AS DateTime), NULL, 15, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (103, 103, NULL, CAST(N'2016-04-15 04:30:00.667' AS DateTime), NULL, 15, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (104, 104, NULL, CAST(N'2016-04-15 04:30:00.667' AS DateTime), NULL, 15, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (105, 105, NULL, CAST(N'2016-04-15 04:30:00.667' AS DateTime), NULL, 15, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (106, 106, NULL, CAST(N'2016-04-15 04:30:00.667' AS DateTime), NULL, 15, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (107, 107, NULL, CAST(N'2016-04-15 04:30:00.667' AS DateTime), NULL, 15, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (108, 108, NULL, CAST(N'2016-04-15 04:30:00.667' AS DateTime), NULL, 15, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (109, 109, NULL, CAST(N'2016-04-15 04:30:00.667' AS DateTime), NULL, 15, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (110, 110, NULL, CAST(N'2016-04-15 04:30:00.667' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (111, 111, NULL, CAST(N'2016-04-15 04:30:00.667' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (112, 112, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (113, 113, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (114, 114, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (115, 115, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (116, 116, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (117, 117, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (118, 118, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (119, 119, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (120, 120, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (121, 121, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (122, 122, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (123, 123, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (124, 124, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (125, 125, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (126, 126, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (127, 127, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (128, 128, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (129, 129, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (130, 130, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (131, 131, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (132, 132, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (133, 133, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (134, 134, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (135, 135, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (136, 136, NULL, CAST(N'2016-04-15 04:30:00.670' AS DateTime), NULL, 16, 1)
INSERT [dbo].[Employee] ([Id], [PersonId], [PositionId], [JoinDate], [Salary], [AreaId], [Status]) VALUES (137, 137, NULL, CAST(N'2016-04-15 04:30:00.673' AS DateTime), NULL, 16, 1)
SET IDENTITY_INSERT [dbo].[Employee] OFF
SET IDENTITY_INSERT [dbo].[Person] ON 

INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (1, N'ANCHAHUA 	', N'ZEVALLOS	', N'VANESSA MARISOL	', NULL, NULL, N'44512203', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (2, N'CORILLOCLLA', N'ELESCANO	', N'HEIDI SAIDA	', NULL, NULL, N'40860400', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (3, N'QUILLE 	', N'JIMENEZ	', N'KAREN GABRIELA	', NULL, NULL, N'45345563', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (4, N'HUAMANI 	', N'ATOCCZA	', N'CASTOR DOROTEO	', NULL, NULL, N'21485741', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (5, N'CONDE 	', N'HUAMANÍ	', N'JUAN BAUTISTA	', NULL, NULL, N'30582478', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (6, N'ROJAS 	', N'SANCHEZ	', N'SANTOS LEONARDO	', NULL, NULL, N'46683432', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (7, N'SAPACAYO 	', N'THEA	', N'PERCY	', NULL, NULL, N'29631837', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (8, N'FERREYRA 	', N'AGÜERO	', N'SAMUEL GONZALO	', NULL, NULL, N'21428504', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (9, N'QUISPE 	', N'YANASUPO	', N'ADRIAN	', NULL, NULL, N'40280397', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (10, N'HUAMANI 	', N'BERROCAL	', N'BRIGIDA TOLA	', NULL, NULL, N'43885559', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (11, N'PONCE 	', N'MORALES	', N'MARILYN	', NULL, NULL, N'42194991', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (12, N'MAYO 	', N'URTECHO	', N'JUAN MANUEL	', NULL, NULL, N'47158446', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (13, N'PALACIOS 	', N'GOICOCHEA	', N'ARMIDA LILIANA	', NULL, NULL, N'26962706', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (14, N'SAPACAYO 	', N'CCAHUACHIA	', N'JUAN TEODORO	', NULL, NULL, N'24880747', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (15, N'VASQUEZ 	', N'FACUNDO	', N'BENJAMIN	', NULL, NULL, N'30484985', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (16, N'CHAVEZ 	', N'FILIO	', N'HECTOR	', NULL, NULL, N'21562634', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (17, N'HUAMANCAYO', N'MANRIQUE	', N'ROLANDO ULISES	', NULL, NULL, N'22283519', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (18, N'QUISPE 	', N'TORRICOS	', N'PEDRO	', NULL, NULL, N'30405580', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (19, N'TORRES 	', N'DELGADO	', N'JAIME JOEL	', NULL, NULL, N'42042949', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (20, N'BARRIENTOS', N'CASTILLO	', N'TANY ALEX	', NULL, NULL, N'46167677', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (21, N'COSI 	', N'COSI	', N'HUBERT RODRIGO	', NULL, NULL, N'42964906', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (22, N'DE LA CRUZ', N'ICHPAS	', N'JULIO	', NULL, NULL, N'41459547', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (23, N'FERNANDEZ', N'ROJAS	', N'FRANZ JOHANN	', NULL, NULL, N'44940761', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (24, N'HUAMANI 	', N'AVENDAÑO  	', N'RUVER	', NULL, NULL, N'44075508', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (25, N'HUAMANI 	', N'ZAPANA	', N'LUIS MIGUEL	', NULL, NULL, N'45529887', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (26, N'MONTAÑEZ 	', N'VARGAS	', N'BRAYAN	', NULL, NULL, N'46899457', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (27, N'ROJAS 	', N'CAMARGO	', N'LUIS CARLOS	', NULL, NULL, N'20001629', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (28, N'SANCHEZ 	', N'PORTAL	', N'JORGE LUIS	', NULL, NULL, N'45803129', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (29, N'CALLA 	', N'CANAHUA	', N'ALVARO	', NULL, NULL, N'42138139', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (30, N'CCOAQUIRA', N'HUAMANI', N'	 CRISOLOGO	', NULL, NULL, N'24806642', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (31, N'CHIPANI 	', N'CORDOVA	', N'YABAR	', NULL, NULL, N'40122970', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (32, N'CURO 	', N'ZAPANA	', N'JAVIER FERNANDO	', NULL, NULL, N'42922696', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (33, N'HERMOZA 	', N'HUILLCA	', N'JOSE ANGEL	', NULL, NULL, N'46188803', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (34, N'HUAMAN 	', N'HUAROTO	', N'JORGE	', NULL, NULL, N'23545801', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (35, N'HURTADO 	', N'CARBAJAL  	', N'MAURO	', NULL, NULL, N'45185599', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (36, N'JIMENEZ 	', N'QUISPE	', N'EDGAR ANTONIO	', NULL, NULL, N'80555760', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (37, N'MENDOZA 	', N'HUAYLLANI', N'	 JAVIER	', NULL, NULL, N'24806559', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (38, N'MONTOYA 	', N'CAHUANA	', N'FREDY	', NULL, NULL, N'46088207', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (39, N'OCHOA 	', N'MAYHUIRI  	', N'BRUNO	', NULL, NULL, N'42661807', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (40, N'PALOMINO 	', N'VERA	', N'CARLOS	', NULL, NULL, N'40670890', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (41, N'PARIONA 	', N'TORRES	', N'JUAN MAXIMO	', NULL, NULL, N'21483415', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (42, N'QUISPE 	', N'DIAZ	', N'WENCESLAO	', NULL, NULL, N'24563086', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (43, N'QUISPE 	', N'QUISPE	', N'LAUREANO	', NULL, NULL, N'30950056', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (44, N'RAMOS 	', N'SALVADOR  	', N'TEODOCIO JACINTO	', NULL, NULL, N'23700878', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (45, N'REYES 	', N'CASTRO	', N'RICHARD	', NULL, NULL, N'71849443', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (46, N'RODRIGUEZ', N'DE LA CRUZ', N'MICHAEL FRANCIS	', NULL, NULL, N'76766674', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (47, N'TAMANI 	', N'PARANA	', N'SOLIS	', NULL, NULL, N'44755940', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (48, N'UGARTE 	', N'LOPEZ	', N'EDWIN	', NULL, NULL, N'41220992', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (49, N'GUTIERREZ', N'CHIQUIHUAYTA	', N'WILBER JOAQUIN	', NULL, NULL, N'29543053', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (50, N'PALOMINO 	', N'VERA	', N'ANTONIO	', NULL, NULL, N'41512664', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (51, N'REQUEJO 	', N'URTEAGA	', N'JOSE OMAR	', NULL, NULL, N'43205484', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (52, N'CONDORI 	', N'QUISPE	', N'VICTOR	', NULL, NULL, N'44624363', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (53, N'CORRALES 	', N'HUARCA	', N'JAIME	', NULL, NULL, N'40720226', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (54, N'FLORES 	', N'QUISPE	', N'JOSE WILBER	', NULL, NULL, N'41453357', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (55, N'GOMEZ 	', N'CALLE	', N'MARIO	', NULL, NULL, N'21571904', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (56, N'HUACHACA 	', N'GOMEZ	', N'ORLANDO WILFREDO', NULL, NULL, N'29687315', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (57, N'HUAYHUA 	', N'QUILLE	', N'DIEGO ARMANDO	', NULL, NULL, N'47502954', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (58, N'ILAQUITA 	', N'YANCAPALLO	', N'VICENTE PAUL	', NULL, NULL, N'80280753', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (59, N'MAMANI 	', N'GUTIERREZ	', N'ALFREDO	', NULL, NULL, N'41333129', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (60, N'MONTESINO', N'COLLAO	', N'BRAYAN DEMETRIO	', NULL, NULL, N'70115081', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (61, N'NEYRA 	', N'CASTRO	', N'SILVESTRE MAXIMO	', NULL, NULL, N'30500888', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (62, N'NINA 	', N'HERRERA	', N'OMAR	', NULL, NULL, N'46076943', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (63, N'PADILLA 	', N'GONZALES	', N'WALDO ENRIQIUE	', NULL, NULL, N'40885093', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (64, N'QUISPE 	', N'CASAPUMA	', N'MARIO	', NULL, NULL, N'23523888', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (65, N'RAMOS 	', N'BRAÑEZ	', N'LUIS	', NULL, NULL, N'22296220', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (66, N'RODRIGUEZ', N'PEREZ	', N'ROLDOSIN NICANDRO	', NULL, NULL, N'44054796', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (67, N'SANCHEZ 	', N'CAHUANA	', N'SAMUEL	', NULL, NULL, N'41880489', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (68, N'SANTIAGO 	', N'FALCON	', N'VICTOR ROMEL	', NULL, NULL, N'48852539', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (69, N'TORRES 	', N'HUAMANI	', N'JOSE SAUL	', NULL, NULL, N'46853146', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (70, N'TORRES 	', N'JAYO	', N'WILMER JONATHAN	', NULL, NULL, N'72708882', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (71, N'YALLERCCO', N'VIZCARRA	', N'CECILIO	', NULL, NULL, N'80263736', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (72, N'ESPINOZA 	', N'QUISPE	', N'MARCO POLO	', NULL, NULL, N'41706970', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (73, N'POMA 	', N'POMA	', N'JUAN	', NULL, NULL, N'30853870', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (74, N'YESANG 	', N'CASTILLO  	', N'FRANCISCO JAVIER	', NULL, NULL, N'43207464', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (75, N'HERMOZA 	', N'COLQUE	', N'GAVINO	', NULL, NULL, N'77575734', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (76, N'HERMOZA 	', N'HUAMAN	', N'ANGEL	', NULL, NULL, N'24668071', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (77, N'LLAMOCCA 	', N'HUAMANCHA', N'	 RICARDO	', NULL, NULL, N'28851585', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (78, N'ROMERO 	', N'JULCA	', N'SILVERIO	', NULL, NULL, N'48605205', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (79, N'ROMERO 	', N'REYES	', N'IGNACIO JULIAN	', NULL, NULL, N'20118762', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (80, N'VIZCARRA 	', N'HERMOZA	', N'LUIS ENRIQUE	', NULL, NULL, N'46103922', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (81, N'LAZARO 	', N'ROMERO	', N'IVAN FELIX	', NULL, NULL, N'41985212', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (82, N'HUAMAN 	', N'CAHUANA	', N'DANIEL	', NULL, NULL, N'46437681', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (83, N'HUAMANI 	', N'MEDINA	', N'JONNY TEODORO	', NULL, NULL, N'70339597', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (84, N'HUAMANI 	', N'MEDINA	', N'JULIO AGAPITO	', NULL, NULL, N'44648312', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (85, N'HUAMANI 	', N'RAMOS	', N'EULOGIO	', NULL, NULL, N'31301147', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (86, N'HUARCAYA 	', N'MENDOZA	', N'ABEL ALEXANDER	', NULL, NULL, N'47626615', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (87, N'INGA 	', N'APARCO	', N'JULIO	', NULL, NULL, N'41265377', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (88, N'JANAMPA 	', N'ICHPAS	', N'ANTONIO	', NULL, NULL, N'46031865', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (89, N'LOPEZ 	', N'CARLOS	', N'CERILO	', NULL, NULL, N'41882410', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (90, N'RAMOS 	', N'HUMPIRI	', N'SANTIAGO	', NULL, NULL, N'40277867', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (91, N'REYES 	', N'LLANTOY	', N'VICTOR ANDRES	', NULL, NULL, N'43066865', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (92, N'SANCHEZ 	', N'PARRA	', N'RAFAEL	', NULL, NULL, N'46021219', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (93, N'SANCHEZ 	', N'PARRA	', N'WILLIAM ARMANDO	', NULL, NULL, N'47188837', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (94, N'SANTIAGO 	', N'CARLOS	', N'FRANCISCO	', NULL, NULL, N'23019035', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (95, N'TORRES 	', N'LLOCLLA	', N'ROGELIO	', NULL, NULL, N'71239674', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (96, N'VILLANUEVA', N'	 LINARES	', N'JUAN	', NULL, NULL, N'30641826', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (97, N'YAURI 	', N'MONTES	', N'MARCOS ANTONIO	', NULL, NULL, N'48316882', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (98, N'MOSCOSO 	', N'VILLALBA	', N'MOISES DAVID	', NULL, NULL, N'41053149', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (99, N'MEDINA 	', N'TAPIA	', N'MARTIN HERNANI	', NULL, NULL, N'25789318', NULL, NULL, NULL, NULL, NULL, 1, 1)
GO
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (100, N'MUCHA 	', N'QUINTO	', N'FLAVIO MAXIMO	', NULL, NULL, N'41813111', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (101, N'NEYRA 	', N'NIÑO DE GUZMAN	', N'CESAR	', NULL, NULL, N'44162633', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (102, N'MENDOZA 	', N'HUACHO	', N'ODILON	', NULL, NULL, N'31426793', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (103, N'MENDOZA 	', N'SANCHEZ	', N'DONATO	', NULL, NULL, N'24707144', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (104, N'PACO 	', N'FLORES	', N'PEDRO GONZALO	', NULL, NULL, N'21872008', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (105, N'ROJAS 	', N'ROJAS	', N'JOSE ADRIAN	', NULL, NULL, N'26726194', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (106, N'TINOCO 	', N'TERRAZO	', N'NIKVER JONATHAN	', NULL, NULL, N'71960509', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (107, N'TORRES 	', N'HUACHO	', N'GRIMALDO	', NULL, NULL, N'29486313', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (108, N'MEDINA 	', N'AYBAR	', N'WILBER WILFREDO	', NULL, NULL, N'47909694', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (109, N'MEJIA 	', N'QUISPE	', N'JUAN	', NULL, NULL, N'40942018', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (110, N'PAREDES 	', N'CABRERA	', N'JOSE ANTONIO	', NULL, NULL, N'76924592', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (111, N'PAREDES 	', N'CABRERA	', N'NELSON ERIK	', NULL, NULL, N'46938467', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (112, N'PARICAHUA', N'VILCA	', N'AGUSTIN	', NULL, NULL, N'70044209', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (113, N'PARICAHUA', N'VILCA	', N'CIRIACO	', NULL, NULL, N'43658646', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (114, N'PARIONA 	', N'HUARCAYA', N'	 GONZALO	', NULL, NULL, N'21554279', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (115, N'PINO 	', N'ASTOYAURI	', N'BRAULIO EUSEBIO	', NULL, NULL, N'74484158', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (116, N'PISCONTE 	', N'DIAZ	', N'EDY NORMAN	', NULL, NULL, N'41331450', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (117, N'POCCOHUANCA', N'	', N'JAVIER	 HENRY	', NULL, NULL, N'71568480', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (118, N'QUINTO 	', N'CCANTO	', N'ALFREDO	', NULL, NULL, N'47242959', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (119, N'QUISPE 	', N'CONISLLA  	', N'ADRIAN	', NULL, NULL, N'21569000', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (120, N'QUISPE 	', N'MAMANI	', N'WALTER	', NULL, NULL, N'45428595', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (121, N'QUISPE 	', N'QUISPE	', N'PERCY ROSAMEL	', NULL, NULL, N'44341111', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (122, N'RAFAELE 	', N'PALOMINO  	', N'FERMIN	', NULL, NULL, N'42810039', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (123, N'RAFAELE 	', N'QUISPE	', N'NILTON ARMANDO	', NULL, NULL, N'47477860', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (124, N'RAMOS 	', N'HUILLCA	', N'ERNESTO	', NULL, NULL, N'47473476', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (125, N'RENDON 	', N'VERA	', N'ERASMO	', NULL, NULL, N'24805561', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (126, N'REYES 	', N'CONOZCO	', N'JUAN LEONCIO	', NULL, NULL, N'23700823', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (127, N'ROMO 	', N'SANTOS	', N'JULIO CESAR	', NULL, NULL, N'20047359', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (128, N'RUEDA 	', N'QUISPE	', N'SANTIAGO FERNANDO	', NULL, NULL, N'21414313', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (129, N'SARMIENTO', N'TOLENTINO	', N'JOSE LUIS	', NULL, NULL, N'48020669', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (130, N'SOTO 	', N'CATALAN	', N'ALBERTO	', NULL, NULL, N'41177947', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (131, N'TORRES 	', N'RAMOS	', N'MARCIANO	', NULL, NULL, N'45239116', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (132, N'VARGAS 	', N'YUPANQUI    	', N'SALOMON	', NULL, NULL, N'44009074', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (133, N'YAURICASA', N'MEJIA	', N'JHONATAN JAVIER	', NULL, NULL, N'70175586', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (134, N'YAURICASA', N'QUISPE	', N'UVALDO	', NULL, NULL, N'44845093', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (135, N'YAURICASA', N'TOLEDO	', N'ROQUE JAVIER	', NULL, NULL, N'45053354', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (136, N'YUCRA 	', N'QUISPE	', N'JOSE ANTONIO	', NULL, NULL, N'80118595', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[Person] ([Id], [PaternalName], [MaternalName], [Names], [BusinessName], [Ruc], [Dni], [HomePhone], [MobilePhone], [Email], [Address], [BirthDate], [TypePersonId], [Status]) VALUES (137, N'ZELA 	', N'HUAMAN	', N'FRANCISCO	', NULL, NULL, N'48217840', NULL, NULL, NULL, NULL, NULL, 1, 1)
SET IDENTITY_INSERT [dbo].[Person] OFF
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (1, N'ACUÑA JAUREGUI, DANY KEVIN', N'', N'48397719', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (2, N'AGUILAR QUISPE, ANA TERESA', N'', N'10175122', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. ADMINISTRATIVA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (3, N'ALCANTARA VILLAVICENCIO, DANNY ALEX', N'', N'44464994', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. TOPOGRAFIA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (4, N'ALEJO ZAPANA, YENCE KONAN', N'', N'48433163', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - VERTICAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (5, N'ALI QUISPE, ALVARO EVER', N'', N'46464179', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (6, N'ALIAGA HUAYNALAYA, JEAN POOL', N'', N'70134827', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. LOGISTICA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (7, N'ALIAGA YAÑAC, MIGUEL ANGEL', N'', N'16168224', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (8, N'ALMIRON HUAMANI, GUIDO CIRILO', N'', N'46847175', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (9, N'ALVAREZ MAMANI, BERNABE', N'', N'48740184', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (10, N'ALVAREZ MAMANI, ELOY', N'', N'45846950', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (11, N'ALVIS BAUTISTA, FERNANDO', N'', N'47554094', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - VERTICAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (12, N'ALVITREZ BENDEZU, DAVID', N'', N'23256010', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LIMPIEZA ACARREO EXTRACCION DESARROLLO')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (13, N'ANAMPA CHIPANA, ELMER RICARDO', N'', N'71640072', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - VERTICAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (14, N'ANAMPA CHIPANA, SAUL DANIEL', N'', N'70382886', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - VERTICAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (15, N'ANAMPA VARA, FERMIN DARIO', N'', N'80061222', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ALIMENTACION Y CLASIFICACION PAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (16, N'ANCHAHUA ZEVALLOS, CARLOS EDISON', N'', N'43432427', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (17, N'ANCHAHUA ZEVALLOS, VANESSA MARISOL', N'', N'44512203', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. RRHH')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (18, N'ANDIA DE LA MATA, WILFREDO', N'', N'23523553', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (19, N'APACCLLA RIVEROS, RAFAEL', N'', N'23271593', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. ECONOMICA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (20, N'ARAPA SOLANO, GERARDO', N'', N'29442043', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ABAST. SERV. INT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (21, N'ARENAS RENDON, ANGEL', N'', N'43107522', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (22, N'ARENAS RENDON, FREDI', N'', N'42050726', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (23, N'ARGOT NIÑO DE GUZMAN, DENNIS LUI', N'', N'75600660', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ALIMENTACION Y CLASIFICACION PAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (24, N'ARREDONDO CORNEJO, JOHN DANNY', N'', N'40839100', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'COMITE DE GERENCIAS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (25, N'ARROYO CABANA, ISMAEL', N'', N'42114971', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - HORIZONTAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (26, N'ASTO GUTIERREZ, RAUL JAVIER', N'', N'70351427', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (27, N'BACILIO ROBLES, MOISES', N'', N'40160527', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (28, N'BALDEON ÑAHUI, JHONSON HENRRY', N'', N'23466687', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (29, N'BARRIENTOS CASTILLO, TANY ALEX', N'', N'46167677', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (30, N'BENITES QUISPE, NILTON FLAVIO', N'', N'42116358', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. LABORATORIO QUIMICO')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (31, N'BOZA QUISPE, EULOGIO', N'', N'41962350', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ACARREO')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (32, N'BURGA REYES, JHONNY ABEL', N'', N'47992113', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ALIMENTACION Y CLASIFICACION PAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (33, N'CABEZAS LOAYZA, CLEVER', N'', N'43041023', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. LABORATORIO QUIMICO')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (34, N'CABRERA LLOSA, OSCAR', N'', N'30674327', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (35, N'CACERES ROMERO, ELEAZAR FAUSTO', N'', N'22281600', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'TRACTOR ORUGA CAT D6N')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (36, N'CAJAHUACCHA CHACO, BERNARDINO BASILIO', N'', N'41327898', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - VERTICAL SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (37, N'CALDERON CARI, WILLIAMS', N'', N'45955161', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (38, N'CALDERON NAVENTA, CARLOS JAVIER', N'', N'80007668', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. LABORATORIO QUIMICO')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (39, N'CALLA APAZA, GUMERCINDO', N'', N'29635971', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'CHANCADO OPERACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (40, N'CALLA CANAHUA, ALVARO', N'', N'42138139', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (41, N'CAMPOS FLORES, CAMILO ENRIQUE', N'', N'29487968', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (42, N'CANDIOTTI QUISPE, MASAGUEL MERARDO', N'', N'70087318', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ABAST. SERV. INT. MINA SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (43, N'CARBAJAL GOMEZ, FLAVIO', N'', N'40093599', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (44, N'CARBAJAL LEON, JASIEL RAFAEL', N'', N'47280468', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ABAST. SERV. INT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (45, N'CARDENAS HUAMANI, YERE ERNESTO', N'', N'70580363', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - HORIZONTAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (46, N'CARI CONDORI, YONY JUAN', N'', N'40615765', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. LOGISTICA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (47, N'CASTAÑEDA GRIJALBA, OSCAR', N'', N'27563095', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO PLANTA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (48, N'CAUTE HOYOS, CESAR GUSTAVO', N'', N'44560390', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (49, N'CAXI LLANO, YOMAN', N'', N'47299798', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. TOPOGRAFIA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (50, N'CCARHUAS RAMIREZ, JUAN CARLOS', N'', N'46361621', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. OBRAS CIVILES')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (51, N'CCOAQUIRA HUAMANI, CRISOLOGO', N'', N'24806642', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (52, N'CEPERIAN LOAYZA, VALENTIN ALBINCO', N'', N'22295950', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ABASTECIMIENTO DE AGUA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (53, N'CEPERIAN LOPEZ, ALDO RAFAEL', N'', N'47648098', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (54, N'CHACON CASTILLO, EDUAR YVAN', N'', N'48723511', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. GEOLOG. Y EXPLOR.')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (55, N'CHAMBILLA CORDOVA, RAUL', N'', N'43354508', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ABAST. SERV. INT. MINA SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (56, N'CHAMBILLA CORDOVA, WILLIAM', N'', N'41933709', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PROGRAMA DE MEJORA Y AMPLIACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (57, N'CHARCAHUANA QUILLE, JOEL ANGEL', N'', N'75127843', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (58, N'CHAUCA ROJAS, GIAN MARCOS', N'', N'45657823', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DESORCION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (59, N'CHAVEZ FILIO, HECTOR', N'', N'21562634', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'COMITE DE GERENCIAS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (60, N'CHAVEZ MONTOYA, WILBERTO GENARO', N'', N'80007430', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (61, N'CHAVEZ RIOS, POOL ANDREW', N'', N'46162544', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. OBRAS CIVILES')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (62, N'CHIPANA LLACTA, MARGARITA FORTUNATA', N'', N'10728884', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ACOPIO MINERAL TERCEROS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (63, N'CHIPANI CORDOVA, YABAR', N'', N'40122970', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (64, N'CHOQUE GUZMAN, FRANCISCO', N'', N'40985006', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (65, N'CHOQUE MENESES, EUGENIO LEOPOLDO', N'', N'29652478', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'COMITE DE GERENCIAS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (66, N'CHUCTAYA GUTIERREZ, JOHN', N'', N'47186737', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (67, N'CHUCTAYA GUTIERREZ, JUVENAL', N'', N'74821687', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - VERTICAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (68, N'COLQUE CCAHUANA, ADDOM RONAL', N'', N'47378817', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (69, N'CONDE HUAMANÍ, JUAN BAUTISTA', N'', N'30582478', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ACOPIO MINERAL TERCEROS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (70, N'CONDO RAMOS, WILBER JAIME', N'', N'44516726', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (71, N'CONDORI QUISPE, VICTOR', N'', N'44624363', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'VOLQUETE DONG FENG PLACA F4A - 946')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (72, N'CONOZCO RAMOS, GILMER', N'', N'76310920', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ABAST. SERV. INT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (73, N'CONOZCO RAMOS, RIDER', N'', N'47279730', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES EXPLORACION - VERTICAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (74, N'CONOZCO REYES, ALBERTO', N'', N'46608283', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ALIMENTACION Y CLASIFICACION PAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (75, N'CONOZCO RIVEROS, EDVIN SANTIAGO', N'', N'20037965', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (76, N'CONTRERAS ROBLES, ELA', N'', N'16137361', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (77, N'CORDOVA HUAMANCHAQUI, HECTOR MILLER', N'', N'43615219', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - HORIZONTAL SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (78, N'CORILLOCLLA ELESCANO, HEIDI SAIDA', N'', N'40860400', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. RRHH')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (79, N'CORNEJO BRACKE, ELOY UBALDO', N'', N'10170662', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (80, N'CORONADO CONTRERAS, JEAN CARLOS', N'', N'47371925', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - VERTICAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (81, N'CORRALES HUARCA, JAIME', N'', N'40720226', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (82, N'COSI COSI, HUBERT RODRIGO', N'', N'42964906', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. TOPOGRAFIA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (83, N'CRUZ GALVAN, JORGE ALFREDO', N'', N'46150199', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ALIMENTACION Y CLASIFICACION PAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (84, N'CRUZ PINEDA, CLIVER', N'', N'74042326', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES PREPARACION - HORIZONTAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (85, N'CRUZ RAMOS, SAUL', N'', N'40717099', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (86, N'CRUZ RAMOS, VALENTIN', N'', N'47159958', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ABAST. SERV. INT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (87, N'CRUZ RAMOS, VICTOR', N'', N'45387468', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (88, N'CURO VALENCIA, JESUS', N'', N'45088964', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (89, N'CURO ZAPANA, JAVIER FERNANDO', N'', N'42922696', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (90, N'CUTI SANCHEZ, ALBERTO', N'', N'24710157', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (91, N'CUTIPA RODRIGUEZ, RODRIGO', N'', N'43167109', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'MOLIENDA OPERACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (92, N'DAVILA BRAVO, JOEL JEREMIAS', N'', N'46774658', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'CARGADOR FRONTAL CAT 962H')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (93, N'DE LA CRUZ ICHPAS, JULIO', N'', N'41459547', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (94, N'DE LA CRUZ JAVIER, ELMER', N'', N'71966899', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (95, N'DE LA CRUZ SALVADOR, YONI MIQUIAS', N'', N'20071576', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (96, N'DE LA CRUZ TITO, MANUEL VICTOR', N'', N'30424456', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. OBRAS CIVILES')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (97, N'DELGADO SUMARAN, NELSON MISAEL', N'', N'71207842', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (98, N'DIAZ CHAVARRIA, NELBIN', N'', N'43717803', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. PLANTA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (99, N'DIAZ GUEVARA, JOSE LUIS', N'', N'46044271', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (100, N'DIAZ LEON, MIGUEL ANGEL', N'', N'47540626', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. GEOLOG. Y EXPLOR.')
GO
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (101, N'DIAZ QUISPE, SEVERO', N'', N'43524385', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (102, N'ELLIS HOYOS, LUIS ANTONIO', N'', N'80278467', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'CHANCADO OPERACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (103, N'ESCOBAR LA TORRE, MOISES RODRIGO', N'', N'23522804', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. ADMINISTRATIVA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (104, N'ESCOBAR MADRID, CLEVER JHON', N'', N'43689659', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (105, N'ESCOBAR RODRIGUEZ, JOSE LITO', N'', N'45913852', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'CIANURACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (106, N'ESCOBAR SANCHEZ, ALFREDO', N'', N'46679289', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (107, N'ESPINOZA CUSSI, CLEMENTE', N'', N'24717101', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'CARGADOR FRONTAL KOMATSU WA-200')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (108, N'ESPINOZA QUISPE, MARCO POLO', N'', N'41706970', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (109, N'ESPINOZA RECINAS, NELFOR', N'', N'42725405', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION DIAMANTINA SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (110, N'FERNANDEZ CHECCA, FREDY', N'', N'45118749', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - HORIZONTAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (111, N'FERNANDEZ FLORES, ALAN EDISON', N'', N'45135850', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO PLANTA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (112, N'FERNANDEZ RODRIGUEZ, ALEXANDER LAZARO', N'', N'45896850', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'CHANCADO OPERACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (113, N'FERNANDEZ ROJAS, FRANZ JOHANN', N'', N'44940761', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (114, N'FERREYRA AGÜERO, SAMUEL GONZALO', N'', N'21428504', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ACOPIO MINERAL TERCEROS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (115, N'FERREYRA HUAMANI, LUIS GERARDO', N'', N'45204134', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (116, N'FLORES ALCOCER, RUBEN GREGORIO', N'', N'19826303', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. LOGISTICA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (117, N'FLORES CALDERON, ROGELIO CARLOS', N'', N'30497242', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PROGRAMA DE MEJORA Y AMPLIACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (118, N'FLORES HUANCA, ERNESTO', N'', N'41508327', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'CARGADOR FRONTAL CAT 938K')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (119, N'FLORES PACOMPIA, DELFIN', N'', N'80255706', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (120, N'FLORES PILCO, JULIO CESAR', N'', N'799013', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (121, N'FLORES QUISPE, JOSE WILBER', N'', N'41453357', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ACOPIO MINERAL TERCEROS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (122, N'FLORES QUISPE, YONY', N'', N'70493819', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - VERTICAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (123, N'FUENTES ZAPANA, JOSE DANIEL', N'', N'48599302', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ALIMENTACION Y CLASIFICACION PAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (124, N'GALARZA QUILCA, HUGO NILO', N'', N'23666109', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (125, N'GALARZA QUILLCA, LEVER', N'', N'23682708', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (126, N'GARAYAR SAUÑE, GUILLERMO VIRGILIO', N'', N'80491651', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (127, N'GOMEZ CALLE, MARIO', N'', N'21571904', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'VOLQUETE VOLVO FM-12 PLACA B3N - 922')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (128, N'GOMEZ CALLE, WILLIAM RAUL', N'', N'44564166', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (129, N'GONZALES MUÑOZ, NEHEMIAS', N'', N'73789007', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - HORIZONTAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (130, N'GUTIERREZ CHIQUIHUAYTA, WILBER JOAQUIN', N'', N'29543053', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. LOGISTICA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (131, N'GUTIERREZ MARTINEZ, GLEN JULIAN', N'', N'8930913', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (132, N'GUTIERREZ YUCRA, JOHN LAZARO', N'', N'43368759', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (133, N'HANCCO CHAMBI, ALEXSANDER', N'', N'70032560', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ABAST. SERV. INT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (134, N'HERMOZA COLQUE, GAVINO', N'', N'77575734', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LIXIVIACION PAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (135, N'HERMOZA HUAMAN, ANGEL', N'', N'24668071', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. PAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (136, N'HERMOZA HUILLCA, JOSE ANGEL', N'', N'46188803', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (137, N'HUACHACA GOMEZ, ORLANDO WILFREDO', N'', N'29687315', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'CAMION CISTERNA HINO PLACA AES - 900')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (138, N'HUALLPA MEZA, JUAN DE DIOS', N'', N'41384461', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO PLANTA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (139, N'HUAMAN BAYLON, RUDY CALLAJA FELIX', N'', N'70090153', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'CARGADOR FRONTAL KOMATSU WA-200')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (140, N'HUAMAN CAHUANA, DANIEL', N'', N'46437681', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES PREPARACION - VERTICAL SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (141, N'HUAMAN CHAUCA, HECTOR RAUL', N'', N'21481307', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. OBRAS CIVILES')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (142, N'HUAMAN DIAZ, ABNER', N'', N'46594613', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - HORIZONTAL SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (143, N'HUAMAN DIAZ, GUDVER', N'', N'44576637', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - HORIZONTAL SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (144, N'HUAMAN DIAZ, YHENSON', N'', N'47645021', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - VERTICAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (145, N'HUAMAN HUAROTO, JORGE', N'', N'23545801', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (146, N'HUAMANCAYO MANRIQUE, ROLANDO ULISES', N'', N'22283519', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'COMITE DE GERENCIAS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (147, N'HUAMANI ATOCCZA, CASTOR DOROTEO', N'', N'21485741', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. LOGISTICA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (148, N'HUAMANI AVENDAÑO, RUVER', N'', N'44075508', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. PLANEAMIENTO')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (149, N'HUAMANI BERROCAL, BRIGIDA TOLA', N'', N'43885559', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. ECONOMICA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (150, N'HUAMANI MEDINA, JONNY TEODORO', N'', N'70339597', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (151, N'HUAMANI MEDINA, JULIO AGAPITO', N'', N'44648312', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES PREPARACION - VERTICAL SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (152, N'HUAMANI RAMOS, EULOGIO', N'', N'31301147', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES PREPARACION - HORIZONTAL SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (153, N'HUAMANI ZAPANA, LUIS MIGUEL', N'', N'45529887', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. GEOLOG. Y EXPLOR.')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (154, N'HUAMPA CAHUANA, ABELARDO', N'', N'44054042', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (155, N'HUARCAYA MENDOZA, ABEL ALEXANDER', N'', N'47626615', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - HORIZONTAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (156, N'HUAYHUA QUILLE, DIEGO ARMANDO', N'', N'47502954', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (157, N'HUAYRE ACEVEDO, RONAL CESAR', N'', N'44877597', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (158, N'HUILLCAHUAMAN POMA, MIRIAN CATALINA', N'', N'43495339', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. LABORATORIO QUIMICO')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (159, N'HUINCHO NOA, PABLO', N'', N'47043427', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (160, N'HUISA LLAIQUE, CLAUDIO GERARDO', N'', N'40064887', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ABAST. SERV. INT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (161, N'HUISA VILCA, FELIX', N'', N'2151009', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (162, N'HURTADO CARBAJAL, MAURO', N'', N'45185599', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (163, N'ILAQUITA YANCAPALLO, VICENTE PAUL', N'', N'80280753', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (164, N'INGA APARCO, JULIO', N'', N'41265377', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (165, N'JANAMPA ICHPAS, ANTONIO', N'', N'46031865', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - VERTICAL SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (166, N'JANAMPA ICHPAS, GREGORIO', N'', N'42235741', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (167, N'JANAMPA ICHPAS, SAMUEL', N'', N'47480950', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (168, N'JIMENEZ GUERRA, VICTOR', N'', N'25713027', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (169, N'JIMENEZ PERALTA, AMADEUS', N'', N'29708513', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'COMITE DE GERENCIAS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (170, N'JIMENEZ QUISPE, EDGAR ANTONIO', N'', N'80555760', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (171, N'JUAREZ CHOQUEMAMANI, ADOLFO NOE', N'', N'42050041', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - VERTICAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (172, N'LA ROSA FLORES, JESUS EVARISTO', N'', N'45568207', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'MOLIENDA OPERACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (173, N'LA ROSA ROMERO, LEONEL FERNANDO', N'', N'44573747', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. PLANTA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (174, N'LAYMI QUINTO, HENRY', N'', N'46755176', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (175, N'LAZARO HERRERA, JUSTO GERMAN', N'', N'42384162', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES PREPARACION - VERTICAL SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (176, N'LAZARO ROMERO, IVAN FELIX', N'', N'41985212', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. PLANTA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (177, N'LAZARO ROMERO, SAMUEL JESUS', N'', N'47558276', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. LABORATORIO QUIMICO')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (178, N'LIMA CHIPA, EDSON', N'', N'46917348', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. ECONOMICA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (179, N'LLACCHUA MEZA, SANTOS', N'', N'31144133', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ABASTECIMIENTO DE AGUA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (180, N'LLAMOCCA HUAMANCHA, RICARDO', N'', N'28851585', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LIXIVIACION PAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (181, N'LLAMOSAS BARRIGA, HUGO RUFINO', N'', N'41068165', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. SEGURIDAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (182, N'LOPEZ CARLOS, CERILO', N'', N'41882410', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (183, N'LOPEZ MEDINA, FLAVIO ESTANISLAO', N'', N'9286977', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'COMITE DE GERENCIAS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (184, N'LOYOLA LEON, KAROLAY STEPHANI', N'', N'46081398', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. ADMINISTRATIVA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (185, N'MADRID DIAZ, MELISIO', N'', N'72229940', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - HORIZONTAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (186, N'MADRID DIAZ, MILQUER GILBERTO', N'', N'43360592', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES EXPLORACION - VERTICAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (187, N'MAMANI CORRALES, OCTAVIO', N'', N'24585741', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (188, N'MAMANI CUTIPA, NOLBERTO', N'', N'46350047', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (189, N'MAMANI GUTIERREZ, ALFREDO', N'', N'41333129', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (190, N'MAMANI LAURA, CARLOS JOSE', N'', N'76700045', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. PAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (191, N'MAMANI PUMA, AGUSTIN', N'', N'45052736', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO PLANTA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (192, N'MARRON PACURI, RONALD ALEX', N'', N'46197547', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (193, N'MAYHUA SARAYA, ALONSO', N'', N'70414513', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. ECONOMICA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (194, N'MAYO URTECHO, JUAN MANUEL', N'', N'47158446', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. ECONOMICA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (195, N'MEDINA AYBAR, WILBER WILFREDO', N'', N'47909694', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (196, N'MEDINA CCACYA, JUAN FEDERICO', N'', N'44527336', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ALIMENTACION Y CLASIFICACION PAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (197, N'MEDINA TAPIA, MARTIN HERNANI', N'', N'25789318', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MEDIO AMBIENTE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (198, N'MEJIA MARCOS, ELVIS DUVAL', N'', N'40746722', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. PLANTA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (199, N'MEJIA QUISPE, JUAN', N'', N'40942018', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (200, N'MELGAR SOTOMAYOR, ANICETO MELQUIADES', N'', N'20101093', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. SEGURIDAD')
GO
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (201, N'MELGAREJO VALENZUELA, WILLIAM', N'', N'43478771', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. PLANTA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (202, N'MENDOZA APAZA, ISRAEL', N'', N'77270980', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ABAST. SERV. INT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (203, N'MENDOZA HUACHO, ODILON', N'', N'31426793', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (204, N'MENDOZA HUAYLLANI, JAVIER', N'', N'24806559', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (205, N'MENDOZA PAUCCARA, JORGE ADOLFO', N'', N'48546382', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (206, N'MENDOZA SANCHEZ, DONATO', N'', N'24707144', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (207, N'MERINO ACUÑA, EDGAR WILLY', N'', N'48343248', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES PREPARACION - HORIZONTAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (208, N'MONTAÑEZ VARGAS, BRAYAN', N'', N'46899457', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. TOPOGRAFIA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (209, N'MONTESINO COLLAO, BRAYAN DEMETRIO', N'', N'70115081', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (210, N'MONTOYA CAHUANA, FREDY', N'', N'46088207', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (211, N'MOSCOSO VILLALBA, MOISES DAVID', N'', N'41053149', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. OBRAS CIVILES')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (212, N'MUCHA QUINTO, FLAVIO MAXIMO', N'', N'41813111', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. SEGURIDAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (213, N'MUÑOA MEDINA, ERWIN MAYCOL', N'', N'46991930', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. PLANTA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (214, N'MUÑOZ CONTRERAS, HUGO', N'', N'19977467', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (215, N'NARCISO SALINAS, LUIS ANTONIO', N'', N'22530124', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. ADMINISTRATIVA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (216, N'NEYRA CASTRO, SILVESTRE MAXIMO', N'', N'30500888', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'VOLQUETE VOLVO FMX PLACA D5R - 872')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (217, N'NEYRA NIÑO DE GUZMAN, CESAR', N'', N'44162633', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. SEGURIDAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (218, N'NINA HERRERA, OMAR', N'', N'46076943', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'CARGADOR FRONTAL CAT 938K')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (219, N'NINA MAMANI, LUIS', N'', N'29532947', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DESORCION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (220, N'OCHOA MAYHUIRI, AGUSTIN CESAR', N'', N'72131112', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (221, N'OCHOA MAYHUIRI, BRUNO', N'', N'42661807', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (222, N'PACO FLORES, PEDRO GONZALO', N'', N'21872008', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (223, N'PADILLA GONZALES, WALDO ENRIQIUE', N'', N'40885093', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'VOLQUETE VOLVO FM-12 PLACA B3N - 922')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (224, N'PALACIOS GOICOCHEA, ARMIDA LILIANA', N'', N'26962706', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. ECONOMICA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (225, N'PALLI ALCA, GERSON NICOLAS', N'', N'72640822', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ALIMENTACION Y CLASIFICACION PAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (226, N'PALOMINO VERA, ANTONIO', N'', N'41512664', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. LOGISTICA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (227, N'PALOMINO VERA, CARLOS', N'', N'40670890', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (228, N'PAREDES CABRERA, JOSE ANTONIO', N'', N'76924592', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES PREPARACION - HORIZONTAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (229, N'PAREDES CABRERA, NELSON ERIK', N'', N'46938467', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES EXPLORACION - VERTICAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (230, N'PARICAHUA VILCA, AGUSTIN', N'', N'70044209', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES PREPARACION - HORIZONTAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (231, N'PARICAHUA VILCA, CIRIACO', N'', N'43658646', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (232, N'PARILLO SUPO, TEOFILA', N'', N'1293910', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (233, N'PARIONA HUARCAYA, GONZALO', N'', N'21554279', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. OBRAS CIVILES')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (234, N'PARIONA TORRES, JUAN MAXIMO', N'', N'21483415', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (235, N'PEREZ RIVAS, JHON DILMER', N'', N'47496892', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MEDIO AMBIENTE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (236, N'PINO ASTOYAURI, BRAULIO EUSEBIO', N'', N'74484158', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (237, N'PISCONTE DIAZ, EDY NORMAN', N'', N'41331450', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (238, N'POCCOHUANCA JAVIER, HENRY', N'', N'71568480', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - HORIZONTAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (239, N'POMA POMA, JUAN', N'', N'30853870', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (240, N'PONCE MORALES, MARILYN', N'', N'42194991', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. ECONOMICA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (241, N'QUILLE CONDO, VICTOR CACIANO', N'', N'29702217', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (242, N'QUILLE JIMENEZ, KAREN GABRIELA', N'', N'45345563', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'COMITE DE GERENCIAS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (243, N'QUINTO CCANTO, ALFREDO', N'', N'47242959', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (244, N'QUISPE ARIZACA, MIGUEL', N'', N'80019865', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. LABORATORIO QUIMICO')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (245, N'QUISPE BENDEZU, MIGUEL', N'', N'41135429', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (246, N'QUISPE CASAPUMA, MARIO', N'', N'23523888', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (247, N'QUISPE CHOCCA, FRANCISCO', N'', N'45311452', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (248, N'QUISPE CONISLLA, ADRIAN', N'', N'21569000', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (249, N'QUISPE CONISLLA, HUBER BASILIO', N'', N'43220061', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (250, N'QUISPE DIAZ, WENCESLAO', N'', N'24563086', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (251, N'QUISPE ESCOBAR, ANGEL', N'', N'44942079', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (252, N'QUISPE MAMANI, WALTER', N'', N'45428595', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES EXPLORACION - VERTICAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (253, N'QUISPE QUISPE, LAUREANO', N'', N'30950056', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (254, N'QUISPE QUISPE, PERCY ROSAMEL', N'', N'44341111', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (255, N'QUISPE SANCHEZ, ORLANDO', N'', N'43497562', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (256, N'QUISPE TORRICOS, PEDRO', N'', N'30405580', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'COMITE DE GERENCIAS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (257, N'QUISPE YANASUPO, ADRIAN', N'', N'40280397', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ACOPIO MINERAL TERCEROS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (258, N'RAFAELE PALOMINO, FERMIN', N'', N'42810039', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. OBRAS CIVILES')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (259, N'RAFAELE QUISPE, NILTON ARMANDO', N'', N'47477860', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (260, N'RAMOS BARRIOS, GRABIEL', N'', N'20071782', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (261, N'RAMOS BRAÑEZ, LUIS', N'', N'22296220', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (262, N'RAMOS CHIPANA, HEBER GONZALO', N'', N'46723632', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ACARREO')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (263, N'RAMOS HUILLCA, ERNESTO', N'', N'47473476', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (264, N'RAMOS HUMPIRI, SANTIAGO', N'', N'40277867', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. OBRAS CIVILES')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (265, N'RAMOS ROSARIO, JUAN JOSE', N'', N'80506321', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'CHANCADO OPERACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (266, N'RAMOS SALVADOR, TEODOCIO JACINTO', N'', N'23700878', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (267, N'RENDON VERA, ERASMO', N'', N'24805561', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (268, N'REQUEJO MEJIA, LUIS GABRIEL', N'', N'44223968', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. ECONOMICA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (269, N'REQUEJO URTEAGA, JOSE OMAR', N'', N'43205484', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. LOGISTICA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (270, N'REVATTA PARRA, JORGE LUIS', N'', N'41007395', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ACOPIO MINERAL TERCEROS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (271, N'REYES CASTRO, RICHARD', N'', N'71849443', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (272, N'REYES CONOZCO, JUAN LEONCIO', N'', N'23700823', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ABAST. SERV. INT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (273, N'REYES LLANTOY, VICTOR ANDRES', N'', N'43066865', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (274, N'RIVERA ACO, BRIDYIDTH DENNIS', N'', N'74080694', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ACOPIO MINERAL TERCEROS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (275, N'RIVERA BONILLA, EDUARDO ISAAC', N'', N'4205437', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. SEGURIDAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (276, N'RIVERA CARRERA, JOSE LUIS', N'', N'45314288', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. PAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (277, N'RIVERA LAZO, JHORDAN ITALO', N'', N'70244658', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - VERTICAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (278, N'RODRIGUEZ DE LA CRUZ, MICHAEL FRANCIS', N'', N'76766674', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (279, N'RODRIGUEZ MAYO, GIANCARLOS', N'', N'47035882', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'CHANCADO OPERACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (280, N'RODRIGUEZ MINO, SILVIA PATRICIA', N'', N'41440416', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'GEST. ECONOMICA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (281, N'RODRIGUEZ PEREZ, ROLDOSIN NICANDRO', N'', N'44054796', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'VOLQUETE DONG FENG PLACA F4A - 946')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (282, N'ROJAS CAMARGO, LUIS CARLOS', N'', N'20001629', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (283, N'ROJAS MARTINEZ, ADHONIS YURDHANO JACOB', N'', N'44382989', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. SEGURIDAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (284, N'ROJAS RAMOS, PERCY SERAFIN', N'', N'40048461', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'MOLIENDA OPERACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (285, N'ROJAS ROJAS, JOSE ADRIAN', N'', N'26726194', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (286, N'ROJAS SANCHEZ, SANTOS LEONARDO', N'', N'46683432', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ACOPIO MINERAL TERCEROS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (287, N'ROJAS YUCRA, HIPOLITO CASIMIRO', N'', N'32131898', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (288, N'ROMERO HUAMANCAYO, IVAN GIOVANY', N'', N'46811094', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'CARGADOR FRONTAL CAT 962H')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (289, N'ROMERO JULCA, SILVERIO', N'', N'48605205', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LIXIVIACION PAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (290, N'ROMERO REYES, IGNACIO JULIAN', N'', N'20118762', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ALIMENTACION Y CLASIFICACION PAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (291, N'ROMO SANTOS, JULIO CESAR', N'', N'20047359', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LIMPIEZA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (292, N'RUEDA QUISPE, SANTIAGO FERNANDO', N'', N'21414313', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (293, N'RUEDA URBANO, CARLOS SANTIAGO', N'', N'16128311', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. SISTEMAS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (294, N'SALCEDO CUTIRE, CARLOS CRISTIAN', N'', N'61438792', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - VERTICAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (295, N'SALINAS CALDERON, MARICELI ANABEL', N'', N'45497209', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (296, N'SANCHEZ CAHUANA, SAMUEL', N'', N'41880489', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'VOLQUETE DONG FENG PLACA F4A - 946')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (297, N'SANCHEZ CARBAJAL, URIEL', N'', N'6260941', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. SEGURIDAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (298, N'SANCHEZ PARRA, RAFAEL', N'', N'46021219', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ABAST. SERV. INT. MINA SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (299, N'SANCHEZ PARRA, WILLIAM ARMANDO', N'', N'47188837', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (300, N'SANCHEZ PORTAL, JORGE LUIS', N'', N'45803129', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. GEOLOG. Y EXPLOR.')
GO
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (301, N'SANGAMA FASABI, TERCERO ILDEFONSO', N'', N'40991119', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'CHANCADO OPERACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (302, N'SANTIAGO CARLOS, FRANCISCO', N'', N'23019035', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LIMPIEZA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (303, N'SANTIAGO FALCON, VICTOR ROMEL', N'', N'48852539', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (304, N'SANTOS ZAVALA, GHERSON GIANMARCO', N'', N'47606799', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DESORCION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (305, N'SAPACAYO CCAHUACHIA, JUAN TEODORO', N'', N'24880747', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'COMITE DE GERENCIAS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (306, N'SAPACAYO THEA, PERCY', N'', N'29631837', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ACOPIO MINERAL TERCEROS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (307, N'SARMIENTO TOLENTINO, JOSE LUIS', N'', N'48020669', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (308, N'SOLANO POLO, PEPER RITHER', N'', N'4015053', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (309, N'SOTELO BERROSPI, FELIX ALEJANDRO', N'', N'46822520', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (310, N'SOTO CATALAN, ALBERTO', N'', N'41177947', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. GEOLOG. Y EXPLOR.')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (311, N'TAMANI PARANA, SOLIS', N'', N'44755940', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'SERV. EXTRACCION IZAJE')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (312, N'TICONA RUELAS, RENE', N'', N'45202237', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES PREPARACION - VERTICAL SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (313, N'TINOCO TERRAZO, NIKVER JONATHAN', N'', N'71960509', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (314, N'TOLA MAMANI, EDGAR', N'', N'2440398', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES PREPARACION - VERTICAL SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (315, N'TORALVA RECINAS, ARTURO LUIS', N'', N'41523087', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. GEOLOG. Y EXPLOR.')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (316, N'TORRES DELGADO, JAIME JOEL', N'', N'42042949', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'COMITE DE GERENCIAS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (317, N'TORRES HUACHO, GRIMALDO', N'', N'29486313', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. ADMINISTRACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (318, N'TORRES HUAMANI, JOSE SAUL', N'', N'46853146', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. PLANTA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (319, N'TORRES JAYO, WILMER JONATHAN', N'', N'72708882', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (320, N'TORRES LLOCLLA, ROGELIO', N'', N'71239674', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ABAST. SERV. INT. MINA SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (321, N'TORRES RAMOS, MARCIANO', N'', N'45239116', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ABAST. SERV. INT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (322, N'UGARTE LOPEZ, EDWIN', N'', N'41220992', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (323, N'VALERO PERALTA, LUIS FRANCISCO', N'', N'43990252', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - VERTICAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (324, N'VARGAS YUPANQUI, SALOMON', N'', N'44009074', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - HORIZONTAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (325, N'VASQUEZ FACUNDO, BENJAMIN', N'', N'30484985', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'COMITE DE GERENCIAS')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (326, N'VASQUEZ ZAMORA, VICTOR HUGO', N'', N'43790194', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'MOLIENDA OPERACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (327, N'VIDARTE BRAVO, JOSE', N'', N'46943365', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'CHANCADO OPERACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (328, N'VILLANUEVA LINARES, JUAN', N'', N'30641826', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (329, N'VILLEGAS BALDEON, ELIAZAR VETO', N'', N'41729588', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. GEOLOG. Y EXPLOR.')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (330, N'VIZCARRA HERMOZA, LUIS ENRIQUE', N'', N'46103922', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LIXIVIACION PAD')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (331, N'YALLERCCO VIZCARRA, CECILIO', N'', N'80263736', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (332, N'YANQUI CAPACOILA, ALBERTO', N'', N'2488', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'ABAST. SERV. INT. MINA SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (333, N'YARETA APAZA, WILSON', N'', N'48767457', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES PREPARACION - HORIZONTAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (334, N'YAURI MONTES, MARCOS ANTONIO', N'', N'48316882', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES EXPLORACION - VERTICAL SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (335, N'YAURICASA MEJIA, JHONATAN JAVIER', N'', N'70175586', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - HORIZONTAL')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (336, N'YAURICASA QUISPE, UVALDO', N'', N'44845093', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MINA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (337, N'YAURICASA TOLEDO, ROQUE JAVIER', N'', N'45053354', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (338, N'YESANG CASTILLO, FRANCISCO JAVIER', N'', N'43207464', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DEPT. MTTO PLANTA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (339, N'YUCRA CHOCHOCA, IVAN ALEJANDRO', N'', N'44321781', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'DESORCION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (340, N'YUCRA QUISPE, JOSE ANTONIO', N'', N'80118595', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (341, N'ZAPANA VALDIVIA, BRANNY ANTHONY', N'', N'71439242', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'LABORES DESARROLLO - VERTICAL SANTA ROSA')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (342, N'ZELA HUAMAN, FRANCISCO', N'', N'48217840', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'PERFORACION')
INSERT [dbo].[Personas] ([Id_Persona], [Per_RazonSocial], [Per_Ruc], [Per_Dni], [Per_TlfFijo], [Per_TlfMovil], [Per_Email], [Per_Direccion], [Per_Fecha], [Per_Tipo], [Per_Saldo], [Per_Sueldo], [CARGO], [AREA]) VALUES (343, N'', N'', N'', N'', N'', N'', N'', CAST(N'2016-04-08 00:00:00.000' AS DateTime), N'', 0, 0, N'', N'')
SET IDENTITY_INSERT [dbo].[Service] ON 

INSERT [dbo].[Service] ([Id], [Name], [Prece], [CurrencyTypeId], [Active], [Status]) VALUES (1, N'Desayuno', CAST(6.00 AS Decimal(18, 2)), 1, 1, 1)
INSERT [dbo].[Service] ([Id], [Name], [Prece], [CurrencyTypeId], [Active], [Status]) VALUES (2, N'Almuerzo', CAST(9.00 AS Decimal(18, 2)), 1, 1, 1)
INSERT [dbo].[Service] ([Id], [Name], [Prece], [CurrencyTypeId], [Active], [Status]) VALUES (3, N'Cena', CAST(6.00 AS Decimal(18, 2)), 1, 1, 1)
SET IDENTITY_INSERT [dbo].[Service] OFF
SET IDENTITY_INSERT [dbo].[ServiceItem] ON 

INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (1, 1, 1, CAST(N'2016-04-17 11:01:43.157' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (2, 2, 1, CAST(N'2016-04-17 11:01:43.157' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (3, 3, 1, CAST(N'2016-04-17 11:01:43.157' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (4, 1, 2, CAST(N'2016-04-17 11:01:43.157' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (5, 2, 2, CAST(N'2016-04-17 11:01:43.160' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (6, 3, 2, CAST(N'2016-04-17 11:01:43.160' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (7, 1, 3, CAST(N'2016-04-17 11:01:43.160' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (8, 2, 3, CAST(N'2016-04-17 11:01:43.160' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (9, 3, 3, CAST(N'2016-04-17 11:01:43.160' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (10, 1, 4, CAST(N'2016-04-17 11:01:43.160' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (11, 2, 4, CAST(N'2016-04-17 11:01:43.160' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (12, 3, 4, CAST(N'2016-04-17 11:01:43.160' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (13, 1, 5, CAST(N'2016-04-17 11:01:43.160' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (14, 2, 5, CAST(N'2016-04-17 11:01:43.160' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (15, 3, 5, CAST(N'2016-04-17 11:01:43.163' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (16, 1, 6, CAST(N'2016-04-17 11:01:43.163' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (17, 2, 6, CAST(N'2016-04-17 11:01:43.163' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (18, 3, 6, CAST(N'2016-04-17 11:01:43.163' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (19, 1, 7, CAST(N'2016-04-17 11:01:43.163' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (20, 2, 7, CAST(N'2016-04-17 11:01:43.163' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (21, 3, 7, CAST(N'2016-04-17 11:01:43.163' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (22, 1, 1, CAST(N'2016-04-18 11:01:43.180' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (23, 2, 1, CAST(N'2016-04-18 11:01:43.190' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (24, 3, 1, CAST(N'2016-04-18 11:01:43.190' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (25, 1, 2, CAST(N'2016-04-18 11:01:43.190' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (26, 2, 2, CAST(N'2016-04-18 11:01:43.207' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (27, 3, 2, CAST(N'2016-04-18 11:01:43.207' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (28, 1, 3, CAST(N'2016-04-18 11:01:43.207' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (29, 2, 3, CAST(N'2016-04-18 11:01:43.207' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (30, 3, 3, CAST(N'2016-04-18 11:01:43.210' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (31, 1, 4, CAST(N'2016-04-18 11:01:43.210' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (32, 2, 4, CAST(N'2016-04-18 11:01:43.210' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (33, 3, 4, CAST(N'2016-04-18 11:01:43.210' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (34, 1, 5, CAST(N'2016-04-18 11:01:43.210' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (35, 2, 5, CAST(N'2016-04-18 11:01:43.210' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (36, 3, 5, CAST(N'2016-04-18 11:01:43.210' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (37, 1, 6, CAST(N'2016-04-18 11:01:43.210' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (38, 2, 6, CAST(N'2016-04-18 11:01:43.210' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (39, 3, 6, CAST(N'2016-04-18 11:01:43.210' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (40, 1, 7, CAST(N'2016-04-18 11:01:43.210' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (41, 2, 7, CAST(N'2016-04-18 11:01:43.210' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (42, 3, 7, CAST(N'2016-04-18 11:01:43.210' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (43, 1, 1, CAST(N'2016-04-19 11:01:43.217' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (44, 2, 1, CAST(N'2016-04-19 11:01:43.217' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (45, 3, 1, CAST(N'2016-04-19 11:01:43.217' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (46, 1, 2, CAST(N'2016-04-19 11:01:43.217' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (47, 2, 2, CAST(N'2016-04-19 11:01:43.217' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (48, 3, 2, CAST(N'2016-04-19 11:01:43.217' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (49, 1, 3, CAST(N'2016-04-19 11:01:43.217' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (50, 2, 3, CAST(N'2016-04-19 11:01:43.220' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (51, 3, 3, CAST(N'2016-04-19 11:01:43.220' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (52, 1, 4, CAST(N'2016-04-19 11:01:43.220' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (53, 2, 4, CAST(N'2016-04-19 11:01:43.220' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (54, 3, 4, CAST(N'2016-04-19 11:01:43.220' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (55, 1, 5, CAST(N'2016-04-19 11:01:43.220' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (56, 2, 5, CAST(N'2016-04-19 11:01:43.220' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (57, 3, 5, CAST(N'2016-04-19 11:01:43.220' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (58, 1, 6, CAST(N'2016-04-19 11:01:43.220' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (59, 2, 6, CAST(N'2016-04-19 11:01:43.220' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (60, 3, 6, CAST(N'2016-04-19 11:01:43.220' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (61, 1, 7, CAST(N'2016-04-19 11:01:43.220' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (62, 2, 7, CAST(N'2016-04-19 11:01:43.220' AS DateTime), CAST(9.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[ServiceItem] ([Id], [ServiceId], [EmployeeId], [ServiceItemDate], [Payment], [Status]) VALUES (63, 3, 7, CAST(N'2016-04-19 11:01:43.220' AS DateTime), CAST(6.00 AS Decimal(18, 2)), 1)
SET IDENTITY_INSERT [dbo].[ServiceItem] OFF
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [employee_area_fk] FOREIGN KEY([AreaId])
REFERENCES [dbo].[Area] ([Id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [employee_area_fk]
GO
ALTER TABLE [dbo].[Service]  WITH CHECK ADD  CONSTRAINT [service_currencytype_fk] FOREIGN KEY([CurrencyTypeId])
REFERENCES [dbo].[CurrencyType] ([Id])
GO
ALTER TABLE [dbo].[Service] CHECK CONSTRAINT [service_currencytype_fk]
GO
ALTER TABLE [dbo].[ServiceItem]  WITH CHECK ADD  CONSTRAINT [serviceitem_employee_fk] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[ServiceItem] CHECK CONSTRAINT [serviceitem_employee_fk]
GO
ALTER TABLE [dbo].[ServiceItem]  WITH CHECK ADD  CONSTRAINT [serviceitem_Service_fk] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[Service] ([Id])
GO
ALTER TABLE [dbo].[ServiceItem] CHECK CONSTRAINT [serviceitem_Service_fk]
GO
/****** Object:  StoredProcedure [dbo].[sp_get_all_area]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_get_all_area]
as
begin
select Id,UPPER(name) AS Name from Area
where Status = 1;
end;
GO
/****** Object:  StoredProcedure [dbo].[sp_get_name_area_by_id]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_get_name_area_by_id](
@id int = null
)
as
begin

select Name from Area
where id=@id;
end;
GO
/****** Object:  StoredProcedure [dbo].[sp_report_dinamic_by_area]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_report_dinamic_by_area](
@AreaId nvarchar(10) =NULL ,
@Dni nvarchar(11) = NULL,
@startDate datetime = NULL,
@endDate datetime = NULL
)
as
begin

declare @sql nvarchar(max);
declare @vi_startdate datetime;
declare @vi_enddate datetime;

set @vi_startdate = @startDate;
set @vi_enddate = @endDate;

 set @sql = ' select p.Dni, p.PaternalName + '' '' + p.MaternalName + '','' + p.Names as FullName,
  '+ dbo.ColumnsDateName(@vi_startdate,@vi_enddate)+','+
   ISNULL( dbo.SumTotalD(@vi_startdate,@vi_enddate,0),0)+','+
   ISNULL(dbo.SumTotalA(@vi_startdate,@vi_enddate,0),0)+','+
   ISNULL(dbo.SumTotalC(@vi_startdate,@vi_enddate,0),0);
 set @sql = @sql +' from
( select * from (
select  employeeid, CAST([dbo].[fnFormatDate]([ServiceItemDate],''DD/MM'') AS char(5))
 + ''-'' + CAST(serviceid AS NVARCHAR(MAX)) as DateRegister
, count(*) as cantidad  from ServiceItem 
group by employeeid,CAST([dbo].[fnFormatDate]([ServiceItemDate],''DD/MM'') AS char(5))
 + ''-'' + CAST(serviceid AS NVARCHAR(MAX)) 
) as t pivot (
 count (cantidad)
 for dateRegister in ('+dbo.[ColumnsDateNamePivot](@vi_startdate,@vi_enddate)+')  
 ) as tp) as tp right join Employee e on 
 tp.EmployeeId = e.Id
 inner join Area a on
 e.AreaId = a.Id
 inner join Person p on
 e.PersonId = p.Id ';

 if @AreaId is not null 
	 begin
	  set @sql = @sql + ' and a.id = ' + @AreaId;
	 end;

 if @Dni is not null  
	 begin
	  set @sql = @sql + ' and p.dni = ' + @Dni;
 end;

 set @sql = @sql + ' union all ';
 set @sql =  @sql + 'select ''''  as Dni, ''TOTAL'' as FullName,'+ [dbo].[RowSumTotal](@vi_startdate,@vi_enddate)+','+
  dbo.SumTotalD(@vi_startdate,@vi_enddate,1)+','+dbo.SumTotalA(@vi_startdate,@vi_enddate,1)+','+
  dbo.SumTotalC(@vi_startdate,@vi_enddate,1);
 set @sql = @sql + ' from
( select * from (
select  employeeid, CAST([dbo].[fnFormatDate]([ServiceItemDate],''DD/MM'') AS char(5))
 + ''-'' + CAST(serviceid AS NVARCHAR(MAX)) as DateRegister
, count(*) as cantidad  from ServiceItem 
group by employeeid,CAST([dbo].[fnFormatDate]([ServiceItemDate],''DD/MM'') AS char(5))
 + ''-'' + CAST(serviceid AS NVARCHAR(MAX)) 
) as t pivot (
 count (cantidad)
 for dateRegister in ('+dbo.[ColumnsDateNamePivot](@vi_startdate,@vi_enddate)+')  
 ) as tp) as tp right join Employee e on 
 tp.EmployeeId = e.Id
 inner join Area a on
 e.AreaId = a.Id
 inner join Person p on
 e.PersonId = p.Id ';
 if @AreaId is not null 
	 begin
	  set @sql = @sql + ' and a.id = ' + @AreaId;
	 end;

 if @Dni is not null  
	 begin
	  set @sql = @sql + ' and p.dni = ' + @Dni;
 end;
--print @sql;

execute (@sql);

end;

GO
/****** Object:  StoredProcedure [dbo].[sp_report_dinamic_summary]    Script Date: 05/02/2018 22:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_report_dinamic_summary] (@startDate datetime = NULL,
@endDate datetime = NULL)
AS
BEGIN

  DECLARE @sql nvarchar(max);
  DECLARE @vi_startdate datetime;
  DECLARE @vi_enddate datetime;

  SET @vi_startdate = @startDate;
  SET @vi_enddate = @endDate;

  SET @sql = '  SELECT ';
  SET @sql += ' a.Name, ' + dbo.ColumnsDateName(@vi_startdate, @vi_enddate) + ',' +
  ISNULL(dbo.SumTotalD(@vi_startdate, @vi_enddate, 0), 0) + ',' +
  ISNULL(dbo.SumTotalA(@vi_startdate, @vi_enddate, 0), 0) + ',' +
  ISNULL(dbo.SumTotalC(@vi_startdate, @vi_enddate, 0), 0);
  SET @sql += '  FROM (SELECT';
  SET @sql += '    *';
  SET @sql += '  FROM (SELECT';
  SET @sql += '    a.Id,';
  SET @sql += '    t.DateRegister,';
  SET @sql += '    t.Cantidad';
  SET @sql += '  FROM (SELECT';
  SET @sql += '    EmployeeId,';
  SET @sql += '    CAST([dbo].[fnFormatDate]([ServiceItemDate], ''DD/MM'') AS char(5))';
  SET @sql += '    + ''-'' + CAST(serviceid AS nvarchar(max)) AS DateRegister,';
  SET @sql += '    COUNT(*) AS Cantidad';
  SET @sql += '  FROM ServiceItem';
  SET @sql += '  GROUP BY EmployeeId,';
  SET @sql += '           CAST([dbo].[fnFormatDate]([ServiceItemDate], ''DD/MM'') AS char(5))';
  SET @sql += '           + ''-'' + CAST(serviceid AS nvarchar(max))) AS t';
  SET @sql += '  INNER JOIN Employee e';
  SET @sql += '    ON t.EmployeeId = e.Id';
  SET @sql += '  INNER JOIN Area a';
  SET @sql += '    ON e.AreaId = a.Id) AS t PIVOT (';
  SET @sql += '  COUNT(cantidad)';
  SET @sql += '  FOR dateRegister IN (' + dbo.[ColumnsDateNamePivot](@vi_startdate, @vi_enddate) + ')';
  SET @sql += '  ) AS tp) AS tp';
  SET @sql += '  RIGHT JOIN area a';
  SET @sql += '    ON tp.Id = a.Id';
  SET @sql += '  UNION ALL';
  SET @sql += ' SELECT';
  SET @sql += '    ''TOTAL'' AS Name,' + [dbo].[RowSumTotal](@vi_startdate, @vi_enddate) + ',' +
  dbo.SumTotalD(@vi_startdate, @vi_enddate, 1) + ',' + dbo.SumTotalA(@vi_startdate, @vi_enddate, 1) + ',' +
  dbo.SumTotalC(@vi_startdate, @vi_enddate, 1);
  SET @sql += '   FROM (SELECT';
  SET @sql += '    *';
  SET @sql += '  FROM (SELECT';
  SET @sql += '    a.Id,';
  SET @sql += '    t.DateRegister,';
  SET @sql += '    t.Cantidad';
  SET @sql += '  FROM (SELECT';
  SET @sql += '    EmployeeId,';
  SET @sql += '    CAST([dbo].[fnFormatDate]([ServiceItemDate], ''DD/MM'') AS char(5))';
  SET @sql += '    + ''-'' + CAST(serviceid AS nvarchar(max)) AS DateRegister,';
  SET @sql += '    COUNT(*) AS Cantidad';
  SET @sql += '  FROM ServiceItem';
  SET @sql += '  GROUP BY EmployeeId,';
  SET @sql += '           CAST([dbo].[fnFormatDate]([ServiceItemDate], ''DD/MM'') AS char(5))';
  SET @sql += '           + ''-'' + CAST(serviceid AS nvarchar(max))) AS t';
  SET @sql += '  INNER JOIN Employee e';
  SET @sql += '    ON t.EmployeeId = e.Id';
  SET @sql += '  INNER JOIN Area a';
  SET @sql += '    ON e.AreaId = a.Id) AS t PIVOT (';
  SET @sql += '  COUNT(cantidad)';
  SET @sql += '  FOR dateRegister IN (' + dbo.[ColumnsDateNamePivot](@vi_startdate, @vi_enddate) + ')';
  SET @sql += '  ) AS tp) AS tp';
  SET @sql += '  RIGHT JOIN area a';
  SET @sql += '    ON tp.Id = a.Id';

 -- print @sql;

 execute (@sql);

END;

GO
