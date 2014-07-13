unit Cad_usuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCad_CadastroPaiCS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ComCtrls, DB, DBClient, pFIBClientDataSet, ActnList,
  cxPC, cxContainer, cxEdit, cxTreeView, Buttons, ExtCtrls, StdCtrls, Mask,
  DBCtrls, LabelDBEdit, cxCustomData, cxStyles, cxTL, cxTLdxBarBuiltInMenu,
  cxInplaceContainer, cxTLData, cxDBTL, cxMaskEdit, cxImageComboBox,
  cxEditRepositoryItems, Menus;

type
  TfrmCad_usuario = class(TfrmCad_CadastroPaiCS)
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    LabelDBEdit3: TLabelDBEdit;
    LabelDBEdit1: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    DBCheckBox1: TDBCheckBox;
    cxDBTreeList1: TcxDBTreeList;
    CdsAcessos: TpFIBClientDataSet;
    DataAcessos: TDataSource;
    cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn;
    cxDBTreeList1cxDBTreeListColumn2: TcxDBTreeListColumn;
    cxEditRepository1: TcxEditRepository;
    cxEditRepository1ImageComboBoxItem1: TcxEditRepositoryImageComboBoxItem;
    Label1: TLabel;
    actMudaAcesso: TAction;
    procedure CdsCadastroAfterScroll(DataSet: TDataSet);
    procedure CdsAcessosAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
    procedure CdsCadastroAfterPost(DataSet: TDataSet);
    procedure cxDBTreeList1DblClick(Sender: TObject);
    procedure actMudaAcessoExecute(Sender: TObject);
  private
    { Private declarations }
    Procedure MudaAcesso;
  public
    { Public declarations }
  end;

var
  frmCad_usuario: TfrmCad_usuario;

implementation

uses Comandos, MinhasClasses, UDmConexao;

{$R *.dfm}

procedure TfrmCad_usuario.actMudaAcessoExecute(Sender: TObject);
begin
  inherited;
  MudaAcesso;
end;

procedure TfrmCad_usuario.CdsAcessosAfterOpen(DataSet: TDataSet);
begin
  inherited;
  CdsAcessos.FieldByName('DESCRICAO').ProviderFlags := [];
  CdsAcessos.FieldByName('CLASSIFICACAO').ProviderFlags := [];
  CdsAcessos.FieldByName('IDPAI').ProviderFlags := [];
  CdsAcessos.FieldByName('FLAGEDICAO').ProviderFlags := [];
end;

procedure TfrmCad_usuario.CdsCadastroAfterPost(DataSet: TDataSet);
begin
  inherited;
  SetRegistros(CdsAcessos, tpCSUsuarioAcesso);
end;

procedure TfrmCad_usuario.CdsCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  SetCds(CdsAcessos, tpCSUsuarioAcesso, 'IDUSUARIO = '+CdsCadastro.FieldByName('IDUSUARIO').AsString );
end;

procedure TfrmCad_usuario.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('FLAGADMINISTRADOR').AsString := 'N';
end;

procedure TfrmCad_usuario.cxDBTreeList1DblClick(Sender: TObject);
begin
  inherited;
  MudaAcesso;
end;

procedure TfrmCad_usuario.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa :=tpCSUsuario;
end;


procedure TfrmCad_usuario.MudaAcesso;
begin
  MudaEstado;

  if CdsAcessos.State in [dsInsert, dsEdit] then
    CdsAcessos.Post
  else
    CdsAcessos.Edit;

  if CdsAcessos.FieldByName('FLAGPERMITIDO').AsString = 'Y' then
    CdsAcessos.FieldByName('FLAGPERMITIDO').AsString := 'N'
  else
    CdsAcessos.FieldByName('FLAGPERMITIDO').AsString := 'Y';

  if CdsAcessos.FieldByName('IDACESSOUSUARIO').AsString = '' then
  Begin
    CdsAcessos.FieldByName('IDACESSOUSUARIO').AsInteger := GetValSeq('SEQ_IDACESSOUSUARIO');
    CdsAcessos.FieldByName('IDUSUARIO').AsInteger := CdsCadastro.FieldByName('IDUSUARIO').AsInteger;
    CdsAcessos.FieldByName('FLAGEDICAO').AsString :='I';
  End ELSE
    if CdsAcessos.FieldByName('FLAGEDICAO').AsString = 'N' then
       CdsAcessos.FieldByName('FLAGEDICAO').AsString := 'E';

  CdsAcessos.Post;

end;

end.

