USE [master]
GO
/****** Object:  Database [gatekeeper]    Script Date: 2021-05-21 02:14:20 ******/
CREATE DATABASE [gatekeeper]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'gatekeeper', FILENAME = N'C:\_sql\MSSQL12.MSSQLSERVER\MSSQL\DATA\gatekeeper.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'gatekeeper_log', FILENAME = N'C:\_sql\MSSQL12.MSSQLSERVER\MSSQL\DATA\gatekeeper_log.ldf' , SIZE = 7168KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [gatekeeper] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [gatekeeper].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [gatekeeper] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [gatekeeper] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [gatekeeper] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [gatekeeper] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [gatekeeper] SET ARITHABORT OFF 
GO
ALTER DATABASE [gatekeeper] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [gatekeeper] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [gatekeeper] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [gatekeeper] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [gatekeeper] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [gatekeeper] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [gatekeeper] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [gatekeeper] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [gatekeeper] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [gatekeeper] SET  DISABLE_BROKER 
GO
ALTER DATABASE [gatekeeper] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [gatekeeper] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [gatekeeper] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [gatekeeper] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [gatekeeper] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [gatekeeper] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [gatekeeper] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [gatekeeper] SET RECOVERY FULL 
GO
ALTER DATABASE [gatekeeper] SET  MULTI_USER 
GO
ALTER DATABASE [gatekeeper] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [gatekeeper] SET DB_CHAINING OFF 
GO
ALTER DATABASE [gatekeeper] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [gatekeeper] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [gatekeeper] SET DELAYED_DURABILITY = DISABLED 
GO
USE [gatekeeper]
GO
/****** Object:  Table [dbo].[AccessLogs]    Script Date: 2021-05-21 02:14:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccessLogs](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[personId] [uniqueidentifier] NULL,
	[controlPointId] [uniqueidentifier] NULL,
	[accessDateTime] [datetime] NOT NULL,
	[accessDirection] [int] NOT NULL,
 CONSTRAINT [PK_AccessLogs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Buildings]    Script Date: 2021-05-21 02:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Buildings](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[name] [nvarchar](150) NULL,
	[statusId] [int] NOT NULL,
 CONSTRAINT [PK_Buildings] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ControlPoints]    Script Date: 2021-05-21 02:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ControlPoints](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[name] [nvarchar](150) NULL,
	[buildingId] [uniqueidentifier] NULL,
	[statusId] [int] NOT NULL,
 CONSTRAINT [PK_ControlPoints] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person]    Script Date: 2021-05-21 02:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[name] [nvarchar](100) NULL,
	[statusId] [int] NOT NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vAccessLogs]    Script Date: 2021-05-21 02:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vAccessLogs]
AS
SELECT        al.accessDateTime, al.id, p.name AS 'personName', cp.name AS 'controlPointName', b.name AS 'buildingName'
FROM            dbo.AccessLogs AS al INNER JOIN
                         dbo.Person AS p ON al.personId = p.id INNER JOIN
                         dbo.ControlPoints AS cp ON al.controlPointId = cp.id INNER JOIN
                         dbo.Buildings AS b ON cp.buildingId = b.id
GO
ALTER TABLE [dbo].[AccessLogs] ADD  CONSTRAINT [DF_AccessLogs_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[AccessLogs] ADD  CONSTRAINT [DF_AccessLogs_accessDateTime]  DEFAULT (getdate()) FOR [accessDateTime]
GO
ALTER TABLE [dbo].[AccessLogs] ADD  CONSTRAINT [DF_AccessLogs_accessDirection]  DEFAULT ((0)) FOR [accessDirection]
GO
ALTER TABLE [dbo].[Buildings] ADD  CONSTRAINT [DF_Buildings_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[Buildings] ADD  CONSTRAINT [DF_Buildings_statusId]  DEFAULT ((1)) FOR [statusId]
GO
ALTER TABLE [dbo].[ControlPoints] ADD  CONSTRAINT [DF_ControlPoints_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[ControlPoints] ADD  CONSTRAINT [DF_ControlPoints_statusId]  DEFAULT ((1)) FOR [statusId]
GO
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_statusId]  DEFAULT ((1)) FOR [statusId]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "al"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 211
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 6
               Left = 249
               Bottom = 119
               Right = 419
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cp"
            Begin Extent = 
               Top = 6
               Left = 457
               Bottom = 136
               Right = 627
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 120
               Left = 249
               Bottom = 233
               Right = 419
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAccessLogs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vAccessLogs'
GO
USE [master]
GO
ALTER DATABASE [gatekeeper] SET  READ_WRITE 
GO
