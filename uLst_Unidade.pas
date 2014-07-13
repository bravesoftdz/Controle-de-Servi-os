unit uLst_Unidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uLstCadastroSimplesCS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxTL, cxTLdxBarBuiltInMenu, StdCtrls,
  DBCtrls, DBClient, pFIBClientDataSet, Menus, ActnList, cxInplaceContainer,
  cxTLData, cxDBTL, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxPC,
  ComCtrls, ToolWin, Buttons, Mask, LabelDBEdit, cxSplitter, ExtCtrls;

type
  TfrmLst_Unidade = class(TfrmLstCadastroSimplesCS)
    DBCheckBox1: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLst_Unidade: TfrmLst_Unidade;

implementation

uses MinhasClasses;

{$R *.dfm}

procedure TfrmLst_Unidade.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('FLAGFRACIONADO').AsString := 'N';
end;

procedure TfrmLst_Unidade.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpCSUnidade;
end;

end.
