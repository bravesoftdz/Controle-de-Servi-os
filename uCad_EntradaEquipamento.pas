unit uCad_EntradaEquipamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCad_CadastroPaiCS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ComCtrls, cxContainer, cxEdit, StdCtrls, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, Menus, DB, DBClient,
  pFIBClientDataSet, ActnList, cxPC, cxTreeView, Buttons, ExtCtrls, DBCtrls,
  LabelDBEdit, Mask, EditPesquisa, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid;

type
  TfrmCad_EntradaEquipamento = class(TfrmCad_CadastroPaiCS)
    Panel2: TPanel;
    edtData: TcxDBDateEdit;
    Label1: TLabel;
    edtCliente: TEditPesquisa;
    LabelDBEdit1: TLabelDBEdit;
    edtRecibo: TEditPesquisa;
    edtLocalEstoque: TEditPesquisa;
    GroupBox1: TGroupBox;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    CdsItens: TpFIBClientDataSet;
    DataItens: TDataSource;
    cxGrid1: TcxGrid;
    TvItens: TcxGridDBTableView;
    vItensColumn1: TcxGridDBColumn;
    vItensColumn2: TcxGridDBColumn;
    vItensColumn3: TcxGridDBColumn;
    vItensColumn5: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    vItensColumn6: TcxGridDBColumn;
    vItensColumn4: TcxGridDBColumn;
    vItensColumn7: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
    procedure edtClienteRegAchado(ADataSet: TDataSet);
    procedure CdsItensNewRecord(DataSet: TDataSet);
    procedure CdsItensBeforePost(DataSet: TDataSet);
    procedure edtReciboRegAchado(ADataSet: TDataSet);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure actGravarExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_EntradaEquipamento: TfrmCad_EntradaEquipamento;

implementation

uses MinhasClasses, Comandos, uDlg_SaidaEquipamento, uDlg_EntradaEquipamento;

{$R *.dfm}

procedure TfrmCad_EntradaEquipamento.actGravarExecute(Sender: TObject);
begin
  VerificaEdits := True;
  inherited;

end;

procedure TfrmCad_EntradaEquipamento.BitBtn1Click(Sender: TObject);
begin
  inherited;
  MudaEstado;
  frmDlg_EntradaEquipamento := TfrmDlg_EntradaEquipamento.Create(nil);
  Try
    frmDlg_EntradaEquipamento.pDataSet := Self.CdsItens;
    frmDlg_EntradaEquipamento.pDataSet.Append;
    frmDlg_EntradaEquipamento.ShowModal;
  Finally
    FreeAndNil(frmDlg_EntradaEquipamento);
  End;
end;

procedure TfrmCad_EntradaEquipamento.BitBtn2Click(Sender: TObject);
begin
  inherited;
  MudaEstado;
  frmDlg_EntradaEquipamento := TfrmDlg_EntradaEquipamento.Create(nil);
  Try
    frmDlg_EntradaEquipamento.pDataSet := Self.CdsItens;
    frmDlg_EntradaEquipamento.pDataSet.Edit;
    frmDlg_EntradaEquipamento.ShowModal;
  Finally
    FreeAndNil(frmDlg_EntradaEquipamento);
  End;
end;

procedure TfrmCad_EntradaEquipamento.BitBtn3Click(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  Begin
     MudaEstado;
     CdsItens.Edit;
     CdsItens.FieldByName('FLAGEDICAO').AsString := 'D';
     CdsItens.Post;
  End;
end;

procedure TfrmCad_EntradaEquipamento.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  SetRegistros(CdsItens, tpCSEntradaEquipamentoItens);
end;

procedure TfrmCad_EntradaEquipamento.CdsCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  SetCds(CdsItens,tpCSEntradaEquipamentoItens,'IDENTRADAEQUIPAMENTO = '+ValorChave);
end;

procedure TfrmCad_EntradaEquipamento.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('DATA').AsString := GetDataServidor;
  CdsCadastro.FieldByName('HORA').AsString := GetHoraServidor;
  CdsCadastro.FieldByName('DATAENTRADA').AsString := GetDataServidor;
end;

procedure TfrmCad_EntradaEquipamento.CdsItensBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (CdsItens.FieldByName('FLAGEDICAO').AsString = 'N') AND (CdsItens.State = dsEdit) then
    CdsItens.FieldByName('FLAGEDICAO').AsString := 'E';
end;

procedure TfrmCad_EntradaEquipamento.CdsItensNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsItens.FieldByName('IDENTRADAEQUIPAMENTOITENS').AsString := GetCodigo(tpCSEntradaEquipamentoItens);
  CdsItens.FieldByName('IDENTRADAEQUIPAMENTO').AsString := ValorChave;
  CdsItens.FieldByName('FLAGEDICAO').AsString := 'I';

end;

procedure TfrmCad_EntradaEquipamento.edtClienteRegAchado(ADataSet: TDataSet);
begin
  inherited;
  edtRecibo.SQLComp := ' S.IDCLIENTE = '+edtCliente.ValorChaveString;
end;

procedure TfrmCad_EntradaEquipamento.edtReciboRegAchado(ADataSet: TDataSet);
begin
  inherited;
  if CdsCadastro.State in [dsEdit, dsInsert] then
    CdsCadastro.FieldByName('DOCUMENTO').AsString := PadL(edtRecibo.Text,6,'0');
end;

procedure TfrmCad_EntradaEquipamento.FormActivate(Sender: TObject);
begin
  inherited;
  edtData.SetFocus;
end;

procedure TfrmCad_EntradaEquipamento.FormCreate(Sender: TObject);
begin
  inherited;
 // TipoPesquisa := tpCSEntradaEquipamento;
end;

procedure TfrmCad_EntradaEquipamento.FormShow(Sender: TObject);
begin
  inherited;
  ConfiguraEditPesquisa(edtCliente,CdsCadastro,tpCsCliente,True);
  ConfiguraEditPesquisa(edtRecibo,CdsCadastro,tpCsServicos,False);
//  edtRecibo.NomeTabela := 'SERVICO S';
  edtRecibo.SQLComp := ' S.IDCLIENTE = '+edtCliente.ValorChaveString;
  ConfiguraEditPesquisa(edtLocalEstoque,CdsCadastro,tpCSLocalEstoque);


end;

end.
