USE [BIM]
GO



/****** Object:  Table [dbo].[Categoria]    Script Date: 21/03/2017 17:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categoria](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descricao] [varchar](250) NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Documento]    Script Date: 21/03/2017 17:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Documento](
	[Id] [uniqueidentifier] NOT NULL,
	[IdProduto] [uniqueidentifier] NOT NULL,
	[Titulo] [varchar](250) NOT NULL,
	[Formato] [varchar](50) NOT NULL,
	[TamanhoKb] [smallint] NOT NULL,
	[Objeto] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_Documento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Fabricante]    Script Date: 21/03/2017 17:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fabricante](
	[Id] [uniqueidentifier] NOT NULL,
	[RazaoSocial] [varchar](500) NOT NULL,
	[Nome] [varchar](255) NOT NULL,
	[Telefone] [varchar](15) NULL,
	[Email] [varchar](255) NULL,
	[Site] [varchar](255) NULL,
	[Logo] [varbinary](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Familia]    Script Date: 21/03/2017 17:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Familia](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descricao] [varchar](250) NULL,
	[Ativo] [bit] NOT NULL,
 CONSTRAINT [PK_Familia] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Produto]    Script Date: 21/03/2017 17:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Produto](
	[Id] [uniqueidentifier] NOT NULL,
	[IdFabricante] [uniqueidentifier] NOT NULL,
	[Codigo] [varchar](150) NOT NULL,
	[Nome] [varchar](250) NOT NULL,
	[Descricao] [varchar](500) NOT NULL,
	[IdFamilia] [int] NOT NULL,
	[IdSubtipo] [int] NULL,
	[Dimensoes] [varchar](150) NULL,
	[Voltagem] [varchar](50) NULL,
	[ClasseConsumo] [varchar](50) NULL,
	[Preco] [decimal](10, 2) NULL,
	[Status] [varchar](250) NULL,
	[Imagem] [varbinary](max) NULL,
 CONSTRAINT [PK_Produto] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Subtipo]    Script Date: 21/03/2017 17:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Subtipo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descricao] [varchar](250) NULL,
	[Ativo] [bit] NOT NULL,
 CONSTRAINT [PK_Subtipo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Familia] ADD  CONSTRAINT [DF_Familia_Ativo]  DEFAULT ((1)) FOR [Ativo]
GO
ALTER TABLE [dbo].[Subtipo] ADD  CONSTRAINT [DF_Subtipo_Ativo]  DEFAULT ((1)) FOR [Ativo]
GO
ALTER TABLE [dbo].[Documento]  WITH CHECK ADD  CONSTRAINT [FK_Documento_Produto] FOREIGN KEY([IdProduto])
REFERENCES [dbo].[Produto] ([Id])
GO
ALTER TABLE [dbo].[Documento] CHECK CONSTRAINT [FK_Documento_Produto]
GO





/****** Object:  StoredProcedure [dbo].[spGetDocumento]    Script Date: 21/03/2017 17:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetDocumento]( 
								  @Id uniqueidentifier = null,
								  @IdProduto uniqueidentifier = null,
								  @Titulo varchar(250) = null
								 )
	
AS
BEGIN
	SET NOCOUNT ON;

SELECT [Id]
		,[IdProduto]
		,[Titulo]
		,[Formato]
		,[TamanhoKb]
		,[Objeto]
FROM [dbo].[Documento]
WHERE [Id] = ISNULL(@Id, [Id]) AND
		[IdProduto] = ISNULL(@IdProduto, [IdProduto]) AND 
		([Titulo] LIKE '%' + @Titulo + '%' OR @Titulo IS NULL) 
		 
	END



GO
/****** Object:  StoredProcedure [dbo].[spGetFabricante]    Script Date: 21/03/2017 17:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetFabricante]( 
								  @OpType int = null,
								  @Id uniqueidentifier = null,
								  @RazaoSocial varchar(500) = null,
								  @Nome varchar(255) = null
								 )
	
AS
BEGIN
	SET NOCOUNT ON;

	IF @OpType IS NULL
	BEGIN
			SELECT [Id]
				  ,[RazaoSocial]
				  ,[Nome]
				  ,[Email]
				  ,[Site]
				  ,[Logo]
			  FROM [dbo].[Fabricante]
			  WHERE [Id] = ISNULL(@Id, ID) AND
					([RazaoSocial] LIKE '%' + @RazaoSocial + '%' OR @RazaoSocial IS NULL) AND
					([Nome] LIKE '%' + @Nome +  '%'  OR @Nome IS NULL)
			
	END

	


END

GO
/****** Object:  StoredProcedure [dbo].[spGetFamilia]    Script Date: 21/03/2017 17:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetFamilia]( 
								  @Id int = null,
								  @Descricao varchar(250) = null,
								  @Ativo bit = null
								 )
	
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [Id]
		,[Descricao]
		,[Ativo]
	FROM [dbo].[Familia]
	WHERE [Id] = ISNULL(@Id, [Id]) AND
		([Descricao] LIKE '%' + @Descricao + '%' OR @Descricao IS NULL) AND
		([Ativo] = ISNULL(@Ativo, [Ativo]))
	END


GO
/****** Object:  StoredProcedure [dbo].[spGetProduto]    Script Date: 21/03/2017 17:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetProduto]( 
								  @Id uniqueidentifier = null,
								  @IdFabricante  uniqueidentifier = null,
								  @Codigo varchar(150) = null,
								  @Nome varchar(250) = null,
								  @Descricao  varchar(500) = null,
								  ---@IdCategoria int = null,
								  @IdFamilia int = null,
								  @IdSubtipo int = null,
								  @Dimensoes varchar(150) = null,
								  @Voltagem varchar(50) = null,
								  @ClasseConsumo  varchar(50) = null,
								  @Preco decimal(10,2) = null,
								  @Status varchar(250) = null,
								  @Imagem varchar(1000) = null
								 )
	
AS
BEGIN
	SET NOCOUNT ON;


	SELECT [Id]
		  ,[IdFabricante]
		  ,[Codigo]
		  ,[Nome]
		  ,[Descricao]
		  --,[IdCategoria]
		  ,[IdFamilia]
		  ,[IdSubtipo]
		  ,[Dimensoes]
		  ,[Voltagem]
		  ,[ClasseConsumo]
		  ,[Preco]
		  ,[Status]
		  ,[Imagem]
	  FROM [dbo].[Produto]
	  WHERE [Id] = ISNULL(@Id, ID) AND
			[IdFabricante] = ISNULL(@IdFabricante, [IdFabricante]) AND
			([Codigo] LIKE '%' + @Codigo + '%' OR @Codigo IS NULL) AND
			([Nome] LIKE '%' + @Nome +  '%' OR @Nome IS NULL )AND
			([Descricao] LIKE '%' + @Descricao +  '%' OR @Descricao IS NULL) AND
			--[IdCategoria] = ISNULL(@IdCategoria, [IdCategoria]) AND
			[IdFamilia] = ISNULL(@IdFamilia, [IdFamilia]) AND
			[IdSubtipo] = ISNULL(@IdSubtipo, [IdSubtipo]) AND
			[Dimensoes] = ISNULL(@Dimensoes, [Dimensoes]) AND
			([Voltagem] LIKE '%' + @Voltagem +  '%' OR @Voltagem IS NULL) AND
			[ClasseConsumo] = ISNULL(@ClasseConsumo, [ClasseConsumo]) AND
			[Preco] = ISNULL(@Preco, [Preco]) AND
			[Status] = ISNULL(@Status, [Status]) 

END


GO
/****** Object:  StoredProcedure [dbo].[spGetSubtipo]    Script Date: 21/03/2017 17:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetSubtipo]( 
								  @Id int = null,
								  @Descricao varchar(250) = null,
								  @Ativo bit = null
								 )
	
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [Id]
			,[Descricao]
			,[Ativo]
		FROM [dbo].[Subtipo]
		WHERE [Id] = ISNULL(@Id, [Id]) AND
			([Descricao] LIKE '%' + @Descricao + '%' OR @Descricao IS NULL) AND
			([Ativo] = ISNULL(@Ativo, [Ativo]))
END


GO
/****** Object:  StoredProcedure [dbo].[spSetDocumento]    Script Date: 21/03/2017 17:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		@Author,,Name>
-- Create date: @Create Date,,>
-- Description:	@Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSetDocumento]( 
								  @OpType int,
								  @Id uniqueidentifier = NULL,
								  @IdProduto uniqueidentifier = NULL,
								  @Titulo varchar(250) = NULL,
								  @Formato varchar(50) = NULL,
								  @TamanhoKb smallint = NULL,
								  @Objeto varbinary(max) = NULL
								 )
	
AS
BEGIN
	
	 IF (@OpType = 1)
	 BEGIN
		 SET @Id = NEWID();

		 IF (@IdProduto = NULL OR @Titulo = NULL OR @Formato = NULL OR @TamanhoKb = NULL OR @Objeto = NULL)
		 BEGIN
			RAISERROR('Campos obrigatórios na inclusão: @IdProduto, @Titulo,  @TamanhoKb, @Objeto', 16, 0)
		 END


		INSERT INTO [dbo].[Documento]
			   ([Id]
			   ,[IdProduto]
			   ,[Titulo]
			   ,[Formato]
			   ,[TamanhoKb]
			   ,[Objeto])
		 VALUES
			   (@Id
			   ,@IdProduto
			   ,@Titulo
			   ,@Formato
			   ,@TamanhoKb
			   ,@Objeto)

		  SELECT @Id;
	END

	IF (@OpType = 2)
	BEGIN

		IF (@Id = NULL)
		BEGIN
			RAISERROR('Campos obrigatórios na alteração: Id (Documento)', 16, 0)
		END


		UPDATE [dbo].[Documento]
		   SET  
			   [IdProduto] = ISNULL(@IdProduto, [IdProduto])
			  ,[Titulo] = ISNULL(@Titulo, [Titulo])
			  ,[Formato] = ISNULL(@Formato, [Formato])
			  ,[TamanhoKb] = ISNULL(@TamanhoKb, [TamanhoKb])
			  ,[Objeto] = ISNULL(@Objeto, [Objeto])
		 WHERE [Id] = @Id
	END

	IF (@OpType = 3)
	BEGIN

		IF (@Id = NULL)
		BEGIN
			RAISERROR('Campos obrigatórios na exclusão: Id (Documento)', 16, 0)
		END

		DELETE FROM [dbo].[Documento]
        WHERE [Id] = @Id
	END
	
END


GO
/****** Object:  StoredProcedure [dbo].[spSetFabricante]    Script Date: 21/03/2017 17:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSetFabricante]( 
								  @OpType int,
								  @Id uniqueidentifier = NULL,
								  @RazaoSocial varchar(500) = NULL,
								  @Nome varchar(255) = NULL,
								  @Telefone varchar(15) = NULL,
								  @Email varchar(255) = NULL,
								  @Site varchar(255) = NULL,
								  @Logo varbinary(max) = NULL
								 )
	
AS
BEGIN
	
	 IF (@OpType = 1)
	 BEGIN
		 SET @Id = NEWID();

		 IF (@RazaoSocial = NULL OR @Nome = NULL OR @Email = NULL)
		 BEGIN
			RAISERROR('Campos obrigatórios na inclusão: Razão Social, Nome e e-mail', 16, 0)
		 END

		 INSERT INTO [dbo].[Fabricante]
			   ([Id]
			   ,[RazaoSocial]
			   ,[Nome]
			   ,[Telefone]
			   ,[Email]
			   ,[Site]
			   ,[Logo])
		 VALUES
			   (@Id
			   ,@RazaoSocial
			   ,@Nome
			   ,@Telefone
			   ,@Email
			   ,@Site
			   ,@Logo )

		  SELECT @Id;
	END

	IF (@OpType = 2)
	BEGIN

		IF (@Id = NULL)
		BEGIN
			RAISERROR('Campos obrigatórios na alteração: Id (Fabricante)', 16, 0)
		END

		UPDATE [dbo].[Fabricante]
		   SET 
			   [RazaoSocial] = ISNULL(@RazaoSocial, [RazaoSocial])
			  ,[Nome] = ISNULL(@Nome, [Nome])
			  ,[Telefone] = ISNULL(@Telefone, [Telefone])
			  ,[Email] = ISNULL(@Email, [Email])
			  ,[Site] = ISNULL(@Site, [Site])
			  ,[Logo] = ISNULL(@Logo, [Logo])
		 WHERE [Id] = @Id
	END

	IF (@OpType = 3)
	BEGIN

		IF (@Id = NULL)
		BEGIN
			RAISERROR('Campos obrigatórios na exclusão: Id (Fabricante)', 16, 0)
		END

		DELETE FROM [dbo].[Fabricante]
        WHERE [Id] = @Id
	END
	
END

GO
/****** Object:  StoredProcedure [dbo].[spSetFamilia]    Script Date: 21/03/2017 17:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSetFamilia]( 
								  @OpType int,
								  @Id int = NULL,
								  @Descricao varchar(250) = NULL,
								  @Ativo int = NULL
								 )
	
AS
BEGIN
	
	 IF (@OpType = 1)
	 BEGIN
		
		 IF (@Descricao = NULL)
		 BEGIN
			RAISERROR('Campo(s) obrigatório(s) na inclusão: Descrição', 16, 0)
		 END

		 INSERT INTO [dbo].[Familia]
			   ([Descricao]
			   ,[Ativo])
		 VALUES
			   (@Descricao
			   ,@Ativo )

		  SELECT @@IDENTITY; -- Retorna Id Criado
	END

	IF (@OpType = 2)
	BEGIN

		IF (@Id = NULL)
		BEGIN
			RAISERROR('Campos obrigatórios na alteração: Id', 16, 0)
		END

		UPDATE [dbo].[Familia]
		   SET 
			   [Descricao] = ISNULL(@Descricao, [Descricao])
			  ,[Ativo] = ISNULL(@Ativo, [Ativo])
		 WHERE [Id] = @Id
	END

	IF (@OpType = 3)
	BEGIN

		IF (@Id = NULL)
		BEGIN
			RAISERROR('Campos obrigatórios na exclusão: Id' , 16, 0)
		END

		DELETE FROM [dbo].[Familia]
        WHERE [Id] = @Id
	END
	
END


GO
/****** Object:  StoredProcedure [dbo].[spSetProduto]    Script Date: 21/03/2017 17:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSetProduto]( 
								  @OpType int = null,
								  @Id uniqueidentifier = null,
								  @IdFabricante  uniqueidentifier = null,
								  @Codigo varchar(150) = null,
								  @Nome varchar(250) = null,
								  @Descricao  varchar(500) = null,
								 -- @IdCategoria int = null,
								  @IdFamilia int = null,
								  @IdSubtipo int = null,
								  @Dimensoes varchar(150) = null,
								  @Voltagem varchar(10) = null,
								  @ClasseConsumo  char(1) = null,
								  @Preco decimal(10,2) = null,
								  @Status varchar(250) = null,
								  @Imagem varbinary(max) = null
								 )
	
AS
BEGIN
	SET NOCOUNT ON;

	IF(@OpType IS NULL) 
	BEGIN
	  RAISERROR('Informe o tipo de operação em @OpType. [1,2 ou 3]', 16, 0)
	END

	IF(@OpType = 1)
	BEGIN
		--- SET @Id = NEWID();
		IF (@Id IS NULL OR @IdFabricante IS NULL OR @Codigo IS NULL OR @Nome IS NULL OR @Descricao IS NULL)
		BEGIN
			RAISERROR('Campos obrigatórios: Id, Fabricante, Código, Nome, Descrição e Categoria', 16, 0)
		END

		INSERT INTO [dbo].[Produto]
			   ([Id]
			   ,[IdFabricante]
			   ,[Codigo]
			   ,[Nome]
			   ,[Descricao]
			  -- ,[IdCategoria]
			   ,[IdFamilia]
			   ,[IdSubtipo]
			   ,[Dimensoes]
			   ,[Voltagem]
			   ,[ClasseConsumo]
			   ,[Preco]
			   ,[Status]
			   ,[Imagem])
		 VALUES
			   (@Id
			   ,@IdFabricante
			   ,@Codigo
			   ,@Nome
			   ,@Descricao
			  -- ,@IdCategoria
			   ,@IdFamilia
			   ,@IdSubtipo
			   ,@Dimensoes
			   ,@Voltagem
			   ,@ClasseConsumo
			   ,@Preco
			   ,@Status
			   ,@Imagem)

		 SELECT @Id
	END

	IF(@OpType = 2)
	BEGIN

		IF(@Id IS NULL )
		BEGIN
			RAISERROR('Campo(s) obrigatório(s): Id', 16, 0)
		END
		
		UPDATE [dbo].[Produto]
		   SET [Id] = @Id
			  ,[IdFabricante] = @IdFabricante
			  ,[Codigo] = @Codigo
			  ,[Nome] = @Nome
			  ,[Descricao] = @Descricao
			  --,[IdCategoria] = @IdCategoria
			  ,[IdFamilia] = @IdFamilia
			  ,[IdSubtipo] = @IdSubtipo
			  ,[Dimensoes] = @Dimensoes
			  ,[Voltagem] = @Voltagem
			  ,[ClasseConsumo] = @ClasseConsumo
			  ,[Preco] = @Preco
			  ,[Status] = @Status
			  ,[Imagem] = @Imagem
		 WHERE [Id] = @Id


	END

	IF(@OpType = 3)
	BEGIN
		IF(@Id IS NULL )
		BEGIN
			RAISERROR('Campo(s) obrigatório(s): Id', 16, 0)
		END

		DELETE FROM [dbo].[Produto]
		WHERE [Id] = @Id
	END
END


GO
/****** Object:  StoredProcedure [dbo].[spSetSubtipo]    Script Date: 21/03/2017 17:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spSetSubtipo]( 
								  @OpType int,
								  @Id int = NULL,
								  @Descricao varchar(250) = NULL,
								  @Ativo int = NULL
								 )
	
AS
BEGIN
	
	 IF (@OpType = 1)
	 BEGIN
		
		 IF (@Descricao = NULL)
		 BEGIN
			RAISERROR('Campo(s) obrigatório(s) na inclusão: Descrição', 16, 0)
		 END

		 INSERT INTO [dbo].[Subtipo]
			   ([Descricao]
			   ,[Ativo])
		 VALUES
			   (@Descricao
			   ,@Ativo )

		  SELECT @@IDENTITY; -- Retorna Id Criado
	END

	IF (@OpType = 2)
	BEGIN

		IF (@Id = NULL)
		BEGIN
			RAISERROR('Campos obrigatórios na alteração: Id', 16, 0)
		END

		UPDATE [dbo].[Subtipo]
		   SET 
			   [Descricao] = ISNULL(@Descricao, [Descricao])
			  ,[Ativo] = ISNULL(@Ativo, [Ativo])
		 WHERE [Id] = @Id
	END

	IF (@OpType = 3)
	BEGIN

		IF (@Id = NULL)
		BEGIN
			RAISERROR('Campos obrigatórios na exclusão: Id' , 16, 0)
		END

		DELETE FROM [dbo].[Subtipo]
        WHERE [Id] = @Id
	END
	
END

