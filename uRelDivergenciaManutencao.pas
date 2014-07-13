unit uRelDivergenciaManutencao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UdlgRelatorioPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxContainer, DBClient, pFIBClientDataSet,
  ActnList, ImgList, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit, StdCtrls,
  ExtCtrls, DBCtrls, JvGradient, Buttons, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxPC,
  JvExControls, JvLabel, dxGDIPlusClasses, ComCtrls, cxCalendar,uRelPadraoCS;

type
  TfrmRelDivergenciaManutencao = class(TfrmRelPadraoCS)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtDataIni: TcxDateEdit;
    edtDataFin: TcxDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelDivergenciaManutencao: TfrmRelDivergenciaManutencao;

implementation

uses MinhasClasses, Comandos;

{$R *.dfm}

procedure TfrmRelDivergenciaManutencao.btnNovoClick(Sender: TObject);
var
  StrSQL,StrFiltro: String;
begin
  StrFiltro := GetFiltro(tpCSEquipamento,'E.IDEQUIPAMENTO');
  GetPeriodo(edtDataIni.Text, edtDataFin.Text,StrFiltro, 'M.DATAMANUTENCAO');
  StrSQL :=
    'SELECT M.IDMANUTENCAO, M.HORA, M.DATAMANUTENCAO,E.NOMEEQUIPAMENTO, E.CODIGO CODIGO_EQUIPAMENTO,'+
    '       E.IDENTIFICADOR,MT.CODIGO CODIGO_MATERIAL, MT.NOMEMATERIAL,'+
    '       COALESCE(MP.QUANTIDADE,0) QUANTIDADE_USADA, COALESCE(EA.QUANTIDADE,0) QUANTIDADE_ARVORE'+
    '  FROM MANUTENCAO M'+
    ' INNER JOIN EQUIPAMENTO E'+
    '    ON (E.IDEQUIPAMENTO = M.IDEQUIPAMENTO)'+
    '  LEFT JOIN EQUIPAMENTOARVORE EA'+
    '    ON (EA.IDEQUIPAMENTO = E.IDEQUIPAMENTO )'+
    '  LEFT JOIN MATERIAL MT'+
    '    ON (MT.IDMATERIAL = EA.IDMATERIAL)'+
    '  LEFT JOIN MANUTENCAOPECAS MP'+
    '    ON (MP.IDMANUTENCAO= M.IDMANUTENCAO AND MT.IDMATERIAL = MP.IDMATERIAL)'+
    '  WHERE COALESCE(MP.QUANTIDADE,0) <> COALESCE(EA.QUANTIDADE,0) '+StrFiltro+
    ' ORDER BY E.IDEQUIPAMENTO, M.IDMANUTENCAO ';
  SetCds(CdsMaster,StrSQL);
  inherited;

end;

procedure TfrmRelDivergenciaManutencao.FormCreate(Sender: TObject);
begin
  inherited;
  IdRelatorio := IdRelDivergenciaManutencao;
  CamposFiltro.Add(tpCSEquipamento);
end;

end.
