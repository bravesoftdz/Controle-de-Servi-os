unit uRelClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UdlgRelatorioPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxContainer, DBClient, pFIBClientDataSet,
  ActnList, ImgList, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit, StdCtrls,
  ExtCtrls, DBCtrls, JvGradient, Buttons, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxPC,
  JvExControls, JvLabel, dxGDIPlusClasses, ComCtrls, cxCalendar, uRelPadraoCS;

type
  TfrmRelClientes = class(TfrmRelPadraoCS)
    grpTipoPessoa: TRadioGroup;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtDataIni: TcxDateEdit;
    edtDataFin: TcxDateEdit;
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelClientes: TfrmRelClientes;

implementation

uses Comandos, MinhasClasses, uLibCS;

{$R *.dfm}

procedure TfrmRelClientes.btnNovoClick(Sender: TObject);
var
  Filtro,StrData: String;
begin
  GetPeriodo(edtDataIni.Text,edtDataFin.Text,StrData,'DATACADASTRO', False);
  Filtro :=' 1=1 '+StrData;
   if edtBairro.Text <> '' then
    Filtro := Filtro+ ' AND  BAIRRO LIKE '+QuotedStr(edtBairro.Text);
   if edtCidade.Text <> '' then
    Filtro := Filtro+ ' AND  CIDADE LIKE '+QuotedStr(edtCidade.Text);
  case grpTipoPessoa.ItemIndex of
    1:
      Filtro := Filtro+ ' AND FLAGTIPOPESSOA = ''F'' ';
    2:
      Filtro := Filtro+ ' AND FLAGTIPOPESSOA = ''J'' ';

  end;
  SetCds(CdsMaster,tpCsCliente,Filtro);
  inherited;
  

end;

procedure TfrmRelClientes.FormCreate(Sender: TObject);
begin
  inherited;
  IdRelatorio :=   IdRelCliente;
end;

end.
