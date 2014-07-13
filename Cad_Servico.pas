unit Cad_Servico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Cad_CadastroPai, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ComCtrls, DB, DBClient, pFIBClientDataSet, ActnList,
  cxPC, cxContainer, cxTreeView, Buttons, ExtCtrls, StdCtrls, Mask, DBCtrls,
  LabelDBEdit, EditPesquisa, Grids, DBGrids, cxEdit, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter;

type
  TfrmCad_Servico = class(TfrmCad_CadastroPai)
    GroupBox1: TGroupBox;
    DBMemo1: TDBMemo;
    Panel2: TPanel;
    LabelDBEdit1: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    edtCliente: TEditPesquisa;
    LabelDBEdit8: TLabelDBEdit;
    cxTabSheet1: TcxTabSheet;
    GroupBox3: TGroupBox;
    DBGrid2: TDBGrid;
    CdsPagamentos: TpFIBClientDataSet;
    DataItens: TDataSource;
    CdsItens: TpFIBClientDataSet;
    DataPagamentos: TDataSource;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    actAdd: TAction;
    actEditarItem: TAction;
    actDell: TAction;
    LabelDBEdit3: TLabelDBEdit;
    DBCheckBox1: TDBCheckBox;
    LabelDBEdit4: TLabelDBEdit;
    DBCheckBox2: TDBCheckBox;
    edtConta: TEditPesquisa;
    cxTabSheet2: TcxTabSheet;
    GroupBox2: TGroupBox;
    Panel5: TPanel;
    BitBtn4: TBitBtn;
    TvCadastro: TcxGrid;
    TvRevisao: TcxGridDBTableView;
    TvCadastroLevel1: TcxGridLevel;
    DataRevisao: TDataSource;
    CdsRevisao: TpFIBClientDataSet;
    cxTabSheet3: TcxTabSheet;
    GroupBox4: TGroupBox;
    Panel6: TPanel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    actAddEquipamento: TAction;
    actEditarEquipamento: TAction;
    actDelEquipamento: TAction;
    CdsEquipamento: TpFIBClientDataSet;
    DataEquipamento: TDataSource;
    DBGrid1: TDBGrid;
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure CdsItensAfterOpen(DataSet: TDataSet);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
    procedure actEditarItemExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actDellExecute(Sender: TObject);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure CdsItensNewRecord(DataSet: TDataSet);
    procedure CdsItensBeforePost(DataSet: TDataSet);
    procedure CdsItensAfterPost(DataSet: TDataSet);
    procedure BitBtn4Click(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure CdsRevisaoAfterOpen(DataSet: TDataSet);
    procedure CdsCadastroBeforePost(DataSet: TDataSet);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
    procedure actAddEquipamentoExecute(Sender: TObject);
    procedure actEditarEquipamentoExecute(Sender: TObject);
    procedure actDelEquipamentoExecute(Sender: TObject);
    procedure CdsEquipamentoAfterOpen(DataSet: TDataSet);
    procedure CdsEquipamentoAfterPost(DataSet: TDataSet);
    procedure CdsEquipamentoNewRecord(DataSet: TDataSet);
    procedure CdsEquipamentoBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure CalculaTotal;
  end;

var
  frmCad_Servico: TfrmCad_Servico;

implementation

uses Comandos, MinhasClasses, uSQL, Cad_Item, uLibCS, uDlg_SaidaEquipamento;

{$R *.dfm}

procedure TfrmCad_Servico.actAddEquipamentoExecute(Sender: TObject);
begin
  inherited;
  MudaEstado;
  frmDlg_SaidaEquipamento := TfrmDlg_SaidaEquipamento.Create(nil);
  Try
    frmDlg_SaidaEquipamento.pDataSet := Self.CdsEquipamento;
    frmDlg_SaidaEquipamento.pDataSet.Append;
    frmDlg_SaidaEquipamento.VerificaAlugado := False;
    frmDlg_SaidaEquipamento.ShowModal;
  Finally
    FreeAndNil(frmDlg_SaidaEquipamento);
  End;
end;

procedure TfrmCad_Servico.actAddExecute(Sender: TObject);
begin
  inherited;
  MudaEstado;
  frmCad_Itens := TfrmCad_Itens.Create(Self);
  Try
    frmCad_Itens.pDataSet := Self.CdsItens;
    frmCad_Itens.pDataSet.Append;
    frmCad_Itens.FechaEGrava := True;
    frmCad_Itens.ShowModal;
  Finally
    FreeAndNil(frmCad_Itens);
  End;
end;

procedure TfrmCad_Servico.actDelEquipamentoExecute(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  Begin
     MudaEstado;
     CdsEquipamento.Edit;
     CdsEquipamento.FieldByName('FLAGEDICAO').AsString := 'D';
     CdsEquipamento.Post;
  End;

end;

procedure TfrmCad_Servico.actDellExecute(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  Begin
     MudaEstado;
     CdsItens.Edit;
     CdsItens.FieldByName('FLAGEDICAO').AsString := 'D';
     CdsItens.Post;
    {try
      StartTrans;
      Exec_SQL('DELETE FROM SERVICODETALHE '+
               ' WHERE IDSERVICODETALHE = '+CdsItens.FieldByName('IDSERVICODETALHE').AsString);
      Commit;
    except
      on E: Exception do
      Begin
        RollBack;
        Raise;
      End;
    end;}
  End;

end;

procedure TfrmCad_Servico.actEditarEquipamentoExecute(Sender: TObject);
begin
  inherited;
  MudaEstado;
  frmDlg_SaidaEquipamento := TfrmDlg_SaidaEquipamento.Create(nil);
  Try
    frmDlg_SaidaEquipamento.pDataSet := Self.CdsEquipamento;
    frmDlg_SaidaEquipamento.pDataSet.Edit;
    frmDlg_SaidaEquipamento.VerificaAlugado := False;
    frmDlg_SaidaEquipamento.ShowModal;
  Finally
    FreeAndNil(frmDlg_SaidaEquipamento);
  End;
end;

procedure TfrmCad_Servico.actEditarItemExecute(Sender: TObject);
begin
  inherited;
  MudaEstado;
  frmCad_Itens := TfrmCad_Itens.Create(Self);
  Try
    frmCad_Itens.pDataSet := Self.CdsItens;
    frmCad_Itens.pDataSet.Edit;
    frmCad_Itens.FechaEGrava := True;
    frmCad_Itens.ShowModal;
  Finally
    FreeAndNil(frmCad_Itens);
  End;

end;

procedure TfrmCad_Servico.actGravarExecute(Sender: TObject);
begin
  inherited;
  try
    StartTrans();
    Exec_SQL('execute procedure sp_criadocumento('+CdsCadastro.FieldByName('IDEMPRESA').AsString+','+CdsCadastro.FieldByName('IDSERVICO').AsString+')');
    Commit;
  except
    on E: Exception do
    begin
      RollBack;
      Raise;
    end;
  end;
end;

procedure TfrmCad_Servico.BitBtn4Click(Sender: TObject);
begin
  inherited;
  Imp_Recibo(CdsCadastro.FieldByName('IDEMPRESA').AsInteger,CdsCadastro.FieldByName('IDSERVICO').AsString,tlTela, CdsRevisao.FieldByName('IDDOCUMENTO').AsInteger);
end;

procedure TfrmCad_Servico.CalculaTotal;
var
  Tot: Currency;
begin
  inherited;
  with TClientDataSet.Create(nil) do
  begin
    CloneCursor(CdsItens,False);
    First;
    Tot:= 0;
    while not Eof do
    Begin
      Tot := Tot+ FieldByName('TOTAL').AsCurrency;
      Next;
    End;

    CloneCursor(CdsEquipamento,False);
    First;
    while not Eof do
    Begin
      Tot := Tot+ FieldByName('TOTAL').AsCurrency;
      Next;
    End;


    CdsCadastro.FieldByName('VALORTOTALLIQUIDO').AsCurrency := Tot;
    Free;
  end;
end;

procedure TfrmCad_Servico.CdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsCadastro.FieldByName('VALORTOTAL'), tcMoeda);
  FormataMascara(CdsCadastro.FieldByName('VALORACRESCIMO'), tcMoeda);
  FormataMascara(CdsCadastro.FieldByName('VALORDESCONTO'), tcMoeda);
  FormataMascara(CdsCadastro.FieldByName('VALORTOTALLIQUIDO'), tcMoeda);
  CdsCadastro.FieldByName('CODIGO').ProviderFlags := [];
  CdsCadastro.FieldByName('NOMECLIENTE').ProviderFlags := [];
  CdsCadastro.FieldByName('CEP').ProviderFlags := [];
  CdsCadastro.FieldByName('LOGRADOURO').ProviderFlags := [];
  CdsCadastro.FieldByName('BAIRRO').ProviderFlags := [];
  CdsCadastro.FieldByName('CIDADE').ProviderFlags := [];
  CdsCadastro.FieldByName('UF').ProviderFlags := [];
  CdsCadastro.FieldByName('CNPJ_CPF').ProviderFlags := [];
  CdsCadastro.FieldByName('CFOP').ProviderFlags := [];
  CdsCadastro.FieldByName('NATUREZA').ProviderFlags := [];
  CdsCadastro.FieldByName('IE').ProviderFlags := [];
  CdsCadastro.FieldByName('IM').ProviderFlags := [];
  CdsCadastro.FieldByName('VALORTOTALLIQUIDOREL').ProviderFlags := [];
  CdsCadastro.FieldByName('AGENCIA').ProviderFlags := [];
  CdsCadastro.FieldByName('CONTA').ProviderFlags := [];
  CdsCadastro.FieldByName('NOMEBANCO').ProviderFlags := [];
  CdsCadastro.FieldByName('LOGIN').ProviderFlags := [];

end;

procedure TfrmCad_Servico.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  SetRegistros(CdsItens,tpCsServicosDetalhe);
  SetRegistros(CdsEquipamento,tpCSSaidaEquipamento);
end;

procedure TfrmCad_Servico.CdsCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
   SetCds(CdsItens,tpCSServicosDetalhe,'IDSERVICO = '+ValorChave);
   SetCds(CdsRevisao,tpCSDocumento,'IDSERVICO = '+ValorChave);
   SetCds(CdsEquipamento,tpCSSaidaEquipamento,'IDSERVICO = '+ValorChave);
  //SetCds(CdsPagamentos,GetSelect(tpPetServicoPagamentos,'1=1')+' AND S.IDSERVICO = '+ValorChave);

end;

procedure TfrmCad_Servico.CdsCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('IDLASTUSUARIO').AsInteger := USuarioLogado.Id;
end;

procedure TfrmCad_Servico.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('IDLASTUSUARIO').AsInteger := USuarioLogado.Id;
  CdsCadastro.FieldByName('IDUSUARIO').AsInteger := USuarioLogado.Id;
end;

procedure TfrmCad_Servico.CdsItensAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsItens.FieldByName('VALOR'), tcMoeda);
  FormataMascara(CdsItens.FieldByName('VALORORIGINAL'), tcMoeda);
  FormataMascara(CdsItens.FieldByName('TOTAL'),tcMoeda);
  FormataMascara(CdsItens.FieldByName('QUANTIDADE'),tcReal);
  CdsItens.FieldByName('NOME').ProviderFlags := [];
  CdsItens.FieldByName('CODIGO').ProviderFlags := [];
  CdsItens.FieldByName('FLAGEDICAO').ProviderFlags := [];
  CdsItens.FieldByName('NOMEUNIDADE').ProviderFlags := [];
  CdsItens.FieldByName('UNIDADEORIGINAL').ProviderFlags := [];
end;


procedure TfrmCad_Servico.CdsItensAfterPost(DataSet: TDataSet);
begin
  inherited;
  CalculaTotal;
end;

procedure TfrmCad_Servico.CdsItensBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (CdsItens.FieldByName('FLAGEDICAO').AsString = 'N') AND (CdsItens.State = dsEdit) then
    CdsItens.FieldByName('FLAGEDICAO').AsString := 'E';

end;

procedure TfrmCad_Servico.CdsItensNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsItens.FieldByName('IDSERVICO').AsString := CdsCadastro.FieldByName('IDSERVICO').AsString ;
  CdsItens.FieldByName('IDSERVICODETALHE').AsString := GetCodigo(tpCsServicosDetalhe);
  CdsItens.FieldByName('FLAGEDICAO').AsString := 'I';
end;

procedure TfrmCad_Servico.CdsRevisaoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsRevisao.FieldByName('VALORTOTALLIQUIDO'), tcMoeda);
end;

procedure TfrmCad_Servico.FormShow(Sender: TObject);
begin
  inherited;
  MontaGrid(TvRevisao, 'NUMVERSAO','Versão', tcInt);
  MontaGrid(TvRevisao, 'DATACRIACAO','Data', tcCampoData);
  MontaGrid(TvRevisao, 'HORACRIACAO','Hora', tcHora);
  MontaGrid(TvRevisao, 'VALORTOTALLIQUIDO','Valor do documento', tcMoeda, 100);
  MontaGrid(TvRevisao, 'FLAGCANCELADO','Cancelado', tcString);
  MontaGrid(TvRevisao, 'LOGIN','Usuário', tcString);

  ConfiguraEditPesquisa(edtCliente,CdsCadastro,tpCSCliente,True);
  ConfiguraEditPesquisa(edtConta,CdsCadastro,tpCSConta);
  edtConta.TamanhoCodigo := 3;
  edtCliente.Localiza;
  edtConta.Localiza;
  actAddEquipamento.Visible := GetPermissao(IdListagemServicoAddEquipamento);
  actAddEquipamento.Enabled := actAddEquipamento.Visible ;

  actEditarEquipamento.Visible := GetPermissao(IdListagemServicoEditarEquipamento);
  actEditarEquipamento.Enabled := actEditarEquipamento.Visible ;

  actDelEquipamento.Visible := GetPermissao(IdListagemServicoExcluirEquipamento);
  actDelEquipamento.Enabled := actDelEquipamento.Visible ;

end;

procedure TfrmCad_Servico.CdsEquipamentoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsEquipamento.FieldByName('VALOR'), tcMoeda);
  FormataMascara(CdsEquipamento.FieldByName('TOTAL'), tcMoeda);
end;

procedure TfrmCad_Servico.CdsEquipamentoAfterPost(DataSet: TDataSet);
begin
  inherited;
  CalculaTotal;
end;

procedure TfrmCad_Servico.CdsEquipamentoBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (CdsEquipamento.FieldByName('FLAGEDICAO').AsString = 'N') AND (CdsEquipamento.State = dsEdit) then
    CdsEquipamento.FieldByName('FLAGEDICAO').AsString := 'E';
end;

procedure TfrmCad_Servico.CdsEquipamentoNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsEquipamento.FieldByName('IDSERVICO').AsString := CdsCadastro.FieldByName('IDSERVICO').AsString ;
  CdsEquipamento.FieldByName('IDSAIDAEQUIPAMENTO').AsString := GetCodigo(tpCSSaidaEquipamento);
  CdsEquipamento.FieldByName('FLAGEDICAO').AsString := 'I';
end;

end.
