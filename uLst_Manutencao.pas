unit uLst_Manutencao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uListagemPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, pFIBClientDataSet, ActnList,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxPC, StdCtrls, Buttons,
  dxStatusBar, ExtCtrls, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinsdxStatusBarPainter, dxSkinscxPCPainter;

type
  TfrmLst_Manutencao = class(TfrmListagemPadrao)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLst_Manutencao: TfrmLst_Manutencao;

implementation

uses MinhasClasses, uCad_Manutencao, uRelManutencao;

{$R *.dfm}

procedure TfrmLst_Manutencao.actEditarExecute(Sender: TObject);
begin
  inherited;
  frmCad_manutencao := TfrmCad_manutencao.Create(nil);
  Try
    frmCad_manutencao.TipoPesquisa := Self.TipoPesquisa;
    frmCad_manutencao.ValorChave := Self.CdsListagem.FieldByName('IDMANUTENCAO').AsString;
    frmCad_manutencao.EditReg := True;
    frmCad_manutencao.ShowModal;
    AtuDados;
  Finally
    FreeAndNil(frmCad_manutencao);
  End;
end;

procedure TfrmLst_Manutencao.actImprimirExecute(Sender: TObject);
begin
  inherited;
  frmRelManutencao := TfrmRelManutencao.Create(nil);
  Try
    frmRelManutencao.ShowModal;
  Finally
    FreeAndNil(frmRelManutencao);
  End;
end;

procedure TfrmLst_Manutencao.actNovoExecute(Sender: TObject);
begin
  inherited;
  frmCad_manutencao := TfrmCad_manutencao.Create(nil);
  Try
    frmCad_manutencao.TipoPesquisa := Self.TipoPesquisa;
    frmCad_manutencao.Novoreg := True;
    frmCad_manutencao.ShowModal;
    AtuDados;
  Finally
    FreeAndNil(frmCad_manutencao);
  End;

end;

procedure TfrmLst_Manutencao.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpCSManutencao;
  CriaColuna('IDMANUTENCAO','Nº manutenção',80,tcInt);
  CriaColuna('DATAMANUTENCAO','Data',80,tcCampoData);
  CriaColuna('NOMEEQUIPAMENTO','Equipamento',100,tcString);
  CriaColuna('IDENTIFICADOR','Identificador',80,tcString);
  CriaColuna('NOMECLIENTE','Cliente',200,tcString);
  CriaColuna('NOMELOCALESTOQUE','Local',100,tcString);
  CriaColuna('LOGIN','Usuário',90,tcString);

end;

procedure TfrmLst_Manutencao.FormShow(Sender: TObject);
begin
  inherited;
  AtuDados;
end;

end.
