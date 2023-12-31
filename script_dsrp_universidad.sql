USE [master]
GO
/****** Object:  Database [dsrp_universidad]    Script Date: 8/10/2023 9:57:27 PM ******/
CREATE DATABASE [dsrp_universidad]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dsrp_universidad', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQL2023Q2\MSSQL\DATA\dsrp_universidad.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dsrp_universidad_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQL2023Q2\MSSQL\DATA\dsrp_universidad_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [dsrp_universidad] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dsrp_universidad].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dsrp_universidad] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dsrp_universidad] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dsrp_universidad] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dsrp_universidad] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dsrp_universidad] SET ARITHABORT OFF 
GO
ALTER DATABASE [dsrp_universidad] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dsrp_universidad] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dsrp_universidad] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dsrp_universidad] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dsrp_universidad] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dsrp_universidad] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dsrp_universidad] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dsrp_universidad] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dsrp_universidad] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dsrp_universidad] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dsrp_universidad] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dsrp_universidad] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dsrp_universidad] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dsrp_universidad] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dsrp_universidad] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dsrp_universidad] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dsrp_universidad] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dsrp_universidad] SET RECOVERY FULL 
GO
ALTER DATABASE [dsrp_universidad] SET  MULTI_USER 
GO
ALTER DATABASE [dsrp_universidad] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dsrp_universidad] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dsrp_universidad] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dsrp_universidad] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dsrp_universidad] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dsrp_universidad] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'dsrp_universidad', N'ON'
GO
ALTER DATABASE [dsrp_universidad] SET QUERY_STORE = OFF
GO
USE [dsrp_universidad]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 8/10/2023 9:57:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
GO
/****** Object:  Table [dbo].[alumnos]    Script Date: 8/10/2023 9:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[alumnos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombres] [varchar](100) NOT NULL,
	[apellido_paterno] [varchar](100) NULL,
	[apellido_materno] [varchar](100) NULL,
	[numero_documento] [varchar](11) NOT NULL,
	[codigo] [varchar](11) NOT NULL,
	[fecha_ingreso] [date] NULL,
	[estado] [int] NOT NULL,
	[email] [varchar](100) NULL,
	[fecha_nacimiento] [date] NULL,
	[genero] [char](1) NULL,
	[celular] [varchar](12) NULL,
	[direccion] [varchar](100) NULL,
	[especialidad_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[celular] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[numero_documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cargas]    Script Date: 8/10/2023 9:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cargas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[numero_seccion] [int] NOT NULL,
	[capacidad] [int] NOT NULL,
	[turno] [varchar](11) NULL,
	[curso_id] [int] NOT NULL,
	[docente_id] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
	[deleted_at] [datetime] NULL,
	[created_by] [int] NOT NULL,
	[updated_by] [int] NULL,
	[deleted_by] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cursos]    Script Date: 8/10/2023 9:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cursos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[codigo] [char](6) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[horas_teoria] [int] NOT NULL,
	[horas_practica] [int] NOT NULL,
	[creditos] [int] NOT NULL,
	[estado] [int] NOT NULL,
	[especialidad_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[docentes]    Script Date: 8/10/2023 9:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[docentes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombres] [varchar](100) NOT NULL,
	[apellido_paterno] [varchar](100) NULL,
	[apellido_materno] [varchar](100) NULL,
	[fecha_nacimiento] [date] NULL,
	[numero_documento] [varchar](11) NOT NULL,
	[fecha_ingreso] [date] NULL,
 CONSTRAINT [pk_docentes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [unike_num_documento] UNIQUE NONCLUSTERED 
(
	[numero_documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[especialidades]    Script Date: 8/10/2023 9:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[especialidades](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](55) NOT NULL,
	[fecha_creacion] [date] NULL,
	[estados] [int] NOT NULL,
	[duracion] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [nombres_unicos] UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[matriculas]    Script Date: 8/10/2023 9:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[matriculas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[alumno_id] [int] NOT NULL,
	[monto] [money] NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NULL,
	[deleted_at] [datetime] NULL,
	[created_by] [int] NOT NULL,
	[updated_by] [int] NULL,
	[deleted_by] [int] NULL,
	[carga_id] [int] NOT NULL,
 CONSTRAINT [PK__matricul__3213E83F54DCE7FF] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 8/10/2023 9:57:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
 CONSTRAINT [PK__sysdiagr__C2B05B61BC88D77F] PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[alumnos]  WITH CHECK ADD  CONSTRAINT [fk_especialidad_alumno] FOREIGN KEY([especialidad_id])
REFERENCES [dbo].[especialidades] ([id])
GO
ALTER TABLE [dbo].[alumnos] CHECK CONSTRAINT [fk_especialidad_alumno]
GO
ALTER TABLE [dbo].[cargas]  WITH CHECK ADD  CONSTRAINT [fk_cargas_curso] FOREIGN KEY([curso_id])
REFERENCES [dbo].[cursos] ([id])
GO
ALTER TABLE [dbo].[cargas] CHECK CONSTRAINT [fk_cargas_curso]
GO
ALTER TABLE [dbo].[cargas]  WITH CHECK ADD  CONSTRAINT [fk_cargas_docente] FOREIGN KEY([docente_id])
REFERENCES [dbo].[docentes] ([id])
GO
ALTER TABLE [dbo].[cargas] CHECK CONSTRAINT [fk_cargas_docente]
GO
ALTER TABLE [dbo].[cursos]  WITH CHECK ADD  CONSTRAINT [fk_especialidad_cursos] FOREIGN KEY([especialidad_id])
REFERENCES [dbo].[especialidades] ([id])
GO
ALTER TABLE [dbo].[cursos] CHECK CONSTRAINT [fk_especialidad_cursos]
GO
ALTER TABLE [dbo].[matriculas]  WITH CHECK ADD  CONSTRAINT [fk_matricula_alumnos] FOREIGN KEY([alumno_id])
REFERENCES [dbo].[alumnos] ([id])
GO
ALTER TABLE [dbo].[matriculas] CHECK CONSTRAINT [fk_matricula_alumnos]
GO
ALTER TABLE [dbo].[matriculas]  WITH CHECK ADD  CONSTRAINT [fk_matricula_cargas] FOREIGN KEY([carga_id])
REFERENCES [dbo].[cargas] ([id])
GO
ALTER TABLE [dbo].[matriculas] CHECK CONSTRAINT [fk_matricula_cargas]
GO
USE [master]
GO
ALTER DATABASE [dsrp_universidad] SET  READ_WRITE 
GO
