unit uDlg_SaidaEquipamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dlg_Cadastro, DBCtrls, LabelDBEdit, StdCtrls, Mask, EditPesquisa,
  Buttons, ExtCtrls, DB;

type

  TfrmDlg_SaidaEquipamento = class(TfrmDlg_Cadastro)
    edtEquipamento: TEditPesquisa;
    edtQuantidade: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    GroupBox1: TGroupBox;
    DBMemo1: TDBMemo;
    DataEquipamento: TDataSource;
    edtUnidade: TEditPesquisa;
    LabelDBEdit1: TLabelDBEdit;
    procedure FormShow(Sender: TObject);
    procedure LabelDBEdit2Exit(Sender: TObject);
    procedure edtEquipamentoRegAchado(ADataSet: TDataSet);
    procedure btnOkClick(Sender: TObject);
    procedure edtUnidadeRegAchado(ADataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    FVerificaAlugado: Boolean;
    { Private declarations }
  public
    { Public declarations }
    property VerificaAlugado: Boolean read FVerificaAlugado write FVerificaAlugado;
  end;

var
  frmDlg_SaidaEquipamento: TfrmDlg_SaidaEquipamento;

implementation

uses uVenda, Comandos, MinhasClasses, uLibCS;

{$R *.dfm}

procedure TfrmDlg_SaidaEquipamento.btnOkClick(Sender: TObject);
begin
  if ExisteRegistro(pDataSet,'CODIGO') then
  BEGIN
    Avisa('Esse equipamento já foi adicionado');
    edtEquipamento.SetFocus;
    Exit;
  END;
  inherited;

end;

procedure TfrmDlg_SaidaEquipamento.edtEquipamentoRegAchado(ADataSet: TDataSet);
begin
  inherited;
  if pDataSet.State in [dsEdit, dsInsert] then
  begin
    WITH GetCds(tpCSEquipamento,'idequipamento = '+edtEquipamento.ValorChaveString) do
    begin
      pDataSet.FieldByName('CODIGO').AsString := FieldByName('CODIGO').AsString;
      pDataSet.FieldByName('NOMEEQUIPAMENTO').AsString := FieldByName('NOMEEQUIPAMENTO').AsString;
      pDataSet.FieldByName('IDENTIFICADOR').AsString := FieldByName('IDENTIFICADOR').AsString;
      //pDataSet.FieldByName('NOMEUNIDADE').AsString := FieldByName('NOMEUNIDADE').AsString;
      pDataSet.FieldByName('MARCADOR').AsString := FieldByName('MARCADOR').AsString;
      pDataSet.FieldByName('MARCADORCONTRATADO').AsString := FieldByName('MARCADOR').AsString;
      pDataSet.FieldByName('VALOR').AsString := FieldByName('PRECO').AsString;
      Free;
    end;
  end;
end;

procedure TfrmDlg_SaidaEquipamento.edtUnidadeRegAchado(ADataSet: TDataSet);
begin
  inherited;
  if (pDataSet.State in [dsEdit, dsInsert]) and (pDataSet.FieldByName('IDUNIDADE').Value <> pDataSet.FieldByName('IDUNIDADE').OldValue ) then
  begin
    pDataSet.FieldByName('VALOR').AsCurrency := StrToFloatDef(GetValorCds(tpCSTabelaPrecoEquipamento,'  E.IDEQUIPAMENTO = '+edtEquipamento.ValorChaveString+
                                                                                                     '  AND U.IDUNIDADE = '+edtUnidade.ValorChaveString,'PRECO'),0);

    pDataSet.FieldByName('VALORORIGINAL').AsCurrency := pDataSet.FieldByName('VALOR').AsCurrency ;
  end;

end;

procedure TfrmDlg_SaidaEquipamento.FormCreate(Sender: TObject);
begin
  inherited;
  VerificaAlugado:= True;
end;

procedure TfrmDlg_SaidaEquipamento.FormShow(Sender: TObject);
begin
  inherited;
  ConfiguraEditPesquisa(edtEquipamento,pDataSet,tpCSEquipamento,True);
  ConfiguraEditPesquisa(edtUnidade,pDataSet,tpCSUnidade,True);
  edtUnidade.SQLComp := 'FLAUNIDADEDEEQUIPAMENTO = ''Y'' ';
  edtEquipamento.OnAbrePesquisa := ClassePadrao.AbrePesquisaEquipamento;

  DataEquipamento.DataSet := pDataSet;
  if VerificaAlugado then
    edtEquipamento.SQLComp := 'COALESCE(FLAGALUGADO,''N'') = ''N'' ';
end;

procedure TfrmDlg_SaidaEquipamento.LabelDBEdit2Exit(Sender: TObject);
begin
  inherited;
  pDataSet.FieldByName('TOTAL').AsCurrency := pDataSet.FieldByName('VALOR').AsCurrency *
                                              pDataSet.FieldByName(edtQuantidade.DataField).AsCurrency;
end;


end.
