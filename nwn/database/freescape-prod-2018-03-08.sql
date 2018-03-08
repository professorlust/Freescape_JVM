USE [master]
GO
/****** Object:  Database [freescape]    Script Date: 3/8/2018 4:27:20 PM ******/
CREATE DATABASE [freescape]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'freescape', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\freescape.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'freescape_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\freescape_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [freescape] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [freescape].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [freescape] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [freescape] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [freescape] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [freescape] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [freescape] SET ARITHABORT OFF 
GO
ALTER DATABASE [freescape] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [freescape] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [freescape] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [freescape] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [freescape] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [freescape] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [freescape] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [freescape] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [freescape] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [freescape] SET  ENABLE_BROKER 
GO
ALTER DATABASE [freescape] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [freescape] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [freescape] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [freescape] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [freescape] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [freescape] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [freescape] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [freescape] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [freescape] SET  MULTI_USER 
GO
ALTER DATABASE [freescape] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [freescape] SET DB_CHAINING OFF 
GO
ALTER DATABASE [freescape] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [freescape] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [freescape] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [freescape] SET QUERY_STORE = OFF
GO
USE [freescape]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [freescape]
GO
/****** Object:  Table [dbo].[Abilities]    Script Date: 3/8/2018 4:27:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Abilities](
	[AbilityID] [int] NOT NULL,
	[Name] [varchar](64) NOT NULL,
	[FeatID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[JavaScriptName] [varchar](64) NOT NULL,
	[BaseManaCost] [int] NOT NULL,
	[BaseCastingTime] [float] NOT NULL,
	[Description] [nvarchar](256) NOT NULL,
	[AbilityCategoryID] [int] NOT NULL,
	[AbilityCooldownCategoryID] [int] NULL,
	[IsQueuedWeaponSkill] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AbilityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbilityCategories]    Script Date: 3/8/2018 4:27:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbilityCategories](
	[AbilityCategoryID] [int] NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AbilityCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AbilityCooldownCategories]    Script Date: 3/8/2018 4:27:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AbilityCooldownCategories](
	[AbilityCooldownCategoryID] [int] NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[BaseCooldownTime] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AbilityCooldownCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuthorizedDMs]    Script Date: 3/8/2018 4:27:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuthorizedDMs](
	[AuthorizedDMID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[CDKey] [nvarchar](20) NOT NULL,
	[DMRole] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AuthorizedDMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BaseItemTypes]    Script Date: 3/8/2018 4:27:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BaseItemTypes](
	[BaseItemTypeID] [int] NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BaseItemTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BuildPrivacyDomain]    Script Date: 3/8/2018 4:27:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BuildPrivacyDomain](
	[BuildPrivacyTypeID] [int] NOT NULL,
	[Name] [nvarchar](12) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BuildPrivacyTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChatChannelsDomain]    Script Date: 3/8/2018 4:27:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatChannelsDomain](
	[ChatChannelID] [int] NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ChatChannelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChatLog]    Script Date: 3/8/2018 4:27:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatLog](
	[ChatLogID] [bigint] IDENTITY(1,1) NOT NULL,
	[ChatChannelID] [int] NOT NULL,
	[SenderPlayerID] [nvarchar](60) NULL,
	[SenderAccountName] [nvarchar](1024) NOT NULL,
	[SenderCDKey] [nvarchar](20) NOT NULL,
	[ReceiverPlayerID] [nvarchar](60) NULL,
	[ReceiverAccountName] [nvarchar](1024) NULL,
	[ReceiverCDKey] [nvarchar](20) NULL,
	[Message] [nvarchar](max) NOT NULL,
	[DateSent] [datetime2](7) NOT NULL,
	[SenderDMName] [nvarchar](60) NULL,
	[ReceiverDMName] [nvarchar](60) NULL,
PRIMARY KEY CLUSTERED 
(
	[ChatLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientLogEvents]    Script Date: 3/8/2018 4:27:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientLogEvents](
	[ClientLogEventID] [int] IDENTITY(1,1) NOT NULL,
	[ClientLogEventTypeID] [int] NOT NULL,
	[PlayerID] [nvarchar](60) NULL,
	[CDKey] [nvarchar](20) NOT NULL,
	[AccountName] [nvarchar](1024) NOT NULL,
	[DateOfEvent] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ClientLogEvents_ClientLogEventID] PRIMARY KEY CLUSTERED 
(
	[ClientLogEventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClientLogEventTypesDomain]    Script Date: 3/8/2018 4:27:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientLogEventTypesDomain](
	[ClientLogEventTypeID] [int] NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_ClientLogEventTypesDomain_ClientLogEventTypeID] PRIMARY KEY CLUSTERED 
(
	[ClientLogEventTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConstructionSites]    Script Date: 3/8/2018 4:27:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConstructionSites](
	[ConstructionSiteID] [int] IDENTITY(1,1) NOT NULL,
	[PCTerritoryFlagID] [int] NULL,
	[PlayerID] [nvarchar](60) NOT NULL,
	[StructureBlueprintID] [int] NOT NULL,
	[WoodRequired] [int] NOT NULL,
	[MetalRequired] [int] NOT NULL,
	[NailsRequired] [int] NOT NULL,
	[ClothRequired] [int] NOT NULL,
	[LeatherRequired] [int] NOT NULL,
	[LocationAreaTag] [nvarchar](64) NOT NULL,
	[LocationX] [float] NOT NULL,
	[LocationY] [float] NOT NULL,
	[LocationZ] [float] NOT NULL,
	[LocationOrientation] [float] NOT NULL,
	[IronRequired] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ConstructionSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CraftBlueprintCategories]    Script Date: 3/8/2018 4:27:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CraftBlueprintCategories](
	[CraftBlueprintCategoryID] [bigint] NOT NULL,
	[Name] [nvarchar](32) NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CraftBlueprintCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CraftBlueprintComponents]    Script Date: 3/8/2018 4:27:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CraftBlueprintComponents](
	[CraftComponentID] [bigint] IDENTITY(1,1) NOT NULL,
	[CraftBlueprintID] [bigint] NOT NULL,
	[ItemResref] [nvarchar](16) NOT NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CraftComponentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CraftBlueprints]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CraftBlueprints](
	[CraftBlueprintID] [bigint] NOT NULL,
	[CraftID] [bigint] NOT NULL,
	[CraftCategoryID] [bigint] NOT NULL,
	[Level] [int] NOT NULL,
	[ItemName] [nvarchar](64) NOT NULL,
	[ItemResref] [nvarchar](16) NOT NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CraftBlueprintID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Crafts]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Crafts](
	[CraftID] [bigint] NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CraftID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomEffects]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomEffects](
	[CustomEffectID] [bigint] NOT NULL,
	[Name] [nvarchar](32) NOT NULL,
	[IconID] [int] NOT NULL,
	[ScriptHandler] [nvarchar](64) NOT NULL,
	[StartMessage] [nvarchar](64) NOT NULL,
	[ContinueMessage] [nvarchar](64) NOT NULL,
	[WornOffMessage] [nvarchar](64) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomEffectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DMRoleDomain]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DMRoleDomain](
	[DMRoleDomainID] [int] NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DMRoleDomainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Downloads]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Downloads](
	[DownloadID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](1000) NOT NULL,
	[Url] [nvarchar](200) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Downloads_DownloadID] PRIMARY KEY CLUSTERED 
(
	[DownloadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FameRegions]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FameRegions](
	[FameRegionID] [int] NOT NULL,
	[Name] [nvarchar](32) NOT NULL,
 CONSTRAINT [QuestFameRegions_FameRegionID] PRIMARY KEY CLUSTERED 
(
	[FameRegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KeyItemCategories]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KeyItemCategories](
	[KeyItemCategoryID] [int] NOT NULL,
	[Name] [nvarchar](32) NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[KeyItemCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KeyItems]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KeyItems](
	[KeyItemID] [int] NOT NULL,
	[KeyItemCategoryID] [int] NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[Description] [nvarchar](1000) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[KeyItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LootTableItems]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LootTableItems](
	[LootTableItemID] [int] IDENTITY(1,1) NOT NULL,
	[LootTableID] [int] NOT NULL,
	[Resref] [varchar](16) NOT NULL,
	[MaxQuantity] [int] NOT NULL,
	[Weight] [tinyint] NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LootTableItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LootTables]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LootTables](
	[LootTableID] [int] NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LootTableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NPCGroups]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NPCGroups](
	[NPCGroupID] [int] NOT NULL,
	[Name] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_NPCGroups_NPCGroupID] PRIMARY KEY CLUSTERED 
(
	[NPCGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCAbilityCooldowns]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCAbilityCooldowns](
	[PCAbilityCooldownID] [int] IDENTITY(1,1) NOT NULL,
	[PlayerID] [nvarchar](60) NOT NULL,
	[AbilityCooldownCategoryID] [int] NOT NULL,
	[DateUnlocked] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PCAbilityCooldownID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCBlueprints]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCBlueprints](
	[PCBlueprintID] [bigint] IDENTITY(1,1) NOT NULL,
	[PlayerID] [nvarchar](60) NOT NULL,
	[CraftBlueprintID] [bigint] NOT NULL,
	[AcquiredDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PCBlueprintID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCCorpseItems]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCCorpseItems](
	[PCCorpseItemID] [bigint] IDENTITY(1,1) NOT NULL,
	[PCCorpseID] [bigint] NOT NULL,
	[NWItemObject] [varbinary](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PCCorpseItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCCorpses]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCCorpses](
	[PCCorpseID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[PositionX] [float] NOT NULL,
	[PositionY] [float] NOT NULL,
	[PositionZ] [float] NOT NULL,
	[Orientation] [float] NOT NULL,
	[AreaTag] [nvarchar](32) NULL,
PRIMARY KEY CLUSTERED 
(
	[PCCorpseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCCustomEffects]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCCustomEffects](
	[PCCustomEffectID] [bigint] IDENTITY(1,1) NOT NULL,
	[PlayerID] [nvarchar](60) NOT NULL,
	[CustomEffectID] [bigint] NOT NULL,
	[Ticks] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PCCustomEffectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCKeyItems]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCKeyItems](
	[PCKeyItemID] [int] IDENTITY(1,1) NOT NULL,
	[PlayerID] [nvarchar](60) NOT NULL,
	[KeyItemID] [int] NOT NULL,
	[AcquiredDate] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PCKeyItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCLearnedAbilities]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCLearnedAbilities](
	[PCLearnedAbilityID] [int] IDENTITY(1,1) NOT NULL,
	[PlayerID] [nvarchar](60) NOT NULL,
	[AcquiredDate] [datetime2](7) NOT NULL,
	[AbilityID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PCLearnedAbilityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCMigrationItems]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCMigrationItems](
	[PCMigrationItemID] [int] NOT NULL,
	[PCMigrationID] [int] NOT NULL,
	[CurrentResref] [nvarchar](16) NOT NULL,
	[NewResref] [nvarchar](16) NOT NULL,
	[StripItemProperties] [bit] NOT NULL,
	[BaseItemTypeID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PCMigrationItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCMigrations]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCMigrations](
	[PCMigrationID] [int] NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PCMigrationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCOutfits]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCOutfits](
	[PlayerID] [nvarchar](60) NOT NULL,
	[Outfit1] [varbinary](max) NULL,
	[Outfit2] [varbinary](max) NULL,
	[Outfit3] [varbinary](max) NULL,
	[Outfit4] [varbinary](max) NULL,
	[Outfit5] [varbinary](max) NULL,
	[Outfit6] [varbinary](max) NULL,
	[Outfit7] [varbinary](max) NULL,
	[Outfit8] [varbinary](max) NULL,
	[Outfit9] [varbinary](max) NULL,
	[Outfit10] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[PlayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCOverflowItems]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCOverflowItems](
	[PCOverflowItemID] [bigint] IDENTITY(1,1) NOT NULL,
	[PlayerID] [nvarchar](60) NOT NULL,
	[ItemName] [nvarchar](max) NOT NULL,
	[ItemTag] [nvarchar](64) NOT NULL,
	[ItemResref] [nvarchar](16) NOT NULL,
	[ItemObject] [varbinary](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PCOverflowItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCQuestKillTargetProgress]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCQuestKillTargetProgress](
	[PCQuestKillTargetProgressID] [int] IDENTITY(1,1) NOT NULL,
	[PlayerID] [nvarchar](60) NOT NULL,
	[PCQuestStatusID] [int] NOT NULL,
	[NPCGroupID] [int] NOT NULL,
	[RemainingToKill] [int] NOT NULL,
 CONSTRAINT [PK_PCQuestKillTargetProgress_PCQuestKillTargetProgressID] PRIMARY KEY CLUSTERED 
(
	[PCQuestKillTargetProgressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCQuestStatus]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCQuestStatus](
	[PCQuestStatusID] [int] IDENTITY(1,1) NOT NULL,
	[PlayerID] [nvarchar](60) NOT NULL,
	[QuestID] [int] NOT NULL,
	[CurrentQuestStateID] [int] NOT NULL,
	[CompletionDate] [datetime2](7) NULL,
	[SelectedItemRewardID] [int] NULL,
 CONSTRAINT [PK_PCQuestStatus_PCQuestStatusID] PRIMARY KEY CLUSTERED 
(
	[PCQuestStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCRegionalFame]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCRegionalFame](
	[PCRegionalFameID] [int] IDENTITY(1,1) NOT NULL,
	[PlayerID] [nvarchar](60) NOT NULL,
	[FameRegionID] [int] NOT NULL,
	[Amount] [int] NOT NULL,
 CONSTRAINT [PK_PCRegionalFame_PCRegionalFameID] PRIMARY KEY CLUSTERED 
(
	[PCRegionalFameID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCSearchSiteItems]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCSearchSiteItems](
	[PCSearchSiteItemID] [bigint] IDENTITY(1,1) NOT NULL,
	[PlayerID] [nvarchar](60) NOT NULL,
	[SearchSiteID] [int] NOT NULL,
	[SearchItem] [varbinary](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PCSearchSiteItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCSearchSites]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCSearchSites](
	[PCSearchSiteID] [int] IDENTITY(1,1) NOT NULL,
	[PlayerID] [nvarchar](60) NOT NULL,
	[SearchSiteID] [int] NOT NULL,
	[UnlockDateTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PCSearchSiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCTerritoryFlags]    Script Date: 3/8/2018 4:27:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCTerritoryFlags](
	[PCTerritoryFlagID] [int] IDENTITY(1,1) NOT NULL,
	[PlayerID] [nvarchar](60) NOT NULL,
	[StructureBlueprintID] [int] NOT NULL,
	[LocationAreaTag] [nvarchar](64) NOT NULL,
	[LocationX] [float] NOT NULL,
	[LocationY] [float] NOT NULL,
	[LocationZ] [float] NOT NULL,
	[LocationOrientation] [float] NOT NULL,
	[BuildPrivacySettingID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PCTerritoryFlagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCTerritoryFlagsPermissions]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCTerritoryFlagsPermissions](
	[PCTerritoryFlagPermissionID] [int] IDENTITY(1,1) NOT NULL,
	[PCTerritoryFlagID] [int] NOT NULL,
	[PlayerID] [nvarchar](60) NOT NULL,
	[TerritoryFlagPermissionID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PCTerritoryFlagPermissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCTerritoryFlagsStructures]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCTerritoryFlagsStructures](
	[PCTerritoryFlagStructureID] [bigint] IDENTITY(1,1) NOT NULL,
	[PCTerritoryFlagID] [int] NOT NULL,
	[StructureBlueprintID] [int] NOT NULL,
	[IsUseable] [bit] NOT NULL,
	[LocationAreaTag] [nvarchar](64) NOT NULL,
	[LocationX] [float] NOT NULL,
	[LocationY] [float] NOT NULL,
	[LocationZ] [float] NOT NULL,
	[LocationOrientation] [float] NOT NULL,
	[CreateDate] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PCTerritoryFlagStructureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCTerritoryFlagsStructuresItems]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCTerritoryFlagsStructuresItems](
	[PCStructureItemID] [bigint] IDENTITY(1,1) NOT NULL,
	[PCStructureID] [bigint] NOT NULL,
	[ItemName] [nvarchar](max) NOT NULL,
	[ItemTag] [nvarchar](64) NOT NULL,
	[ItemResref] [nvarchar](16) NOT NULL,
	[ItemObject] [varbinary](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PCStructureItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PCTerritoryFlagsStructuresResearchQueues]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PCTerritoryFlagsStructuresResearchQueues](
	[PCStructureResearchID] [int] IDENTITY(1,1) NOT NULL,
	[PCStructureID] [bigint] NOT NULL,
	[ResearchBlueprintID] [int] NOT NULL,
	[ResearchSlot] [int] NOT NULL,
	[StartDateTime] [datetime2](7) NOT NULL,
	[CompletedDateTime] [datetime2](7) NOT NULL,
	[IsCanceled] [bit] NOT NULL,
	[DeliverDateTime] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[PCStructureResearchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerCharacters]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerCharacters](
	[PlayerID] [nvarchar](60) NOT NULL,
	[CharacterName] [nvarchar](max) NULL,
	[HitPoints] [int] NOT NULL,
	[LocationAreaTag] [nvarchar](64) NOT NULL,
	[LocationX] [float] NOT NULL,
	[LocationY] [float] NOT NULL,
	[LocationZ] [float] NOT NULL,
	[LocationOrientation] [float] NOT NULL,
	[CreateTimestamp] [datetime2](0) NOT NULL,
	[MaxHunger] [int] NOT NULL,
	[CurrentHunger] [int] NOT NULL,
	[CurrentHungerTick] [int] NOT NULL,
	[UnallocatedSP] [int] NOT NULL,
	[NextSPResetDate] [datetime2](0) NULL,
	[NumberOfSPResets] [int] NOT NULL,
	[ResetTokens] [int] NOT NULL,
	[NextResetTokenReceiveDate] [datetime2](0) NULL,
	[HPRegenerationAmount] [int] NOT NULL,
	[RegenerationTick] [int] NOT NULL,
	[RegenerationRate] [int] NOT NULL,
	[VersionNumber] [int] NOT NULL,
	[MaxMana] [int] NOT NULL,
	[CurrentMana] [int] NOT NULL,
	[CurrentManaTick] [int] NOT NULL,
	[RevivalStoneCount] [int] NOT NULL,
	[RespawnAreaTag] [nvarchar](64) NOT NULL,
	[RespawnLocationX] [float] NOT NULL,
	[RespawnLocationY] [float] NOT NULL,
	[RespawnLocationZ] [float] NOT NULL,
	[RespawnLocationOrientation] [float] NOT NULL,
	[DateLastForcedSPReset] [datetime2](7) NULL,
	[DateSanctuaryEnds] [datetime2](7) NOT NULL,
	[IsSanctuaryOverrideEnabled] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PlayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestKillTargetList]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestKillTargetList](
	[QuestKillTargetListID] [int] IDENTITY(1,1) NOT NULL,
	[QuestID] [int] NOT NULL,
	[NPCGroupID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[QuestStateID] [int] NOT NULL,
 CONSTRAINT [PK_QuestKillTargetList_QuestKillTargetListID] PRIMARY KEY CLUSTERED 
(
	[QuestKillTargetListID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestPrerequisites]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestPrerequisites](
	[QuestPrerequisiteID] [int] IDENTITY(1,1) NOT NULL,
	[QuestID] [int] NOT NULL,
	[RequiredQuestID] [int] NOT NULL,
 CONSTRAINT [PK_QuestPreqrequisites_QuestPrerequisiteID] PRIMARY KEY CLUSTERED 
(
	[QuestPrerequisiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestRequiredItemList]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestRequiredItemList](
	[QuestRequiredItemListID] [int] IDENTITY(1,1) NOT NULL,
	[QuestID] [int] NOT NULL,
	[Resref] [nvarchar](16) NOT NULL,
	[Quantity] [int] NOT NULL,
	[QuestStateID] [int] NOT NULL,
 CONSTRAINT [PK_QuestRequiredItemList_QuestRequiredItemListID] PRIMARY KEY CLUSTERED 
(
	[QuestRequiredItemListID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestRequiredKeyItemList]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestRequiredKeyItemList](
	[QuestRequiredKeyItemID] [int] IDENTITY(1,1) NOT NULL,
	[QuestID] [int] NOT NULL,
	[KeyItemID] [int] NOT NULL,
	[QuestStateID] [int] NOT NULL,
 CONSTRAINT [PK_QuestRequiredKeyItemList_QuestRequiredKeyItemID] PRIMARY KEY CLUSTERED 
(
	[QuestRequiredKeyItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestRewardItems]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestRewardItems](
	[QuestRewardItemID] [int] IDENTITY(1,1) NOT NULL,
	[QuestID] [int] NOT NULL,
	[Resref] [nvarchar](16) NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_QuestRewards_QuestRewardID] PRIMARY KEY CLUSTERED 
(
	[QuestRewardItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quests]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quests](
	[QuestID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[JournalTag] [nvarchar](32) NOT NULL,
	[FameRegionID] [int] NOT NULL,
	[RequiredFameAmount] [int] NOT NULL,
	[AllowRewardSelection] [bit] NOT NULL,
	[RewardGold] [int] NOT NULL,
	[RewardXP] [int] NOT NULL,
	[RewardKeyItemID] [int] NULL,
	[RewardFame] [int] NOT NULL,
	[IsRepeatable] [bit] NOT NULL,
	[MapNoteTag] [nvarchar](32) NOT NULL,
	[StartKeyItemID] [int] NULL,
	[RemoveStartKeyItemAfterCompletion] [bit] NOT NULL,
 CONSTRAINT [PK_Quests_QuestID] PRIMARY KEY CLUSTERED 
(
	[QuestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestStates]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestStates](
	[QuestStateID] [int] IDENTITY(1,1) NOT NULL,
	[QuestID] [int] NOT NULL,
	[Sequence] [int] NOT NULL,
	[QuestTypeID] [int] NOT NULL,
	[JournalStateID] [int] NOT NULL,
	[IsFinalState] [bit] NOT NULL,
 CONSTRAINT [PK_QuestStates_QuestStateID] PRIMARY KEY CLUSTERED 
(
	[QuestStateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestTypeDomain]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestTypeDomain](
	[QuestTypeID] [int] NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_QuestTypeDomain_QuestTypeID] PRIMARY KEY CLUSTERED 
(
	[QuestTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResearchBlueprints]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResearchBlueprints](
	[ResearchBlueprintID] [int] IDENTITY(1,1) NOT NULL,
	[CraftBlueprintID] [bigint] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Price] [int] NOT NULL,
	[ResearchPoints] [bigint] NOT NULL,
	[SkillRequired] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ResearchBlueprintID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServerConfiguration]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServerConfiguration](
	[ServerConfigurationID] [int] NOT NULL,
	[ServerName] [varchar](50) NOT NULL,
	[MessageOfTheDay] [varchar](1024) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ServerConfigurationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SpawnTableCreatures]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpawnTableCreatures](
	[SpawnTableCreatureID] [int] IDENTITY(1,1) NOT NULL,
	[SpawnTableID] [int] NOT NULL,
	[Resref] [nvarchar](16) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Weight] [tinyint] NOT NULL,
	[MaxNumberInArea] [int] NOT NULL,
	[LootTableID] [int] NULL,
	[DifficultyRating] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SpawnTableCreatureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SpawnTables]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpawnTables](
	[SpawnTableID] [int] NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SpawnTableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StorageContainers]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StorageContainers](
	[StorageContainerID] [int] NOT NULL,
	[AreaName] [nvarchar](255) NOT NULL,
	[AreaTag] [nvarchar](64) NOT NULL,
	[AreaResref] [nvarchar](16) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StorageContainerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StorageItems]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StorageItems](
	[StorageItemID] [int] IDENTITY(1,1) NOT NULL,
	[StorageContainerID] [int] NOT NULL,
	[ItemName] [nvarchar](max) NOT NULL,
	[ItemTag] [nvarchar](64) NOT NULL,
	[ItemResref] [nvarchar](16) NOT NULL,
	[ItemObject] [varbinary](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StorageItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StructureBlueprints]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StructureBlueprints](
	[StructureBlueprintID] [int] NOT NULL,
	[StructureCategoryID] [int] NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[Resref] [nvarchar](16) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsTerritoryFlag] [bit] NOT NULL,
	[IsUseable] [bit] NOT NULL,
	[WoodRequired] [int] NOT NULL,
	[MetalRequired] [int] NOT NULL,
	[NailsRequired] [int] NOT NULL,
	[ClothRequired] [int] NOT NULL,
	[LeatherRequired] [int] NOT NULL,
	[ItemStorageCount] [int] NOT NULL,
	[MaxStructuresCount] [int] NOT NULL,
	[MaxBuildDistance] [float] NOT NULL,
	[IronRequired] [int] NOT NULL,
	[ResearchSlots] [int] NOT NULL,
	[RPPerSecond] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StructureBlueprintID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StructureCategories]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StructureCategories](
	[StructureCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[Description] [nvarchar](64) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsTerritoryFlagCategory] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StructureCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StructureQuickBuildAudit]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StructureQuickBuildAudit](
	[StructureQuickBuildID] [int] IDENTITY(1,1) NOT NULL,
	[PCTerritoryFlagID] [int] NULL,
	[PCTerritoryFlagStructureID] [bigint] NULL,
	[DMName] [nvarchar](200) NOT NULL,
	[DateBuilt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_StructureQuickBuildAudit_StructureQuickBuildID] PRIMARY KEY CLUSTERED 
(
	[StructureQuickBuildID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TerritoryFlagPermissions]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TerritoryFlagPermissions](
	[TerritoryFlagPermissionID] [int] NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsSelectable] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TerritoryFlagPermissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/8/2018 4:27:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[DiscordUserID] [nvarchar](max) NOT NULL,
	[Username] [nvarchar](32) NOT NULL,
	[AvatarHash] [nvarchar](max) NOT NULL,
	[Discriminator] [nvarchar](4) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[RoleID] [int] NOT NULL,
	[DateRegistered] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AuthorizedDMs] ON 

INSERT [dbo].[AuthorizedDMs] ([AuthorizedDMID], [Name], [CDKey], [DMRole], [IsActive]) VALUES (1, N'zunath', N'PXDK7WRX', 2, 1)
SET IDENTITY_INSERT [dbo].[AuthorizedDMs] OFF
INSERT [dbo].[BaseItemTypes] ([BaseItemTypeID], [Name]) VALUES (-1, N'Invalid')
INSERT [dbo].[BuildPrivacyDomain] ([BuildPrivacyTypeID], [Name]) VALUES (0, N'Unknown')
INSERT [dbo].[BuildPrivacyDomain] ([BuildPrivacyTypeID], [Name]) VALUES (1, N'Owner Only')
INSERT [dbo].[BuildPrivacyDomain] ([BuildPrivacyTypeID], [Name]) VALUES (2, N'Friends Only')
INSERT [dbo].[BuildPrivacyDomain] ([BuildPrivacyTypeID], [Name]) VALUES (3, N'Public')
INSERT [dbo].[ChatChannelsDomain] ([ChatChannelID], [Name]) VALUES (1, N'Shout')
INSERT [dbo].[ChatChannelsDomain] ([ChatChannelID], [Name]) VALUES (2, N'Whisper')
INSERT [dbo].[ChatChannelsDomain] ([ChatChannelID], [Name]) VALUES (3, N'Talk')
INSERT [dbo].[ChatChannelsDomain] ([ChatChannelID], [Name]) VALUES (4, N'Party')
INSERT [dbo].[ChatChannelsDomain] ([ChatChannelID], [Name]) VALUES (5, N'DM')
INSERT [dbo].[ChatChannelsDomain] ([ChatChannelID], [Name]) VALUES (6, N'Tell')
INSERT [dbo].[ChatChannelsDomain] ([ChatChannelID], [Name]) VALUES (7, N'Server')
INSERT [dbo].[ClientLogEventTypesDomain] ([ClientLogEventTypeID], [Name]) VALUES (1, N'Log In')
INSERT [dbo].[ClientLogEventTypesDomain] ([ClientLogEventTypeID], [Name]) VALUES (2, N'Log Out')
INSERT [dbo].[CraftBlueprintCategories] ([CraftBlueprintCategoryID], [Name], [IsActive]) VALUES (0, N'Unknown', 0)
INSERT [dbo].[CraftBlueprintCategories] ([CraftBlueprintCategoryID], [Name], [IsActive]) VALUES (1, N'Components', 1)
INSERT [dbo].[CraftBlueprintCategories] ([CraftBlueprintCategoryID], [Name], [IsActive]) VALUES (2, N'Melee Weapons', 1)
INSERT [dbo].[CraftBlueprintCategories] ([CraftBlueprintCategoryID], [Name], [IsActive]) VALUES (3, N'Ranged Weapons', 1)
INSERT [dbo].[CraftBlueprintCategories] ([CraftBlueprintCategoryID], [Name], [IsActive]) VALUES (4, N'Ammo', 1)
INSERT [dbo].[CraftBlueprintCategories] ([CraftBlueprintCategoryID], [Name], [IsActive]) VALUES (5, N'Armor', 1)
INSERT [dbo].[CraftBlueprintCategories] ([CraftBlueprintCategoryID], [Name], [IsActive]) VALUES (6, N'Tools', 1)
INSERT [dbo].[CraftBlueprintCategories] ([CraftBlueprintCategoryID], [Name], [IsActive]) VALUES (7, N'Upgrade Kits', 1)
INSERT [dbo].[CraftBlueprintCategories] ([CraftBlueprintCategoryID], [Name], [IsActive]) VALUES (8, N'Repair Kits', 1)
INSERT [dbo].[CraftBlueprintCategories] ([CraftBlueprintCategoryID], [Name], [IsActive]) VALUES (9, N'Medical', 1)
INSERT [dbo].[CraftBlueprintCategories] ([CraftBlueprintCategoryID], [Name], [IsActive]) VALUES (12, N'Throwing', 1)
INSERT [dbo].[Crafts] ([CraftID], [Name], [IsActive], [Description]) VALUES (1, N'Smithery', 1, N'This craft enables you to create items such as blades and armor. A Smithery Workbench is required to use this craft.')
INSERT [dbo].[Crafts] ([CraftID], [Name], [IsActive], [Description]) VALUES (3, N'Mixing', 1, N'This craft enables you to create medical kits, treatment kits, food, and other restorative items. A Mixing Table is required to use this craft.')
INSERT [dbo].[Crafts] ([CraftID], [Name], [IsActive], [Description]) VALUES (4, N'Engineering', 1, N'This craft enables you to create guns, ammo, explosives and other mechanically-based items. An Engineering Workbench is required to use this craft.')
INSERT [dbo].[DMRoleDomain] ([DMRoleDomainID], [Description]) VALUES (1, N'DM')
INSERT [dbo].[DMRoleDomain] ([DMRoleDomainID], [Description]) VALUES (2, N'Admin')
INSERT [dbo].[DMRoleDomain] ([DMRoleDomainID], [Description]) VALUES (3, N'Player')
INSERT [dbo].[FameRegions] ([FameRegionID], [Name]) VALUES (3, N'Global')
INSERT [dbo].[KeyItemCategories] ([KeyItemCategoryID], [Name], [IsActive]) VALUES (0, N'Unknown', 0)
INSERT [dbo].[KeyItemCategories] ([KeyItemCategoryID], [Name], [IsActive]) VALUES (1, N'Maps', 1)
INSERT [dbo].[KeyItemCategories] ([KeyItemCategoryID], [Name], [IsActive]) VALUES (2, N'Quest Items', 1)
INSERT [dbo].[KeyItemCategories] ([KeyItemCategoryID], [Name], [IsActive]) VALUES (3, N'Documents', 1)
INSERT [dbo].[KeyItemCategories] ([KeyItemCategoryID], [Name], [IsActive]) VALUES (4, N'Blueprints', 1)
INSERT [dbo].[QuestTypeDomain] ([QuestTypeID], [Name]) VALUES (0, N'None')
INSERT [dbo].[QuestTypeDomain] ([QuestTypeID], [Name]) VALUES (1, N'Kill Enemies')
INSERT [dbo].[QuestTypeDomain] ([QuestTypeID], [Name]) VALUES (2, N'Talk to NPC')
INSERT [dbo].[QuestTypeDomain] ([QuestTypeID], [Name]) VALUES (3, N'Use Object')
INSERT [dbo].[QuestTypeDomain] ([QuestTypeID], [Name]) VALUES (4, N'Collect Items')
INSERT [dbo].[QuestTypeDomain] ([QuestTypeID], [Name]) VALUES (5, N'Explore Area')
INSERT [dbo].[QuestTypeDomain] ([QuestTypeID], [Name]) VALUES (6, N'Use Item on Target')
INSERT [dbo].[ServerConfiguration] ([ServerConfigurationID], [ServerName], [MessageOfTheDay]) VALUES (1, N'Freescape', N'Welcome to Freescape!')
INSERT [dbo].[StructureBlueprints] ([StructureBlueprintID], [StructureCategoryID], [Name], [Description], [Resref], [IsActive], [IsTerritoryFlag], [IsUseable], [WoodRequired], [MetalRequired], [NailsRequired], [ClothRequired], [LeatherRequired], [ItemStorageCount], [MaxStructuresCount], [MaxBuildDistance], [IronRequired], [ResearchSlots], [RPPerSecond]) VALUES (1, 1, N'Basic Territory Flag', N'', N'terr_flag_1', 1, 1, 0, 15, 0, 5, 0, 0, 0, 20, 10, 0, 0, 0)
INSERT [dbo].[StructureBlueprints] ([StructureBlueprintID], [StructureCategoryID], [Name], [Description], [Resref], [IsActive], [IsTerritoryFlag], [IsUseable], [WoodRequired], [MetalRequired], [NailsRequired], [ClothRequired], [LeatherRequired], [ItemStorageCount], [MaxStructuresCount], [MaxBuildDistance], [IronRequired], [ResearchSlots], [RPPerSecond]) VALUES (2, 1, N'Large Territory Flag', N'', N'terr_flag_2', 1, 1, 0, 45, 0, 15, 20, 20, 0, 40, 20, 10, 0, 0)
SET IDENTITY_INSERT [dbo].[StructureCategories] ON 

INSERT [dbo].[StructureCategories] ([StructureCategoryID], [Name], [Description], [IsActive], [IsTerritoryFlagCategory]) VALUES (1, N'Territory Flags', N'', 1, 1)
SET IDENTITY_INSERT [dbo].[StructureCategories] OFF
INSERT [dbo].[TerritoryFlagPermissions] ([TerritoryFlagPermissionID], [Name], [IsActive], [IsSelectable]) VALUES (0, N'None', 1, 0)
INSERT [dbo].[TerritoryFlagPermissions] ([TerritoryFlagPermissionID], [Name], [IsActive], [IsSelectable]) VALUES (1, N'Can Use Structures', 1, 1)
INSERT [dbo].[TerritoryFlagPermissions] ([TerritoryFlagPermissionID], [Name], [IsActive], [IsSelectable]) VALUES (2, N'Can Build Structures', 1, 1)
INSERT [dbo].[TerritoryFlagPermissions] ([TerritoryFlagPermissionID], [Name], [IsActive], [IsSelectable]) VALUES (3, N'Can Raze Structures', 1, 1)
INSERT [dbo].[TerritoryFlagPermissions] ([TerritoryFlagPermissionID], [Name], [IsActive], [IsSelectable]) VALUES (4, N'Can Move Structures', 1, 1)
INSERT [dbo].[TerritoryFlagPermissions] ([TerritoryFlagPermissionID], [Name], [IsActive], [IsSelectable]) VALUES (5, N'Can Rotate Structures', 1, 1)
INSERT [dbo].[TerritoryFlagPermissions] ([TerritoryFlagPermissionID], [Name], [IsActive], [IsSelectable]) VALUES (6, N'Can Access Persistent Storage', 1, 1)
/****** Object:  Index [uq_Abilities_FeatID]    Script Date: 3/8/2018 4:27:23 PM ******/
ALTER TABLE [dbo].[Abilities] ADD  CONSTRAINT [uq_Abilities_FeatID] UNIQUE NONCLUSTERED 
(
	[FeatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Abilities] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[Abilities] ADD  DEFAULT ((0)) FOR [FeatID]
GO
ALTER TABLE [dbo].[Abilities] ADD  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Abilities] ADD  DEFAULT ('') FOR [JavaScriptName]
GO
ALTER TABLE [dbo].[Abilities] ADD  DEFAULT ((0)) FOR [BaseManaCost]
GO
ALTER TABLE [dbo].[Abilities] ADD  DEFAULT ((0.0)) FOR [BaseCastingTime]
GO
ALTER TABLE [dbo].[Abilities] ADD  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[Abilities] ADD  DEFAULT ((0)) FOR [IsQueuedWeaponSkill]
GO
ALTER TABLE [dbo].[AbilityCategories] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[AbilityCategories] ADD  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[AbilityCooldownCategories] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[AbilityCooldownCategories] ADD  DEFAULT ((0.0)) FOR [BaseCooldownTime]
GO
ALTER TABLE [dbo].[ChatChannelsDomain] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[ChatLog] ADD  DEFAULT ('') FOR [SenderAccountName]
GO
ALTER TABLE [dbo].[ChatLog] ADD  DEFAULT ('') FOR [SenderCDKey]
GO
ALTER TABLE [dbo].[ChatLog] ADD  DEFAULT ('') FOR [Message]
GO
ALTER TABLE [dbo].[ChatLog] ADD  DEFAULT (getutcdate()) FOR [DateSent]
GO
ALTER TABLE [dbo].[ClientLogEvents] ADD  DEFAULT (getutcdate()) FOR [DateOfEvent]
GO
ALTER TABLE [dbo].[ConstructionSites] ADD  DEFAULT ((0)) FOR [IronRequired]
GO
ALTER TABLE [dbo].[Downloads] ADD  DEFAULT ('') FOR [Name]
GO
ALTER TABLE [dbo].[Downloads] ADD  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[Downloads] ADD  DEFAULT ('') FOR [Url]
GO
ALTER TABLE [dbo].[Downloads] ADD  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PCKeyItems] ADD  CONSTRAINT [df_PCKeyItems_AcquiredDate]  DEFAULT (getutcdate()) FOR [AcquiredDate]
GO
ALTER TABLE [dbo].[PCLearnedAbilities] ADD  DEFAULT (getutcdate()) FOR [AcquiredDate]
GO
ALTER TABLE [dbo].[PCRegionalFame] ADD  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[PCTerritoryFlags] ADD  CONSTRAINT [df_PCTerritoryFlags_BuildPrivacySettingID]  DEFAULT ((1)) FOR [BuildPrivacySettingID]
GO
ALTER TABLE [dbo].[PCTerritoryFlagsStructures] ADD  CONSTRAINT [df_PCTerritoryFlagsStructures_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PCTerritoryFlagsStructuresResearchQueues] ADD  DEFAULT (getutcdate()) FOR [StartDateTime]
GO
ALTER TABLE [dbo].[PCTerritoryFlagsStructuresResearchQueues] ADD  DEFAULT ((0)) FOR [IsCanceled]
GO
ALTER TABLE [dbo].[PlayerCharacters] ADD  CONSTRAINT [df_PlayerCharacters_CreateTimestamp]  DEFAULT (getutcdate()) FOR [CreateTimestamp]
GO
ALTER TABLE [dbo].[PlayerCharacters] ADD  DEFAULT ((0)) FOR [MaxMana]
GO
ALTER TABLE [dbo].[PlayerCharacters] ADD  DEFAULT ((0)) FOR [CurrentMana]
GO
ALTER TABLE [dbo].[PlayerCharacters] ADD  DEFAULT ((0)) FOR [CurrentManaTick]
GO
ALTER TABLE [dbo].[PlayerCharacters] ADD  DEFAULT ((0)) FOR [RevivalStoneCount]
GO
ALTER TABLE [dbo].[PlayerCharacters] ADD  DEFAULT ('') FOR [RespawnAreaTag]
GO
ALTER TABLE [dbo].[PlayerCharacters] ADD  DEFAULT ((0.0)) FOR [RespawnLocationX]
GO
ALTER TABLE [dbo].[PlayerCharacters] ADD  DEFAULT ((0.0)) FOR [RespawnLocationY]
GO
ALTER TABLE [dbo].[PlayerCharacters] ADD  DEFAULT ((0.0)) FOR [RespawnLocationZ]
GO
ALTER TABLE [dbo].[PlayerCharacters] ADD  DEFAULT ((0.0)) FOR [RespawnLocationOrientation]
GO
ALTER TABLE [dbo].[PlayerCharacters] ADD  DEFAULT (dateadd(hour,(72),getutcdate())) FOR [DateSanctuaryEnds]
GO
ALTER TABLE [dbo].[PlayerCharacters] ADD  DEFAULT ((0)) FOR [IsSanctuaryOverrideEnabled]
GO
ALTER TABLE [dbo].[Quests] ADD  DEFAULT ((0)) FOR [AllowRewardSelection]
GO
ALTER TABLE [dbo].[Quests] ADD  DEFAULT ((0)) FOR [IsRepeatable]
GO
ALTER TABLE [dbo].[Quests] ADD  DEFAULT ((0)) FOR [RemoveStartKeyItemAfterCompletion]
GO
ALTER TABLE [dbo].[QuestStates] ADD  DEFAULT ((0)) FOR [IsFinalState]
GO
ALTER TABLE [dbo].[ResearchBlueprints] ADD  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ResearchBlueprints] ADD  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[ResearchBlueprints] ADD  DEFAULT ((0)) FOR [ResearchPoints]
GO
ALTER TABLE [dbo].[ResearchBlueprints] ADD  DEFAULT ((0)) FOR [SkillRequired]
GO
ALTER TABLE [dbo].[ServerConfiguration] ADD  DEFAULT ('') FOR [ServerName]
GO
ALTER TABLE [dbo].[ServerConfiguration] ADD  DEFAULT ('') FOR [MessageOfTheDay]
GO
ALTER TABLE [dbo].[SpawnTableCreatures] ADD  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[SpawnTableCreatures] ADD  DEFAULT ((0)) FOR [Weight]
GO
ALTER TABLE [dbo].[SpawnTableCreatures] ADD  DEFAULT ((0)) FOR [MaxNumberInArea]
GO
ALTER TABLE [dbo].[SpawnTableCreatures] ADD  DEFAULT ((0)) FOR [DifficultyRating]
GO
ALTER TABLE [dbo].[StructureBlueprints] ADD  DEFAULT ((0)) FOR [IronRequired]
GO
ALTER TABLE [dbo].[StructureBlueprints] ADD  DEFAULT ((0)) FOR [ResearchSlots]
GO
ALTER TABLE [dbo].[StructureBlueprints] ADD  DEFAULT ((0)) FOR [RPPerSecond]
GO
ALTER TABLE [dbo].[StructureQuickBuildAudit] ADD  DEFAULT ('') FOR [DMName]
GO
ALTER TABLE [dbo].[StructureQuickBuildAudit] ADD  DEFAULT (getutcdate()) FOR [DateBuilt]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((3)) FOR [RoleID]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getutcdate()) FOR [DateRegistered]
GO
ALTER TABLE [dbo].[Abilities]  WITH CHECK ADD  CONSTRAINT [fk_Abilities_AbilityCategoryID] FOREIGN KEY([AbilityCategoryID])
REFERENCES [dbo].[AbilityCategories] ([AbilityCategoryID])
GO
ALTER TABLE [dbo].[Abilities] CHECK CONSTRAINT [fk_Abilities_AbilityCategoryID]
GO
ALTER TABLE [dbo].[Abilities]  WITH CHECK ADD  CONSTRAINT [fk_Abilities_AbilityCooldownCategoryID] FOREIGN KEY([AbilityCooldownCategoryID])
REFERENCES [dbo].[AbilityCooldownCategories] ([AbilityCooldownCategoryID])
GO
ALTER TABLE [dbo].[Abilities] CHECK CONSTRAINT [fk_Abilities_AbilityCooldownCategoryID]
GO
ALTER TABLE [dbo].[ChatLog]  WITH CHECK ADD  CONSTRAINT [fk_ChatLog_ChatChannelID] FOREIGN KEY([ChatChannelID])
REFERENCES [dbo].[ChatChannelsDomain] ([ChatChannelID])
GO
ALTER TABLE [dbo].[ChatLog] CHECK CONSTRAINT [fk_ChatLog_ChatChannelID]
GO
ALTER TABLE [dbo].[ChatLog]  WITH CHECK ADD  CONSTRAINT [fk_ChatLog_ReceiverPlayerID] FOREIGN KEY([ReceiverPlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[ChatLog] CHECK CONSTRAINT [fk_ChatLog_ReceiverPlayerID]
GO
ALTER TABLE [dbo].[ChatLog]  WITH CHECK ADD  CONSTRAINT [fk_ChatLog_SenderPlayerID] FOREIGN KEY([SenderPlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[ChatLog] CHECK CONSTRAINT [fk_ChatLog_SenderPlayerID]
GO
ALTER TABLE [dbo].[ClientLogEvents]  WITH CHECK ADD  CONSTRAINT [FK_ClientLogEvents_ClientLogEventTypeID] FOREIGN KEY([ClientLogEventTypeID])
REFERENCES [dbo].[ClientLogEventTypesDomain] ([ClientLogEventTypeID])
GO
ALTER TABLE [dbo].[ClientLogEvents] CHECK CONSTRAINT [FK_ClientLogEvents_ClientLogEventTypeID]
GO
ALTER TABLE [dbo].[ClientLogEvents]  WITH CHECK ADD  CONSTRAINT [FK_ClientLogEvents_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[ClientLogEvents] CHECK CONSTRAINT [FK_ClientLogEvents_PlayerID]
GO
ALTER TABLE [dbo].[ConstructionSites]  WITH CHECK ADD  CONSTRAINT [fk_ConstructionSites_PCTerritoryFlagID] FOREIGN KEY([PCTerritoryFlagID])
REFERENCES [dbo].[PCTerritoryFlags] ([PCTerritoryFlagID])
GO
ALTER TABLE [dbo].[ConstructionSites] CHECK CONSTRAINT [fk_ConstructionSites_PCTerritoryFlagID]
GO
ALTER TABLE [dbo].[ConstructionSites]  WITH CHECK ADD  CONSTRAINT [fk_ConstructionSites_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[ConstructionSites] CHECK CONSTRAINT [fk_ConstructionSites_PlayerID]
GO
ALTER TABLE [dbo].[ConstructionSites]  WITH CHECK ADD  CONSTRAINT [fk_ConstructionSites_StructureBlueprintID] FOREIGN KEY([StructureBlueprintID])
REFERENCES [dbo].[StructureBlueprints] ([StructureBlueprintID])
GO
ALTER TABLE [dbo].[ConstructionSites] CHECK CONSTRAINT [fk_ConstructionSites_StructureBlueprintID]
GO
ALTER TABLE [dbo].[CraftBlueprintComponents]  WITH CHECK ADD  CONSTRAINT [fk_CraftBlueprintComponents_CraftBlueprintID] FOREIGN KEY([CraftBlueprintID])
REFERENCES [dbo].[CraftBlueprints] ([CraftBlueprintID])
GO
ALTER TABLE [dbo].[CraftBlueprintComponents] CHECK CONSTRAINT [fk_CraftBlueprintComponents_CraftBlueprintID]
GO
ALTER TABLE [dbo].[CraftBlueprints]  WITH CHECK ADD  CONSTRAINT [fk_CraftBlueprints_CraftCategoryID] FOREIGN KEY([CraftCategoryID])
REFERENCES [dbo].[CraftBlueprintCategories] ([CraftBlueprintCategoryID])
GO
ALTER TABLE [dbo].[CraftBlueprints] CHECK CONSTRAINT [fk_CraftBlueprints_CraftCategoryID]
GO
ALTER TABLE [dbo].[CraftBlueprints]  WITH CHECK ADD  CONSTRAINT [fk_CraftBlueprints_CraftID] FOREIGN KEY([CraftID])
REFERENCES [dbo].[Crafts] ([CraftID])
GO
ALTER TABLE [dbo].[CraftBlueprints] CHECK CONSTRAINT [fk_CraftBlueprints_CraftID]
GO
ALTER TABLE [dbo].[KeyItems]  WITH CHECK ADD  CONSTRAINT [fk_KeyItems_KeyItemCategoryID] FOREIGN KEY([KeyItemCategoryID])
REFERENCES [dbo].[KeyItemCategories] ([KeyItemCategoryID])
GO
ALTER TABLE [dbo].[KeyItems] CHECK CONSTRAINT [fk_KeyItems_KeyItemCategoryID]
GO
ALTER TABLE [dbo].[LootTableItems]  WITH CHECK ADD  CONSTRAINT [fk_LootTableItems_LootTableID] FOREIGN KEY([LootTableID])
REFERENCES [dbo].[LootTables] ([LootTableID])
GO
ALTER TABLE [dbo].[LootTableItems] CHECK CONSTRAINT [fk_LootTableItems_LootTableID]
GO
ALTER TABLE [dbo].[PCAbilityCooldowns]  WITH CHECK ADD  CONSTRAINT [fk_PCAbilityCooldowns_AbilityCooldownCategoryID] FOREIGN KEY([AbilityCooldownCategoryID])
REFERENCES [dbo].[AbilityCooldownCategories] ([AbilityCooldownCategoryID])
GO
ALTER TABLE [dbo].[PCAbilityCooldowns] CHECK CONSTRAINT [fk_PCAbilityCooldowns_AbilityCooldownCategoryID]
GO
ALTER TABLE [dbo].[PCAbilityCooldowns]  WITH CHECK ADD  CONSTRAINT [fk_PCAbilityCooldowns_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[PCAbilityCooldowns] CHECK CONSTRAINT [fk_PCAbilityCooldowns_PlayerID]
GO
ALTER TABLE [dbo].[PCBlueprints]  WITH CHECK ADD  CONSTRAINT [fk_PCBlueprints_CraftBlueprintID] FOREIGN KEY([CraftBlueprintID])
REFERENCES [dbo].[CraftBlueprints] ([CraftBlueprintID])
GO
ALTER TABLE [dbo].[PCBlueprints] CHECK CONSTRAINT [fk_PCBlueprints_CraftBlueprintID]
GO
ALTER TABLE [dbo].[PCBlueprints]  WITH CHECK ADD  CONSTRAINT [fk_PCBlueprints_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[PCBlueprints] CHECK CONSTRAINT [fk_PCBlueprints_PlayerID]
GO
ALTER TABLE [dbo].[PCCorpseItems]  WITH CHECK ADD  CONSTRAINT [fk_PCCorpseItems_PCCorpseID] FOREIGN KEY([PCCorpseID])
REFERENCES [dbo].[PCCorpses] ([PCCorpseID])
GO
ALTER TABLE [dbo].[PCCorpseItems] CHECK CONSTRAINT [fk_PCCorpseItems_PCCorpseID]
GO
ALTER TABLE [dbo].[PCCustomEffects]  WITH CHECK ADD  CONSTRAINT [fk_PCCustomEffects_CustomEffectID] FOREIGN KEY([CustomEffectID])
REFERENCES [dbo].[CustomEffects] ([CustomEffectID])
GO
ALTER TABLE [dbo].[PCCustomEffects] CHECK CONSTRAINT [fk_PCCustomEffects_CustomEffectID]
GO
ALTER TABLE [dbo].[PCCustomEffects]  WITH CHECK ADD  CONSTRAINT [fk_PCCustomEffects_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[PCCustomEffects] CHECK CONSTRAINT [fk_PCCustomEffects_PlayerID]
GO
ALTER TABLE [dbo].[PCKeyItems]  WITH CHECK ADD  CONSTRAINT [fk_PCKeyItems_KeyItemID] FOREIGN KEY([KeyItemID])
REFERENCES [dbo].[KeyItems] ([KeyItemID])
GO
ALTER TABLE [dbo].[PCKeyItems] CHECK CONSTRAINT [fk_PCKeyItems_KeyItemID]
GO
ALTER TABLE [dbo].[PCKeyItems]  WITH CHECK ADD  CONSTRAINT [fk_PCKeyItems_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[PCKeyItems] CHECK CONSTRAINT [fk_PCKeyItems_PlayerID]
GO
ALTER TABLE [dbo].[PCLearnedAbilities]  WITH CHECK ADD  CONSTRAINT [fk_PCLearnedAbilities_AbilityID] FOREIGN KEY([AbilityID])
REFERENCES [dbo].[Abilities] ([AbilityID])
GO
ALTER TABLE [dbo].[PCLearnedAbilities] CHECK CONSTRAINT [fk_PCLearnedAbilities_AbilityID]
GO
ALTER TABLE [dbo].[PCLearnedAbilities]  WITH CHECK ADD  CONSTRAINT [fk_PCLearnedAbilities_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[PCLearnedAbilities] CHECK CONSTRAINT [fk_PCLearnedAbilities_PlayerID]
GO
ALTER TABLE [dbo].[PCMigrationItems]  WITH CHECK ADD  CONSTRAINT [fk_PCMigrationItems_BaseItemTypeID] FOREIGN KEY([BaseItemTypeID])
REFERENCES [dbo].[BaseItemTypes] ([BaseItemTypeID])
GO
ALTER TABLE [dbo].[PCMigrationItems] CHECK CONSTRAINT [fk_PCMigrationItems_BaseItemTypeID]
GO
ALTER TABLE [dbo].[PCMigrationItems]  WITH CHECK ADD  CONSTRAINT [fk_PCMigrationItems_PCMigrationID] FOREIGN KEY([PCMigrationID])
REFERENCES [dbo].[PCMigrations] ([PCMigrationID])
GO
ALTER TABLE [dbo].[PCMigrationItems] CHECK CONSTRAINT [fk_PCMigrationItems_PCMigrationID]
GO
ALTER TABLE [dbo].[PCOutfits]  WITH CHECK ADD  CONSTRAINT [fk_PCOutfits_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[PCOutfits] CHECK CONSTRAINT [fk_PCOutfits_PlayerID]
GO
ALTER TABLE [dbo].[PCOverflowItems]  WITH CHECK ADD  CONSTRAINT [fk_PCOverflowItems_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[PCOverflowItems] CHECK CONSTRAINT [fk_PCOverflowItems_PlayerID]
GO
ALTER TABLE [dbo].[PCQuestKillTargetProgress]  WITH CHECK ADD  CONSTRAINT [FK_PCQuestKillTargetProgress_NPCGroupID] FOREIGN KEY([NPCGroupID])
REFERENCES [dbo].[NPCGroups] ([NPCGroupID])
GO
ALTER TABLE [dbo].[PCQuestKillTargetProgress] CHECK CONSTRAINT [FK_PCQuestKillTargetProgress_NPCGroupID]
GO
ALTER TABLE [dbo].[PCQuestKillTargetProgress]  WITH CHECK ADD  CONSTRAINT [FK_PCQuestKillTargetProgress_PCQuestStatusID] FOREIGN KEY([PCQuestStatusID])
REFERENCES [dbo].[PCQuestStatus] ([PCQuestStatusID])
GO
ALTER TABLE [dbo].[PCQuestKillTargetProgress] CHECK CONSTRAINT [FK_PCQuestKillTargetProgress_PCQuestStatusID]
GO
ALTER TABLE [dbo].[PCQuestKillTargetProgress]  WITH CHECK ADD  CONSTRAINT [FK_PCQuestKillTargetProgress_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[PCQuestKillTargetProgress] CHECK CONSTRAINT [FK_PCQuestKillTargetProgress_PlayerID]
GO
ALTER TABLE [dbo].[PCQuestStatus]  WITH CHECK ADD  CONSTRAINT [FK_PCQuestStatus_CurrentQuestStateID] FOREIGN KEY([CurrentQuestStateID])
REFERENCES [dbo].[QuestStates] ([QuestStateID])
GO
ALTER TABLE [dbo].[PCQuestStatus] CHECK CONSTRAINT [FK_PCQuestStatus_CurrentQuestStateID]
GO
ALTER TABLE [dbo].[PCQuestStatus]  WITH CHECK ADD  CONSTRAINT [FK_PCQuestStatus_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[PCQuestStatus] CHECK CONSTRAINT [FK_PCQuestStatus_PlayerID]
GO
ALTER TABLE [dbo].[PCQuestStatus]  WITH CHECK ADD  CONSTRAINT [FK_PCQuestStatus_QuestID] FOREIGN KEY([QuestID])
REFERENCES [dbo].[Quests] ([QuestID])
GO
ALTER TABLE [dbo].[PCQuestStatus] CHECK CONSTRAINT [FK_PCQuestStatus_QuestID]
GO
ALTER TABLE [dbo].[PCQuestStatus]  WITH CHECK ADD  CONSTRAINT [FK_PCQuestStatus_SelectedRewardID] FOREIGN KEY([SelectedItemRewardID])
REFERENCES [dbo].[QuestRewardItems] ([QuestRewardItemID])
GO
ALTER TABLE [dbo].[PCQuestStatus] CHECK CONSTRAINT [FK_PCQuestStatus_SelectedRewardID]
GO
ALTER TABLE [dbo].[PCRegionalFame]  WITH CHECK ADD  CONSTRAINT [FK_PCRegionalFame_FameRegionID] FOREIGN KEY([FameRegionID])
REFERENCES [dbo].[FameRegions] ([FameRegionID])
GO
ALTER TABLE [dbo].[PCRegionalFame] CHECK CONSTRAINT [FK_PCRegionalFame_FameRegionID]
GO
ALTER TABLE [dbo].[PCRegionalFame]  WITH CHECK ADD  CONSTRAINT [FK_PCRegionalFame_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[PCRegionalFame] CHECK CONSTRAINT [FK_PCRegionalFame_PlayerID]
GO
ALTER TABLE [dbo].[PCSearchSiteItems]  WITH CHECK ADD  CONSTRAINT [fk_PCSearchSiteItems_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[PCSearchSiteItems] CHECK CONSTRAINT [fk_PCSearchSiteItems_PlayerID]
GO
ALTER TABLE [dbo].[PCSearchSites]  WITH CHECK ADD  CONSTRAINT [fk_PCSearchSites_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[PCSearchSites] CHECK CONSTRAINT [fk_PCSearchSites_PlayerID]
GO
ALTER TABLE [dbo].[PCTerritoryFlags]  WITH CHECK ADD  CONSTRAINT [fk_PCTerritoryFlags_BuildPrivacySettingID] FOREIGN KEY([BuildPrivacySettingID])
REFERENCES [dbo].[BuildPrivacyDomain] ([BuildPrivacyTypeID])
GO
ALTER TABLE [dbo].[PCTerritoryFlags] CHECK CONSTRAINT [fk_PCTerritoryFlags_BuildPrivacySettingID]
GO
ALTER TABLE [dbo].[PCTerritoryFlags]  WITH CHECK ADD  CONSTRAINT [fk_PCTerritoryFlags_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[PCTerritoryFlags] CHECK CONSTRAINT [fk_PCTerritoryFlags_PlayerID]
GO
ALTER TABLE [dbo].[PCTerritoryFlags]  WITH CHECK ADD  CONSTRAINT [fk_PCTerritoryFlags_StructureBlueprintID] FOREIGN KEY([StructureBlueprintID])
REFERENCES [dbo].[StructureBlueprints] ([StructureBlueprintID])
GO
ALTER TABLE [dbo].[PCTerritoryFlags] CHECK CONSTRAINT [fk_PCTerritoryFlags_StructureBlueprintID]
GO
ALTER TABLE [dbo].[PCTerritoryFlagsPermissions]  WITH CHECK ADD  CONSTRAINT [fk_PCTerritoryFlagsPermissions_PCTerritoryFlagID] FOREIGN KEY([PCTerritoryFlagID])
REFERENCES [dbo].[PCTerritoryFlags] ([PCTerritoryFlagID])
GO
ALTER TABLE [dbo].[PCTerritoryFlagsPermissions] CHECK CONSTRAINT [fk_PCTerritoryFlagsPermissions_PCTerritoryFlagID]
GO
ALTER TABLE [dbo].[PCTerritoryFlagsPermissions]  WITH CHECK ADD  CONSTRAINT [fk_PCTerritoryFlagsPermissions_PlayerID] FOREIGN KEY([PlayerID])
REFERENCES [dbo].[PlayerCharacters] ([PlayerID])
GO
ALTER TABLE [dbo].[PCTerritoryFlagsPermissions] CHECK CONSTRAINT [fk_PCTerritoryFlagsPermissions_PlayerID]
GO
ALTER TABLE [dbo].[PCTerritoryFlagsPermissions]  WITH CHECK ADD  CONSTRAINT [fk_PCTerritoryFlagsPermissions_TerritoryFlagPermissionID] FOREIGN KEY([TerritoryFlagPermissionID])
REFERENCES [dbo].[TerritoryFlagPermissions] ([TerritoryFlagPermissionID])
GO
ALTER TABLE [dbo].[PCTerritoryFlagsPermissions] CHECK CONSTRAINT [fk_PCTerritoryFlagsPermissions_TerritoryFlagPermissionID]
GO
ALTER TABLE [dbo].[PCTerritoryFlagsStructures]  WITH CHECK ADD  CONSTRAINT [fk_PCTerritoryFlagsStructures_PCTerritoryFlagID] FOREIGN KEY([PCTerritoryFlagID])
REFERENCES [dbo].[PCTerritoryFlags] ([PCTerritoryFlagID])
GO
ALTER TABLE [dbo].[PCTerritoryFlagsStructures] CHECK CONSTRAINT [fk_PCTerritoryFlagsStructures_PCTerritoryFlagID]
GO
ALTER TABLE [dbo].[PCTerritoryFlagsStructures]  WITH CHECK ADD  CONSTRAINT [fk_PCTerritoryFlagsStructures_StructureBlueprintID] FOREIGN KEY([StructureBlueprintID])
REFERENCES [dbo].[StructureBlueprints] ([StructureBlueprintID])
GO
ALTER TABLE [dbo].[PCTerritoryFlagsStructures] CHECK CONSTRAINT [fk_PCTerritoryFlagsStructures_StructureBlueprintID]
GO
ALTER TABLE [dbo].[PCTerritoryFlagsStructuresItems]  WITH CHECK ADD  CONSTRAINT [fk_PCTerritoryFlagsStructuresItems_PCStructureID] FOREIGN KEY([PCStructureID])
REFERENCES [dbo].[PCTerritoryFlagsStructures] ([PCTerritoryFlagStructureID])
GO
ALTER TABLE [dbo].[PCTerritoryFlagsStructuresItems] CHECK CONSTRAINT [fk_PCTerritoryFlagsStructuresItems_PCStructureID]
GO
ALTER TABLE [dbo].[PCTerritoryFlagsStructuresResearchQueues]  WITH CHECK ADD  CONSTRAINT [fk_PCTerritoryFlagsStructuresResearchQueues_PCStructureID] FOREIGN KEY([PCStructureID])
REFERENCES [dbo].[PCTerritoryFlagsStructures] ([PCTerritoryFlagStructureID])
GO
ALTER TABLE [dbo].[PCTerritoryFlagsStructuresResearchQueues] CHECK CONSTRAINT [fk_PCTerritoryFlagsStructuresResearchQueues_PCStructureID]
GO
ALTER TABLE [dbo].[PCTerritoryFlagsStructuresResearchQueues]  WITH CHECK ADD  CONSTRAINT [fk_PCTerritoryFlagsStructuresResearchQueues_ResearchBlueprintID] FOREIGN KEY([ResearchBlueprintID])
REFERENCES [dbo].[ResearchBlueprints] ([ResearchBlueprintID])
GO
ALTER TABLE [dbo].[PCTerritoryFlagsStructuresResearchQueues] CHECK CONSTRAINT [fk_PCTerritoryFlagsStructuresResearchQueues_ResearchBlueprintID]
GO
ALTER TABLE [dbo].[QuestKillTargetList]  WITH CHECK ADD  CONSTRAINT [FK_QuestKillTargetList_NPCGroupID] FOREIGN KEY([NPCGroupID])
REFERENCES [dbo].[NPCGroups] ([NPCGroupID])
GO
ALTER TABLE [dbo].[QuestKillTargetList] CHECK CONSTRAINT [FK_QuestKillTargetList_NPCGroupID]
GO
ALTER TABLE [dbo].[QuestKillTargetList]  WITH CHECK ADD  CONSTRAINT [FK_QuestKillTargetList_QuestID] FOREIGN KEY([QuestID])
REFERENCES [dbo].[Quests] ([QuestID])
GO
ALTER TABLE [dbo].[QuestKillTargetList] CHECK CONSTRAINT [FK_QuestKillTargetList_QuestID]
GO
ALTER TABLE [dbo].[QuestKillTargetList]  WITH CHECK ADD  CONSTRAINT [FK_QuestKillTargetList_QuestStateID] FOREIGN KEY([QuestStateID])
REFERENCES [dbo].[QuestStates] ([QuestStateID])
GO
ALTER TABLE [dbo].[QuestKillTargetList] CHECK CONSTRAINT [FK_QuestKillTargetList_QuestStateID]
GO
ALTER TABLE [dbo].[QuestPrerequisites]  WITH CHECK ADD  CONSTRAINT [FK_QuestPrerequisites_QuestID] FOREIGN KEY([QuestID])
REFERENCES [dbo].[Quests] ([QuestID])
GO
ALTER TABLE [dbo].[QuestPrerequisites] CHECK CONSTRAINT [FK_QuestPrerequisites_QuestID]
GO
ALTER TABLE [dbo].[QuestPrerequisites]  WITH CHECK ADD  CONSTRAINT [FK_QuestPrerequisites_RequiredQuestID] FOREIGN KEY([RequiredQuestID])
REFERENCES [dbo].[Quests] ([QuestID])
GO
ALTER TABLE [dbo].[QuestPrerequisites] CHECK CONSTRAINT [FK_QuestPrerequisites_RequiredQuestID]
GO
ALTER TABLE [dbo].[QuestRequiredItemList]  WITH CHECK ADD  CONSTRAINT [FK_QuestRequiredItemList] FOREIGN KEY([QuestStateID])
REFERENCES [dbo].[QuestStates] ([QuestStateID])
GO
ALTER TABLE [dbo].[QuestRequiredItemList] CHECK CONSTRAINT [FK_QuestRequiredItemList]
GO
ALTER TABLE [dbo].[QuestRequiredItemList]  WITH CHECK ADD  CONSTRAINT [FK_QuestRequiredItemList_QuestID] FOREIGN KEY([QuestID])
REFERENCES [dbo].[Quests] ([QuestID])
GO
ALTER TABLE [dbo].[QuestRequiredItemList] CHECK CONSTRAINT [FK_QuestRequiredItemList_QuestID]
GO
ALTER TABLE [dbo].[QuestRequiredKeyItemList]  WITH CHECK ADD  CONSTRAINT [FK_QuestRequiredKeyItemList] FOREIGN KEY([QuestStateID])
REFERENCES [dbo].[QuestStates] ([QuestStateID])
GO
ALTER TABLE [dbo].[QuestRequiredKeyItemList] CHECK CONSTRAINT [FK_QuestRequiredKeyItemList]
GO
ALTER TABLE [dbo].[QuestRequiredKeyItemList]  WITH CHECK ADD  CONSTRAINT [FK_QuestRequiredKeyItemList_KeyItemID] FOREIGN KEY([KeyItemID])
REFERENCES [dbo].[KeyItems] ([KeyItemID])
GO
ALTER TABLE [dbo].[QuestRequiredKeyItemList] CHECK CONSTRAINT [FK_QuestRequiredKeyItemList_KeyItemID]
GO
ALTER TABLE [dbo].[QuestRequiredKeyItemList]  WITH CHECK ADD  CONSTRAINT [FK_QuestRequiredKeyItemList_QuestID] FOREIGN KEY([QuestID])
REFERENCES [dbo].[Quests] ([QuestID])
GO
ALTER TABLE [dbo].[QuestRequiredKeyItemList] CHECK CONSTRAINT [FK_QuestRequiredKeyItemList_QuestID]
GO
ALTER TABLE [dbo].[QuestRewardItems]  WITH CHECK ADD  CONSTRAINT [FK_QuestRewards_QuestID] FOREIGN KEY([QuestID])
REFERENCES [dbo].[Quests] ([QuestID])
GO
ALTER TABLE [dbo].[QuestRewardItems] CHECK CONSTRAINT [FK_QuestRewards_QuestID]
GO
ALTER TABLE [dbo].[Quests]  WITH CHECK ADD  CONSTRAINT [FK_Quests_FameRegionID] FOREIGN KEY([FameRegionID])
REFERENCES [dbo].[FameRegions] ([FameRegionID])
GO
ALTER TABLE [dbo].[Quests] CHECK CONSTRAINT [FK_Quests_FameRegionID]
GO
ALTER TABLE [dbo].[Quests]  WITH CHECK ADD  CONSTRAINT [FK_Quests_RewardKeyItemID] FOREIGN KEY([RewardKeyItemID])
REFERENCES [dbo].[KeyItems] ([KeyItemID])
GO
ALTER TABLE [dbo].[Quests] CHECK CONSTRAINT [FK_Quests_RewardKeyItemID]
GO
ALTER TABLE [dbo].[Quests]  WITH CHECK ADD  CONSTRAINT [FK_Quests_TemporaryKeyItemID] FOREIGN KEY([StartKeyItemID])
REFERENCES [dbo].[KeyItems] ([KeyItemID])
GO
ALTER TABLE [dbo].[Quests] CHECK CONSTRAINT [FK_Quests_TemporaryKeyItemID]
GO
ALTER TABLE [dbo].[QuestStates]  WITH CHECK ADD  CONSTRAINT [FK_QuestStates_QuestID] FOREIGN KEY([QuestID])
REFERENCES [dbo].[Quests] ([QuestID])
GO
ALTER TABLE [dbo].[QuestStates] CHECK CONSTRAINT [FK_QuestStates_QuestID]
GO
ALTER TABLE [dbo].[QuestStates]  WITH CHECK ADD  CONSTRAINT [FK_QuestStates_QuestTypeID] FOREIGN KEY([QuestTypeID])
REFERENCES [dbo].[QuestTypeDomain] ([QuestTypeID])
GO
ALTER TABLE [dbo].[QuestStates] CHECK CONSTRAINT [FK_QuestStates_QuestTypeID]
GO
ALTER TABLE [dbo].[ResearchBlueprints]  WITH CHECK ADD  CONSTRAINT [fk_ResearchBlueprints_BlueprintID] FOREIGN KEY([CraftBlueprintID])
REFERENCES [dbo].[CraftBlueprints] ([CraftBlueprintID])
GO
ALTER TABLE [dbo].[ResearchBlueprints] CHECK CONSTRAINT [fk_ResearchBlueprints_BlueprintID]
GO
ALTER TABLE [dbo].[SpawnTableCreatures]  WITH CHECK ADD  CONSTRAINT [fk_SpawnTableCreatures_LootTableID] FOREIGN KEY([LootTableID])
REFERENCES [dbo].[LootTables] ([LootTableID])
GO
ALTER TABLE [dbo].[SpawnTableCreatures] CHECK CONSTRAINT [fk_SpawnTableCreatures_LootTableID]
GO
ALTER TABLE [dbo].[SpawnTableCreatures]  WITH CHECK ADD  CONSTRAINT [fk_SpawnTableCreatures_SpawnTableID] FOREIGN KEY([SpawnTableID])
REFERENCES [dbo].[SpawnTables] ([SpawnTableID])
GO
ALTER TABLE [dbo].[SpawnTableCreatures] CHECK CONSTRAINT [fk_SpawnTableCreatures_SpawnTableID]
GO
ALTER TABLE [dbo].[StorageItems]  WITH CHECK ADD  CONSTRAINT [fk_StorageItems_StorageContainerID] FOREIGN KEY([StorageContainerID])
REFERENCES [dbo].[StorageContainers] ([StorageContainerID])
GO
ALTER TABLE [dbo].[StorageItems] CHECK CONSTRAINT [fk_StorageItems_StorageContainerID]
GO
ALTER TABLE [dbo].[StructureBlueprints]  WITH CHECK ADD  CONSTRAINT [fk_StructureBlueprints_StructureCategoryID] FOREIGN KEY([StructureCategoryID])
REFERENCES [dbo].[StructureCategories] ([StructureCategoryID])
GO
ALTER TABLE [dbo].[StructureBlueprints] CHECK CONSTRAINT [fk_StructureBlueprints_StructureCategoryID]
GO
ALTER TABLE [dbo].[StructureQuickBuildAudit]  WITH CHECK ADD  CONSTRAINT [FK_StructureQuickBuildAudit_PCTerritoryFlagID] FOREIGN KEY([PCTerritoryFlagID])
REFERENCES [dbo].[PCTerritoryFlags] ([PCTerritoryFlagID])
GO
ALTER TABLE [dbo].[StructureQuickBuildAudit] CHECK CONSTRAINT [FK_StructureQuickBuildAudit_PCTerritoryFlagID]
GO
ALTER TABLE [dbo].[StructureQuickBuildAudit]  WITH CHECK ADD  CONSTRAINT [FK_StructureQuickBuildAudit_PCTerritoryFlagStructureID] FOREIGN KEY([PCTerritoryFlagStructureID])
REFERENCES [dbo].[PCTerritoryFlagsStructures] ([PCTerritoryFlagStructureID])
GO
ALTER TABLE [dbo].[StructureQuickBuildAudit] CHECK CONSTRAINT [FK_StructureQuickBuildAudit_PCTerritoryFlagStructureID]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [fk_Users_RoleID] FOREIGN KEY([RoleID])
REFERENCES [dbo].[DMRoleDomain] ([DMRoleDomainID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [fk_Users_RoleID]
GO
USE [master]
GO
ALTER DATABASE [freescape] SET  READ_WRITE 
GO
