unit uSQLCS;

interface
  uses SysUtils,MinhasClasses,StrUtils;
   Type
     TSQLCS = class(TSQLs)
       Function GetMySQL(TipoPesquisa : TTipoPesquisa ; Complemento : String; Join: String = '') :TSQL;override;
     end;

implementation

{ TSQLCS }

function TSQLCS.GetMySQL(TipoPesquisa: TTipoPesquisa;
  Complemento: String; Join: String = ''): TSQL;
begin
  Result.CampoCodigo := 'CODIGO' ;
  Result := inherited;
  Result.Versao20 := True;
  Result.UsaMaxParaCodigo := False;
  Result.TipoForm := TfGrid;
  with Result do
  Begin
    case TipoPesquisa of
     tpCSEmpresa:
       Begin
         CampoChave := 'IDEMPRESA';
         CampoDisplay := 'RAZAOSOCIAL';
         NomeTabela := 'EMPRESA';
         DescricaoCampoDisplay := 'Razão social';
         DescricaoTabela := 'Empresa';
         Versao20 := False;
         Select :=
           'SELECT E.IDEMPRESA, E.CODIGO, E.RAZAOSOCIAL, E.FANTASIA, E.CNPJ, '+
           '       E.IDCEP, E.COMPLEMENTO, E.NUMERO, E.LOGOMARCA, E.IE,E.NUMSERVICO,E.IM,  '+
           '       E.TELEFONE, E.FAX, E.OBS, E.IDLAYOUT,CEP.CEP, CEP.LOGRADOURO, CEP.BAIRRO, '+
           '       CEP.CIDADE, CEP.UF  '+
           '  FROM EMPRESA E '+
           ' INNER JOIN CEP  '+
           '    ON (CEP.IDCEP = E.IDCEP) '+
           ' WHERE 1=1 '+Complemento;
       End;
      tpCsCliente:
       Begin
         CampoChave := 'IDCLIENTE';
         CampoDisplay := 'NOMECLIENTE';
         NomeTabela := 'CLIENTE';
         DescricaoCampoDisplay := 'Nome';
         DescricaoTabela := 'Clientes';
         Versao20 := False;
         UsaMaxParaCodigo := True;
         Select :=
            ' SELECT C.IDCLIENTE, C.CODIGO, C.NOMECLIENTE, C.NUMERO, C.COMPLEMENTO, C.CPF,C.CNPJ, C.ORGAOEMISSOR,'+
            '        C.DATAEMISSAO, C.DATANASCIMENTO, C.DATACADASTRO, C.TELEFONE, C.OBS, C.RG, C.IDCEP, C.CELULAR,C.FANTASIA, '+
            '        C.CONTATO, C.IE, C.IM, C.FLAGTIPOPESSOA,C.CEP, C.LOGRADOURO, C.BAIRRO, C.CIDADE, C.UF,C.EMAIL'+
            '   FROM CLIENTE C'+
            '  WHERE 1=1 '+Complemento;
       End;
      tpCsProdutos:
       Begin
         CampoChave := 'IDPRODUTOS';
         CampoDisplay := 'NOME';
         NomeTabela := 'PRODUTOS';
         DescricaoCampoDisplay := 'Tipo de Serviço';
         DescricaoTabela := 'Tipo de Serviço';
         Versao20 := False;
         UsaMaxParaCodigo := True;
         Select :=
            'SELECT p.IDPRODUTOS, P.CODIGO, P.NOME, P.OBS, P.VALORVENDA,P.IDMARCA, P.IDUNIDADE, '+
            '       M.NOME MARCA '+
            '  FROM PRODUTOS P '+
            '  LEFT JOIN MARCA M '+
            '    ON (M.IDMARCA = P.IDMARCA)'+
            '  WHERE 1=1 '+Complemento;
       End;
      tpCsServicos:
       Begin
         CampoChave := 'IDSERVICO';
         NomeTabela := 'SERVICO';
         DescricaoTabela := 'Serviços';
         CampoCodigo := 'NUMSERVICO';
         CampoDisplay := 'NUMSERVICO';
         Versao20 := False;
         AliasTabela := 'S';
         Select :=
            'SELECT S.IDSERVICO, S.DATA, S.HORA, S.IDEMPRESA, S.VALORTOTAL, S.OBS,S.FLAGMOSTRARVALORUNI,S.IDCONTABANCARIA,S.IDLASTUSUARIO, S.IDUSUARIO,'+
            '       S.IDCLIENTE, S.NUMSERVICO, S.VALORACRESCIMO,S.VENCIMENTO,COALESCE(S.FLAGCANCELADO,''N'')FLAGCANCELADO,S.PRACAPAGAMENTO, S.VALORTOTALLIQUIDO,'+
            '       S.VALORDESCONTO, CASE WHEN COALESCE(S.FLAGCANCELADO,''N'') = ''S'' THEN 0 ELSE S.VALORTOTALLIQUIDO END VALORTOTALLIQUIDOREL ,'+
            '       C.CODIGO, C.NOMECLIENTE,C.IE, C.IM, S.IDCFOP, CF.CFOP, CF.NATUREZA,'+
            '       C.CEP, COALESCE(C.LOGRADOURO,'''')||'',''||COALESCE(C.NUMERO,'''')||'' ''||COALESCE(C.COMPLEMENTO,'''') LOGRADOURO, C.BAIRRO, C.CIDADE, '+
            '       C.UF,COALESCE(C.CPF,C.CNPJ)CNPJ_CPF, CB.AGENCIA, CB.CONTA,B.NOMEBANCO, U.LOGIN '+
            '  FROM SERVICO S'+
            ' INNER JOIN CLIENTE C'+
            '    ON (C.IDCLIENTE = S.IDCLIENTE)'+
            '  LEFT JOIN CFOP CF ' +
            '    ON (CF.IDCFOP = S.IDCFOP) '+
            '  LEFT JOIN CONTABANCARIA CB '+
            '    ON (CB.IDCONTABANCARIA = S.IDCONTABANCARIA) '+
            '  LEFT JOIN BANCO B '+
            '    ON (CB.IDBANCO = B.IDBANCO)'+
            '  LEFT JOIN USUARIO U '+
            '    ON (U.IDUSUARIO = S.IDUSUARIO)'+
            ' WHERE 1=1 '+Complemento;
       End;
      tpCsServicosDetalhe:
       Begin
         CampoChave := 'IDSERVICODETALHE';
         NomeTabela := 'SERVICODETALHE';
         DescricaoTabela := 'Itens do Serviços';
         Select :=
            'SELECT SD.IDSERVICODETALHE, SD.IDSERVICO, SD.IDPRODUTOS, '+
            '       SD.VALOR, SD.VALORORIGINAL,SD.QUANTIDADE,SD.TOTAL,SD.OBSITEM,'+
            '       SD.IDUNIDADEORIGINAL, SD.IDUNIDADE, '+
            '       P.CODIGO, P.NOME, U.NOMEUNIDADE,UO.NOMEUNIDADE UNIDADEORIGINAL, ''N'' FLAGEDICAO'+
            '  FROM SERVICODETALHE SD'+
            ' INNER JOIN PRODUTOS P'+
            '    ON (SD.IDPRODUTOS = P.IDPRODUTOS)'+
            '  LEFT JOIN UNIDADE U '+
            '    ON (U.IDUNIDADE = SD.IDUNIDADE) '+
            '  LEFT JOIN UNIDADE UO '+
            '    ON (UO.IDUNIDADE = SD.IDUNIDADEORIGINAL) '+
            ' WHERE 1=1 '+Complemento;
       End;
      tpCsCFOP:
       Begin
         CampoChave := 'IDCFOP';
         CampoDisplay := 'NATUREZA';
         NomeTabela := 'CFOP';
         DescricaoCampoDisplay := 'Natureza';
         DescricaoTabela := 'CFOP';
         CampoCodigo := 'CFOP';
         Versao20 := True;
         Select :=
            'SELECT IDCFOP, CFOP, NATUREZA '+
            '  FROM CFOP '+
            '  WHERE 1=1 '+Complemento;
       End;
      tpCSMarca:
       Begin
         CampoChave := 'IDMARCA';
         CampoDisplay := 'NOME';
         NomeTabela := 'MARCA';
         DescricaoCampoDisplay := 'Marca';
         DescricaoTabela := 'Marcas';
         Versao20 := True;
         Select :=
            'SELECT IDMARCA, CODIGO, NOME '+
            '  FROM MARCA '+
            '  WHERE 1=1 '+Complemento;
       End;
      tpCSUnidade:
       Begin
         CampoChave := 'IDUNIDADE';
         CampoDisplay := 'NOMEUNIDADE';
         NomeTabela := 'UNIDADE';
         DescricaoCampoDisplay := 'Unidade';
         DescricaoTabela := 'Unidade';
         Versao20 := True;
         Select :=
            'SELECT IDUNIDADE, CODIGO, NOMEUNIDADE,FLAGFRACIONADO,FLAUNIDADEDEEQUIPAMENTO '+
            '  FROM UNIDADE '+
            '  WHERE 1=1 '+Complemento;
       End;

       tpCSBanco:
       Begin
         CampoChave := 'IDBANCO';
         CampoDisplay := 'NOMEBANCO';
         NomeTabela := 'BANCO';
         DescricaoCampoDisplay := 'Banco';
         DescricaoTabela := 'Bancos';
         Versao20 := True;
         Select :=
            'SELECT IDBANCO, CODIGO, NOMEBANCO '+
            '  FROM BANCO '+
            '  WHERE 1=1 '+Complemento;
       End;
       tpCSConta:
       Begin
         CampoChave := 'IDCONTABANCARIA';
         CampoDisplay := 'CONTA';
         NomeTabela := 'CONTABANCARIA';
         DescricaoCampoDisplay := 'Conta';
         DescricaoTabela := 'Contas bancárias';
         CampoCodigo := 'CONTA';
         Versao20 := False;
         Select :=
            'SELECT IDCONTABANCARIA, C.IDBANCO,  AGENCIA, CONTA,B.NOMEBANCO '+
            '  FROM CONTABANCARIA C '+
            ' INNER JOIN BANCO B   '+
            '    ON (B.IDBANCO = C.IDBANCO) '+
            ' WHERE 1=1 '+Complemento;
       End;
       tpCSAgenda:
       Begin
         CampoChave := 'IDAGENDA';
         CampoDisplay := '';
         NomeTabela := 'AGENDA';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Agenda';
         CampoCodigo := '';
         Versao20 := False;
         Select :=
              'SELECT A.IDAGENDA, A.DATACOMPROMISSO, A.HORA, A.ASSUNTO,A.DATACRIACAO,'+
              '       A.TEXTO, A.FLAGBAIXADO,C.NOMECLIENTE,C.IDCLIENTE , A.NUMREPETICAO,A.IDAGENDAREF,'+
              '       ''0'' TYPE,''3'' OPTIONS,A.IDUSUARIO,'+
              '       CAST(A.DATACOMPROMISSO+ A.HORA AS TIMESTAMP)DATA_HORAINI,'+
              '       CAST(A.DATACOMPROMISSO+ A.HORA AS TIMESTAMP)DATA_HORAFIM, '+
              '       ''Assunto: ''||A.ASSUNTO||'' Cliente: ''||COALESCE(C.NOMECLIENTE,'''') CAPTION'+
              '  FROM AGENDA A'+
              '  LEFT JOIN CLIENTE C'+
              '    ON (C.IDCLIENTE = A.IDCLIENTE)'+
              ' WHERE ((IDUSUARIO IS NULL) OR (IDUSUARIO =  '+IntToStr(USuarioLogado.Id)+')) '+ Complemento;
       End;
       tpCSDocumento:
       Begin
         CampoChave := 'IDDOCUMENTO';
         CampoDisplay := '';
         NomeTabela := 'DOCUMENTO';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Documento';
         CampoCodigo := '';
         Versao20 := False;
         Select :=
           'SELECT IDDOCUMENTO, IDCLIENTE, NOMECLIENTE, DATACRIACAO, HORACRIACAO, '+
           '       DATA, LOGRADOURO, BAIRRO, CIDADE, UF,PRACAPAGAMENTO, CNPJ_CPF, '+
           '       VENCIMENTO, IE, IM, VALORTOTALLIQUIDO, NUMSERVICO, IDEMPRESA, '+
           '       FLAGCANCELADO, NUMVERSAO,  IDSERVICO,FLAGMOSTRARVALORUNI, CEP,AGENCIA,CONTA,NOMEBANCO, U.LOGIN '+
           '  FROM DOCUMENTO D '+
           '  LEFT JOIN USUARIO U '+
           '    ON (U.IDUSUARIO = D.IDUSUARIO)'+
           ' WHERE 1=1 '+Complemento+
           ' ORDER BY  NUMVERSAO DESC ';
       End;
       tpCSUsuario:
       Begin
         CampoChave := 'IDUSUARIO';
         CampoDisplay := 'NOMECOMPLETO';
         NomeTabela := 'USUARIO';
         DescricaoCampoDisplay := 'Nome';
         DescricaoTabela := 'Usuário';
         CampoCodigo := 'LOGIN';
         Versao20 := True;
         Select :=
           'SELECT IDUSUARIO, LOGIN, SENHA, NOMECOMPLETO, COALESCE(FLAGADMINISTRADOR,''Y'')FLAGADMINISTRADOR '+
           '  FROM USUARIO '+
           ' WHERE 1=1 '+Complemento;
       End;
       tpCSUsuarioAcesso:
       Begin
         CampoChave := 'IDACESSOUSUARIO';
         CampoDisplay := '';
         NomeTabela := 'ACESSOUSUARIO';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Acessos do Usuário';
         CampoCodigo := '';
         Select :=
           'SELECT A.IDACESSO, A.DESCRICAO, A.CLASSIFICACAO, A.IDPAI, '+
           '       AU.IDACESSOUSUARIO, AU.IDUSUARIO IDUSUARIO, '+
           '       COALESCE(AU.FLAGPERMITIDO,''Y'')FLAGPERMITIDO, ''N'' FLAGEDICAO '+
           '  FROM ACESSO A '+
           '  LEFT JOIN ACESSOUSUARIO AU '+
           '    ON (A.IDACESSO = AU.IDACESSO  '+Complemento+') ';
       End;
       tpCSCombustivel:
       Begin
         CampoChave := 'IDCOMBUSTIVEL';
         CampoDisplay := 'DESCRICAO';
         NomeTabela := 'COMBUSTIVEL';
         DescricaoCampoDisplay := 'Combustível';
         DescricaoTabela := 'Combustível';
         Versao20 := True;
         Select :=
            'SELECT IDCOMBUSTIVEL, CODIGO, DESCRICAO '+
            '  FROM COMBUSTIVEL '+
            '  WHERE 1=1 '+Complemento;
       End;

       tpCSStatusEquipamento:
       Begin
         CampoChave := 'IDSTATUSEQUIPAMENTO';
         CampoDisplay := 'NOMESTATUS';
         NomeTabela := 'STATUSEQUIPAMENTO';
         DescricaoCampoDisplay := 'Status';
         DescricaoTabela := 'Status do equipamento';
         Select :=
            'SELECT IDSTATUSEQUIPAMENTO, CODIGO, NOMESTATUS, COR   '+
            '  FROM STATUSEQUIPAMENTO '+
            '  WHERE 1=1 '+Complemento;
       End;
       tpCSFornecedor:
       Begin
         CampoChave := 'IDFORNECEDOR';
         CampoDisplay := 'RAZAOSOCIAL';
         NomeTabela := 'FORNECEDOR';
         DescricaoCampoDisplay := 'Razão social';
         DescricaoTabela := 'Fornecedor';
         Select :=
            'SELECT IDFORNECEDOR, CODIGO, RAZAOSOCIAL,NOMEFANTASIA, CNPJ, CONTATO, '+
            '       TELEFONE, EMAIL, ENDERECO, NUMERO, CEP, BAIRRO, CIDADE, UF,'+
            '       DATACADASTRO,COMPLEMENTO,OBS '+
            '  FROM FORNECEDOR '+
            ' WHERE 1=1 '+Complemento;
       End;
       tpCSGrupoEquipamento:
       Begin
         CampoChave := 'IDGRUPOEQUIPAMENTO';
         CampoDisplay := 'NOMEGRUPO';
         NomeTabela := 'GRUPOEQUIPAMENTO';
         DescricaoCampoDisplay := 'Grupo';
         DescricaoTabela := 'Grupo de equipamentos';
         Select :=
           'SELECT IDGRUPOEQUIPAMENTO, CODIGO, NOMEGRUPO '+
           '  FROM GRUPOEQUIPAMENTO '+
           ' WHERE 1=1 '+Complemento;
       End;
       tpCSTipoMaterial:
       Begin
         CampoChave := 'IDTIPOMATERIAL';
         CampoDisplay := 'NOMETIPOMATERIAL';
         NomeTabela := 'TIPOMATERIAL';
         DescricaoCampoDisplay := 'Tipo de material';
         DescricaoTabela := 'Tipo de material';
         Select :=
           'SELECT IDTIPOMATERIAL, CODIGO, NOMETIPOMATERIAL '+
           '  FROM TIPOMATERIAL '+
           ' WHERE 1=1 '+Complemento;
       End;
       tpCSMaterial:
       Begin
         CampoChave := 'IDMATERIAL';
         CampoDisplay := 'NOMEMATERIAL';
         NomeTabela := 'MATERIAL';
         DescricaoCampoDisplay := 'Material';
         DescricaoTabela := 'Material';
         DesconsiderarCampos := 'NOMETIPOMATERIAL;RAZAOSOCIAL;NOMEUNIDADE';
         Versao20 := False;
         Select :=
            'SELECT M.IDMATERIAL, M.CODIGO, M.NOMEMATERIAL, M.VALORCUSTO,'+
            '       M.IDFORNECEDOR, M.ESTOQUETOTAL, M.FLAGCONTROLASERIAL,M.PERIODOMANUTENCAO, M.PERCALERTA,'+
            '       M.IDTIPOMATERIAL, M.DATACADASTRO, M.LASTCHANGE,M.CODIGOFORNECEDOR, M.IDUNIDADE,M.OBS,'+
            '       T.NOMETIPOMATERIAL, F.RAZAOSOCIAL, U.NOMEUNIDADE, M.ESTOQUEMINIMO'+
            '  FROM MATERIAL M'+
            ' INNER JOIN TIPOMATERIAL T'+
            '    ON (T.IDTIPOMATERIAL = M.IDTIPOMATERIAL)'+
            '  LEFT JOIN FORNECEDOR F'+
            '    ON (F.IDFORNECEDOR = M.IDFORNECEDOR)'+
            '  LEFT JOIN UNIDADE U'+
            '    ON (U.IDUNIDADE = M.IDUNIDADE)'+
            ' WHERE 1=1 '+Complemento;
       End;
       tpCSEquipamento:
       Begin
         CampoChave := 'IDEQUIPAMENTO';
         CampoDisplay := 'NOMEEQUIPAMENTO';
         NomeTabela := 'EQUIPAMENTO';
         DescricaoCampoDisplay := 'Descrição';
         DescricaoTabela := 'Equipamentos';
         DesconsiderarCampos := 'NOMEGRUPO;MARCA;COMBUSTIVEL;NOMESTATUS;COR;NOMESTATUS2;NOMEUNIDADE';
         Versao20 := False;
         Select :=
            'SELECT E.IDEQUIPAMENTO, E.NOMEEQUIPAMENTO, E.CODIGO, E.IDCOMBUSTIVEL, E.IDGRUPOEQUIPAMENTO,'+
            '       E.IDENTIFICADOR, E.IDMARCA,E.VALORTOTAL, E.NUMPARCELAS, E.PARCELASRESTANTES, E.VALORPORPARCELA, '+
            '       E.VALORRESTANTE, E.FLAGQUITADO,E.MARCADOR, E.IDUNIDADE,E.PRECO,'+
            '       E.DATACADASTRO, E.DATAAQUISICAO, E.LASTCHANGE, E.IDSTATUSEQUIPAMENTO,E.IDSTATUSEQUIPAMENTO2, E.OBS,COALESCE(E.FLAGINATIVO,''N'')FLAGINATIVO, '+
            '       G.NOMEGRUPO,M.NOME MARCA, C.DESCRICAO COMBUSTIVEL, S.NOMESTATUS, S.COR, S2.NOMESTATUS NOMESTATUS2,U.NOMEUNIDADE  '+
            '  FROM EQUIPAMENTO E'+
            ' INNER JOIN GRUPOEQUIPAMENTO G'+
            '    ON (G.IDGRUPOEQUIPAMENTO = E.IDGRUPOEQUIPAMENTO)'+
            '  LEFT JOIN MARCA M'+
            '    ON (M.IDMARCA = E.IDMARCA)'+
            '  LEFT JOIN COMBUSTIVEL C'+
            '    ON (C.IDCOMBUSTIVEL = E.IDCOMBUSTIVEL)'+
            '  LEFT JOIN STATUSEQUIPAMENTO S'+
            '    ON (S.IDSTATUSEQUIPAMENTO = E.IDSTATUSEQUIPAMENTO)'+
            '  LEFT JOIN STATUSEQUIPAMENTO S2'+
            '    ON (S2.IDSTATUSEQUIPAMENTO = E.IDSTATUSEQUIPAMENTO)'+
            '   LEFT JOIN UNIDADE U '+
            '     ON (U.IDUNIDADE = E.IDUNIDADE) '+
            ' WHERE 1=1 '+Complemento;

       End;
       tpCSEquipamentoArvore:
       Begin
         CampoChave := 'IDEQUIPAMENTOARVORE';
         CampoDisplay := 'NOMEMATERIAL';
         NomeTabela := 'EQUIPAMENTOARVORE';
         DescricaoCampoDisplay := 'Descrição';
         DescricaoTabela := 'Árvore de peças dos Equipamentos';
         DesconsiderarCampos := 'NOMEMATERIAL;NOMEEQUIPAMENTO;FLAGEDICAO;CODIGO;CODIGOMATERIAL;PERIODOMANUTENCAO';
         Versao20 := False;
         Select :=
            'SELECT ES.IDEQUIPAMENTOARVORE, ES.IDEQUIPAMENTO,'+
            '       M.NOMEMATERIAL ,M.CODIGO CODIGOMATERIAL,'+
            '       ES.IDMATERIAL, ES.QUANTIDADE, ES.OBS,'+
            '       E.NOMEEQUIPAMENTO,E.CODIGO, ''N'' FLAGEDICAO, M.PERIODOMANUTENCAO'+
            '  FROM EQUIPAMENTOARVORE ES'+
            ' INNER JOIN EQUIPAMENTO E'+
            '    ON (E.IDEQUIPAMENTO = ES.IDEQUIPAMENTO)'+
            '  LEFT JOIN MATERIAL M'+
            '    ON (M.IDMATERIAL = ES.IDMATERIAL)'+
            ' WHERE 1=1 '+Complemento;

       End;
       tpCSGrupoEquipamentoEspecificacao :
       Begin
         CampoChave := 'IDGRUPOESPECIFICACAO';
         CampoDisplay := 'DESCRICAO';
         NomeTabela := 'GRUPOESPECIFICACAO';
         DescricaoCampoDisplay := 'Descrição';
         DescricaoTabela := 'Itens das especificações';
         DesconsiderarCampos := 'FLAGEDICAO';
         Select :=
           'SELECT IDGRUPOESPECIFICACAO, IDGRUPOEQUIPAMENTO, DESCRICAO, ''N'' FLAGEDICAO '+
           '  FROM GRUPOESPECIFICACAO '+
           ' WHERE 1=1 '+Complemento;
       End;
       tpCSEquipamentoEspecificacao:
         Begin
         CampoChave := 'IDEQUIPAMENTOESPECIFICACAO';
         CampoDisplay := 'TEXTO';
         NomeTabela := 'EQUIPAMENTOESPECIFICACAO';
         DescricaoCampoDisplay := 'Descrição';
         DescricaoTabela := 'Especificações Dos Itens';
         DesconsiderarCampos := 'FLAGEDICAO;IDGRUPOEQUIPAMENTO;DESCRICAO';
         Select :=
          'SELECT G.IDGRUPOESPECIFICACAO, G.IDGRUPOEQUIPAMENTO, G.DESCRICAO,'+
          '       EE.IDEQUIPAMENTOESPECIFICACAO, EE.IDEQUIPAMENTO,  EE.TEXTO, ''N'' FLAGEDICAO'+
          '  FROM GRUPOESPECIFICACAO G'+
          '  LEFT JOIN EQUIPAMENTOESPECIFICACAO EE'+
          '    ON (EE.IDGRUPOESPECIFICACAO = G.IDGRUPOESPECIFICACAO '+Join+')'+
          ' WHERE 1=1 '+Complemento;
       End;
       tpCSCompraEquipamento:
        Begin
         CampoChave := 'IDCOMPRAEQUIPAMENTO';
         CampoDisplay := '';
         NomeTabela := 'COMPRAEQUIPAMENTO';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Compra Dos equipamentos';
         CampoCodigo := '';
         DesconsiderarCampos := 'LOGIN;RAZAOSOCIAL';
         Select :=
          ' SELECT CP.IDCOMPRAEQUIPAMENTO, CP.DATA, CP.DATANOTA,CP.HORA,  '+
          '        CP.IDFORNECEDOR, CP.DOCUMENTO, CP.TOTALNOTA, '+
          '        CP.IDUSUARIO, CP.OBS,F.RAZAOSOCIAL, U.LOGIN '+
          '   FROM COMPRAEQUIPAMENTO CP '+
          '  INNER JOIN FORNECEDOR F '+
          '     ON (F.IDFORNECEDOR= CP.IDFORNECEDOR) '+
          '  INNER JOIN USUARIO U '+
          '     ON (U.IDUSUARIO = CP.IDUSUARIO) '+
          '  WHERE 1=1 '+Complemento;
       End;
       tpCSCompraEquipamentoItens:
        Begin
         CampoChave := 'IDCOMPRAEQUIPAMENTOITENS';
         CampoDisplay := '';
         NomeTabela := 'COMPRAEQUIPAMENTOITENS';
         CampoCodigo := '';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Compra Dos equipamentos(Itens)';
         DesconsiderarCampos := 'NOMEEQUIPAMENTO;CODIGO;IDENTIFICADOR;FLAGEDICAO';
         Select :=
          '  SELECT CI.IDCOMPRAEQUIPAMENTOITENS, '+
          '         CI.IDCOMPRAEQUIPAMENTO, CI.IDEQUIPAMENTO, CI.MARCADOR, '+
          '         CI.VALOR, E.NOMEEQUIPAMENTO, E.CODIGO, E.IDENTIFICADOR ,''N'' FLAGEDICAO'+
          '    FROM COMPRAEQUIPAMENTOITENS CI '+
          '   INNER JOIN EQUIPAMENTO E '+
          '      ON (E.IDEQUIPAMENTO = CI.IDEQUIPAMENTO) '+
          '  WHERE 1=1 '+Complemento;
       End;
       tpCSSaidaEquipamento:
       Begin
         CampoChave := 'IDSAIDAEQUIPAMENTO';
         CampoDisplay := '';
         NomeTabela := 'SAIDAEQUIPAMENTO';
         CampoCodigo := '';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Saída Dos equipamentos(Itens)';
         DesconsiderarCampos := 'NOMEEQUIPAMENTO;CODIGO;IDENTIFICADOR;NOMEUNIDADE;FLAGEDICAO';
         Select :=
          ' SELECT SE.IDSAIDAEQUIPAMENTO, SE.IDSERVICO, SE.IDEQUIPAMENTO, SE.QUANTIDADE,'+
          '        SE.VALOR, SE.MARCADOR, SE.MARCADORCONTRATADO, SE.OBS, SE.TOTAL, SE.IDUNIDADE,SE.VALORORIGINAL,'+
          '        E.NOMEEQUIPAMENTO, E.CODIGO, E.IDENTIFICADOR, U.NOMEUNIDADE  ,''N'' FLAGEDICAO'+
          '   FROM SAIDAEQUIPAMENTO SE '+
          '  INNER JOIN EQUIPAMENTO E '+
          '     ON (E.IDEQUIPAMENTO = SE.IDEQUIPAMENTO) '+
          '   LEFT JOIN UNIDADE U '+
          '     ON (U.IDUNIDADE = SE.IDUNIDADE) '+
          '  WHERE 1=1 '+Complemento;
       End;
       tpCSEntradaEquipamento:
       Begin
         CampoChave := 'IDENTRADAEQUIPAMENTO';
         CampoDisplay := '';
         NomeTabela := 'ENTRADAEQUIPAMENTO';
         CampoCodigo := '';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Entrada Dos equipamentos';
         Versao20:= False;
         DesconsiderarCampos := 'CODIGO_CLIENTE;NOMECLIENTE;LOGIN;NOMELOCALESTOQUE';
         Select :=
          'SELECT E.IDENTRADAEQUIPAMENTO, E.DATA, E.HORA, E.DATAENTRADA,'+
          '       E.IDCLIENTE, E.DOCUMENTO, E.IDUSUARIO, E.IDLOCALESTOQUE,'+
          '       E.IDSERVICO, C.CODIGO CODIGO_CLIENTE, C.NOMECLIENTE,'+
          '       U.LOGIN, LE.NOMELOCALESTOQUE'+
          '  FROM ENTRADAEQUIPAMENTO E'+
          ' INNER JOIN USUARIO U'+
          '    ON (U.IDUSUARIO = E.IDUSUARIO)'+
          '  LEFT JOIN CLIENTE C'+
          '    ON (C.IDCLIENTE = E.IDCLIENTE)'+
          '  LEFT JOIN LOCALESTOQUE LE'+
          '    ON (LE.IDLOCALESTOQUE = E.IDLOCALESTOQUE)'+
          '  WHERE 1=1 '+Complemento;
       End;
       tpCSEntradaEquipamentoItens:
        Begin
         CampoChave := 'IDENTRADAEQUIPAMENTOITENS';
         CampoDisplay := '';
         NomeTabela := 'ENTRADAEQUIPAMENTOITENS';
         CampoCodigo := '';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Entrada Dos equipamentos(itens)';
         DesconsiderarCampos := 'NOMEEQUIPAMENTO;CODIGO;IDENTIFICADOR;FLAGEDICAO;NOMEUNIDADE';
         Select :=
        'SELECT EI.IDENTRADAEQUIPAMENTOITENS, EI.IDENTRADAEQUIPAMENTO,'+
        '       EI.IDEQUIPAMENTO, EI.MARCADOR, EI.OBS, EI.MARCADORATUAL,'+
        '       EI.QUANTIDADEEXCEDENTE, EI.VALOR, EI.TOTAL, EI.MARCADORCONTRATADO, EI.DIFERENCAMARCADOR,'+
        '       E.NOMEEQUIPAMENTO, E.CODIGO, E.IDENTIFICADOR , U.NOMEUNIDADE,''N'' FLAGEDICAO'+
        '  FROM ENTRADAEQUIPAMENTOITENS EI'+
        ' INNER JOIN EQUIPAMENTO E'+
        '    ON (E.IDEQUIPAMENTO = EI.IDEQUIPAMENTO)'+
        '   LEFT JOIN UNIDADE U '+
        '     ON (U.IDUNIDADE = E.IDUNIDADE) '+
        '  WHERE 1=1 '+Complemento;
       End;
       tpCSLocalEstoque:
       Begin
         CampoChave := 'IDLOCALESTOQUE';
         CampoDisplay := 'NOMELOCALESTOQUE';
         NomeTabela := 'LOCALESTOQUE';
         DescricaoCampoDisplay := 'Local do estoque';
         DescricaoTabela := 'Local do estoque';
         Select :=
           'SELECT IDLOCALESTOQUE, CODIGO, NOMELOCALESTOQUE '+
           '  FROM LOCALESTOQUE '+
           ' WHERE 1=1 '+Complemento;
       End;
       tpCSManutencao:
        Begin
         CampoChave := 'IDMANUTENCAO';
         CampoDisplay := '';
         NomeTabela := 'MANUTENCAO';
         CampoCodigo := '';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Manutenção';
         DesconsiderarCampos := 'NOMEEQUIPAMENTO;CODIGO;IDENTIFICADOR;NOMECLIENTE;LOGIN;NOMELOCALESTOQUE';
         Select :=
          'SELECT M.IDMANUTENCAO, M.DATA, M.HORA, M.DATAMANUTENCAO, M.IDEQUIPAMENTO,'+
          '       M.MARCADORATUAL, M.MARCADOR, M.IDCLIENTE,'+
          '       M.IDUSUARIO, M.IDLOCALESTOQUE, M.OBS, E.NOMEEQUIPAMENTO,'+
          '       E.CODIGO, E.IDENTIFICADOR, C.NOMECLIENTE, U.LOGIN,L.NOMELOCALESTOQUE'+
          '  FROM MANUTENCAO M'+
          ' INNER JOIN EQUIPAMENTO E'+
          '    ON (E.IDEQUIPAMENTO = M.IDEQUIPAMENTO)'+
          ' INNER JOIN USUARIO U'+
          '    ON (U.IDUSUARIO = M.IDUSUARIO)'+
          '  LEFT JOIN CLIENTE C'+
          '    ON (C.IDCLIENTE = M.IDCLIENTE)'+
          '  LEFT JOIN LOCALESTOQUE L   '+
          '    ON (L.IDLOCALESTOQUE = M.IDLOCALESTOQUE) '+
          ' WHERE 1=1 '+Complemento;
       End;
       tpCSEntradaMaterial:
       Begin
         CampoChave := 'IDENTRADAMATERIAL';
         CampoDisplay := '';
         NomeTabela := 'ENTRADAMATERIAL';
         CampoCodigo := '';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Entrada de material';
         DesconsiderarCampos := 'CODIGO;RAZAOSOCIAL';
         Versao20 := False;
         Select :=
            'SELECT EM.IDENTRADAMATERIAL, EM.DATA, EM.HORA, EM.DATANOTA,'+
            '       EM.IDFORNECEDOR, EM.DOCUMENTO, EM.OBS, EM.TOTALNOTA,'+
            '       F.CODIGO, F.RAZAOSOCIAL'+
            '  FROM ENTRADAMATERIAL EM'+
            '  LEFT JOIN FORNECEDOR F'+
            '    ON (F.IDFORNECEDOR = EM.IDFORNECEDOR)'+
            ' WHERE 1=1 '+Complemento;
       End;
       tpCSEntradaMaterialItem:
       Begin
         CampoChave := 'IDENTRADAMATERIALITEM';
         CampoDisplay := '';
         NomeTabela := 'ENTRADAMATERIALITEM';
         CampoCodigo := '';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Entrada de material(itens)';
         DesconsiderarCampos := 'CODIGO;NOMEMATERIAL;FLAGEDICAO';
         Select :=
            'SELECT EI.IDENTRADAMATERIALITEM, EI.IDENTRADAMATERIAL, EI.IDMATERIAL,'+
            '       EI.QUANTIDADE, EI.VALOR, EI.TOTAL,M.CODIGO, M.NOMEMATERIAL, ''N'' FLAGEDICAO'+
            '  FROM ENTRADAMATERIALITEM EI'+
            '  LEFT JOIN MATERIAL M'+
            '    ON (M.IDMATERIAL = EI.IDMATERIAL)'+
            ' WHERE 1=1'+Complemento;
       End;
       tpCSManutencaoPecas:
       Begin
         CampoChave := 'IDMANUTENCAOPECAS';
         CampoDisplay := '';
         NomeTabela := 'MANUTENCAOPECAS';
         CampoCodigo := '';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Manutenção (peças)';
         DesconsiderarCampos := 'CODIGO;NOMEMATERIAL;FLAGEDICAO';
         Select :=
            'SELECT MP.IDMANUTENCAOPECAS, MP.IDMANUTENCAO, MP.IDMATERIAL, '+
            '       MP.QUANTIDADE, MP.VALOR, MP.TOTAL, M.CODIGO, M.NOMEMATERIAL, ''N'' FLAGEDICAO '+
            '  FROM MANUTENCAOPECAS MP '+
            ' INNER JOIN MATERIAL M '+
            '    ON (M.IDMATERIAL = MP.IDMATERIAL) '+
            ' WHERE 1=1'+Complemento;
       End;
       tpCSTabelaPrecoEquipamento:
        Begin
         CampoChave := 'IDTABELAPRECOEQUIPAMENTO';
         CampoDisplay := '';
         NomeTabela := 'TABELAPRECOEQUIPAMENTO';
         CampoCodigo := '';
         DescricaoCampoDisplay := '';
         DescricaoTabela := 'Tabela de preços dos equipamentos';
         DesconsiderarCampos := 'UNIDADE;EQUIPAMENTO';
         Select :=
            'SELECT IDTABELAPRECOEQUIPAMENTO, U.IDUNIDADE, E.IDEQUIPAMENTO,'+
            '       E.CODIGO||'' ''||E.NOMEEQUIPAMENTO EQUIPAMENTO,'+
            '       T.PRECO,'+
            '       U.NOMEUNIDADE UNIDADE'+
            '  FROM EQUIPAMENTO E '+
            ' INNER JOIN  UNIDADE U   '+
            '    ON (1=1) '+
            '  LEFT JOIN TABELAPRECOEQUIPAMENTO T'+
            '    ON (E.IDEQUIPAMENTO = T.IDEQUIPAMENTO AND'+
            '        U.IDUNIDADE = T.IDUNIDADE )'+
            ' WHERE u.FLAUNIDADEDEEQUIPAMENTO = ''Y'' '+Complemento;
       End;

    end; //End Case


  End; //End With



end;

end.
