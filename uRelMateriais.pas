unit uRelMateriais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRelPadraoCS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxContainer, DBClient, pFIBClientDataSet,
  ActnList, ImgList, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxDBEdit, StdCtrls,
  ExtCtrls, DBCtrls, JvGradient, Buttons, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxPC,
  JvExControls, JvLabel, dxGDIPlusClasses, ComCtrls, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter;

type
  TfrmRelMateriais = class(TfrmRelPadraoCS)
    grpStatusEstoque: TRadioGroup;
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelMateriais: TfrmRelMateriais;

implementation

uses MinhasClasses, Comandos;

{$R *.dfm}

procedure TfrmRelMateriais.btnNovoClick(Sender: TObject);
var
  StrWr: String;
begin
  StrWr := ' 1=1 ';
  StrWr := StrWr+GetFiltro(tpCSMaterial, 'M.IDMATERIAL');
  StrWr := StrWr+GetFiltro(tpCSTipoMaterial, 'M.IDTIPOMATERIAL');
  StrWr := StrWr+GetFiltro(tpCSFornecedor, 'M.IDFORNECEDOR');
  case grpStatusEstoque.ItemIndex of
   0:;
   1: StrWr := StrWr+' AND  COALESCE(M.ESTOQUETOTAL,0) < COALESCE(M.ESTOQUEMINIMO,0) ';
   2: StrWr := StrWr+' AND COALESCE(M.ESTOQUETOTAL,0) > COALESCE(M.ESTOQUEMINIMO,0) ';
   3: StrWr := StrWr+' AND COALESCE(M.ESTOQUETOTAL,0) = 0 ';
   4: StrWr := StrWr+' AND COALESCE(M.ESTOQUETOTAL,0) < 0  ';
   5: StrWr := StrWr+' AND COALESCE(M.ESTOQUETOTAL,0) > 0 ';
  end;
  SetCds(CdsMaster,tpCSMaterial,StrWr);
  inherited;

end;

procedure TfrmRelMateriais.FormCreate(Sender: TObject);
begin
  inherited;
  IdRelatorio := IdRelMateriais;
  CamposFiltro.Add(tpCSMaterial);
  CamposFiltro.Add(tpCSTipoMaterial);
  CamposFiltro.Add(tpCSFornecedor);
end;

end.
