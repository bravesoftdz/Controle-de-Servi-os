unit uPesquisaEquipamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPesquisa_kimera, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxTL, cxTLdxBarBuiltInMenu,
  cxEditRepositoryItems, cxExtEditRepositoryItems, FIBDataSet, pFIBDataSet,
  cxPropertiesStore, cxInplaceContainer, cxTLData, cxDBTL, Buttons, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxPC, JvExControls, JvLabel, StdCtrls, Mask,
  ExtCtrls, cxContainer, cxListBox, cxSplitter, cxGridCardView,
  cxGridDBCardView, DBClient, pFIBClientDataSet;

type
  TfrmPesquisaEquipamento = class(TfrmPesquisa)
    GroupBox3: TGroupBox;
    CdsEspecificacao: TpFIBClientDataSet;
    DataEspecificacao: TDataSource;
    cxGrid2: TcxGrid;
    cxGrid2DBCardView1: TcxGridDBCardView;
    cxGrid2DBCardView1DESCRICAO: TcxGridDBCardViewRow;
    cxGrid2DBCardView1TEXTO: TcxGridDBCardViewRow;
    cxGrid2Level1: TcxGridLevel;
    cxSplitter1: TcxSplitter;
    procedure cdsPesquisaAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesquisaEquipamento: TfrmPesquisaEquipamento;

implementation

uses Comandos, MinhasClasses;

{$R *.dfm}

procedure TfrmPesquisaEquipamento.cdsPesquisaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  SetCds(CdsEspecificacao,tpCSEquipamentoEspecificacao,
          'G.IDGRUPOEQUIPAMENTO  = '+cdsPesquisa.FieldByName('IDGRUPOEQUIPAMENTO').AsString +
          '   AND COALESCE(EE.IDEQUIPAMENTO,'+cdsPesquisa.FieldByName('IDEQUIPAMENTO').AsString+') = '+cdsPesquisa.FieldByName('IDEQUIPAMENTO').AsString);
end;

end.
