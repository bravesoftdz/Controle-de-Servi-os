unit Lst_Produtos;

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
  TfrmLstProdutos = class(TfrmLstCadastroSimplesCS)
    LabelDBEdit2: TLabelDBEdit;
    GroupBox1: TGroupBox;
    DBMemo1: TDBMemo;
    LabelDBEdit1: TLabelDBEdit;
    edtMarca: TEditPesquisa;
    procedure FormCreate(Sender: TObject);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
    procedure edtMarcaBtnNovoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLstProdutos: TfrmLstProdutos;

implementation

uses MinhasClasses, Comandos;

{$R *.dfm}

procedure TfrmLstProdutos.CdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('MARCA').ProviderFlags := [];
  FormataMascara(CdsCadastro.FieldByName('VALORVENDA'),tcMoeda);
end;

procedure TfrmLstProdutos.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('IDUNIDADE').AsString := '1';
end;

procedure TfrmLstProdutos.edtMarcaBtnNovoClick(Sender: TObject);
begin
  inherited;
   Try
    frmLstCadastroSimples := TfrmLstCadastroSimples.Create(nil);
    with frmLstCadastroSimples do
    Begin
      TipoPesquisa :=tpCSMarca;
      NovoReg := True;
      if ShowModal = mrOk Then
      Begin
        edtMarca.ValorChave := frmLstCadastroSimples.CdsCadastro.FieldByName('IDMARCA').AsString;
        edtMarca.Localiza;
      End;
    End;
  Finally
    FreeAndNil(frmLstCadastroSimples);

  End;
end;

procedure TfrmLstProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpCSProdutos;
  CriaColuna('CODIGO','Código');
  CriaColuna('NOME','Tipo de Serviço',200);
  ConfiguraEditPesquisa(edtMarca,CdsCadastro,tpCSMarca);
//  ConfiguraEditPesquisa(edtUnidade,CdsCadastro,tpCSUnidade);
end;

end.
