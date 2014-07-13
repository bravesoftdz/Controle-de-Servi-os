unit uCad_CadastroPaiCS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Cad_CadastroPai, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ComCtrls, DB, DBClient, pFIBClientDataSet, ActnList,
  cxPC, cxContainer, cxEdit, cxTreeView, Buttons, ExtCtrls, Menus, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter;

type
  TfrmCad_CadastroPaiCS = class(TfrmCad_CadastroPai)
    MainMenu1: TMainMenu;
    actAuditoria: TAction;
    actAudDesteRegistro: TAction;
    actDessaTabela: TAction;
    Auditoria1: TMenuItem;
    Desseregistro1: TMenuItem;
    Dessatabela1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure actDeletarExecute(Sender: TObject);
    procedure actAuditoriaExecute(Sender: TObject);
    procedure actAudDesteRegistroExecute(Sender: TObject);
    procedure actDessaTabelaExecute(Sender: TObject);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure AtualizaPermissoes;Virtual;

  end;

var
  frmCad_CadastroPaiCS: TfrmCad_CadastroPaiCS;

implementation

uses uLibCS, MinhasClasses, uAuditoria;

{$R *.dfm}


procedure TfrmCad_CadastroPaiCS.actAudDesteRegistroExecute(Sender: TObject);
begin
  inherited;
  frmAuditoria := TfrmAuditoria.Create(nil);
  Try
    frmAuditoria.Filtro := ' AND TABELA = '+QuotedStr(NomeTabela)+ ' AND IDTABELA ='+ValorChave;
    frmAuditoria.ShowModal;
  Finally
    FreeAndNil(frmAuditoria);
  End;
end;

procedure TfrmCad_CadastroPaiCS.actAuditoriaExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmCad_CadastroPaiCS.actDeletarExecute(Sender: TObject);
begin
  inherited;
  if TipoAlteracao = taDeleta then
    RegistraAuditoria('Apagou um  registro em '+Self.Caption,'O Usuário '+USuarioLogado.Login+' apagou um registro ',
                      Self.NomeTabela,Self.Name,Self.Caption,Self.ValorChave,toDeletar,CdsCadastro, False, True );

end;

procedure TfrmCad_CadastroPaiCS.actDessaTabelaExecute(Sender: TObject);
begin
  inherited;
  frmAuditoria := TfrmAuditoria.Create(nil);
  Try
    frmAuditoria.Filtro := ' AND TABELA = '+QuotedStr(NomeTabela);
    frmAuditoria.ShowModal;
  Finally
    FreeAndNil(frmAuditoria);
  End;
end;

procedure TfrmCad_CadastroPaiCS.AtualizaPermissoes;
begin

end;

procedure TfrmCad_CadastroPaiCS.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  if TipoAlteracao = taInsere then
    RegistraAuditoria('Criou um novo registro em '+Self.Caption,'O Usuário '+USuarioLogado.Login+' criou um novo registro ',
                      Self.NomeTabela, Self.Name,Self.Caption,Self.ValorChave, toIncluir,CdsCadastro,  False, False );
  if TipoAlteracao = taModifica then
    RegistraAuditoria('Editou um  registro em '+Self.Caption,'O Usuário '+USuarioLogado.Login+' editou um registro ',
                      Self.NomeTabela,Self.Name,Self.Caption,Self.ValorChave, toEditar,CdsCadastro,
                       False, False );
end;

procedure TfrmCad_CadastroPaiCS.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  if CdsCadastro.FindField('IDUSUARIO') <> NIL then
    CdsCadastro.FieldByName('IDUSUARIO').AsInteger := USuarioLogado.Id;

end;

procedure TfrmCad_CadastroPaiCS.FormShow(Sender: TObject);
begin
  inherited;
  AtualizaPermissoes;
  RegistraAuditoria('Acessou '+Self.Caption,'', Self.NomeTabela,Self.Name,Self.Caption,'',toAbrir,nil, False, True );

end;


end.
