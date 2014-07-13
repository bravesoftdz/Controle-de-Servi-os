unit Cad_Item;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dlg_Cadastro, StdCtrls, Buttons, ExtCtrls, Mask, EditPesquisa, DB,
  DBCtrls, LabelDBEdit;

type
  TfrmCad_Itens = class(TfrmDlg_Cadastro)
    DataItem: TDataSource;
    edtTipoServico: TEditPesquisa;
    edtValor: TLabelDBEdit;
    LabelDBEdit1: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    GroupBox1: TGroupBox;
    DBMemo1: TDBMemo;
    procedure FormShow(Sender: TObject);
    procedure edtTipoServicoRegAchado(ADataSet: TDataSet);
    procedure LabelDBEdit1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCad_Itens: TfrmCad_Itens;

implementation

uses Comandos, MinhasClasses;

{$R *.dfm}

procedure TfrmCad_Itens.edtTipoServicoRegAchado(ADataSet: TDataSet);
var
  StrWh: String;
begin
  inherited;
  if (pDataSet.State= dsBrowse) then
    Exit;
  StrWh :=
     ' IDPRODUTOS = '+edtTipoServico.ValorChaveString;
  with GetCds(tpCSProdutos,StrWh) do
  Begin
    pDataSet.FieldByName('VALORORIGINAL').AsCurrency := FieldByName('VALORVENDA').AsCurrency;
    Free;
  End;

end;

procedure TfrmCad_Itens.FormShow(Sender: TObject);
begin
  inherited;
  DataItem.DataSet := pDataSet;
  ConfiguraEditPesquisa(edtTipoServico,pDataSet,tpCSProdutos);
  edtTipoServico.AutoCompletar := False;

end;

procedure TfrmCad_Itens.LabelDBEdit1Exit(Sender: TObject);
begin
  inherited;
  if (pDataSet.State <> dsBrowse) then
    pDataSet.FieldByName('TOTAL').AsCurrency := pDataSet.FieldByName('VALOR').AsCurrency *
                                                pDataSet.FieldByName('QUANTIDADE').AsCurrency;
end;

end.
