unit udlg_CompraEquipamentosItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dlg_Cadastro, StdCtrls, Buttons, ExtCtrls, Mask, EditPesquisa,
  DBCtrls, LabelDBEdit, DB;

type
  TTipoForm = (tfEquipamento,tfMaterial,tfCompraMaterial);
  TfrmDlg_CompraEquipamentoItens = class(TfrmDlg_Cadastro)
    Panel3: TPanel;
    edtEquipamento: TEditPesquisa;
    edtQuantidade: TLabelDBEdit;
    edtValor: TLabelDBEdit;
    edtTotal: TLabelDBEdit;
    DataItem: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure edtEquipamentoBtnNovoClick(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtEquipamentoRegAchado(ADataSet: TDataSet);
    procedure btnOkClick(Sender: TObject);
  private
    FTipoForm: TTipoForm;
    { Private declarations }
  public
    { Public declarations }
    property TipoForm: TTipoForm read FTipoForm write FTipoForm;
  end;

var
  frmDlg_CompraEquipamentoItens: TfrmDlg_CompraEquipamentoItens;

implementation

uses uCad_CompraEquipamento, MinhasClasses, Comandos, uCad_Equipamento;

{$R *.dfm}

procedure TfrmDlg_CompraEquipamentoItens.btnOkClick(Sender: TObject);
begin
  if TipoForm = tfEquipamento then
  begin
    if pDataSet.State <> dsEdit then
      if ExisteRegistro(tpCSCompraEquipamentoItens,'IDEQUIPAMENTO',edtEquipamento.ValorChaveString) Then
        AvisaErro('Esse equipamento já foi comprado.');
  end;
  inherited;

end;

procedure TfrmDlg_CompraEquipamentoItens.edtEquipamentoBtnNovoClick(
  Sender: TObject);
begin
  inherited;
  frmCad_Equipamento := TfrmCad_Equipamento.Create(nil);
  frmCad_Equipamento.NovoReg := True;
  if frmCad_Equipamento.ShowModal = mrOk Then
  begin
    edtEquipamento.ValorChave := frmCad_Equipamento.ValorChave;
    edtEquipamento.Localiza;
  end;
end;

procedure TfrmDlg_CompraEquipamentoItens.edtEquipamentoRegAchado(
  ADataSet: TDataSet);
begin
  inherited;
  if TipoForm = tfMaterial then
  begin
    with GetCds(tpCSMaterial,'IDMATERIAL = '+edtEquipamento.ValorChaveString) do
    begin
      if pDataSet.State in [dsEdit, dsInsert] then
      begin
        pDataSet.FieldByName('VALOR').AsString := FieldByName('VALORCUSTO').AsString;
        if FieldByName('ESTOQUETOTAL').AsCurrency <= 0  then
          Avisa('Não existe quantidade suficiente desse material no estoque.');

      end;
      Free;
    end;
  end;
end;

procedure TfrmDlg_CompraEquipamentoItens.FormActivate(Sender: TObject);
begin
  inherited;
  edtQuantidade.DataSource := DataItem //frmCad_CompraEquipamento.DataItens;
end;

procedure TfrmDlg_CompraEquipamentoItens.FormShow(Sender: TObject);
begin
  inherited;

  if FTipoForm in [tfMaterial,tfCompraMaterial] then
  begin
    ConfiguraEditPesquisa(edtEquipamento, pDataSet, tpCSMaterial,True);
    edtEquipamento.LblTitulo.Caption := 'Material';
    edtEquipamento.UsaBtnNovo := False;
    edtQuantidade.Titulo.Caption := 'Quantidade';
    edtQuantidade.DataField := 'QUANTIDADE';
    Self.Caption := 'Entrada de material';
  end else
  begin
    edtTotal.DataField := '';
    edtTotal.Visible := False;
    ConfiguraEditPesquisa(edtEquipamento,pDataSet {frmCad_CompraEquipamento.CdsItens}, tpCSEquipamento,True);
  end;
  DataItem.DataSet := pDataSet;
end;

procedure TfrmDlg_CompraEquipamentoItens.edtValorExit(Sender: TObject);
begin
  inherited;
  if FTipoForm in [tfMaterial,tfCompraMaterial] then
     pDataSet.FieldByName('TOTAL').AsCurrency :=
        pDataSet.FieldByName(edtQuantidade.DataField).AsCurrency *
                 pDataSet.FieldByName('VALOR').AsCurrency ;
end;

end.
