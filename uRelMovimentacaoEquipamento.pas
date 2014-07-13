unit uRelMovimentacaoEquipamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRelPadraoCS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxContainer, DBClient, pFIBClientDataSet,
  ActnList, ImgList, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit, StdCtrls,
  ExtCtrls, DBCtrls, JvGradient, Buttons, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxPC,
  JvExControls, JvLabel, dxGDIPlusClasses, ComCtrls, cxCalendar, Mask,
  EditPesquisa, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter;

type
  TfrmRelMovimentacaoEquipamento = class(TfrmRelPadraoCS)
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
  frmRelMovimentacaoEquipamento: TfrmRelMovimentacaoEquipamento;

implementation

uses MinhasClasses, Comandos;

{$R *.dfm}

procedure TfrmRelMovimentacaoEquipamento.btnNovoClick(Sender: TObject);
var
  Filtro,StrSQL: String;
begin
  Filtro := GetFiltro(tpCSEquipamento, 'IDEQUIPAMENTO');
  GetPeriodo(edtDataIni.Text, edtDataFin.Text,Filtro, 'M.DATA');
  StrSQL :=
    'SELECT IDEQUIPAMENTO, NOMEEQUIPAMENTO, CODIGO, IDENTIFICADOR, MARCADORANTERIOR,'+
    '       MARCADOR, DATA, HORA, CLIENTE, IDGRUPOEQUIPAMENTO, NOMEGRUPO,'+
    '       CASE WHEN M.OPERACAO = ''C'' THEN ''COMPRA'''+
    '            WHEN M.OPERACAO = ''S'' THEN ''SAÍDA'''+
    '            WHEN M.OPERACAO = ''E'' THEN ''ENTRADA'''+
    '            WHEN M.OPERACAO = ''M'' THEN ''MANUTENÇÃO'' END OPERACAO,LOCAL,'+
    '       M.VALOR'+
    '  FROM MOVIMENTACAO_EQUIPAMENTO M'+
    ' WHERE 1=1 '+Filtro;
  SetCds(CdsMaster,StrSQL);
  inherited;

end;

procedure TfrmRelMovimentacaoEquipamento.FormCreate(Sender: TObject);
begin
  inherited;
  IdRelatorio := IdRelMovimentacaoEquipamento;
  CamposFiltro.Add(tpCSEquipamento);
end;

end.
