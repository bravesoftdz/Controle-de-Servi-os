unit uRelDespRecEquipamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UdlgRelatorioPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxContainer, DBClient, pFIBClientDataSet,
  ActnList, ImgList, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit, StdCtrls,
  ExtCtrls, DBCtrls, JvGradient, Buttons, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxPC,
  JvExControls, JvLabel, dxGDIPlusClasses, ComCtrls,uRelPadraoCS;

type
  TfrmRelDespRecEquipamento = class(TfrmRelPadraoCS)
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelDespRecEquipamento: TfrmRelDespRecEquipamento;

implementation

uses MinhasClasses, Comandos;

{$R *.dfm}

procedure TfrmRelDespRecEquipamento.btnNovoClick(Sender: TObject);
Var
  StrSQL,StrFIltro: String;
begin
  StrFiltro := GetFiltro(tpCSEquipamento,'M.IDEQUIPAMENTO');
  StrFiltro := StrFiltro+ GetFiltro(tpCSGrupoEquipamento,'M.IDGRUPOEQUIPAMENTO');
  StrSQL :=
    'SELECT M.IDEQUIPAMENTO, NOMEEQUIPAMENTO, CODIGO, IDENTIFICADOR,NOMEGRUPO, '+
    '       M.CLIENTE,'+
    '       CASE WHEN M.OPERACAO = ''C'' THEN ''COMPRA'''+
    '            WHEN M.OPERACAO = ''S'' THEN ''SAÍDA'''+
    '            WHEN M.OPERACAO = ''M'' THEN ''MANUTENÇÃO'' END OPERACAO,'+
    '       CASE WHEN M.OPERACAO = ''C'' THEN M.VALOR * -1'+
    '            WHEN M.OPERACAO = ''S'' THEN M.VALOR'+
    '            WHEN M.OPERACAO = ''M'' THEN M.VALOR * -1 END VALOR'+
    '  FROM MOVIMENTACAO_EQUIPAMENTO M'+
    ' WHERE M.OPERACAO <> ''E'' '+StrFIltro+
    ' ORDER BY IDGRUPOEQUIPAMENTO,IDEQUIPAMENTO,DATA, HORA ';
  SetCds(CdsMaster,StrSQL);
  inherited;

end;

procedure TfrmRelDespRecEquipamento.FormCreate(Sender: TObject);
begin
  inherited;
  IdRelatorio := IdRelRecDesp;
  CamposFiltro.Add(tpCSEquipamento);
  CamposFiltro.Add(tpCSGrupoEquipamento);
end;

end.
