unit uLst_Servicos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uListagemPadrao,
  DB, DBClient, pFIBClientDataSet, ActnList,
  StdCtrls, Buttons,
  ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxPC, dxStatusBar, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinsdxStatusBarPainter, dxSkinscxPCPainter, Menus;

type
  TfrmLst_Servicos = class(TfrmListagemPadrao)
    BitBtn11: TBitBtn;
    actImpComprovante: TAction;
    btnComprovante: TBitBtn;
    PopupComprovante: TPopupMenu;
    Comprovante1: TMenuItem;
    actImpVariosComprovantes: TAction;
    ImprimirVarioscomprovantes1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure CdsListagemAfterOpen(DataSet: TDataSet);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
    procedure actImpComprovanteExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
    procedure actImpVariosComprovantesExecute(Sender: TObject);
    procedure btnComprovanteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLst_Servicos: TfrmLst_Servicos;

implementation

uses MinhasClasses, Comandos, Cad_Servico, uVenda, uLibCS, uRelServicos,
  uMultiComprovante;

{$R *.dfm}

procedure TfrmLst_Servicos.actEditarExecute(Sender: TObject);
begin
  inherited;
  frmCad_Servico := TfrmCad_Servico.Create(nil);
  Try
    frmCad_Servico.TipoPesquisa := Self.TipoPesquisa;
    frmCad_Servico.ValorChave := Self.CdsListagem.FieldByName('IDSERVICO').AsString;
    frmCad_Servico.EditReg := True;
    frmCad_Servico.ShowModal;
    AtuDados;
  Finally
    FreeAndNil(frmCad_Servico);
  End;
end;

procedure TfrmLst_Servicos.actImpComprovanteExecute(Sender: TObject);
begin
  Imp_Recibo(CdsListagem.FieldByName('IDEMPRESA').AsInteger,CdsListagem.FieldByName('IDSERVICO').AsString,tlTela);
end;

procedure TfrmLst_Servicos.actImprimirExecute(Sender: TObject);
begin
  inherited;
  frmRelServicos := TfrmRelServicos.Create(nil);
  Try
    frmRelServicos.ShowModal;
  Finally
    FreeAndNil(frmRelServicos);
  End;
end;

procedure TfrmLst_Servicos.actImpVariosComprovantesExecute(Sender: TObject);
begin
  inherited;
  Try
    frmMultiComprovante := TfrmMultiComprovante.Create(nil);
    frmMultiComprovante.ShowModal;
  Finally
    FreeAndNil(frmMultiComprovante);
  End;
end;

procedure TfrmLst_Servicos.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  actImpComprovante.Enabled := (CdsListagem.Active) and (CdsListagem.RecordCount > 0 );
  actImprimir.Enabled := actImpComprovante.Enabled ;
end;

procedure TfrmLst_Servicos.actNovoExecute(Sender: TObject);
begin
  inherited;
  if frmVenda = nil then
    frmVenda := TfrmVenda.Create(nil);
  if frmVenda.Showing then
    frmVenda.BringToFront
  else
    frmVenda.Show;
end;

procedure TfrmLst_Servicos.BitBtn11Click(Sender: TObject);
begin
  inherited;
  AtuDados;
end;

procedure TfrmLst_Servicos.btnComprovanteClick(Sender: TObject);
begin
  inherited;
  PopupComprovante.Popup(btnComprovante.Left,btnComprovante.Height+ 20);
end;

procedure TfrmLst_Servicos.CdsListagemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsListagem.FieldByName('VALORTOTALLIQUIDO'), tcMoeda);
end;

procedure TfrmLst_Servicos.FormCreate(Sender: TObject);
begin
  inherited;
  CriaColuna('NUMSERVICO','Nº Serviço', 60,tcString);
  CriaColuna('DATA','Data', 80,tcCampoData);
  CriaColuna('HORA','Hora', 80,tcHora);
  CriaColuna('NOMECLIENTE','Cliente', 200,tcString);
  CriaColuna('VALORTOTALLIQUIDO','Total', 100,tcMoeda);
  CriaColuna('FLAGCANCELADO','Cancelado', 60,tcString);
  CriaColuna('LOGIN','Usuário', 80,tcString);
  CampoOrdem := ' NUMSERVICO DESC ';
  TipoPesquisa := tpCsServicos;

end;

procedure TfrmLst_Servicos.FormShow(Sender: TObject);
begin
  inherited;
  AtuDados;
  actNovo.Visible := GetPermissao(IdCheckout);
  actEditar.Visible := GetPermissao(IdListagemServicoEditar);
  actExcluir.Visible := GetPermissao(IdListagemServicoExcluir);
  actImpComprovante.Visible := GetPermissao(IdListagemServicoComprovante);
  actImprimir.Visible := GetPermissao(IdListagemServicoRelatorio);
  actImpVariosComprovantes.Visible := actImprimir.Visible ;
  RegistraAuditoria('Acessou '+Self.Caption,'', '',Self.Name,Self.Caption,'',toAbrir,nil, False, True );
end;

end.
