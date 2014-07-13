unit uVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, ExtCtrls, DB, DBClient, pFIBClientDataSet, Grids,
  DBGrids, StdCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxDBEdit, Mask, EditPesquisa, Buttons,
  cxCurrencyEdit, DBCtrls, LabelDBEdit, cxPC, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, Menus, cxSplitter, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver;

type
  TfrmVenda = class(TfrmPadrao)
    Panel1: TPanel;
    Panel3: TPanel;
    DataItens: TDataSource;
    DataServico: TDataSource;
    CdsServico: TpFIBClientDataSet;
    CdsItens: TpFIBClientDataSet;
    Label1: TLabel;
    edtData: TcxDBDateEdit;
    lblTotal: TLabel;
    Panel4: TPanel;
    btnAdd: TBitBtn;
    edtTipoServico: TEditPesquisa;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    PageControl: TcxPageControl;
    tsClienteCadastrado: TcxTabSheet;
    edtCliente: TEditPesquisa;
    Label3: TLabel;
    lblServico: TLabel;
    edtValor: TcxCurrencyEdit;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    edtEmpresa: TEditPesquisa;
    edtQuantidade: TcxCurrencyEdit;
    Label4: TLabel;
    edtTotal: TcxCurrencyEdit;
    Label5: TLabel;
    PopupMenu1: TPopupMenu;
    Obs1: TMenuItem;
    LabelDBEdit1: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    DBCheckBox1: TDBCheckBox;
    edtConta: TEditPesquisa;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox3: TGroupBox;
    DBGrid2: TDBGrid;
    cxSplitter1: TcxSplitter;
    DataEquipamento: TDataSource;
    CdsEquipamento: TpFIBClientDataSet;
    btnAddEquipamentos: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure edtClienteBtnNovoClick(Sender: TObject);
    procedure CdsServicoNewRecord(DataSet: TDataSet);
    procedure CdsItensNewRecord(DataSet: TDataSet);
    procedure edtTipoServicoRegAchado(ADataSet: TDataSet);
    procedure btnAddClick(Sender: TObject);
    procedure CdsItensAfterOpen(DataSet: TDataSet);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CdsServicoAfterOpen(DataSet: TDataSet);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure Obs1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAddEquipamentosClick(Sender: TObject);
    procedure CdsEquipamentoNewRecord(DataSet: TDataSet);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure CdsEquipamentoAfterPost(DataSet: TDataSet);
    procedure CdsEquipamentoAfterOpen(DataSet: TDataSet);
    procedure DBGrid2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FValorTotal: Currency;
    ValorOriginal: Currency;
    FIdAgenda: Integer;
    Procedure CalculaTotal;
    procedure SetValorTotal(const Value: Currency);


    { Private declarations }
  public
    { Public declarations }
    Property ValorTotal: Currency read FValorTotal write SetValorTotal;
  end;

var
  frmVenda: TfrmVenda;

implementation

uses Comandos, MinhasClasses,  uFechamento, uObs, uLibCS, Cad_Cliente,
  uDlg_SaidaEquipamento;

{$R *.dfm}

//
//function TfrmVenda.AjustaValor(pValorOriginal, Quantidade: Currency; pUnidadeOriginal,
//  Unidade: String): Currency;
//begin
//  if pUnidadeOriginal = '' then
//    Exit;
//  if pUnidadeOriginal = Unidade then
//  Begin
//    Result := pValorOriginal * Quantidade;
//    Exit;
//  End;
//  if pUnidadeOriginal = 'H' then
//    Result := pValorOriginal * 24
//  else
//    Result := pValorOriginal / 24;
//
//  if Unidade = 'H' then
//   Result := (Result * Quantidade ) / 24
//  else
//  if Unidade = 'D' then
//   Result := Result * Quantidade
//  else
//  if Unidade = 'Q' then
//   Result := (Result * 15) * Quantidade
//  else
//  if Unidade = 'M' then
//   Result := (Result * 30) * Quantidade;
//
//
//end;

procedure TfrmVenda.btnAddClick(Sender: TObject);
begin
  inherited;
  VerificaEdit(edtCliente,'Informe o cliente');
  VerificaEdit(edtTipoServico,'Informe o tipo de serviço');
  VerificaEdit(edtEmpresa,'Informe a empresa');
  if edtValor.Value <= 0  then
  Begin
    Avisa('Informe um valor maior que zero!');
    edtValor.SetFocus;
    Abort;
  End;
  if edtQuantidade.Value <= 0  then
  Begin
    Avisa('Informe uma quantidade maior que zero!');
    edtQuantidade.SetFocus;
    Abort;
  End;
  CdsItens.Append;

  CdsItens.FieldByName('IDPRODUTOS').AsString := edtTipoServico.ValorChaveString;

  CdsItens.FieldByName('NOME').AsString := edtTipoServico.Display.Text;

  CdsItens.FieldByName('VALORORIGINAL').AsCurrency := ValorOriginal;
  CdsItens.FieldByName('VALOR').AsCurrency := edtValor.Value;
  CdsItens.FieldByName('QUANTIDADE').AsCurrency := edtQuantidade.Value;
  CdsItens.FieldByName('TOTAL').AsCurrency := edtTotal.Value;

//  CdsItens.FieldByName('IDUNIDADEORIGINAL').AsString := UnidadeOriginal;
//  CdsItens.FieldByName('IDUNIDADE').AsString := edtUnidade.ValorChaveString;
//  CdsItens.FieldByName('NOMEUNIDADE').AsString := edtUnidade.Display.Text;

  ValorTotal:= ValorTotal + edtTotal.Value;
  Try
    frmOBS := TfrmOBS.Create(nil);
    frmOBS.ShowModal;
    CdsItens.FieldByName('OBSITEM').AsString := frmOBS.mmObs.Text;
  Finally
    FreeAndNil(frmOBS);
  End;


  CdsItens.Post;

  edtTipoServico.Limpa;
  edtValor.Clear;
  edtQuantidade.Clear;
  edtTotal.Clear;
  edtTipoServico.SetFocus;
end;

procedure TfrmVenda.btnAddEquipamentosClick(Sender: TObject);
begin
  inherited;
  frmDlg_SaidaEquipamento := TfrmDlg_SaidaEquipamento.Create(nil);
  Try
    frmDlg_SaidaEquipamento.pDataSet := Self.CdsEquipamento;
    frmDlg_SaidaEquipamento.pDataSet.Append;
    frmDlg_SaidaEquipamento.ShowModal;
  Finally
    FreeAndNil(frmDlg_SaidaEquipamento);
  End;
end;

procedure TfrmVenda.btnCancelarClick(Sender: TObject);
begin
  inherited;
  CdsServico.Cancel;
  CdsItens.Cancel;
  CdsServico.EmptyDataSet;
  CdsItens.EmptyDataSet;
  CdsEquipamento.EmptyDataSet;

  edtTipoServico.Limpa;
  //edtUnidade.Limpa;
  edtCliente.Limpa;
  edtValor.Clear;
  edtQuantidade.Value := 1;
  edtTotal.Clear;
  CdsServico.Append;
  edtCliente.SetFocus;
end;

procedure TfrmVenda.btnGravarClick(Sender: TObject);
var
  TotalCaixa : Currency;
  Dia: Integer;
  DataVencimento: TDate;
  Tratamento: TTratamentoLayout;
begin
  inherited;
  if (CdsServico.FieldByName('DATA').AsDateTime = 0) OR
     (CdsServico.FieldByName('DATA').AsDateTime <= StrToDate('01/01/1990')) or
     (CdsServico.FieldByName('DATA').AsDateTime >= StrToDate('01/01/2020')) Then
  Begin
    edtData.SetFocus;
    Avisa('Data inválida');
    Exit;
  End;
  if CdsItens.IsEmpty then
  Begin
    Avisa('Não existe itens para vender!');
    Abort;
  End;
  try
    Try
      frmOBS := TfrmOBS.Create(nil);
      {frmFechamento := TfrmFechamento.Create(Self);
      frmFechamento.TotalVenda := Self.ValorTotal;
      frmFechamento.IdServico := CdsServico.FieldByName('IDSERVICO').AsInteger;
      if CdsServico.FieldByName('IDSERVICO').AsString <> '' then
      Begin
        if frmFechamento.CdsPagamentos.Locate('TIPOFORMAPAGAMENTO','F',[]) Then
        Begin
           frmFechamento.CdsPagamentos.Edit;
           frmFechamento.CdsPagamentos.FieldByName('VALOR').AsCurrency := ValorTotal;
           frmFechamento.CalculaTotal;
        End;

      End;
      if frmFechamento.ShowModal = mrCancel then
        Exit;  }

      frmOBS.mmObs.Text := CdsServico.FieldByName('OBS').AsString;

      frmOBS.ShowModal;
      StartTrans;
      CdsServico.FieldByName('OBS').AsString := frmOBS.mmObs.Text;
//      CdsServico.FieldByName('VALORACRESCIMO').AsCurrency := frmFechamento.edtValAcres.Value;
 //     CdsServico.FieldByName('VALORDESCONTO').AsCurrency :=  frmFechamento.edtValDesc.Value;
      CdsServico.FieldByName('VALORTOTAL').AsCurrency := ValorTotal;
      CdsServico.FieldByName('VALORTOTALLIQUIDO').AsCurrency :=
          (ValorTotal+CdsServico.FieldByName('VALORACRESCIMO').AsCurrency) -
          CdsServico.FieldByName('VALORDESCONTO').AsCurrency;
      CdsServico.FieldByName('HORA').AsString := GetHoraServidor;
      CdsServico.Post;
      AlteraBanco(taInsere, CdsServico,'SERVICO','IDSERVICO');
      CdsItens.First;
      while not CdsItens.Eof do
      Begin
        AlteraBanco(taInsere, CdsItens,'SERVICODETALHE','IDSERVICODETALHE');
        CdsItens.Next;
      End;

      CdsEquipamento.First;
      while not CdsEquipamento.Eof do
      Begin
        AlteraBanco(taInsere, CdsEquipamento,'SAIDAEQUIPAMENTO','IDSAIDAEQUIPAMENTO');
        CdsEquipamento.Next;
      End;

      TotalCaixa := 0;
      {frmFechamento.CdsPagamentos.Filter := 'VALOR IS NOT NULL';
      frmFechamento.CdsPagamentos.Filtered := True;
      frmFechamento.CdsPagamentos.First;

      while not frmFechamento.CdsPagamentos.Eof do
      Begin
        AlteraBanco(taInsere, frmFechamento.CdsPagamentos,'SERVICOFORMAPAGAMENTO','IDSERVICOFORMAPAGAMENTO');
        if frmFechamento.CdsPagamentos.FieldByName('TIPOFORMAPAGAMENTO').AsString = 'D' then
          TotalCaixa := TotalCaixa + frmFechamento.CdsPagamentos.FieldByName('VALOR').AsCurrency;
        if frmFechamento.CdsPagamentos.FieldByName('TIPOFORMAPAGAMENTO').AsString = 'F' then
        Begin
          Dia := StrToInt(GetValorCds('SELECT COALESCE(DIAPAGAMENTO,5) '+
                                      '  FROM CLIENTE '+
                                      ' WHERE IDCLIENTE = '+edtCliente.ValorChaveString));
          DataVencimento := AddDay(Dia, edtData.Date);
          Exec_SQL('INSERT INTO CONTARECEBER (IDCONTARECEBER, DATACRIACAO, DATA, DATAVENCIMENTO, VALOR, IDUSUARIO, FLAGCANCELADA,'+
                   '                          DATACANCELADA, IDUSUARIOCANCELADA, FLAGPAGO, VALORPAGO, DATAPAGO, IDSERVICO, IDCLIENTE,HISTORICO)'+
                   ' VALUES (GEN_ID(SEQ_IDCONTARECEBER,1), CURRENT_DATE, '+GetData(edtData.Date)+', '+GetData(DataVencimento)+', '+
                            GetNumber(frmFechamento.CdsPagamentos.FieldByName('VALOR').AsCurrency)+','+
                            GetInteger(CdsServico.FieldByName('idusuario').AsInteger)+', ''N'', NULL,'+
                   '        NULL, ''N'', NULL, NULL, '+GetInteger(CdsServico.FieldByName('IDSERVICO').AsInteger)+', '+
                   GetInteger(CdsServico.FieldByName('idcliente').AsInteger)+','+GetStr('Referente à venda '+lblServico.Caption)+')');

        End;
        frmFechamento.CdsPagamentos.Next;
      End;
      GetCodigo(tpPetServico);
      if TotalCaixa > 0 then
      Begin
        Exec_SQL('INSERT INTO CAIXA (IDCAIXA, DATA, FLAGOPERACAO, VALOR, IDUSUARIO, IDSERVICO, HISTORICO) '+
                 '           VALUES (GEN_ID(SEQ_IDCAIXA,1), '+GetData(edtData.Date)+', ''C'', '+GetNumber(TotalCaixa)+', '+
                             GetInteger(CdsServico.FieldByName('IDUSUARIO').AsInteger)+','+
                             GetInteger(CdsServico.FieldByName('IDSERVICO').AsInteger)+','+
                             GetStr('Referente à venda '+lblServico.Caption)+')');
      End; }
      Exec_SQL('UPDATE EMPRESA SET NUMSERVICO = COALESCE(NUMSERVICO,0)+1 WHERE IDEMPRESA = '+CdsServico.FieldByName('idempresa').AsString);
      Commit;

      try
        StartTrans();
        Exec_SQL('execute procedure sp_criadocumento('+CdsServico.FieldByName('IDEMPRESA').AsString+','+CdsServico.FieldByName('IDSERVICO').AsString+')');
        Commit;
      except
        on E: Exception do
        begin
          RollBack;
          Raise;
        end;
      end;

      if Pergunta('Gostaria de visualizar antes de imprimir?') then
        Tratamento := tlTela
      else
        Tratamento := tlImpressora;

      Imp_Recibo(CdsServico.FieldByName('idempresa').AsInteger,CdsServico.FieldByName('IDSERVICO').AsString,Tratamento);
      btnCancelarClick(nil);
    Finally
     // FreeAndNil(frmFechamento);
      FreeAndNil(frmOBS);
    End;
  except
    on E: Exception do
    Begin
      RollBack;
      Raise;
    End;
  end;
end;

procedure TfrmVenda.CalculaTotal;
begin

end;

procedure TfrmVenda.CdsEquipamentoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsEquipamento.FieldByName('NOMEEQUIPAMENTO').ProviderFlags := [];
  CdsEquipamento.FieldByName('CODIGO').ProviderFlags := [];
  CdsEquipamento.FieldByName('IDENTIFICADOR').ProviderFlags := [];
  CdsEquipamento.FieldByName('NOMEUNIDADE').ProviderFlags := [];
  CdsEquipamento.FieldByName('FLAGEDICAO').ProviderFlags := [];

  FormataMascara(CdsEquipamento.FieldByName('VALOR'), tcMoeda);
  FormataMascara(CdsEquipamento.FieldByName('TOTAL'), tcMoeda);

end;

procedure TfrmVenda.CdsEquipamentoAfterPost(DataSet: TDataSet);
begin
  inherited;
  ValorTotal := ValorTotal + CdsEquipamento.FieldByName('TOTAL').AsCurrency;
end;

procedure TfrmVenda.CdsEquipamentoNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsEquipamento.FieldByName('IDSERVICO').AsString := CdsServico.FieldByName('IDSERVICO').AsString ;
  CdsEquipamento.FieldByName('IDSAIDAEQUIPAMENTO').AsString := GetCodigo(tpCSSaidaEquipamento);

end;

procedure TfrmVenda.CdsItensAfterOpen(DataSet: TDataSet);
begin
  inherited;
 CdsItens.FieldByName('NOME').ProviderFlags := [];
 CdsItens.FieldByName('CODIGO').ProviderFlags := [];
 CdsItens.FieldByName('FLAGEDICAO').ProviderFlags := [];
 CdsItens.FieldByName('NOMEUNIDADE').ProviderFlags := [];
 CdsItens.FieldByName('UNIDADEORIGINAL').ProviderFlags := [];

 FormataMascara(CdsItens.FieldByName('VALOR'),tcMoeda);
 FormataMascara(CdsItens.FieldByName('TOTAL'),tcMoeda);
 FormataMascara(CdsItens.FieldByName('QUANTIDADE'),tcReal);
end;

procedure TfrmVenda.CdsItensNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsItens.FieldByName('IDSERVICO').AsString := CdsServico.FieldByName('IDSERVICO').AsString ;
  CdsItens.FieldByName('IDSERVICODETALHE').AsString := GetCodigo(tpCsServicosDetalhe);

end;

procedure TfrmVenda.CdsServicoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsServico.FieldByName('NOMECLIENTE').ProviderFlags := [];
  CdsServico.FieldByName('CODIGO').ProviderFlags := [];
  CdsServico.FieldByName('CFOP').ProviderFlags := [];
  CdsServico.FieldByName('NATUREZA').ProviderFlags := [];
  CdsServico.FieldByName('CEP').ProviderFlags := [];
  CdsServico.FieldByName('LOGRADOURO').ProviderFlags := [];
  CdsServico.FieldByName('BAIRRO').ProviderFlags := [];
  CdsServico.FieldByName('CIDADE').ProviderFlags := [];
  CdsServico.FieldByName('UF').ProviderFlags := [];
  CdsServico.FieldByName('CNPJ_CPF').ProviderFlags := [];
  CdsServico.FieldByName('IE').ProviderFlags := [];
  CdsServico.FieldByName('IM').ProviderFlags := [];
  CdsServico.FieldByName('VALORTOTALLIQUIDOREL').ProviderFlags := [];
  CdsServico.FieldByName('AGENCIA').ProviderFlags := [];
  CdsServico.FieldByName('CONTA').ProviderFlags := [];
  CdsServico.FieldByName('NOMEBANCO').ProviderFlags := [];
  CdsServico.FieldByName('LOGIN').ProviderFlags := [];

end;

procedure TfrmVenda.CdsServicoNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsServico.FieldByName('DATA').AsString := GetDataServidor;
  CdsServico.FieldByName('IDEMPRESA').AsInteger := edtEmpresa.ValorChave;
  CdsServico.FieldByName('IDSERVICO').AsString := GetCodigo(tpCsServicos);
  CdsServico.FieldByName('NUMSERVICO').AsString := GetValorCds(tpCSEmpresa,'IDEMPRESA = '+CdsServico.FieldByName('IDEMPRESA').AsString,'NUMSERVICO');
  CdsServico.FieldByName('FLAGCANCELADO').AsString := 'N';
  CdsServico.FieldByName('FLAGMOSTRARVALORUNI').AsString := 'N';
  if CdsServico.FieldByName('NUMSERVICO').AsString = '' then
    CdsServico.FieldByName('NUMSERVICO').AsString := '1';
  CdsServico.FieldByName('NUMSERVICO').AsString := PadL(CdsServico.FieldByName('NUMSERVICO').AsString,6,'0');

  ValorTotal := 0;
  lblServico.Caption := CdsServico.FieldByName('NUMSERVICO').AsString;

  CdsServico.FieldByName('IDLASTUSUARIO').AsInteger := USuarioLogado.Id;
  CdsServico.FieldByName('IDUSUARIO').AsInteger := USuarioLogado.Id;
end;

procedure TfrmVenda.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = Vk_Delete then
    if ConfirmaDel then
       CdsItens.Delete;
end;

procedure TfrmVenda.DBGrid2DblClick(Sender: TObject);
begin
  inherited;
  frmDlg_SaidaEquipamento := TfrmDlg_SaidaEquipamento.Create(nil);
  Try
    frmDlg_SaidaEquipamento.pDataSet := Self.CdsEquipamento;
    frmDlg_SaidaEquipamento.pDataSet.Edit;
    ValorTotal := ValorTotal - CdsEquipamento.FieldByName('TOTAL').AsCurrency;
    if frmDlg_SaidaEquipamento.ShowModal = mrCancel Then
      ValorTotal := ValorTotal + CdsEquipamento.FieldByName('TOTAL').AsCurrency;
  Finally
    FreeAndNil(frmDlg_SaidaEquipamento);
  End;
end;

procedure TfrmVenda.DBGrid2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = Vk_Delete then
    if ConfirmaDel then
       CdsEquipamento.Delete;
end;

procedure TfrmVenda.edtClienteBtnNovoClick(Sender: TObject);
begin
  inherited;
  if frmCad_Cliente = nil then
    frmCad_Cliente := TfrmCad_Cliente.Create(nil);
  if frmCad_Cliente.Showing Then
    frmCad_Cliente.Close;
  frmCad_Cliente.NovoReg := True;
  if frmCad_Cliente.ShowModal = mrOK Then
  Begin
    CdsServico.FieldByName('IDCLIENTE').AsInteger := frmCad_Cliente.CdsCadastro.FieldByName('IDCLIENTE').AsInteger;
    edtCliente.Localiza;
  End;
end;

procedure TfrmVenda.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
  edtTotal.Value := edtValor.Value * edtQuantidade.Value;
end;

procedure TfrmVenda.edtTipoServicoRegAchado(ADataSet: TDataSet);
var
  StrWh: String;
begin
  inherited;
  StrWh :=
     ' IDPRODUTOS = '+edtTipoServico.ValorChaveString;
  with GetCds(tpCSProdutos,StrWh) do
  Begin
    edtValor.Value := FieldByName('VALORVENDA').AsCurrency;
    ValorOriginal := FieldByName('VALORVENDA').AsCurrency;
    Free;
  End;
end;

procedure TfrmVenda.FormCreate(Sender: TObject);
begin
  inherited;
  PageControl.HideTabs := True;
  PageControl.ActivePageIndex := 0;
  SetCds(CdsServico,tpCsServicos,'1<>1');
  SetCds(CdsItens,tpCsServicosDetalhe,'1<>1');
  SetCds(CdsEquipamento,tpCSSaidaEquipamento,'1<>1');
  ConfiguraEditPesquisa(edtCliente,CdsServico,tpCSCliente);
  ConfiguraEditPesquisa(edtConta,CdsServico,tpCSConta);
  edtConta.TamanhoCodigo := 3;
//  ConfiguraEditPesquisa(edtCFOP,CdsServico,tpCSCFOP);
//  edtCFOP.AutoCompletar := False;
  ConfiguraEditPesquisa(edtTipoServico,nil,tpCSProdutos);
//  ConfiguraEditPesquisa(edtUnidade,NIL,tpCSUnidade,True);
  //edtTipoServico.AutoCompletar := False;
  ConfiguraEditPesquisa(edtEmpresa,nil,tpCSEmpresa);
  edtEmpresa.ValorChave := GetValorCds(tpCSEmpresa, '1=1','IDEMPRESA')  ;
  edtEmpresa.Localiza;
  CdsServico.EmptyDataSet;
  CdsServico.Append;

end;

procedure TfrmVenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if KEY = VK_F9 then
    btnGravarClick(nil);
  if KEY = VK_F8 then
    btnAddEquipamentosClick(nil);

end;

procedure TfrmVenda.FormShow(Sender: TObject);
begin
  inherited;
  edtCliente.BtnNovo.Visible := GetPermissao(IdCadastroClienteNovo);
  btnAddEquipamentos.Visible := GetPermissao(IdCheckoutEquipamento);
  RegistraAuditoria('Acessou '+Self.Caption,'', '',Self.Name,Self.Caption,'',toAbrir,nil, False, True );
end;

procedure TfrmVenda.Obs1Click(Sender: TObject);
begin
  inherited;
 Try
    frmOBS := TfrmOBS.Create(nil);
    CdsItens.Edit;
    frmOBS.mmObs.Text := CdsItens.FieldByName('OBSITEM').AsString;
    frmOBS.ShowModal;
    CdsItens.FieldByName('OBSITEM').AsString := frmOBS.mmObs.Text;
    CdsItens.Post;
  Finally
    FreeAndNil(frmOBS);
  End;
end;

procedure TfrmVenda.SetValorTotal(const Value: Currency);
begin
  FValorTotal := Value;
  lblTotal.Caption := FormatFloat(MascaraMoeda,Value);
end;

end.
