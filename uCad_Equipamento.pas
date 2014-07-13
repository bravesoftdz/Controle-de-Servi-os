unit uCad_Equipamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCad_CadastroPaiCS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ComCtrls, Menus, DB, DBClient, pFIBClientDataSet,
  ActnList, cxPC, cxContainer, cxEdit, cxTreeView, Buttons, ExtCtrls, StdCtrls,
  Mask, DBCtrls, LabelDBEdit, EditPesquisa, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxGridCardView, cxGridDBCardView, Grids, DBGrids;

type
  TfrmCad_Equipamento = class(TfrmCad_CadastroPaiCS)
    edtCodigo: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    edtGrupo: TEditPesquisa;
    edtMarca: TEditPesquisa;
    edtCombustivel: TEditPesquisa;
    LabelDBEdit1: TLabelDBEdit;
    edtStatus: TEditPesquisa;
    EdtIdentificador: TLabelDBEdit;
    GroupBox1: TGroupBox;
    DBMemo1: TDBMemo;
    DBCheckBox1: TDBCheckBox;
    GroupBox2: TGroupBox;
    LabelDBEdit3: TLabelDBEdit;
    edtValorTotal: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    LabelDBEdit5: TLabelDBEdit;
    LabelDBEdit6: TLabelDBEdit;
    LabelDBEdit7: TLabelDBEdit;
    DBCheckBox2: TDBCheckBox;
    cxTabSheet1: TcxTabSheet;
    GroupBox3: TGroupBox;
    DataArvore: TDataSource;
    CdsArvore: TpFIBClientDataSet;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxTabSheet2: TcxTabSheet;
    GroupBox4: TGroupBox;
    CdsEspecificacao: TpFIBClientDataSet;
    DataEspecificacao: TDataSource;
    DBGrid: TDBGrid;
    edtStatus2: TEditPesquisa;
    LabelDBEdit8: TLabelDBEdit;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    btnAjustarMarcador: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
    procedure actNovoExecute(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
    procedure LabelDBEdit6Enter(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure CdsArvoreNewRecord(DataSet: TDataSet);
    procedure CdsArvoreBeforePost(DataSet: TDataSet);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure CdsArvoreAfterOpen(DataSet: TDataSet);
    procedure CdsEspecificacaoBeforePost(DataSet: TDataSet);
    procedure CdsEspecificacaoNewRecord(DataSet: TDataSet);
    procedure actPesquisarExecute(Sender: TObject);
    procedure DBGridColEnter(Sender: TObject);
    procedure CdsEspecificacaoBeforeEdit(DataSet: TDataSet);
    procedure edtGrupoRegAchado(ADataSet: TDataSet);
    procedure btnAjustarMarcadorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_Equipamento: TfrmCad_Equipamento;

implementation

uses MinhasClasses, Comandos, uRelEquipamento,
  uDlg_ArvorePeca, UDmConexao, uPesquisaEquipamento, uSQLCS, uSQL,
  uCad_Manutencao;

{$R *.dfm}

procedure TfrmCad_Equipamento.actGravarExecute(Sender: TObject);
begin
   VerificaEdits := True;
   VerificaEdit(edtGrupo,'Informe o grupo');

  if GetTableCount('EQUIPAMENTO','*','IDGRUPOEQUIPAMENTO ='+edtGrupo.ValorChaveString+' AND IDENTIFICADOR = '+QuotedStr(EdtIdentificador.Text)+' AND IDEQUIPAMENTO <> '+VALORCHAVE) > 0 then
  Begin
    EdtIdentificador.SetFocus;
    AvisaErro('Esse identificador já existe para esse grupo');
  End;

  inherited;

end;

procedure TfrmCad_Equipamento.actImprimirExecute(Sender: TObject);
begin
  inherited;
  Try
    frmRelEquipamento := TfrmRelEquipamento.Create(nil);
    frmRelEquipamento.ShowModal;
  Finally
    FreeAndNil(frmRelEquipamento);
  End;
end;

procedure TfrmCad_Equipamento.actNovoExecute(Sender: TObject);
begin
  inherited;
  edtCodigo.SetFocus;
end;

procedure TfrmCad_Equipamento.actPesquisarExecute(Sender: TObject);
var
  vAfterScroll : TDataSetNotifyEvent;
begin
 // inherited;
  Try
    vAfterScroll := CdsCadastro.AfterScroll;
    CdsCadastro.AfterScroll := nil;
    frmPesquisaEquipamento := TfrmPesquisaEquipamento.Create(Self);
    with frmPesquisaEquipamento do
    Begin
      TipoPesquisa := Self.TipoPesquisa;
      if ShowModal = mrOk then
      Begin
        ValorChave := CdsPesquisa.FieldByName(CampoChave).AsString;
        SetCds(CdsCadastro, GetSelect(TipoPesquisa, CampoChave+' = '+GetValorChave(psIgual)));
      End;
    End;
  Finally
    CdsCadastro.AfterScroll := vAfterScroll;
    if Assigned(vAfterScroll) then
      vAfterScroll(CdsCadastro);
    FreeAndNil(frmPesquisaEquipamento);
  End;
end;

procedure TfrmCad_Equipamento.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  SetRegistros(CdsArvore, tpCSEquipamentoArvore);
  SetRegistros(CdsEspecificacao, tpCSEquipamentoEspecificacao);
end;

procedure TfrmCad_Equipamento.CdsCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if ValorChave <> '' then
    SetCds(CdsArvore, tpCSEquipamentoArvore, 'ES.IDEQUIPAMENTO = '+ValorChave);
  if CdsCadastro.FieldByName('IDGRUPOEQUIPAMENTO').AsString <> '' then
    SetCds(CdsEspecificacao, tpCSEquipamentoEspecificacao,
             'G.IDGRUPOEQUIPAMENTO  = '+CdsCadastro.FieldByName('IDGRUPOEQUIPAMENTO').AsString , nil,
             '   AND EE.IDEQUIPAMENTO = '+ValorChave);

end;

procedure TfrmCad_Equipamento.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('DATACADASTRO').AsString := GetDataServidor;
  CdsCadastro.FieldByName('FLAGINATIVO').AsString := 'N';
  CdsCadastro.FieldByName('FLAGQUITADO').AsString := 'N';
end;

procedure TfrmCad_Equipamento.CdsEspecificacaoBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  MudaEstado;
end;

procedure TfrmCad_Equipamento.CdsEspecificacaoBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (CdsEspecificacao.State = dsEdit) and (CdsEspecificacao.FieldByName('FLAGEDICAO').AsString = 'N') and (CdsEspecificacao.FieldByName('IDEQUIPAMENTOESPECIFICACAO').AsString <> '') then
     CdsEspecificacao.FieldByName('FLAGEDICAO').AsString := 'E';
  if (CdsEspecificacao.State = dsEdit) and (CdsEspecificacao.FieldByName('FLAGEDICAO').AsString = 'N') and (CdsEspecificacao.FieldByName('IDEQUIPAMENTOESPECIFICACAO').AsString = '') then
  Begin
    CdsEspecificacao.FieldByName('FLAGEDICAO').AsString := 'I';
    CdsEspecificacao.FieldByName('IDEQUIPAMENTOESPECIFICACAO').AsString := GetCodigo(tpCSEquipamentoEspecificacao);
    CdsEspecificacao.FieldByName('IDEQUIPAMENTO').AsString := ValorChave;
  End;

end;

procedure TfrmCad_Equipamento.CdsEspecificacaoNewRecord(DataSet: TDataSet);
begin
  inherited;
  Abort;

end;

procedure TfrmCad_Equipamento.DBGridColEnter(Sender: TObject);
begin
  inherited;
  DBGrid.SelectedIndex := 1;

end;

procedure TfrmCad_Equipamento.edtGrupoRegAchado(ADataSet: TDataSet);
begin
  inherited;
  if (Alterando) and (not edtGrupo.IsNull) and (edtGrupo.ValorChaveString <> CdsCadastro.FieldByName('IDGRUPOEQUIPAMENTO').OldValue) then
  Begin
    SetCds(CdsEspecificacao, tpCSEquipamentoEspecificacao,
             'G.IDGRUPOEQUIPAMENTO  = '+edtGrupo.ValorChaveString,nil,
             '   AND EE.IDEQUIPAMENTO = '+ValorChave);
  End;
end;

procedure TfrmCad_Equipamento.CdsArvoreAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsArvore.FieldByName('QUANTIDADE'), tcReal);
end;

procedure TfrmCad_Equipamento.CdsArvoreBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (CdsArvore.State = dsEdit) and (CdsArvore.FieldByName('FLAGEDICAO').AsString = 'N') then
     CdsArvore.FieldByName('FLAGEDICAO').AsString := 'E';

end;

procedure TfrmCad_Equipamento.CdsArvoreNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsArvore.FieldByName('IDEQUIPAMENTOARVORE').AsString := GetCodigo(tpCSEquipamentoArvore);
  CdsArvore.FieldByName('IDEQUIPAMENTO').AsString := ValorChave;
  CdsArvore.FieldByName('FLAGEDICAO').AsString := 'I';
end;

procedure TfrmCad_Equipamento.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpCSEquipamento;
  ConfiguraEditPesquisa(edtGrupo,CdsCadastro,tpCSGrupoEquipamento,True);
  ConfiguraEditPesquisa(edtMarca,CdsCadastro,tpCSMarca);
  ConfiguraEditPesquisa(edtCombustivel,CdsCadastro,tpCSCombustivel);
  ConfiguraEditPesquisa(edtStatus,CdsCadastro,tpCSStatusEquipamento);
  ConfiguraEditPesquisa(edtStatus2,CdsCadastro,tpCSStatusEquipamento, False,'','','','IDSTATUSEQUIPAMENTO2');
end;

procedure TfrmCad_Equipamento.LabelDBEdit6Enter(Sender: TObject);
begin
  inherited;
  if CdsCadastro.State in [dsEdit, dsInsert] Then
  Begin
    if CdsCadastro.FieldByName('NUMPARCELAS').AsInteger > 0  then
      CdsCadastro.FieldByName('VALORPORPARCELA').AsCurrency := (CdsCadastro.FieldByName('VALORTOTAL').AsCurrency  / CdsCadastro.FieldByName('NUMPARCELAS').AsInteger);

    if CdsCadastro.FieldByName('PARCELASRESTANTES').AsInteger > 0  then
      CdsCadastro.FieldByName('VALORRESTANTE').AsCurrency := (CdsCadastro.FieldByName('VALORPORPARCELA').AsCurrency  * CdsCadastro.FieldByName('PARCELASRESTANTES').AsInteger);

    if CdsCadastro.FieldByName('VALORRESTANTE').AsCurrency >= CdsCadastro.FieldByName('VALORTOTAL').AsCurrency   then
      CdsCadastro.FieldByName('FLAGQUITADO').AsString := 'Y';


  End;

end;

procedure TfrmCad_Equipamento.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  MudaEstado;
  Try
    frmDlg_ArvorePeca := TfrmDlg_ArvorePeca.Create(nil);
    with frmDlg_ArvorePeca do
    Begin
       pDataSet := Self.CdsArvore;
       pDataSet.Append;
       FechaEGrava := False;
       ShowModal;
    End;
  Finally
    FreeAndNil(frmDlg_ArvorePeca);
  End;
end;

procedure TfrmCad_Equipamento.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  MudaEstado;
  Try
    frmDlg_ArvorePeca := TfrmDlg_ArvorePeca.Create(nil);
    with frmDlg_ArvorePeca do
    Begin
       pDataSet := Self.CdsArvore;
       pDataSet.Edit;
       ShowModal;
    End;
  Finally
    FreeAndNil(frmDlg_ArvorePeca);
  End;
end;

procedure TfrmCad_Equipamento.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  if ConfirmaDel then
  Begin
    Mudaestado;
    CdsArvore.Edit;
    CdsArvore.FieldByName('FLAGEDICAO').AsString := 'D';
    CdsArvore.Post;

  End;

end;

procedure TfrmCad_Equipamento.btnAjustarMarcadorClick(Sender: TObject);
begin
  inherited;
  frmCad_manutencao := TfrmCad_manutencao.Create(nil);
  Try
    frmCad_manutencao.TipoPesquisa := tpCSManutencao;
    frmCad_manutencao.NovoReg := True;
    frmCad_manutencao.IdEquipamento := ValorChave;
    frmCad_manutencao.edtEquipamento.Localiza;
    frmCad_manutencao.edtEquipamento.Enabled := False;
    frmCad_manutencao.ShowModal;
    SetValorChave(psIgual);
  Finally
    FreeAndNil(frmCad_manutencao);
  End;

end;

end.
