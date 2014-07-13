unit uRelEquipamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UdlgRelatorioPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxContainer, cxDropDownEdit, cxCalendar,
  StdCtrls, DBClient, pFIBClientDataSet, ActnList, ImgList, cxTextEdit,
  cxMaskEdit, cxDBEdit, ExtCtrls, DBCtrls, JvGradient, Buttons, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxPC, JvExControls, JvLabel, dxGDIPlusClasses,
  ComCtrls, uRelClientes, uRelPadraoCS;

type
  TfrmRelEquipamento = class(TfrmRelPadraoCS)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtDataIni: TcxDateEdit;
    edtDataFin: TcxDateEdit;
    edtIdentificador: TLabeledEdit;
    grpSituacao: TRadioGroup;
    grpQuitados: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelEquipamento: TfrmRelEquipamento;

implementation

uses MinhasClasses, uLibCS, Comandos;

{$R *.dfm}

procedure TfrmRelEquipamento.btnNovoClick(Sender: TObject);
var
  Filtro,StrData: String;
begin
  GetPeriodo(edtDataIni.Text,edtDataFin.Text,StrData,'DATAAQUISICAO', False);
  Filtro :=' 1=1 '+StrData;
  Filtro := Filtro+ GetFiltro(tpCSMarca,'E.IDMARCA');
  Filtro := Filtro+ GetFiltro(tpCSCombustivel,'E.IDCOMBUSTIVEL');
  Filtro := Filtro+ GetFiltro(tpCSGrupoEquipamento,'E.IDGRUPOEQUIPAMENTO');
  Filtro := Filtro+ GetFiltro(tpCSStatusEquipamento,'E.IDSTATUSEQUIPAMENTO');
  Filtro := Filtro+ GetFiltro(tpCSEquipamento,'E.IDEQUIPAMENTO');
  if edtIdentificador.Text <> '' then
    Filtro := Filtro+ ' AND  E.IDENTIFICADOR LIKE '+QuotedStr(edtIdentificador.Text);
  case grpSituacao.ItemIndex of
    1:
     Filtro := Filtro+ ' AND COALESCE(E.FLAGINATIVO,''N'') = ''N'' ';
    2:
     Filtro := Filtro+ ' AND COALESCE(E.FLAGINATIVO,''N'') = ''Y'' ';
  end;

   case grpQuitados.ItemIndex of
    1:
     Filtro := Filtro+ ' AND COALESCE(E.FLAGQUITADO,''N'') = ''Y'' ';
    2:
     Filtro := Filtro+ ' AND COALESCE(E.FLAGQUITADO,''N'') = ''N'' ';
  end;

  SetCds(CdsMaster,tpCSEquipamento,Filtro);

  Filtro := ' EXISTS(SELECT 1 FROM EQUIPAMENTO E WHERE E.IDEQUIPAMENTO = EE.IDEQUIPAMENTO AND '+Filtro+')';
  SetCds(CdsDetalhes,tpCSEquipamentoEspecificacao,Filtro);

  inherited;

end;

procedure TfrmRelEquipamento.FormCreate(Sender: TObject);
begin
  inherited;
  IdRelatorio := IdRelEquipamentos;
  CamposFiltro.Add(tpCSEquipamento);
  CamposFiltro.Add(tpCSMarca);
  CamposFiltro.Add(tpCSCombustivel);
  CamposFiltro.Add(tpCSGrupoEquipamento);
  CamposFiltro.Add(tpCSStatusEquipamento);
end;

end.
