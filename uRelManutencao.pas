unit uRelManutencao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRelPadraoCS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxContainer, cxDropDownEdit, cxCalendar,
  StdCtrls, DBClient, pFIBClientDataSet, ActnList, ImgList, cxTextEdit,
  cxMaskEdit, cxDBEdit, ExtCtrls, DBCtrls, JvGradient, Buttons, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxPC, JvExControls, JvLabel, dxGDIPlusClasses,
  ComCtrls;

type
  TfrmRelManutencao = class(TfrmRelPadraoCS)
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
  frmRelManutencao: TfrmRelManutencao;

implementation

uses MinhasClasses, Comandos;

{$R *.dfm}

procedure TfrmRelManutencao.btnNovoClick(Sender: TObject);
var
  StrWr,StrData, Str1: String;
begin
  GetPeriodo(edtDataIni.Text,edtDataFin.Text,StrData,'M.DATAMANUTENCAO', False);
  StrWr :=' 1=1 '+StrData;
  StrWr := StrWr+ GetFiltro(tpCSEquipamento,'M.IDEQUIPAMENTO');
  StrWr := StrWr+ GetFiltro(tpCsCliente,'C.IDCLIENTE');
  SetCds(CdsMaster, tpCSManutencao,StrWr);

  Str1 :=
    'EXISTS (SELECT 1' +
    '          FROM MANUTENCAO MT '+
    '         WHERE MT.IDMANUTENCAO = MP.IDMANUTENCAO' +
    '           AND '+StringReplace(StrWr,'M.','MT.',[rfReplaceAll])+')';
  SetCds(CdsDetalhes, tpCSManutencaoPecas,Str1);



  inherited;

end;

procedure TfrmRelManutencao.FormCreate(Sender: TObject);
begin
  inherited;
  IdRelatorio := IdRelManutencao;
  CamposFiltro.Add(tpCSEquipamento);
  CamposFiltro.Add(tpCsCliente);
end;

end.
