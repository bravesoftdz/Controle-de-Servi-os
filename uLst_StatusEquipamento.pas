unit uLst_StatusEquipamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uLstCadastroSimplesCS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxTL, cxTLdxBarBuiltInMenu, DBClient,
  pFIBClientDataSet, Menus, ActnList, cxInplaceContainer, cxTLData, cxDBTL,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxPC, ComCtrls, ToolWin, StdCtrls,
  Buttons, Mask, DBCtrls, LabelDBEdit, cxSplitter, ExtCtrls, Lst_CadastroSimples,
  cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxColorComboBox, cxDBColorComboBox;

type
  TfrmLstStatusEquipamento = class(TfrmLstCadastroSimplesCS)
    LabelDBEdit1: TLabelDBEdit;
    Label1: TLabel;
    cxDBColorComboBox1: TcxDBColorComboBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLstStatusEquipamento: TfrmLstStatusEquipamento;

implementation

uses uLibCS, MinhasClasses;

{$R *.dfm}

procedure TfrmLstStatusEquipamento.FormCreate(Sender: TObject);
begin
  inherited;

  TipoPesquisa := tpCSStatusEquipamento;
end;

end.
