USE Tunning

varchar(200)
varchar(100)



CREATE TABLE dbo.Correspondencia_1 (
    Id int not null,
    Nome varchar(60),
    Idade int,
    Logradouro varchar(80),
    Cidade varchar(40),
    Estado varchar(40),
    constraint I1_Correspondencia_1 primary key (Id)
);

CREATE TABLE dbo.Correspondencia_2 (
    Id int not null,
    Nome varchar(100),
    Idade int,
    Logradouro varchar(100),
    Cidade varchar(100),
    Estado varchar(100),
    constraint I1_Correspondencia_2 primary key (Id)
);


-- código #2
declare @max int, @rc int;
set @max = 10000;
set @rc = 1;
set nocount on;

-- carrega linha inicial
INSERT into dbo.Correspondencia_1
                (Id, Nome, Idade, Logradouro, Cidade, Estado)
   values (1, replicate('A', 60), 80, replicate('B', 80),
           replicate('C', 40), replicate('D', 40));

-- repete a linha inicial até completar N linhas
while @rc * 2 <= @max
   begin
   INSERT into dbo.Correspondencia_1
                   (Id, Nome, Idade, Logradouro, Cidade, Estado)
      SELECT Id + @rc, Nome, ((Id % 60)+1), Logradouro, Cidade, Estado
        from dbo.Correspondencia_1;
   set @rc = @rc * 2;
   end;

-- último bloco
INSERT into dbo.Correspondencia_1
                (Id, Nome, Idade, Logradouro, Cidade, Estado)
   SELECT Id + @rc, Nome, Idade, Logradouro, Cidade, Estado
      from dbo.Correspondencia_1
      where (Id + @rc) <= @max;

-- carrega tabela Correspondencia_2
INSERT into dbo.Correspondencia_2 with (tablock)
                (Id, Nome, Idade, Logradouro, Cidade, Estado)
   SELECT Id, Nome, Idade, Logradouro, Cidade, Estado
      from dbo.Correspondencia_1;

	  set statistics io on
-- código #3
SELECT Estado, Cidade, Nome
   from dbo.Correspondencia_1
   order by Estado, Cidade;

-- código #4
SELECT Estado, Cidade, Nome
   from dbo.Correspondencia_2
   order by Estado, Cidade;