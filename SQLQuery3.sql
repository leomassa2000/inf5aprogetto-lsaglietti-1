DROP TABLE [dbo].ElencoPullman
DROP TABLE [dbo].AutorizzBambini
DROP TABLE [dbo].AutorizzEsterni
DROP TABLE [dbo].AutorizzPersonale
DROP TABLE [dbo].DettagliPullman
DROP TABLE [dbo].Uscite
DROP TABLE [dbo].EsterniUscite
DROP TABLE [dbo].PresenzePersonale
DROP TABLE [dbo].PresenzeBambini
DROP TABLE [dbo].FreqBambini
DROP TABLE [dbo].FreqPersonale

DROP TABLE [dbo].Parentele
DROP TABLE [dbo].LinkPasswordGenitori
DROP TABLE [dbo].LinkPasswordPersonale
DROP TABLE [dbo].BuoniPasto
DROP TABLE [dbo].PresenzeMensa

DROP TABLE [dbo].Genitori
DROP TABLE [dbo].Personale
DROP TABLE [dbo].Bambini
DROP TABLE [dbo].Bollatrici

DROP TABLE [dbo].Classi

DROP TABLE [dbo].RuoliPersonale
DROP TABLE [dbo].Turni
DROP TABLE [dbo].FuoriComune


DROP TABLE [dbo].Centri

DROP TABLE [dbo].Citta
DROP TABLE [dbo].Province
DROP TABLE [dbo].Regioni
DROP TABLE [dbo].Nazioni
GO
CREATE TABLE [dbo].[Nazioni]
(
	[IdNazione] INT IDENTITY (1, 1) NOT NULL,
	[DescNazione] NVARCHAR(50) NOT NULL,
	[ValNazione] CHAR(1) NOT NULL,
	PRIMARY KEY ([IdNazione])
);
  
GO

CREATE TABLE [dbo].[Regioni]
(
	[IdRegione] INT IDENTITY (1, 1) NOT NULL,
	[DescRegione] NVARCHAR(50) NOT NULL,
	[IdNazRegione] INT NOT NULL,
	[ValRegione] CHAR(1) NOT NULL,
	PRIMARY KEY ([IdRegione]),
	CONSTRAINT [FK_Regioni_ToNazioni] FOREIGN KEY ([IdNazRegione]) REFERENCES [Nazioni]([IdNazione]),
);
  
GO

CREATE TABLE [dbo].[Province]
(
	[IdProvincia] INT IDENTITY (1, 1) NOT NULL,
	[DescProvincia] NVARCHAR(50) NOT NULL,
	[IdRegProvincia] INT NOT NULL,
	[CodProvincia] NVARCHAR(2) NOT NULL UNIQUE,
	[ValProvincia] CHAR(1) NOT NULL,
	PRIMARY KEY ([IdProvincia], [CodProvincia]),
	CONSTRAINT [FK_Province_ToRegioni] FOREIGN KEY ([IdRegProvincia]) REFERENCES [Regioni]([IdRegione]),
);
  
GO

CREATE TABLE [dbo].[Citta]
(
	[IdCitta] int IDENTITY(1,1) NOT NULL,
	[descri] nvarchar(50) NULL,
	[cap] nvarchar(10) NULL,
	[prov] nvarchar(2) NULL,
	[cod_istat] nvarchar(10) NULL,
	[cod_locrif] int NULL,
	[sigla_naz] nvarchar(40) NULL,
	[cod_catasto] nvarchar(4) NULL,
	[cod_stato] nvarchar(4) NULL,
	PRIMARY KEY CLUSTERED ([IdCitta] ASC),
	CONSTRAINT [FK_Citta_ToProvince] FOREIGN KEY ([prov]) REFERENCES [Province]([CodProvincia])
);
  
GO

CREATE TABLE Centri
(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	indirizzo VARCHAR(150) NOT NULL,
	numeroCivico VARCHAR(10) NOT NULL,
	idCitta INT NOT NULL,
	numeroTelefono VARCHAR(15) NOT NULL,
	email VARCHAR(50) NOT NULL,
	pwd VARCHAR(255) NOT NULL,
	circolo BIT DEFAULT 0,
	fuoriComune BIT DEFAULT 0,
	ultimaModifica DATETIME DEFAULT GETDATE(),
	FOREIGN KEY ([idCitta]) REFERENCES [dbo].[Citta] ([IdCitta])
);
  
GO

CREATE TABLE FuoriComune
(
	idCentro INT NOT NULL,
	indirizzo VARCHAR(150),
	idCitta INT NOT NULL,
	civicoMin INT,
	civicoMax INT,
	FOREIGN KEY ([idCentro]) REFERENCES [dbo].[Centri] ([id]),
	FOREIGN KEY ([idCitta]) REFERENCES [dbo].[Citta] ([IdCitta])
)
GO

CREATE TABLE Bambini
(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	cognome VARCHAR(50) NOT NULL,
	sesso CHAR NOT NULL,
	dataNascita DATE NOT NULL,
	natoA INT NOT NULL,
	CF VARCHAR(16) NOT NULL,
	nazionalita VARCHAR(150) NOT NULL,
	indirizzo VARCHAR(150) NOT NULL,
	numeroCivico VARCHAR(10) NOT NULL,
	idCitta INT NOT NULL,
	ultimaModifica DATETIME DEFAULT GETDATE(),
	FOREIGN KEY ([natoA]) REFERENCES [dbo].[Citta] ([IdCitta]),
	FOREIGN KEY ([idCitta]) REFERENCES [dbo].[Citta] ([IdCitta])
)
  
GO

CREATE TABLE Genitori
(/*DA MODIFICARE*/
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	cognome VARCHAR(50) NOT NULL,
	sesso CHAR,
	indirizzo VARCHAR(150),
	numeroCivico VARCHAR(10),
	idCitta INT,
	numeroTelefono1 VARCHAR(15) NOT NULL,
	descrizioneNT1 VARCHAR(50),
	numeroTelefono2 VARCHAR(15),
	descrizioneNT2 VARCHAR(50),
	numeroTelefono3 VARCHAR(15),
	descrizioneNT3 VARCHAR(50),
	email VARCHAR(50),
	pwd VARCHAR(255),
	ultimaModifica DATETIME DEFAULT GETDATE(),
	FOREIGN KEY ([idCitta]) REFERENCES [dbo].[Citta] ([IdCitta])
)

GO

CREATE TABLE Personale
(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	cognome VARCHAR(50) NOT NULL,
	sesso CHAR NOT NULL,
	dataNascita DATE NOT NULL,
	natoA INT NOT NULL,
	nazionalita VARCHAR(150) NOT NULL,
	indirizzo VARCHAR(150) NOT NULL,
	numeroCivico VARCHAR(10) NOT NULL,
	idCitta INT NOT NULL,
	numeroTelefono VARCHAR(15),
	codTessera INT NOT NULL,
	email VARCHAR(50),
	pwd VARCHAR(255),
	ultimaModifica DATETIME DEFAULT GETDATE(),
	FOREIGN KEY ([natoA]) REFERENCES [dbo].[Citta] ([IdCitta]),
	FOREIGN KEY ([idCitta]) REFERENCES [dbo].[Citta] ([IdCitta])
)

GO

CREATE TABLE Bollatrici
(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY
)

CREATE TABLE ParenteleBambini
(
	idBambino INT NOT NULL,
	idGenitore INT NOT NULL,
	ultimaModifica DATETIME DEFAULT GETDATE(),
	PRIMARY KEY(idBambino, idGenitore),
	FOREIGN KEY ([idBambino]) REFERENCES [dbo].[Bambini] ([id]),
	FOREIGN KEY ([idGenitore]) REFERENCES [dbo].[Genitori] ([id])
)

CREATE TABLE ParenteleAnimatori
(
	idAnimatore INT NOT NULL,
	idGenitore INT NOT NULL,
	ultimaModifica DATETIME DEFAULT GETDATE(),
	PRIMARY KEY(idAnimatore, idGenitore),
	FOREIGN KEY ([idAnimatore]) REFERENCES [dbo].[Personale] ([id]),
	FOREIGN KEY ([idGenitore]) REFERENCES [dbo].[Genitori] ([id])
)
  
GO

CREATE TABLE Turni
(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	anno INT NOT NULL,
	numero INT NOT NULL,
	idCentro INT NOT NULL,
	dataInizio DATE NOT NULL,
	dataFine DATE NOT NULL,
	numeroSettimane INT NOT NULL,
	quotaAnimOra MONEY NOT NULL,
	servizioMensa BIT NOT NULL,

	p1 INT NOT NULL,
	p1quotaBamb1 MONEY NOT NULL,
	p1quotaBamb2 MONEY NOT NULL,
	p1quotaBamb3 MONEY NOT NULL,

	p2quotaBamb1 MONEY,
	p2quotaBamb2 MONEY,
	p2quotaBamb3 MONEY,

	quotaFuoriComune MONEY,

	costoBuonoPasto MONEY,
	costo4BuoniPasto MONEY,
	FOREIGN KEY ([idCentro]) REFERENCES [dbo].[Centri] ([id])
)
  
GO

CREATE TABLE Classi
(
	id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	anno INT NOT NULL,
	ME CHAR NOT NULL
)

CREATE TABLE FreqBambini
(
	idTurno INT NOT NULL,
	idBambino INT NOT NULL,
	settimane VARCHAR(15) NOT NULL,
	moduloIscrizione INT NOT NULL IDENTITY(1, 1),
	dataIscrizione DATETIME NOT NULL,
	servizioMensa BIT,
	-- AGGIUNGERE DETTAGLI ISCRIZIONE (scuola, mensa...)
	scuola VARCHAR(50),
	idClasse INT NOT NULL,
	pagato BIT NOT NULL DEFAULT 0,
	FOREIGN KEY ([idTurno]) REFERENCES [dbo].[Turni] ([id]),
	FOREIGN KEY (idClasse) REFERENCES [dbo].[Classi] ([id]),
	FOREIGN KEY ([idBambino]) REFERENCES [dbo].[Bambini] ([id])
)
GO
CREATE TABLE RuoliPersonale
(
	id CHAR NOT NULL PRIMARY KEY,
	nomeCompleto VARCHAR(50) NOT NULL,
	--aggiungere le varie autorizzazioni ad accedere alle pagine
	--	buoniPasto
	--	presenzeBambini
	--	messaggiGenitori
	--	messaggiRespRef
	--	messaggiAnimatori
	--
)
GO
CREATE TABLE FreqPersonale
(
	idTurno INT NOT NULL,
	idPersonale INT NOT NULL,
	settimane VARCHAR(15) NOT NULL,
	ruolo CHAR NOT NULL,
	idClasse INT,
	FOREIGN KEY ([idTurno]) REFERENCES [dbo].[Turni] ([id]),
	FOREIGN KEY (idClasse) REFERENCES [dbo].[Classi] ([id]),
	FOREIGN KEY (idPersonale) REFERENCES [dbo].[Personale] ([id]),
	FOREIGN KEY (ruolo) REFERENCES [dbo].[RuoliPersonale] ([id])
)
GO
CREATE TABLE PresenzeBambini
(
	idBambino INT NOT NULL,
	data DATE NOT NULL,
	presenza BIT NOT NULL,
	idPersonale INT NOT NULL,
	PRIMARY KEY(idBambino, data, presenza),
	FOREIGN KEY (idPersonale) REFERENCES [dbo].[Personale] ([id]),
	FOREIGN KEY ([idBambino]) REFERENCES [dbo].[Bambini] ([id])
)
GO
CREATE TABLE PresenzePersonale
(
	idPersonale INT NOT NULL,
	data DATETIME NOT NULL,
	presenza BIT NOT NULL,
	idBollatrice INT NOT NULL,
	PRIMARY KEY(idPersonale, data, presenza),
	FOREIGN KEY (idPersonale) REFERENCES [dbo].[Personale] ([id]),
	FOREIGN KEY (idBollatrice) REFERENCES [dbo].[Bollatrici] ([id])
)
GO
CREATE TABLE Uscite
(
	id INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	destinazione VARCHAR(50) NOT NULL,
	ME CHAR NOT NULL,
	data DATE NOT NULL,
	orarioPartenza TIME NOT NULL,
	orarioArrivo TIME NOT NULL,
	idTurno INT NOT NULL,
	pullman BIT NOT NULL DEFAULT 0,
	FOREIGN KEY (idTurno) REFERENCES [dbo].[Turni] ([id])
)
CREATE TABLE DettagliPullman
(
	idUscita INT NOT NULL,
	id INT NOT NULL,
	postiPullman INT NOT NULL,
	PRIMARY KEY(idUscita, id),
	FOREIGN KEY ([idUscita]) REFERENCES [dbo].[Uscite] ([id])
)
CREATE TABLE AutorizzBambini
(
	idBambino INT NOT NULL,
	idUscita INT NOT NULL,
	idGenitore INT NOT NULL,
	dataAutorizzazione DATETIME DEFAULT GETDATE(),
	autorizzazione BIT NOT NULL,
	PRIMARY KEY(idBambino, idUscita, idGenitore),
	FOREIGN KEY ([idBambino]) REFERENCES [dbo].[Bambini] ([id]),
	FOREIGN KEY ([idUscita]) REFERENCES [dbo].[Uscite] ([id]),
	FOREIGN KEY ([idGenitore]) REFERENCES [dbo].[Genitori] ([id])
)
CREATE TABLE AutorizzPersonale
(
	idPersonale INT NOT NULL,
	idUscita INT NOT NULL,
	dataAutorizzazione DATETIME DEFAULT GETDATE(),
	autorizzazione BIT NOT NULL,
	PRIMARY KEY(idPersonale, idUscita),
	FOREIGN KEY ([idPersonale]) REFERENCES [dbo].[Personale] ([id]),
	FOREIGN KEY ([idUscita]) REFERENCES [dbo].[Uscite] ([id])
)
CREATE TABLE EsterniUscite
(
	id INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	nome VARCHAR(50),
	cognome VARCHAR(50),
	numeroTelefono VARCHAR(15),
	dataNascita DATE NOT NULL,
	natoA INT NOT NULL
)
CREATE TABLE AutorizzEsterni
(
	idUscita INT NOT NULL,
	idEsterno INT NOT NULL,
	dataAutorizzazione DATETIME DEFAULT GETDATE(),
	autorizzazione BIT NOT NULL,
	idPersonale INT NOT NULL,
	FOREIGN KEY ([idEsterno]) REFERENCES [dbo].[EsterniUscite] ([id]),
	FOREIGN KEY ([idPersonale]) REFERENCES [dbo].[Personale] ([id]),
	FOREIGN KEY ([idUscita]) REFERENCES [dbo].[Uscite] ([id])
)
CREATE TABLE ElencoPullman
(
	idUscita INT NOT NULL,
	idPullman INT NOT NULL,
	idBambino INT,
	idPersonale INT,
	idEsterno INT,
	PRIMARY KEY(
      idUscita,
      idPullman,
      idBambino,
      idPersonale,
      idEsterno
    ),
	FOREIGN KEY ([idBambino]) REFERENCES [dbo].[Bambini] ([id]),
	FOREIGN KEY ([idEsterno]) REFERENCES [dbo].[EsterniUscite] ([id]),
	FOREIGN KEY ([idPersonale]) REFERENCES [dbo].[Personale] ([id]),
	FOREIGN KEY ([idUscita], [idPullman]) REFERENCES [dbo].[dettagliPullman] ([idUscita], [id])
)
CREATE TABLE LinkPasswordGenitori
(
	idGenitore INT NOT NULL,
	dataRichiesta DATETIME DEFAULT GETDATE(),
	url VARCHAR(50) NOT NULL UNIQUE,
	modifica BIT DEFAULT 0,
	PRIMARY KEY(idGenitore, dataRichiesta),
	FOREIGN KEY ([idGenitore]) REFERENCES [dbo].[Genitori] ([id]),
)
CREATE TABLE LinkPasswordPersonale
(
	idPersonale INT NOT NULL,
	dataRichiesta DATETIME DEFAULT GETDATE(),
	url VARCHAR(50) NOT NULL UNIQUE,
	modifica BIT DEFAULT 0,
	PRIMARY KEY(idPersonale, dataRichiesta),
	FOREIGN KEY ([idPersonale]) REFERENCES [dbo].[Personale] ([id]),
)

CREATE TABLE LinkPasswordCentri
(
	idCentro INT NOT NULL,
	dataRichiesta DATETIME DEFAULT GETDATE(),
	url VARCHAR(50) NOT NULL UNIQUE,
	modifica BIT DEFAULT 0,
	PRIMARY KEY(idCentro, dataRichiesta),
	FOREIGN KEY ([idCentro]) REFERENCES [dbo].[Centri] ([id]),
)

CREATE TABLE BuoniPasto
(
	idBuonoPasto VARCHAR(25) NOT NULL PRIMARY KEY,
	dataAcquisto DATETIME NOT NULL DEFAULT GETDATE(),
	dataUtilizzo DATETIME,
	idBambino INT,
	FOREIGN KEY ([idBambino]) REFERENCES [dbo].[Bambini] ([id]),
)
CREATE TABLE PresenzeMensa
(
	idBambino INT NOT NULL,
	data DATETIME NOT NULL,
	presenza BIT NOT NULL,
	idPersonale INT NOT NULL,
	PRIMARY KEY(idBambino, data),
	FOREIGN KEY (idPersonale) REFERENCES [dbo].[Personale] ([id]),
	FOREIGN KEY ([idBambino]) REFERENCES [dbo].[Bambini] ([id]),
)

CREATE TABLE pagamentiQuote
(
	idPagamento INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	totale MONEY NOT NULL,
	pagato BIT DEFAULT 0,
	metodo CHAR NOT NULL,
	idIscrizioni VARCHAR(500),
	dataCreazione DATETIME DEFAULT GETDATE(),
	dataPagamento DATETIME
)

CREATE TABLE RuoliPagine
(
	pageTitle VARCHAR(50) NOT NULL,
	ruolo CHAR NOT NULL,
	autorizzazione INT NOT NULL,
	--0: no, 1: controllo completo, 2: sola visualizzazione
	PRIMARY KEY(pageTitle, ruolo),
	FOREIGN KEY (ruolo) REFERENCES [dbo].[RuoliPersonale] ([id])
)