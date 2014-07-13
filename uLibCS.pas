unit uLibCS;

interface
   Uses
     SysUtils, Classes, Comandos, MInhasClasses, DB, pFIBClientDataSet, USQL,
      uLista_Layouts,Controls, StrUtils, Math,Contnrs, Forms, Variants;

   Type
    TAbributoForm = (afNovo, afEditar, afDeletar, afImprimir);
    TAbributosForm = set of TAbributoForm;


     TFormSistema = Class
      private
        FNomeForm: String;
        FClasse: TComponentClass;
        FUsuarioPodeAcessar: boolean;
        FIdentForm: Integer;
        FAbributosForm: TAbributosForm;
      published
        Property NomeForm: String read FNomeForm write FNomeForm;
        Property Classe: TComponentClass read FClasse write FClasse;
        property UsuarioPodeAcessar: boolean read FUsuarioPodeAcessar write FUsuarioPodeAcessar;
        property IdentForm: Integer read FIdentForm write FIdentForm;
        property AbributosForm: TAbributosForm read FAbributosForm write FAbributosForm;
     End;

     TLstFormsSistema = class(TObjectList)
       function GetItems(Index: Integer): TFormSistema;
       procedure SetItems(Index: Integer; const Value: TFormSistema);
    public
       constructor Create;
       property Items[Index: Integer]: TFormSistema read GetItems write SetItems;
       Function Add(aFormSistema: TFormSistema): Integer; overload;
       Function Add(aNomeForm: String; aClasse: TComponentClass; aIdentForm: Integer; aAbributosForm: TAbributosForm  = [afNovo, afEditar, afDeletar, afImprimir]): Integer; overload;
       Procedure Delete(Index: Integer);
     end;
   TClassePadrao = class
     vOnException: TExceptionEvent;
     Procedure OnExcept(Sender: TObject; E: Exception);
     Procedure AbrePesquisaEquipamento(Sender : TObject;ADataSet : TDataSet; aTipoPesquisa: Integer; Titulo : String; Out Resultado : Variant);
   end;

   Function Imp_Recibo(IdEmpresa: Integer;IdServico: String; Tratamento: TTratamentoLayout = tlImpressora; pIdDocumento: Integer = -1): Integer;
   Procedure RegistraAuditoria(Resumo, Texto, Tabela, NomeForm, Caption,pValorChave: String; TipoOperacao: TTipoOperacaoForm;Cds: TpFIBClientDataSet;  Erro: Boolean = False; UsaTrans: Boolean = False);
   Procedure CriaAcessos(Descricao, Classificacao: String; IdAcesso: Integer; IdPai: Integer = -1);
   Procedure RegistraAcessos;
   Function Entra(Bloq: Boolean = False): Boolean;
   Procedure AtualizaAcessos;
   Function GetPermissao(IdAcesso: Integer): Boolean;



Const

  IdCadastroCliente: Integer = 1;
  IdCadastroClienteNovo: Integer = 2;
  IdCadastroClienteEditar: Integer = 3;
  IdCadastroClienteExcluir: Integer = 4;

  IdCadastroTipoServico: Integer = 5;
  IdCadastroTipoServicoNovo: Integer = 6;
  IdCadastroTipoServicoEditar: Integer = 7;
  IdCadastroTipoServicoExcluir: Integer = 8;

  IdCadastroCFOP: Integer = 9;
  IdCadastroCFOPNovo: Integer = 10;
  IdCadastroCFOPEditar: Integer = 11;
  IdCadastroCFOPExcluir: Integer = 12;

  IdCadastroCEP: Integer = 13;
  IdCadastroCEPNovo: Integer = 14;
  IdCadastroCEPEditar: Integer = 15;
  IdCadastroCEPExcluir: Integer = 16;

  IdCadastroEmpresa: Integer = 17;
  IdCadastroEmpresaNovo: Integer = 18;
  IdCadastroEmpresaEditar: Integer = 19;
  IdCadastroEmpresaExcluir: Integer = 20;

  IdCadastroBanco: Integer = 21;
  IdCadastroBancoNovo: Integer = 22;
  IdCadastroBancoEditar: Integer = 23;
  IdCadastroBancoExcluir: Integer = 24;

  IdCadastroContasBancarias: Integer = 25;
  IdCadastroContasBancariasNovo: Integer = 26;
  IdCadastroContasBancariasEditar: Integer = 27;
  IdCadastroContasBancariasExcluir: Integer = 28;


  IdCheckout: Integer = 29;

  IdListagemServico: Integer = 31;
  IdListagemServicoEditar: Integer = 32;
  IdListagemServicoExcluir: Integer = 33;
  IdListagemServicoComprovante: Integer = 34;
  IdListagemServicoRelatorio: Integer = 35;

  IdAgenda: Integer = 36;
  IdAgendaNovo: Integer = 37;
  IdAgendaEditar: Integer = 38;
  IdAgendaExcluir: Integer = 39;

  IdCadastroCombustivel: Integer = 40;
  IdStatusEquipamento: Integer = 41;
  IdCadastroFornecedor: Integer = 42;
  IdCadastroFornecedorNovo = 43;
  IdCadastroFornecedorEditar = 44;
  IdCadastroFornecedorExcluir = 45;

  IdCompraEquipamento = 46;
  IdEntradaEquipamento = 47;
  IdCManutencaoEquipamento = 48;
  IdCompraMaterial = 49;
  IdTabelaPreco = 50;
  IdRelDespesaReceita = 51;
  IdRelMovimentacaoEquipamento = 52;
  IdRelDivergenciaManutencao = 53;

  IdCadastroMaterial = 54;
  IdCadastroLocalEstoque = 55;
  IdCheckoutEquipamento = 56;

  IdListagemServicoAddEquipamento = 57;
  IdListagemServicoEditarEquipamento = 58;
  IdListagemServicoExcluirEquipamento = 59;

  
var
  ClassePadrao: TClassePadrao;
implementation

uses UDmConexao, uLogin;
Var
  CdsAcessosUsuarios: TpFIBClientDataSet;

  Function Imp_Recibo(IdEmpresa: Integer;IdServico: String; Tratamento: TTratamentoLayout = tlImpressora; pIdDocumento: Integer = -1 ): Integer;
  var
     CdsRecibo, CdsItens, CdsEmpresa,CdsEquipamento: TpFIBClientDataSet;
     StrSQL : String;
     IdDocumento,IdRecibo: String;
   Begin
     if not GetPermissao(IdListagemServicoComprovante) then
     begin
       Avisa('Você não tem permissão para imprimir o comprovante.');
       Exit;
     end;

     RegistraAuditoria('Imprimiu um comprovante ','O Usuário '+USuarioLogado.Login+' Imprimiu um comprovante ',
                       '', '','Comprovante de venda','', toImprimir,nil,  False, True );

     GravaRelatorio(IdRelComprovanteVendaCS,'Comprovante de venda');
     Result := -1;
     Try
       CdsRecibo := TpFIBClientDataSet.Create(nil);
       CdsItens := TpFIBClientDataSet.Create(nil);
       CdsEmpresa := TpFIBClientDataSet.Create(nil);
       CdsEquipamento := TpFIBClientDataSet.Create(nil);
       //CdsFP     := TpFIBClientDataSet.Create(nil);

       if pIdDocumento = -1  then
       Begin
         IdDocumento := '';
         StrSQL :=
          'EXECUTE BLOCK RETURNS(IDDOCUMENTO INTEGER) AS '+
          ' DECLARE VARIABLE NUMVERSAO INTEGER; '+
          ' DECLARE VARIABLE PIDSERVICO INTEGER; '+
          'BEGIN'+
          '  FOR'+
          '    SELECT IDSERVICO'+
          '       FROM SERVICO'+
          '      WHERE IDSERVICO IN('+IdServico+')'+
          '      INTO :PIDSERVICO'+
          '   DO'+
          '    BEGIN'+
          '      SELECT FIRST 1 D.NUMVERSAO'+
          '         FROM DOCUMENTO D'+
          '        WHERE D.IDSERVICO = :PIDSERVICO'+
          '       ORDER BY NUMVERSAO DESC'+
          '        INTO :NUMVERSAO;'+
          ''+
          '      SELECT IDDOCUMENTO'+
          '       FROM DOCUMENTO'+
          '      WHERE IDSERVICO = :PIDSERVICO'+
          '        AND NUMVERSAO = :NUMVERSAO'+
          '      INTO :IDDOCUMENTO;'+
          '      SUSPEND;'+
          ''+
          '    END '+
          'END';

         with GetCds(StrSQL ) do
         begin
           First;
           while not Eof do
           begin
             IdDocumento := IdDocumento+FieldByName('IDDOCUMENTO').AsString+',';
             Next;
           end;
           IdDocumento := StringReplace(IdDocumento+'$',',$','',[]);
           Free;
         end;
       End else
         IdDocumento := IntToSTr(pIdDocumento) ;

       SetCds(CdsRecibo, tpCSDocumento, ' IDDOCUMENTO in ('+IdDocumento+')' );


       StrSQL:=
         'SELECT * '+
         '  FROM DOCUMENTOITEM '+
         ' WHERE IDDOCUMENTO in ('+IdDocumento+')'+
         ' order by IDDOCUMENTO ';

       SetCds(CdsItens, StrSQL);

       //SetCds(CdsFP, GetSelect(tpPetServicoPagamentos)+'AND VALOR IS NOT NULL AND  SF.IDSERVICO  = '+IntToStr(IdServico));


       StrSQL:=
         'SELECT * '+
         '  FROM DOCUMENTOEMPRESA '+
         ' WHERE IDDOCUMENTO in ('+IdDocumento+')'+
         ' order by IDDOCUMENTO ';

       SetCds(CdsEmpresa, StrSQL);

       StrSQL:=
         'SELECT * '+
         '  FROM DOCUMENTOEQUIPAMENTO '+
         ' WHERE IDDOCUMENTO in ('+IdDocumento+')'+
         ' order by IDDOCUMENTO ';

       SetCds(CdsEquipamento, StrSQL);

       //SetCds(CdsEmpresa,  GetSelect(tpCSEmpresa,' IDEMPRESA = '+IntToStr(IdEmpresa))) ;
       //CdsFP.Name :='Recebimentos';
       CdsEmpresa.Name :='Empresa';
       CdsEquipamento.Name :='Equipamento';
       if Tratamento <> tlLista  then
         ImprimeRelatorio(IdRelComprovanteVendaCS, CdsRecibo, CdsItens, CdsEmpresa, Tratamento, [CdsEmpresa,CdsEquipamento])
       else
       Begin
         frmLista_Layouts := TfrmLista_Layouts.Create(nil);
         Try
           with frmLista_Layouts do
           Begin
             CdsMaster := CdsRecibo;
             CdsDetalhe := CdsItens;
             IdRelatorio := IdRelComprovanteVendaCS;
             SetLength(CdsExtras,2);
             //CdsExtras[0] := CdsFP;
             CdsExtras[0] := CdsEmpresa;
             CdsExtras[1] := CdsEquipamento;
             if ShowModal = mrOk Then
               Result := CdsLayout.FieldByName('IDLAYOUT').AsInteger;
           End;
         Finally
           FreeAndNil(frmLista_Layouts);
         End;
       End;
     Finally
       FreeAndNil(CdsRecibo);
       FreeAndNil(CdsItens);
       FreeAndNil(CdsEmpresa);
       FreeAndNil(CdsEquipamento);
       //FreeAndNil(CdsFP);
     End;
   End;


Procedure RegistraAuditoria(Resumo, Texto, Tabela, NomeForm, Caption,pValorChave: String; TipoOperacao: TTipoOperacaoForm;Cds: TpFIBClientDataSet; Erro: Boolean = False; UsaTrans: Boolean = False);
Var
  NomePC,Operacao,Txt: String;
  I: Integer;
Begin
  if Cds <> nil then
  Begin
    if TipoOperacao = toEditar then
    Begin
      for I := 0 to Cds.FieldCount - 1 do
        if not Cds.Fields[i].IsBlob Then //Cds.Fields[i].DataType in [ftBlob, ftMemo, ftGraphic, ftFmtMemo, ft] then
          Txt :=Txt+Cds.Fields[i].FieldName+': '+VarToStr(Cds.Fields[i].OldValue)+' -> '+Cds.Fields[i].AsString +sLineBreak;
    End;
    if TipoOperacao = toDeletar then
    Begin
      for I := 0 to Cds.FieldCount - 1 do
        if not Cds.Fields[i].IsBlob Then
          Txt :=Txt+Cds.Fields[i].FieldName+': '+Cds.Fields[i].AsString +sLineBreak;
    End;

  End;


  NomePC:= DMCOnexao.InfoPC.Identification.LocalComputerName;


  case TipoOperacao of
    toLogin:
      Operacao := 'L' ;
    toLogoff:
      Operacao := 'O' ;
    toIncluir:
      Operacao := 'I' ;
    toEditar:
      Operacao := 'E' ;
    toDeletar:
      Operacao := 'E' ;
    toImprimir:
      Operacao := 'P' ;
    toAbrir:
      Operacao := 'A' ;
    toErro:
      Operacao := 'R' ;
  end;
  Try
    if UsaTrans then
      StartTrans;
    DMCOnexao.Query.Close;
    DMCOnexao.Query.SQl.Text :=
      'INSERT INTO AUDITORIA (IDAUDITORIA, DATA, HORA, RESUMO, IDUSUARIO, OPERACAO, TEXTO, NOMEPC, FLAGERRO, IMGERRO, TABELA,'+
      '                       NOMEFORM, CAPTION, IDTABELA,TEXTOANTERIOR)'+
      '               VALUES (GEN_ID(SEQ_IDAUDITORIA,1), CURRENT_DATE, CURRENT_TIME, :RESUMO, :IDUSUARIO,'+
      '                       :OPERACAO, :TEXTO, :NOMEPC, :FLAGERRO, :IMGERRO, :TABELA,'+
      '                       :NOMEFORM, :CAPTION,:IDTABELA,:TEXTOANTERIOR)';

    DMCOnexao.Query.Prepare;
    DMCOnexao.Query.ParamByName('RESUMO').AsString := Trim(Resumo);
    DMCOnexao.Query.ParamByName('IDUSUARIO').Value := USuarioLogado.Id;
    DMCOnexao.Query.ParamByName('OPERACAO').Value := Operacao;
    DMCOnexao.Query.ParamByName('TEXTO').Value := Texto;
    DMCOnexao.Query.ParamByName('NOMEPC').Value := NomePC;
    if Erro then
    Begin
      DMCOnexao.Query.ParamByName('FLAGERRO').Value :=  'Y';
      DMCOnexao.Query.ParamByName('IMGERRO').Clear;{ TODO : Tirar Print }
    End else
    begin
      DMCOnexao.Query.ParamByName('FLAGERRO').Value := 'N';
      DMCOnexao.Query.ParamByName('IMGERRO').Clear;
    end;
    DMCOnexao.Query.ParamByName('TABELA').Value :=  Tabela;
    DMCOnexao.Query.ParamByName('NOMEFORM').Value :=  NomeForm;
    DMCOnexao.Query.ParamByName('CAPTION').Value :=  Caption;
    DMCOnexao.Query.ParamByName('IDTABELA').Value := pValorChave;
    DMCOnexao.Query.ParamByName('TEXTOANTERIOR').Value := Txt;

    DMCOnexao.Query.ExecQuery;
    if UsaTrans then
      Commit;
  Except
    on E: Exception do
    Begin
      if UsaTrans then
        RollBack;
      Raise;
    End;

  End;
End;



{ TLstFormsSistema }

function TLstFormsSistema.Add(aNomeForm: String; aClasse: TComponentClass;
  aIdentForm: Integer; aAbributosForm: TAbributosForm  = [afNovo, afEditar, afDeletar, afImprimir]): Integer;
var
  FormSistema: TFormSistema;
begin
  FormSistema := TFormSistema.Create;
  with FormSistema do
  Begin
    NomeForm := aNomeForm;
    Classe := aClasse;
    IdentForm := aIdentForm;
    AbributosForm := aAbributosForm;
  End;
  Result := Add(FormSistema);

end;

function TLstFormsSistema.Add(aFormSistema: TFormSistema): Integer;
begin
  Result := inherited Add(aFormSistema);
end;

constructor TLstFormsSistema.Create;
begin

end;

procedure TLstFormsSistema.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TLstFormsSistema.GetItems(Index: Integer): TFormSistema;
begin
  Result := inherited Items[Index] as TFormSistema;
end;

procedure TLstFormsSistema.SetItems(Index: Integer; const Value: TFormSistema);
begin
  Inherited Items[Index] := Value;
end;


Procedure CriaAcessos(Descricao, Classificacao: String; IdAcesso: Integer; IdPai: Integer = -1);
var
  StrSQL: String;
Begin
  StrSQL:=
    'UPDATE OR  INSERT INTO ACESSO (IDACESSO, DESCRICAO, CLASSIFICACAO, IDPAI) '+
    '                       VALUES ('+GetInteger(IdAcesso)+', '+QuotedStr(Descricao)+', '+
                                      QuotedStr(Classificacao)+', '+GetInteger(IdPai)+') MATCHING (IDACESSO) ';
  Exec_SQL(StrSQL);
End;

Procedure RegistraAcessos;
Begin
  Try
    StartTrans;
    CriaAcessos('Cadastro de clientes',               '1',IdCadastroCliente);
    CriaAcessos('Novo',                               '1.1',IdCadastroClienteNovo,IdCadastroCliente);
    CriaAcessos('Editar',                             '1.2',IdCadastroClienteEditar,IdCadastroCliente);
    CriaAcessos('Excluir',                            '1.3',IdCadastroClienteExcluir,IdCadastroCliente);

    CriaAcessos('Cadastro de tipos de serviço',       '2',IdCadastroTipoServico);
    CriaAcessos('Novo',                               '2.1',IdCadastroTipoServicoNovo,IdCadastroTipoServico);
    CriaAcessos('Editar',                             '2.2',IdCadastroTipoServicoEditar,IdCadastroTipoServico);
    CriaAcessos('Excluir',                            '3.3',IdCadastroTipoServicoExcluir,IdCadastroTipoServico);

    CriaAcessos('Cadastro de CFOP',                   '3',IdCadastroCFOP);
    CriaAcessos('Novo',                               '3.1',IdCadastroCFOPNovo,IdCadastroCFOP);
    CriaAcessos('Editar',                             '3.2',IdCadastroCFOPEditar,IdCadastroCFOP);
    CriaAcessos('Excluir',                            '3.3',IdCadastroCFOPExcluir,IdCadastroCFOP);

    CriaAcessos('Cadastro de CEP',                    '4',IdCadastroCEP);
    CriaAcessos('Novo',                               '4.1',IdCadastroCEPNovo,IdCadastroCEP);
    CriaAcessos('Editar',                             '4.2',IdCadastroCEPEditar,IdCadastroCEP);
    CriaAcessos('Excluir',                            '4.3',IdCadastroCEPExcluir,IdCadastroCEP);

    CriaAcessos('Cadastro de Empresa',                '5',IdCadastroEmpresa);
    CriaAcessos('Novo',                               '5.1',IdCadastroEmpresaNovo,IdCadastroEmpresa);
    CriaAcessos('Editar',                             '5.2',IdCadastroEmpresaEditar,IdCadastroEmpresa);
    CriaAcessos('Excluir',                            '5.3',IdCadastroEmpresaExcluir,IdCadastroEmpresa);

    CriaAcessos('Cadastro de Banco',                  '6',IdCadastroBanco);
    CriaAcessos('Novo',                               '6.1',IdCadastroBancoNovo,IdCadastroBanco);
    CriaAcessos('Editar',                             '6.2',IdCadastroBancoEditar,IdCadastroBanco);
    CriaAcessos('Excluir',                            '6.3',IdCadastroBancoExcluir,IdCadastroBanco);

    CriaAcessos('Cadastro de contas Bancárias',       '7',IdCadastroContasBancarias);
    CriaAcessos('Novo',                               '7.1',IdCadastroContasBancariasNovo,IdCadastroContasBancarias);
    CriaAcessos('Editar',                             '7.2',IdCadastroContasBancariasEditar,IdCadastroContasBancarias);
    CriaAcessos('Excluir',                            '7.3',IdCadastroContasBancariasExcluir,IdCadastroContasBancarias);

    CriaAcessos('Checkout',                           '8',IdCheckout);
    CriaAcessos('Adicionar equipamento' ,             '8.1',IdCheckoutEquipamento,IdCheckout   );

    CriaAcessos('Listagem de serviço',                '9',IdListagemServico);
    CriaAcessos('Editar',                             '9.2',IdListagemServicoEditar,IdListagemServico);
    CriaAcessos('Excluir',                            '9.3',IdListagemServicoExcluir,IdListagemServico);
    CriaAcessos('Comprovante',                        '9.4',IdListagemServicoComprovante,IdListagemServico);
    CriaAcessos('Relatório'  ,                        '9.5',IdListagemServicoRelatorio,IdListagemServico);
    CriaAcessos('Adicionar Equipamento'  ,            '9.6',IdListagemServicoAddEquipamento,IdListagemServico);
    CriaAcessos('Editar Equipamento'  ,               '9.7',IdListagemServicoEditarEquipamento,IdListagemServico);
    CriaAcessos('Excluir Equipamento'  ,               '9.8',IdListagemServicoExcluirEquipamento,IdListagemServico);

    CriaAcessos('Agenda',                             '10',IdAgenda);
    CriaAcessos('Novo',                               '10.1',IdAgendaNovo,IdAgenda);
    CriaAcessos('Editar',                             '10.2',IdAgendaEditar,IdAgenda);
    CriaAcessos('Excluir',                            '10.3',IdAgendaExcluir,IdAgenda);

    CriaAcessos('Cadastro de fornecedor',             '11',IdCadastroFornecedor);
    CriaAcessos('Novo',                               '11.1',IdCadastroFornecedorNovo,IdCadastroFornecedor);
    CriaAcessos('Editar',                             '11.2',IdCadastroFornecedorEditar,IdCadastroFornecedor);
    CriaAcessos('Excluir',                            '11.3',IdCadastroFornecedorExcluir,IdCadastroFornecedor);
    CriaAcessos('Cadastro de fornecedor',             '11',IdCadastroFornecedor);

    CriaAcessos('Cadastro de combustível',            '12',IdCadastroCombustivel);
    CriaAcessos('Cadastro de status do equipamento',  '13',IdStatusEquipamento);

    CriaAcessos('Compra equipamento',                 '14',IdCompraEquipamento );
    CriaAcessos('Entrada equipamento',                '15',IdEntradaEquipamento );
    CriaAcessos('Manutencao equipamento',             '16',IdCManutencaoEquipamento );
    CriaAcessos('Compra material',                    '17',IdCompraMaterial  );
    CriaAcessos('Tabela de preço',                    '18',IdTabelaPreco  );
    CriaAcessos('Rel. de despesa X receita equipamento',     '19',IdRelDespesaReceita  );
    CriaAcessos('Rel. de movimentação equipamento','20',IdRelMovimentacaoEquipamento  );
    CriaAcessos('Rel. de divergência de manutenção','21',IdRelDivergenciaManutencao   );
    CriaAcessos('Cadastro de material','22',IdCadastroMaterial   );
    CriaAcessos('Cadastro de local de estoque','23',IdCadastroLocalEstoque   );


    Commit;
  Except
    on e:Exception do
    begin
      RollBack;
      Raise;
    end;

  End;

End;

Function Entra(Bloq: Boolean = False): Boolean;
var
   vFile: String;
Begin
   frmLogin := TfrmLogin.Create(nil);
   if DMConexao = nil then
     Application.CreateForm(TDMConexao, DMConexao);
   Result := False;
   if not frmLogin.AutoLogin then
   Begin
     if Bloq then
     Begin
       frmLogin.edtLogin.Text := USuarioLogado.Login;
       frmLogin.ActiveControl := frmLogin.edtSenha;
       frmLogin.edtLogin.Enabled := False;
       frmLogin.KeyPreview := False;
       frmLogin.btnCancelar.Visible := False;
     End;

     if frmLogin.ShowModal = mrOk then
       Result := True;
   End else
     Result := True;
 End;

Procedure AtualizaAcessos;
Begin
  SetCds(CdsAcessosUsuarios, tpCSUsuarioAcesso, 'IDUSUARIO = '+IntToStr(USuarioLogado.Id) );
End;


Function GetPermissao(IdAcesso: Integer): Boolean;
Begin
  Result := True;
  if CdsAcessosUsuarios.Locate('IDACESSO', IdAcesso,[]) then
    Result := CdsAcessosUsuarios.FieldByName('FLAGPERMITIDO').AsString = 'Y';
End;



{ TClassePadrao }

procedure TClassePadrao.OnExcept(Sender: TObject; E: Exception);
begin
  Try
    if e <> nil then
    Begin
      RegistraAuditoria('Ocorreu um erro no sistema ',E.Message, '',e.ClassName,'','',toErro,nil, True, True );
      AvisaErro(E.Message);
    End;
  Except
    vOnException(Sender,E);
  End;
end;


Procedure TClassePadrao.AbrePesquisaEquipamento(Sender : TObject;ADataSet : TDataSet; aTipoPesquisa: Integer; Titulo : String; Out Resultado : Variant);
Begin
  AbrePesquisa(Sender,ADataSet,StrToInt(VarToStr(tpCSEquipamento)),Titulo,Resultado);
End;

initialization
  CdsAcessosUsuarios := TpFIBClientDataSet.Create(Application);
  ClassePadrao := TClassePadrao.Create;

end.
