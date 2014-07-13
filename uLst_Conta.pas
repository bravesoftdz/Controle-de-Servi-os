unit uLst_Conta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uLstCadastroSimplesCS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxTL, cxTLdxBarBuiltInMenu, DBClient,
  pFIBClientDataSet, Menus, ActnList, cxInplaceContainer, cxTLData, cxDBTL,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxPC, ComCtrls, ToolWin, StdCtrls,
  Buttons, Mask, DBCtrls, LabelDBEdit, cxSplitter, ExtCtrls, EditPesquisa,
  Lst_CadastroSimples;

type
  TfrmLst_Conta = class(TfrmLstCadastroSimplesCS)
    edtBanco: TEditPesquisa;
    LabelDBEdit1: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLst_Conta: TfrmLst_Conta;

implementation

uses MinhasClasses, Comandos;

{$R *.dfm}

procedure TfrmLst_Conta.CdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('NOMEBANCO').ProviderFlags := []
end;

procedure TfrmLst_Conta.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpCSConta;
  USaCampoCodigo := False;
end;

procedure TfrmLst_Conta.FormShow(Sender: TObject);
begin
  inherited;
  CriaColuna('NOMEBANCO','Banco');
  CriaColuna('CONTA','Conta');
  ConfiguraEditPesquisa(edtBanco,CdsCadastro,tpCSBanco);
  edtBanco.TamanhoCodigo := 3;

end;

end.
