unit uDlg_EntradaEquipamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dlg_Cadastro, DBCtrls, LabelDBEdit, StdCtrls, Mask, EditPesquisa,
  Buttons, ExtCtrls, DB;

type
  TfrmDlg_EntradaEquipamento = class(TfrmDlg_Cadastro)
    edtEquipamento: TEditPesquisa;
    edtQuantidade: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    GroupBox1: TGroupBox;
    DBMemo1: TDBMemo;
    DataEquipamento: TDataSource;
    EdtContador: TLabelDBEdit;
    LabelDBEdit5: TLabelDBEdit;
    procedure FormShow(Sender: TObject);
    procedure LabelDBEdit2Exit(Sender: TObject);
    procedure edtEquipamentoRegAchado(ADataSet: TDataSet);
    procedure edtQuantidadeExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmDlg_EntradaEquipamento: TfrmDlg_EntradaEquipamento;

implementation

uses uVenda, Comandos, MinhasClasses, uCad_EntradaEquipamento;

{$R *.dfm}

procedure TfrmDlg_EntradaEquipamento.edtEquipamentoRegAchado(ADataSet: TDataSet);
VAR
  IdServico: String;
  Cont: Currency;
begin
  inherited;
  if pDataSet.State in [dsEdit, dsInsert] then
  begin
    WITH GetCds(tpCSEquipamento,'idequipamento = '+edtEquipamento.ValorChaveString) do
    begin
      pDataSet.FieldByName('CODIGO').AsString := FieldByName('CODIGO').AsString;
      pDataSet.FieldByName('NOMEEQUIPAMENTO').AsString := FieldByName('NOMEEQUIPAMENTO').AsString;
      pDataSet.FieldByName('IDENTIFICADOR').AsString := FieldByName('IDENTIFICADOR').AsString;
      pDataSet.FieldByName(EdtContador.DataField).AsString := FieldByName('MARCADOR').AsString;

      IdServico:= frmCad_EntradaEquipamento.CdsCadastro.FieldByName('IDSERVICO').AsString;
      if IdServico = '' then
        IdServico :='-1';
      with GetCds(tpCSSaidaEquipamento,'IDSERVICO = '+IdServico+
                                       ' AND E.IDEQUIPAMENTO = '+edtEquipamento.ValorChaveString) do
      begin
        pDataSet.FieldByName('VALOR').AsCurrency := FieldByName('VALOR').AsCurrency;
        pDataSet.FieldByName('NOMEUNIDADE').AsString := FieldByName('NOMEUNIDADE').AsString;
//        pDataSet.FieldByName('MARCADORCONTRATADO').AsString := FieldByName('MARCADORCONTRATADO').AsString;
        Free;
      end;
      Free;
    end;
  end;
end;

procedure TfrmDlg_EntradaEquipamento.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
  pDataSet.FieldByName('DIFERENCAMARCADOR').Value  := pDataSet.FieldByName('MARCADOR').Value - pDataSet.FieldByName('MARCADORATUAL').Value ;
  if pDataSet.FieldByName('DIFERENCAMARCADOR').Value  < 0 then
    pDataSet.FieldByName('DIFERENCAMARCADOR').Value := 0;

end;

procedure TfrmDlg_EntradaEquipamento.FormShow(Sender: TObject);
begin
  inherited;
  ConfiguraEditPesquisa(edtEquipamento,pDataSet,tpCSEquipamento,True);
  DataEquipamento.DataSet := pDataSet;
  edtEquipamento.SQLComp := 'COALESCE(FLAGALUGADO,''N'') = ''Y'' ';
end;

procedure TfrmDlg_EntradaEquipamento.LabelDBEdit2Exit(Sender: TObject);
begin
  inherited;
  pDataSet.FieldByName('TOTAL').AsCurrency := pDataSet.FieldByName('VALOR').AsCurrency *
                                              pDataSet.FieldByName('DIFERENCAMARCADOR').AsCurrency;
end;


end.
