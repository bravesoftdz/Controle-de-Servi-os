unit uLst_GrupoEquipamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uLstCadastroSimplesCS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxTL, cxTLdxBarBuiltInMenu, DBClient,
  pFIBClientDataSet, Menus, ActnList, cxInplaceContainer, cxTLData, cxDBTL,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxPC, ComCtrls, ToolWin, StdCtrls,
  Buttons, Mask, DBCtrls, LabelDBEdit, cxSplitter, ExtCtrls, Grids, DBGrids,
  cxNavigator, cxDBNavigator;

type
  TfrmLst_GrupoEquipamento = class(TfrmLstCadastroSimplesCS)
    GroupBox1: TGroupBox;
    GridEsp: TDBGrid;
    DataEspecificacao: TDataSource;
    CdsEspecificacao: TpFIBClientDataSet;
    cxDBNavigator1: TcxDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure CdsEspecificacaoNewRecord(DataSet: TDataSet);
    procedure CdsEspecificacaoBeforePost(DataSet: TDataSet);
    procedure CdsEspecificacaoBeforeDelete(DataSet: TDataSet);
    procedure CdsEspecificacaoBeforeEdit(DataSet: TDataSet);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLst_GrupoEquipamento: TfrmLst_GrupoEquipamento;

implementation

uses MinhasClasses, Comandos;

{$R *.dfm}

procedure TfrmLst_GrupoEquipamento.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  SetRegistros(CdsEspecificacao, tpCSGrupoEquipamentoEspecificacao);
end;

procedure TfrmLst_GrupoEquipamento.CdsCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if ValorChave <> '' then
    SetCds(CdsEspecificacao,tpCSGrupoEquipamentoEspecificacao, CampoChave+' = '+ValorChave);
end;

procedure TfrmLst_GrupoEquipamento.CdsEspecificacaoBeforeDelete(
  DataSet: TDataSet);
begin
  inherited;
  MudaEstado;
  if ConfirmaDel then
  Begin
    CdsEspecificacao.Edit;
    CdsEspecificacao.FieldByName('FLAGEDICAO').AsString := 'D';
    CdsEspecificacao.Post;
    Abort;

  End;
end;

procedure TfrmLst_GrupoEquipamento.CdsEspecificacaoBeforeEdit(
  DataSet: TDataSet);
begin
  inherited;
  MudaEstado;
end;

procedure TfrmLst_GrupoEquipamento.CdsEspecificacaoBeforePost(
  DataSet: TDataSet);
begin
  inherited;
  if (CdsEspecificacao.State = dsEdit) and (CdsEspecificacao.FieldByName('FLAGEDICAO').AsString = 'N') then
     CdsEspecificacao.FieldByName('FLAGEDICAO').AsString := 'E';

end;

procedure TfrmLst_GrupoEquipamento.CdsEspecificacaoNewRecord(DataSet: TDataSet);
begin
  inherited;
  MudaEstado;
  CdsEspecificacao.FieldByName(CampoChave).AsString := ValorChave;
  CdsEspecificacao.FieldByName('IDGRUPOESPECIFICACAO').AsString := GetCodigo(tpCSGrupoEquipamentoEspecificacao);
  CdsEspecificacao.FieldByName('FLAGEDICAO').AsString := 'I';
  GridEsp.SetFocus;
end;

procedure TfrmLst_GrupoEquipamento.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpCSGrupoEquipamento;
end;

end.
