unit uDlg_ArvorePeca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dlg_Cadastro, StdCtrls, Buttons, ExtCtrls, DBCtrls, LabelDBEdit,
  Mask, EditPesquisa, DB;

type
  TfrmDlg_ArvorePeca = class(TfrmDlg_Cadastro)
    edtMaterial: TEditPesquisa;
    edtQtd: TLabelDBEdit;
    GroupBox1: TGroupBox;
    DBMemo1: TDBMemo;
    procedure btnOkClick(Sender: TObject);
    procedure edtMaterialRegAchado(ADataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDlg_ArvorePeca: TfrmDlg_ArvorePeca;

implementation

uses uCad_Equipamento, Comandos, MinhasClasses;

{$R *.dfm}

procedure TfrmDlg_ArvorePeca.btnOkClick(Sender: TObject);
begin
  VerificaEdit(edtMaterial,'Informe o material');
  VerificaEdit(pDataSet, edtQtd,'','Informe a quantidade');

  inherited;

end;

procedure TfrmDlg_ArvorePeca.edtMaterialRegAchado(ADataSet: TDataSet);
begin
  inherited;
  if PodeAlterarDataSet(pDataSet) then
  Begin
    pDataSet.FieldByName('NOMEEQUIPAMENTO').AsString := edtMaterial.Display.Text;
    pDataSet.FieldByName('CODIGO').AsString := edtMaterial.Text;
    //pDataSet.FieldByName('IDMATERIAL').AsString := edtMaterial.ValorChaveString;
  End;

end;

procedure TfrmDlg_ArvorePeca.FormShow(Sender: TObject);
begin
  inherited;
  ConfiguraEditPesquisa(edtMaterial,pDataSet,tpCSMaterial, True);
  edtMaterial.Localiza;
end;

end.
