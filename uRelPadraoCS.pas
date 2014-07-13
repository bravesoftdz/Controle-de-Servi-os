unit uRelPadraoCS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UdlgRelatorioPadrao, cxGraphics, cxControls, cxLookAndFeels,
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
  TfrmRelPadraoCS = class(TfrmdlgRelatorioPadrao)
    CdsEmpresa: TpFIBClientDataSet;
    DataEmpresa: TDataSource;
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FIdEmpresa: String;
    procedure SetIdEmpresa(const Value: String);
    { Private declarations }
  public
    { Public declarations }
    property IdEmpresa: String read FIdEmpresa write SetIdEmpresa;
  end;

var
  frmRelPadraoCS: TfrmRelPadraoCS;

implementation

uses uLibCS, MinhasClasses, Comandos;

{$R *.dfm}

procedure TfrmRelPadraoCS.btnNovoClick(Sender: TObject);
begin
  SetCds(CdsEmpresa, tpCSEmpresa, 'IDEMPRESA = '+IdEmpresa);
  RegistraAuditoria('Imprimiu um relatório '+Self.Caption,'O Usuário '+USuarioLogado.Login+' Imprimiu um relatório ',
                      '', Self.Name,Self.Caption,'', toImprimir,nil,  False, True );
  inherited;
end;

procedure TfrmRelPadraoCS.FormCreate(Sender: TObject);
begin
  inherited;
  IdEmpresa := GetValorCds(tpCSEmpresa,'','IDEMPRESA');
end;

procedure TfrmRelPadraoCS.FormShow(Sender: TObject);
begin
  inherited;
  SetLength(DataSetExtras, Length(DataSetExtras)+1);
  DataSetExtras[Length(DataSetExtras)-1] := CdsEmpresa;
end;

procedure TfrmRelPadraoCS.SetIdEmpresa(const Value: String);
begin
  FIdEmpresa := Value;
end;

end.
