unit uLstCadastroSimplesCS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Lst_CadastroSimples, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxTL, cxTLdxBarBuiltInMenu, DBClient,
  pFIBClientDataSet, Menus, ActnList, cxInplaceContainer, cxTLData, cxDBTL,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxPC, ComCtrls, ToolWin, StdCtrls,
  Buttons, Mask, DBCtrls, LabelDBEdit, cxSplitter, ExtCtrls, dxSkinsCore,
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
  TfrmLstCadastroSimplesCS = class(TfrmLstCadastroSimples)
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure actExcluirExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLstCadastroSimplesCS: TfrmLstCadastroSimplesCS;

implementation

uses uLibCS, MinhasClasses;

{$R *.dfm}

procedure TfrmLstCadastroSimplesCS.actExcluirExecute(Sender: TObject);
begin
  inherited;
  if TipoAlteracao = taDeleta then
    RegistraAuditoria('Apagou um  registro em '+Self.Caption,'O Usuário '+USuarioLogado.Login+' apagou um registro ',
                      Self.NomeTabela,Self.Name,Self.Caption,Self.ValorChave,toDeletar,CdsCadastro, False, True );

end;

procedure TfrmLstCadastroSimplesCS.CdsCadastroAfterPost(DataSet: TDataSet);
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

procedure TfrmLstCadastroSimplesCS.FormShow(Sender: TObject);
begin
  inherited;
  RegistraAuditoria('Acessou '+Self.Caption,'', Self.NomeTabela,Self.Name,Self.Caption,'',toAbrir,nil, False, True );
end;

end.
