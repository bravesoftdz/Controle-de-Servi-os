unit uCad_CompraEquipamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCad_CadastroPaiCS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ComCtrls, Menus, DB, DBClient, pFIBClientDataSet,
  ActnList, cxPC, cxContainer, cxEdit, cxTreeView, Buttons, ExtCtrls, DBCtrls,
  LabelDBEdit, StdCtrls, Mask, EditPesquisa, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxDBEdit, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter;

type
  TfrmCad_CompraEquipamento = class(TfrmCad_CadastroPaiCS)
    cxTabSheet1: TcxTabSheet;
    GroupBox1: TGroupBox;
    DBMemo1: TDBMemo;
    Panel2: TPanel;
    edtTotalNota: TLabelDBEdit;
    edtDoc: TLabelDBEdit;
    edtData: TcxDBDateEdit;
    edtFornecedor: TEditPesquisa;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    DataItens: TDataSource;
    CdsItens: TpFIBClientDataSet;
    TvItens: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    vItensColumn1: TcxGridDBColumn;
    vItensColumn2: TcxGridDBColumn;
    vItensColumn3: TcxGridDBColumn;
    vItensColumn4: TcxGridDBColumn;
    vItensColumn5: TcxGridDBColumn;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
    procedure CdsItensNewRecord(DataSet: TDataSet);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure CdsItensBeforePost(DataSet: TDataSet);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure CdsItensAfterOpen(DataSet: TDataSet);
    procedure actGravarExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_CompraEquipamento: TfrmCad_CompraEquipamento;

implementation

uses Comandos, MinhasClasses, udlg_CompraEquipamentosItens;

{$R *.dfm}

procedure TfrmCad_CompraEquipamento.actGravarExecute(Sender: TObject);
var
  Soma: Currency;
begin
 ActiveControl :=nil;

 CdsItens.First;
 Soma := 0;
 while not CdsItens.Eof  do
 begin
   if TipoPesquisa = tpCSEntradaMaterial then
     Soma := Soma + CdsItens.FieldByName('total').AsCurrency
   else
     Soma := Soma + CdsItens.FieldByName('valor').AsCurrency ;
   CdsItens.Next;
 end;
 if soma <> CdsCadastro.FieldByName('TOTALNOTA').AsCurrency then
 begin
   Avisa('O total da nota difere da somatória dos itens');
   edtTotalNota.SetFocus;
   Abort;
 end;

 if ExisteRegistro(CdsCadastro,'DOCUMENTO') Then
  begin
    Avisa('Esse documento já foi criado para esse fornecedor.');
    edtDoc.SetFocus;
  end else
    inherited;

end;

procedure TfrmCad_CompraEquipamento.BitBtn1Click(Sender: TObject);
begin
  inherited;
  MudaEstado;
  frmDlg_CompraEquipamentoItens := TfrmDlg_CompraEquipamentoItens.Create(nil);
  Try
    frmDlg_CompraEquipamentoItens.pDataSet := Self.CdsItens;
    if TipoPesquisa = tpCSCompraEquipamento then
      frmDlg_CompraEquipamentoItens.TipoForm := tfEquipamento
    else
      frmDlg_CompraEquipamentoItens.TipoForm := tfMaterial;
    frmDlg_CompraEquipamentoItens.pDataSet.Append;
    frmDlg_CompraEquipamentoItens.ShowModal;

  Finally
    FreeAndNil(frmDlg_CompraEquipamentoItens);
  End;
end;

procedure TfrmCad_CompraEquipamento.BitBtn2Click(Sender: TObject);
begin
  inherited;
  MudaEstado;
  frmDlg_CompraEquipamentoItens := TfrmDlg_CompraEquipamentoItens.Create(nil);
  Try
    frmDlg_CompraEquipamentoItens.pDataSet := Self.CdsItens;
    if TipoPesquisa = tpCSCompraEquipamento then
      frmDlg_CompraEquipamentoItens.TipoForm := tfEquipamento
    else
      frmDlg_CompraEquipamentoItens.TipoForm := tfCompraMaterial;
    frmDlg_CompraEquipamentoItens.pDataSet.Edit;
    frmDlg_CompraEquipamentoItens.ShowModal;

  Finally
    FreeAndNil(frmDlg_CompraEquipamentoItens);
  End;
end;

procedure TfrmCad_CompraEquipamento.BitBtn3Click(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  begin
    MudaEstado;
    CdsItens.Edit;
    CdsItens.FieldByName('FLAGEDICAO').AsString := 'D';
    CdsItens.Post;
  end;

end;

procedure TfrmCad_CompraEquipamento.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  if TipoPesquisa = tpCSEntradaMaterial then
    SetRegistros(CdsItens,tpCSEntradaMaterialItem)
  else
    SetRegistros(CdsItens,tpCSCompraEquipamentoItens);

end;

procedure TfrmCad_CompraEquipamento.CdsCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if TipoPesquisa = tpCSEntradaMaterial then
    SetCds(CdsItens,tpCSEntradaMaterialItem, 'IDENTRADAMATERIAL = '+ValorChave)
  else
    SetCds(CdsItens,tpCSCompraEquipamentoItens, 'IDCOMPRAEQUIPAMENTO = '+ValorChave);

end;

procedure TfrmCad_CompraEquipamento.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('DATA').AsString := GetDataServidor;
  CdsCadastro.FieldByName('HORA').AsString := GetHoraServidor;
  CdsCadastro.FieldByName('DATANOTA').AsString := GetDataServidor;
end;

procedure TfrmCad_CompraEquipamento.CdsItensAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsItens.FieldByName('VALOR'), tcMoeda);
end;

procedure TfrmCad_CompraEquipamento.CdsItensBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (CdsItens.State = dsEdit) and (CdsItens.FieldByName('FLAGEDICAO').AsString = 'N') then
    CdsItens.FieldByName('FLAGEDICAO').AsString := 'E';

end;

procedure TfrmCad_CompraEquipamento.CdsItensNewRecord(DataSet: TDataSet);
begin
  inherited;
  if TipoPesquisa = tpCSEntradaMaterial then
  BEGIN
    CdsItens.FieldByName('IDENTRADAMATERIALITEM').AsString := GetCodigo(tpCSEntradaMaterialItem);
    CdsItens.FieldByName('IDENTRADAMATERIAL').AsString := ValorChave;
  END else
  begin
    CdsItens.FieldByName('IDCOMPRAEQUIPAMENTOITENS').AsString := GetCodigo(tpCSCompraEquipamentoItens);
    CdsItens.FieldByName('IDCOMPRAEQUIPAMENTO').AsString := ValorChave;
  end;
  CdsItens.FieldByName('FLAGEDICAO').AsString := 'I';

end;

procedure TfrmCad_CompraEquipamento.FormActivate(Sender: TObject);
begin
  inherited;
  edtData.SetFocus;
end;

procedure TfrmCad_CompraEquipamento.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpCsCompraEquipamento;
end;

procedure TfrmCad_CompraEquipamento.FormShow(Sender: TObject);
begin
  inherited;
  ConfiguraEditPesquisa(edtFornecedor,CdsCadastro,tpCSFornecedor,True);
  edtFornecedor.Localiza;
  if TipoPesquisa = tpCSEntradaMaterial then
  begin
    TvItens.ClearItems;
    Self.Caption := 'Entrada de material' ;
    MontaGrid(TvItens,'CODIGO','Código',tcString,70);
    MontaGrid(TvItens,'NOMEMATERIAL','Material',tcString,150);
    MontaGrid(TvItens,'QUANTIDADE','Quantidade',tcReal,60);
    MontaGrid(TvItens,'VALOR','Valor',tcMoeda,70);
    MontaGrid(TvItens,'TOTAL','Total',tcMoeda,100);
  end;

end;

ENd.
