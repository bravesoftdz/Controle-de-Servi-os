unit uCad_Fornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCad_CadastroPaiCS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ComCtrls, Menus, DB, DBClient, pFIBClientDataSet,
  ActnList, cxPC, cxContainer, cxEdit, cxTreeView, Buttons, ExtCtrls, StdCtrls,
  Mask, DBCtrls, LabelDBEdit;

type
  TfrmCad_Fornecedor = class(TfrmCad_CadastroPaiCS)
    LabelDBEdit1: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    LabelDBEdit5: TLabelDBEdit;
    LabelDBEdit6: TLabelDBEdit;
    LabelDBEdit7: TLabelDBEdit;
    LabelDBEdit8: TLabelDBEdit;
    LabelDBEdit9: TLabelDBEdit;
    LabelDBEdit10: TLabelDBEdit;
    LabelDBEdit11: TLabelDBEdit;
    LabelDBEdit12: TLabelDBEdit;
    LabelDBEdit13: TLabelDBEdit;
    LabelDBEdit14: TLabelDBEdit;
    edtUf: TLabelDBEdit;
    GroupBox1: TGroupBox;
    DBMemo1: TDBMemo;
    procedure FormCreate(Sender: TObject);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure AtualizaPermissoes;Override;
  end;

var
  frmCad_Fornecedor: TfrmCad_Fornecedor;

implementation

uses MinhasClasses, Comandos, uLibCS;

{$R *.dfm}

procedure TfrmCad_Fornecedor.AtualizaPermissoes;
begin
  inherited;
  actNovo.Visible := GetPermissao(IdCadastroFornecedorNovo);
  actEditar.Visible := GetPermissao(IdCadastroFornecedorEditar);
  actDeletar.Visible := GetPermissao(IdCadastroFornecedorExcluir);
end;

procedure TfrmCad_Fornecedor.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsCadastro.FieldByName('DATACADASTRO').AsString := GetDataServidor;
end;

procedure TfrmCad_Fornecedor.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpCSFornecedor;

end;

end.
