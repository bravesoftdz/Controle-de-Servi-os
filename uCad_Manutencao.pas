unit uCad_Manutencao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCad_CadastroPaiCS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ComCtrls, Menus, DB, DBClient, pFIBClientDataSet,
  ActnList, cxPC, cxContainer, cxEdit, cxTreeView, Buttons, ExtCtrls, StdCtrls,
  Mask, EditPesquisa, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxDBEdit, DBCtrls, LabelDBEdit, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
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
  TfrmCad_manutencao = class(TfrmCad_CadastroPaiCS)
    Panel2: TPanel;
    edtData: TcxDBDateEdit;
    Label1: TLabel;
    edtEquipamento: TEditPesquisa;
    edtMarcador: TLabelDBEdit;
    edtLocal: TEditPesquisa;
    edtCliente: TEditPesquisa;
    GroupBox1: TGroupBox;
    cxTabSheet1: TcxTabSheet;
    GroupBox2: TGroupBox;
    DBMemo1: TDBMemo;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    cxGrid1: TcxGrid;
    TvItens: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    DataItens: TDataSource;
    CdsItens: TpFIBClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
    procedure CdsItensNewRecord(DataSet: TDataSet);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure edtEquipamentoRegAchado(ADataSet: TDataSet);
    procedure edtMarcadorExit(Sender: TObject);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
    procedure CdsItensBeforePost(DataSet: TDataSet);
    procedure BitBtn3Click(Sender: TObject);
  private
    FIdEquipamento: String;
    { Private declarations }
    Procedure VerificaManutencaoPecas;
  public
    { Public declarations }
    property IdEquipamento: String read FIdEquipamento write FIdEquipamento;

  end;

var
  frmCad_manutencao: TfrmCad_manutencao;

implementation

uses MinhasClasses, Comandos, udlg_CompraEquipamentosItens;

{$R *.dfm}

procedure TfrmCad_manutencao.BitBtn1Click(Sender: TObject);
begin
  inherited;
  MudaEstado;
  frmDlg_CompraEquipamentoItens := TfrmDlg_CompraEquipamentoItens.Create(nil);
  Try
    frmDlg_CompraEquipamentoItens.pDataSet := Self.CdsItens;
    frmDlg_CompraEquipamentoItens.TipoForm := tfMaterial;
//    frmDlg_CompraEquipamentoItens.edtTotal.Visible := False;
//    frmDlg_CompraEquipamentoItens.edtValor.Visible := False;
    frmDlg_CompraEquipamentoItens.pDataSet.Append;
    frmDlg_CompraEquipamentoItens.ShowModal;

  Finally
    FreeAndNil(frmDlg_CompraEquipamentoItens);
  End;
end;

procedure TfrmCad_manutencao.BitBtn2Click(Sender: TObject);
begin
  inherited;
  MudaEstado;
  frmDlg_CompraEquipamentoItens := TfrmDlg_CompraEquipamentoItens.Create(nil);
  Try
    frmDlg_CompraEquipamentoItens.pDataSet := Self.CdsItens;
    frmDlg_CompraEquipamentoItens.TipoForm := tfMaterial;
    frmDlg_CompraEquipamentoItens.pDataSet.Edit;
    frmDlg_CompraEquipamentoItens.ShowModal;

  Finally
    FreeAndNil(frmDlg_CompraEquipamentoItens);
  End;
end;

procedure TfrmCad_manutencao.BitBtn3Click(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  begin
    CdsItens.Edit;
    CdsItens.FieldByName('FLAGEDICAO').AsString := 'D';
    CdsItens.Post;
  end;

end;

procedure TfrmCad_manutencao.CdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsCadastro.FieldByName('MARCADOR'),tcReal);
end;

procedure TfrmCad_manutencao.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  SetRegistros(CdsItens,tpCSManutencaoPecas);
end;

procedure TfrmCad_manutencao.CdsCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  SetCds(CdsItens,tpCSManutencaoPecas, 'IDMANUTENCAO = '+ValorChave)
end;

procedure TfrmCad_manutencao.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('DATA').AsString := GetDataServidor;
  CdsCadastro.FieldByName('HORA').AsString := GetHoraServidor;
  CdsCadastro.FieldByName('DATAMANUTENCAO').AsString := GetDataServidor;
end;

procedure TfrmCad_manutencao.CdsItensBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CdsItens.FieldByName('FLAGEDICAO').AsString = 'N' then
    CdsItens.FieldByName('FLAGEDICAO').AsString := 'E';
end;

procedure TfrmCad_manutencao.CdsItensNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsItens.FieldByName('FLAGEDICAO').AsString := 'I';
  CdsItens.FieldByName('IDMANUTENCAOPECAS').AsString := GetCodigo(tpCSManutencaoPecas);
  CdsItens.FieldByName('IDMANUTENCAO').AsString := ValorChave;
end;

procedure TfrmCad_manutencao.edtEquipamentoRegAchado(ADataSet: TDataSet);
begin
  inherited;
  if CdsCadastro.State in [dsEdit, dsInsert] then
  begin
    if (CdsCadastro.FieldByName('MARCADORATUAL').IsNull) or (CdsCadastro.FieldByName('idequipamento').OldValue <> edtEquipamento.ValorChaveString) then
      CdsCadastro.FieldByName('MARCADORATUAL').Value := GetValorCds(tpCSEquipamento,'idequipamento = '+edtEquipamento.ValorChaveString,'MARCADOR');
  end;

end;

procedure TfrmCad_manutencao.FormActivate(Sender: TObject);
begin
  inherited;
  edtData.SetFocus;
end;

procedure TfrmCad_manutencao.FormShow(Sender: TObject);
begin
  inherited;
  MontaGrid(TvItens,'CODIGO','Código',tcString,70);
  MontaGrid(TvItens,'NOMEMATERIAL','Material',tcString,150);
  MontaGrid(TvItens,'QUANTIDADE','Quantidade',tcReal,60);
  MontaGrid(TvItens,'VALOR','Valor',tcMoeda,70);
  MontaGrid(TvItens,'TOTAL','Total',tcMoeda,100);
  ConfiguraEditPesquisa(edtCliente,CdsCadastro,tpCsCliente);
  ConfiguraEditPesquisa(edtEquipamento,CdsCadastro,tpCSEquipamento,True);
  ConfiguraEditPesquisa(edtLocal,CdsCadastro,tpCSLocalEstoque);

  if IdEquipamento <> '' Then
  begin
    CdsCadastro.FieldByName('IDEQUIPAMENTO').Value := IdEquipamento;
    edtEquipamento.Localiza;
  end;
end;

procedure TfrmCad_manutencao.VerificaManutencaoPecas;
var
  StrSQL: String;
begin
  StrSQL :=
    'SELECT M.CODIGO, M.NOMEMATERIAL, E.QUANTIDADE, M.PERIODOMANUTENCAO,EQ.MARCADOR,M.VALORCUSTO,'+
    '       M.VALORCUSTO * E.QUANTIDADE TOTAL,M.CODIGO, M.NOMEMATERIAL,M.IDMATERIAL, COALESCE(M.ESTOQUETOTAL,0)ESTOQUETOTAL  '+
    '  FROM EQUIPAMENTOARVORE E'+
    ' INNER JOIN MATERIAL M'+
    '    ON (M.IDMATERIAL = E.IDMATERIAL)'+
    ' INNER JOIN EQUIPAMENTO EQ'+
    '    ON (EQ.IDEQUIPAMENTO = E.IDEQUIPAMENTO)'+
    ' WHERE E.IDEQUIPAMENTO = '+CdsCadastro.FieldByName('IDEQUIPAMENTO').AsString+
    '   AND ((('+GetNumber(StrToFloatDef(edtMarcador.Text,0))+' - EQ.MARCADOR) >= M.PERIODOMANUTENCAO) or ('+GetNumber(StrToFloatDef(edtMarcador.Text,0))+'  >= M.PERIODOMANUTENCAO) ) ';
  with GetCds(StrSQL) do
  begin
    if not IsEmpty then
    begin
      Avisa('Existem peças que devem sofrer manutenção.');
      First;
      while not Eof do
      begin
        if FieldByName('ESTOQUETOTAL').AsCurrency <= 0 then
        begin
           Avisa('Não existe quantidade suficiente do material '+FieldByName('NOMEMATERIAL').AsString+'  no estoque.');
           Next;
           Continue;
        end;
        CdsItens.Append;
        CdsItens.FieldByName('IDMATERIAL').Value := FieldByName('IDMATERIAL').Value;
        CdsItens.FieldByName('QUANTIDADE').Value := FieldByName('QUANTIDADE').Value;
        CdsItens.FieldByName('TOTAL').Value := FieldByName('TOTAL').Value;
        CdsItens.FieldByName('VALOR').Value := FieldByName('VALORCUSTO').Value;
        CdsItens.FieldByName('NOMEMATERIAL').Value := FieldByName('NOMEMATERIAL').Value;
        CdsItens.FieldByName('CODIGO').Value := FieldByName('CODIGO').Value;
        CdsItens.Post;
        Next;
      end;
    end;


    Free;
  end;

end;

procedure TfrmCad_manutencao.edtMarcadorExit(Sender: TObject);
begin
  inherited;
  if CdsCadastro.FieldByName('MARCADOR').AsCurrency <  CdsCadastro.FieldByName('MARCADORATUAL').AsCurrency  then
  begin
    if not Pergunta('Esse marcador é menor que o atual( '+CdsCadastro.FieldByName('MARCADORATUAL').AsString+'). Deseja continuar?' ) then
      edtMarcador.SetFocus;

  end;
  VerificaManutencaoPecas;
end;

end.
