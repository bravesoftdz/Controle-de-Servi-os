unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,uPrincipalPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ActnList, Menus, dxBar, dxStatusBar, dxRibbonStatusBar,
  cxClasses, dxRibbon, ExtCtrls, StdCtrls, Buttons, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, DBClient,
  pFIBClientDataSet, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxSplitter, ImgList, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinsdxBarPainter, dxSkinscxPCPainter;

type
  TfrmPrincipal = class(TfrmPrincipalPadrao)
    actCadastro: TAction;
    actEmpresa: TAction;
    Cadastro1: TMenuItem;
    Empresa1: TMenuItem;
    actCadCliente: TAction;
    Cliente1: TMenuItem;
    actCEP: TAction;
    CEP1: TMenuItem;
    actCadServico: TAction;
    Servios1: TMenuItem;
    actListagemServicos: TAction;
    actServicos: TAction;
    Servios2: TMenuItem;
    ListagemdeServios1: TMenuItem;
    actVenda: TAction;
    Checkout1: TMenuItem;
    actImporta: TAction;
    Empresa2: TMenuItem;
    actCadCFOP: TAction;
    CFOP1: TMenuItem;
    dxRibbon1Tab1: TdxRibbonTab;
    Ribbon: TdxRibbon;
    dxBarManager1Bar1: TdxBar;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    dxBarManager1Bar2: TdxBar;
    dxBarButton7: TdxBarButton;
    dxBarButton8: TdxBarButton;
    dxBarButton9: TdxBarButton;
    actCadMarca: TAction;
    actServAGenda: TAction;
    dxBarButton10: TdxBarButton;
    CdsAgenda: TpFIBClientDataSet;
    DataAgenda: TDataSource;
    actCadBanco: TAction;
    dxBarButton11: TdxBarButton;
    dxBarButton12: TdxBarButton;
    actCadConta: TAction;
    cxSplitter1: TcxSplitter;
    Timer: TTimer;
    actCadUsuario: TAction;
    dxBarButton13: TdxBarButton;
    dxBarManager1Bar3: TdxBar;
    actLogOut: TAction;
    dxBarButton14: TdxBarButton;
    actBloqSistema: TAction;
    dxBarButton15: TdxBarButton;
    actAuditoria: TAction;
    dxBarButton16: TdxBarButton;
    cxImageList1: TcxImageList;
    actCadCombustivel: TAction;
    dxBarButton17: TdxBarButton;
    dxBarButton18: TdxBarButton;
    actCadStatusEquipamento: TAction;
    dxBarButton19: TdxBarButton;
    actUnidade: TAction;
    dxBarButton20: TdxBarButton;
    actCadFornecedor: TAction;
    dxBarButton21: TdxBarButton;
    actCadGrupoEquipamento: TAction;
    dxBarButton22: TdxBarButton;
    actCadTipoMaterial: TAction;
    dxBarButton23: TdxBarButton;
    actCadMaterial: TAction;
    dxBarButton24: TdxBarButton;
    actCadEquipamento: TAction;
    dxBarButton25: TdxBarButton;
    actCompraEquipamento: TAction;
    dxBarManager1Bar4: TdxBar;
    dxBarButton26: TdxBarButton;
    actCadLocalEstoque: TAction;
    dxBarButton27: TdxBarButton;
    actEntradaEquipamento: TAction;
    dxBarButton28: TdxBarButton;
    actManutencao: TAction;
    dxBarButton29: TdxBarButton;
    actEntradaMaterial: TAction;
    dxBarButton30: TdxBarButton;
    actTabelaPreco: TAction;
    dxBarButton31: TdxBarButton;
    actRelRecDespEquipamento: TAction;
    dxBarButton32: TdxBarButton;
    actRelMovimentacaoEquipamento: TAction;
    dxBarButton33: TdxBarButton;
    actRelDivergenciaManutencao: TAction;
    dxBarButton34: TdxBarButton;
    RibbonTab1: TdxRibbonTab;
    RibbonTab2: TdxRibbonTab;
    dxBarManager1Bar5: TdxBar;
    dxBarButton35: TdxBarButton;
    dxBarButton36: TdxBarButton;
    dxBarButton37: TdxBarButton;
    dxBarButton38: TdxBarButton;
    dxBarButton39: TdxBarButton;
    dxBarButton40: TdxBarButton;
    dxBarButton41: TdxBarButton;
    dxBarButton42: TdxBarButton;
    dxBarButton43: TdxBarButton;
    dxBarButton44: TdxBarButton;
    dxBarButton45: TdxBarButton;
    dxBarButton46: TdxBarButton;
    dxBarButton47: TdxBarButton;
    dxBarButton48: TdxBarButton;
    dxBarButton49: TdxBarButton;
    dxBarButton50: TdxBarButton;
    dxBarButton51: TdxBarButton;
    dxBarManager1Bar6: TdxBar;
    dxBarButton52: TdxBarButton;
    dxBarButton53: TdxBarButton;
    pnlDados: TPanel;
    GrpAgenda: TGroupBox;
    cxGrid1: TcxGrid;
    TvAgenda: TcxGridDBTableView;
    vAgendaColumn1: TcxGridDBColumn;
    vAgendaColumn2: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    grpEstoque: TGroupBox;
    cxSplitter2: TcxSplitter;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    DataProdutos: TDataSource;
    CdsProdutos: TpFIBClientDataSet;
    cxGrid2DBTableView1Column1: TcxGridDBColumn;
    cxGrid2DBTableView1Column2: TcxGridDBColumn;
    cxGrid2DBTableView1Column3: TcxGridDBColumn;
    cxGrid2DBTableView1Column4: TcxGridDBColumn;
    procedure actCadastroExecute(Sender: TObject);
    procedure actEmpresaExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actCadClienteExecute(Sender: TObject);
    procedure actCEPExecute(Sender: TObject);
    procedure actCadServicoExecute(Sender: TObject);
    procedure actListagemServicosExecute(Sender: TObject);
    procedure actServicosExecute(Sender: TObject);
    procedure actVendaExecute(Sender: TObject);
    procedure actCadCFOPExecute(Sender: TObject);
    procedure actCadMarcaExecute(Sender: TObject);
    procedure actServAGendaExecute(Sender: TObject);
    procedure actCadBancoExecute(Sender: TObject);
    procedure actCadContaExecute(Sender: TObject);
    procedure TvAgendaCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure TimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actCadUsuarioExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure actLogOutExecute(Sender: TObject);
    procedure actBloqSistemaExecute(Sender: TObject);
    procedure actAuditoriaExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actCadCombustivelExecute(Sender: TObject);
    procedure actCadStatusEquipamentoExecute(Sender: TObject);
    procedure actUnidadeExecute(Sender: TObject);
    procedure actCadFornecedorExecute(Sender: TObject);
    procedure actCadGrupoEquipamentoExecute(Sender: TObject);
    procedure actCadTipoMaterialExecute(Sender: TObject);
    procedure actCadMaterialExecute(Sender: TObject);
    procedure actCadEquipamentoExecute(Sender: TObject);
    procedure actCompraEquipamentoExecute(Sender: TObject);
    procedure actCadLocalEstoqueExecute(Sender: TObject);
    procedure actEntradaEquipamentoExecute(Sender: TObject);
    procedure actManutencaoExecute(Sender: TObject);
    procedure actEntradaMaterialExecute(Sender: TObject);
    procedure actTabelaPrecoExecute(Sender: TObject);
    procedure actRelRecDespEquipamentoExecute(Sender: TObject);
    procedure actRelMovimentacaoEquipamentoExecute(Sender: TObject);
    procedure actRelDivergenciaManutencaoExecute(Sender: TObject);
  private
    { Private declarations }
    PodeVerAgenda: Boolean;
  public
    { Public declarations }
    Procedure VerificaAgenda;
    Procedure VerificaEstoqueMinimo;
    Procedure AtualizaPermissoes;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses Lst_Empresa, Cad_Cliente, Cad_CEP, Lst_Produtos, uLst_Servicos, uVenda,
     Lst_CadastroSimples, MinhasClasses, uAgenda, uLst_Conta, uSQL, uSQLCS,
  Comandos, uLibCS, Cad_usuario, uLstCadastroSimplesCS, uAuditoria,
  uLst_StatusEquipamento, uLst_Unidade, uCad_Fornecedor, uCad_Material,
  uCad_Equipamento, uLst_GrupoEquipamento, uLst_CompraEquipamento,
  uLst_EntradaEquipamento, uLst_Manutencao, uLst_EntradaMaterial,
  uCad_TabelaPreco, uRelDespRecEquipamento, uRelMovimentacaoEquipamento,
  uRelDivergenciaManutencao;

{$R *.dfm}

procedure TfrmPrincipal.actAuditoriaExecute(Sender: TObject);
begin
  inherited;
  frmAuditoria := TfrmAuditoria.Create(nil);
  Try
    frmAuditoria.ShowModal;
  Finally
    FreeAndNil(frmAuditoria);
  End;
end;

procedure TfrmPrincipal.actBloqSistemaExecute(Sender: TObject);
begin
  inherited;
  Entra(True);
end;

procedure TfrmPrincipal.actCadastroExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmPrincipal.actCadBancoExecute(Sender: TObject);
begin
  inherited;
  Try
    frmLstCadastroSimplesCS := TfrmLstCadastroSimplesCS.Create(nil);
    with frmLstCadastroSimplesCS do
    Begin
      TipoPesquisa :=tpCSBanco;
      ShowModal;
    End;
  Finally
    FreeAndNil(frmLstCadastroSimplesCS);

  End;
end;

procedure TfrmPrincipal.actCadCFOPExecute(Sender: TObject);
begin
  inherited;
  Try
    frmLstCadastroSimplesCS := TfrmLstCadastroSimplesCS.Create(nil);
    with frmLstCadastroSimplesCS do
    Begin
      TipoPesquisa :=tpCSCFOP;
      edtCodigo.DataField := 'CFOP';
      ShowModal;
    End;
  Finally
    FreeAndNil(frmLstCadastroSimplesCS);

  End;
end;

procedure TfrmPrincipal.actCadClienteExecute(Sender: TObject);
begin
  inherited;
  if frmCad_Cliente = nil then
    frmCad_Cliente := TfrmCad_Cliente.Create(nil);
  if frmCad_Cliente.Showing Then
    frmCad_Cliente.BringToFront
  else
   frmCad_Cliente.Show;

end;

procedure TfrmPrincipal.actCadCombustivelExecute(Sender: TObject);
begin
  inherited;
    Try
    frmLstCadastroSimplesCS := TfrmLstCadastroSimplesCS.Create(nil);
    with frmLstCadastroSimplesCS do
    Begin
      TipoPesquisa :=tpCSCombustivel;
      edtCodigo.DataField := 'CODIGO';
      ShowModal;
    End;
  Finally
    FreeAndNil(frmLstCadastroSimplesCS);

  End;
end;

procedure TfrmPrincipal.actCadContaExecute(Sender: TObject);
begin
  inherited;
  frmLst_Conta := TfrmLst_Conta.Create(nil);
  Try
    frmLst_Conta.ShowModal;
  Finally
    FreeAndNil(frmLst_Conta);
  End;
end;

procedure TfrmPrincipal.actCadEquipamentoExecute(Sender: TObject);
begin
  inherited;
   if frmCad_Equipamento = nil then
    frmCad_Equipamento := TfrmCad_Equipamento.Create(nil);

  if frmCad_Equipamento.Showing then
    frmCad_Equipamento.BringToFront
  else
   frmCad_Equipamento.Show;
end;

procedure TfrmPrincipal.actCadFornecedorExecute(Sender: TObject);
begin
  inherited;
  if frmCad_Fornecedor = nil then
    frmCad_Fornecedor := TfrmCad_Fornecedor.Create(nil);

  if frmCad_Fornecedor.Showing then
    frmCad_Fornecedor.BringToFront
  else
   frmCad_Fornecedor.Show;


end;

procedure TfrmPrincipal.actCadGrupoEquipamentoExecute(Sender: TObject);
begin
  inherited;
    Try
    frmLst_GrupoEquipamento := TfrmLst_GrupoEquipamento.Create(nil);
    with frmLst_GrupoEquipamento do
    Begin
      ShowModal;
    End;
  Finally
    FreeAndNil(frmLst_GrupoEquipamento);
  End;
end;

procedure TfrmPrincipal.actCadLocalEstoqueExecute(Sender: TObject);
begin
  inherited;
   Try
    frmLstCadastroSimples := TfrmLstCadastroSimples.Create(nil);
    with frmLstCadastroSimples do
    Begin
      TipoPesquisa :=tpCSLocalEstoque;
      ShowModal;
    End;
  Finally
    FreeAndNil(frmLstCadastroSimples);

  End;

end;

procedure TfrmPrincipal.actCadMarcaExecute(Sender: TObject);
begin
  inherited;
  Try
    frmLstCadastroSimples := TfrmLstCadastroSimples.Create(nil);
    with frmLstCadastroSimples do
    Begin
      TipoPesquisa :=tpCSMarca;
      ShowModal;
    End;
  Finally
    FreeAndNil(frmLstCadastroSimples);

  End;
end;

procedure TfrmPrincipal.actCadMaterialExecute(Sender: TObject);
begin
  inherited;
  if Cad_material = nil then
     Cad_material := TCad_material.Create(nil);
  if Cad_material.Showing then
    Cad_material.BringToFront
  else
    Cad_material.Show;
end;

procedure TfrmPrincipal.actCadServicoExecute(Sender: TObject);
begin
  inherited;
  if frmLstProdutos = nil then
     frmLstProdutos := TfrmLstProdutos.Create(nil);
  if frmLstProdutos.Showing then
    frmLstProdutos.BringToFront
  else
    frmLstProdutos.Show;


end;

procedure TfrmPrincipal.actCadStatusEquipamentoExecute(Sender: TObject);
begin
  inherited;
  frmLstStatusEquipamento := TfrmLstStatusEquipamento.Create(nil);
  Try
    frmLstStatusEquipamento.ShowModal;
  Finally
    FreeAndNil(frmLstStatusEquipamento);
  End;
end;

procedure TfrmPrincipal.actCadTipoMaterialExecute(Sender: TObject);
begin
  inherited;
  Try
    frmLstCadastroSimples := TfrmLstCadastroSimples.Create(nil);
    with frmLstCadastroSimples do
    Begin
      TipoPesquisa :=tpCSTipoMaterial;
      ShowModal;
    End;
  Finally
    FreeAndNil(frmLstCadastroSimples);

  End;
end;

procedure TfrmPrincipal.actCadUsuarioExecute(Sender: TObject);
begin
  inherited;
  if not USuarioLogado.Administrador then
  Begin
    Avisa('Somente usuário administrador');
    Exit;
  End;

  frmCad_usuario := TfrmCad_usuario.Create(nil);
  Try
    frmCad_usuario.ShowModal;
  Finally
    FreeAndNil(frmCad_usuario);
  End;
end;

procedure TfrmPrincipal.actCEPExecute(Sender: TObject);
begin
  inherited;
  frmCad_CEP := TfrmCad_CEP.Create(nil);
  Try
    frmCad_CEP.ShowModal;
  Finally
    FreeAndNil(frmCad_CEP);
  End;
end;

procedure TfrmPrincipal.actCompraEquipamentoExecute(Sender: TObject);
begin
  inherited;
  if frmLst_CompraEquipamentos = nil Then
    frmLst_CompraEquipamentos := TfrmLst_CompraEquipamentos.Create(nil);
  if frmLst_CompraEquipamentos.Showing then
    frmLst_CompraEquipamentos.BringToFront
  else
    frmLst_CompraEquipamentos.Show;

end;

procedure TfrmPrincipal.actEmpresaExecute(Sender: TObject);
begin
  inherited;
  frmLst_Empresa := TfrmLst_Empresa.Create(nil);
  Try
    frmLst_Empresa.ShowModal;
  Finally
    FreeAndNil(frmLst_Empresa);
  End;
end;

procedure TfrmPrincipal.actEntradaEquipamentoExecute(Sender: TObject);
begin
  inherited;
  if frmLst_EntradaEquipamento = nil then
    frmLst_EntradaEquipamento := TfrmLst_EntradaEquipamento.Create(nil);
  if frmLst_EntradaEquipamento.Showing then
    frmLst_EntradaEquipamento.BringToFront
  else
    frmLst_EntradaEquipamento.Show;

end;

procedure TfrmPrincipal.actEntradaMaterialExecute(Sender: TObject);
begin
  inherited;
  if frmLst_EntradaMaterial = nil then
  frmLst_EntradaMaterial := TfrmLst_EntradaMaterial.Create(nil);
  if frmLst_EntradaMaterial.Showing then
  frmLst_EntradaMaterial.BringToFront
  else
  frmLst_EntradaMaterial.Show;
  VerificaEstoqueMinimo;
end;

procedure TfrmPrincipal.actListagemServicosExecute(Sender: TObject);
begin
  inherited;
  if frmLst_Servicos = nil then
    frmLst_Servicos := TfrmLst_Servicos.Create(nil);
  if frmLst_Servicos.Showing then
    frmLst_Servicos.BringToFront
  else
    frmLst_Servicos.Show;


end;

procedure TfrmPrincipal.actLogOutExecute(Sender: TObject);
begin
  inherited;
  Entra;
  FormActivate(nil);
  Status.Panels[1].Text := USuarioLogado.Login;
end;

procedure TfrmPrincipal.actManutencaoExecute(Sender: TObject);
begin
  inherited;
  if frmLst_Manutencao = nil then
    frmLst_Manutencao := TfrmLst_Manutencao.Create(nil);
  if frmLst_Manutencao.Showing then
    frmLst_Manutencao.BringToFront
  else
    frmLst_Manutencao.Show;

end;

procedure TfrmPrincipal.actRelDivergenciaManutencaoExecute(Sender: TObject);
begin
  inherited;
  frmRelDivergenciaManutencao := TfrmRelDivergenciaManutencao.Create(nil);
  Try
    frmRelDivergenciaManutencao.ShowModal;
  Finally
    FreeAndNil(frmRelDivergenciaManutencao);
  End;
end;

procedure TfrmPrincipal.actRelMovimentacaoEquipamentoExecute(Sender: TObject);
begin
  inherited;
  frmRelMovimentacaoEquipamento := TfrmRelMovimentacaoEquipamento.Create(nil);
  Try
    frmRelMovimentacaoEquipamento.ShowModal;
  Finally
    FreeAndNil(frmRelMovimentacaoEquipamento);
  End;
end;

procedure TfrmPrincipal.actRelRecDespEquipamentoExecute(Sender: TObject);
begin
  inherited;
  frmRelDespRecEquipamento := TfrmRelDespRecEquipamento.Create(nil);
  Try
    frmRelDespRecEquipamento.ShowModal;
  Finally
    FreeAndNil(frmRelDespRecEquipamento);
  End;
end;

procedure TfrmPrincipal.actServAGendaExecute(Sender: TObject);
begin
  inherited;
  frmAgenda := TfrmAgenda.Create(nil);
  Try
    frmAgenda.ShowModal;
    VerificaAgenda;
  Finally
    FreeAndNil(frmAgenda);
  End;
end;

procedure TfrmPrincipal.actServicosExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmPrincipal.actTabelaPrecoExecute(Sender: TObject);
begin
  inherited;
  frmCad_TabelaPreco := TfrmCad_TabelaPreco.Create(nil);
  Try
    frmCad_TabelaPreco.ShowModal;
  Finally
    FreeAndNil(frmCad_TabelaPreco);
  End;
end;

procedure TfrmPrincipal.actUnidadeExecute(Sender: TObject);
begin
  inherited;
  frmLst_Unidade := TfrmLst_Unidade.Create(nil);
  Try
    frmLst_Unidade.ShowModal;
  Finally
    FreeAndNil(frmLst_Unidade);
  End;
end;

procedure TfrmPrincipal.actVendaExecute(Sender: TObject);
begin
  inherited;
  if frmVenda = nil then
    frmVenda := TfrmVenda.Create(nil);
  if frmVenda.Showing then
    frmVenda.BringToFront
  else
    frmVenda.Show;
  VerificaEstoqueMinimo;

end;

procedure TfrmPrincipal.AtualizaPermissoes;
var
  I: Integer;
begin
  {actCadCliente.Visible := GetPermissao(IdCadastroCliente);
  actCadServico.Visible := GetPermissao(IdCadastroTipoServico);
  actCadCFOP.Visible := GetPermissao(IdCadastroCFOP);
  actCEP.Visible := GetPermissao(IdCadastroCEP);
  actCadBanco.Visible := GetPermissao(IdCadastroBanco);
  actCadConta.Visible := GetPermissao(IdCadastroContasBancarias);
  actVenda.Visible := GetPermissao(IdCheckout);
  actListagemServicos.Visible := GetPermissao(IdListagemServico);
  actServAGenda.Visible := GetPermissao(IdAgenda);
  actEmpresa.Visible := GetPermissao(IdCadastroEmpresa);
  }



  actCadCliente.Tag := (IdCadastroCliente);
  actCadServico.Tag := (IdCadastroTipoServico);
  actCadCFOP.Tag := (IdCadastroCFOP);
  actCEP.Tag := (IdCadastroCEP);
  actCadBanco.Tag := (IdCadastroBanco);
  actCadConta.Tag := (IdCadastroContasBancarias);
  actVenda.Tag := (IdCheckout);
  actListagemServicos.Tag := (IdListagemServico);
  actServAGenda.Tag := (IdAgenda);
  actEmpresa.Tag := (IdCadastroEmpresa);
  actCadCombustivel.Tag := (IdCadastroCombustivel);
  actCadStatusEquipamento.Tag :=   IdStatusEquipamento;
  actCadFornecedor.Tag :=   IdCadastroFornecedor;

  actCompraEquipamento.Tag :=   IdCompraEquipamento;
  actEntradaEquipamento.Tag :=   IdEntradaEquipamento;
  actManutencao.Tag :=   IdCManutencaoEquipamento;
  actEntradaMaterial.Tag :=   IdCompraMaterial;
  actTabelaPreco.Tag :=   IdTabelaPreco;
  actRelRecDespEquipamento.Tag :=   IdRelDespesaReceita;
  actRelMovimentacaoEquipamento.Tag :=   IdRelMovimentacaoEquipamento;
  actRelDivergenciaManutencao.Tag :=   IdRelDivergenciaManutencao ;
  actCadMaterial.Tag  :=IdCadastroMaterial;
  actCadLocalEstoque.Tag := IdCadastroLocalEstoque;

  actCadEquipamento.Tag := IdCadastroEquipamento;
  actCadMarca.Tag :=IdCadastroMarca;
  actCadGrupoEquipamento.Tag := IdCadastroGrupoEquipamento;
  actCadTipoMaterial.Tag := IdTipoMaterial;
  actUnidade.Tag := IdUnidade;

  for I := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TAction then
    Begin
      (Components[i] as TAction).Visible := GetPermissao((Components[i] as TAction).Tag);
      (Components[i] as TAction).Enabled := GetPermissao((Components[i] as TAction).Tag);
    End;
  end;

  grpEstoque.Visible := GetPermissao(IdViewEstoque);

end;

procedure TfrmPrincipal.FormActivate(Sender: TObject);
begin
  inherited;
  AtualizaAcessos;
  AtualizaPermissoes;
  PodeVerAgenda := GetPermissao(IdAgenda);
  VerificaAgenda;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  RegistraAuditoria('Entrou no sistema','','',Self.Name,'Login','',toLogoff,nil, False, True );
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  inherited;
 // Menu := MainMenu;
 Timer.Interval :=  300000;
 Timer.Enabled := True;
 RegistraAcessos;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  inherited;
 // VerificaAgenda;
end;


procedure TfrmPrincipal.TimerTimer(Sender: TObject);
begin
  inherited;
  VerificaAgenda;
end;

procedure TfrmPrincipal.TvAgendaCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
    frmAgenda := TfrmAgenda.Create(nil);
  Try
    frmAgenda.IdAgenda := CdsAgenda.FieldByName('idagenda').AsInteger;
    frmAgenda.ShowModal;
    VerificaAgenda;
  Finally
    FreeAndNil(frmAgenda);
  End;
end;

procedure TfrmPrincipal.VerificaAgenda;
var
  Filtro: String;
begin
  GrpAgenda.Visible := False;
  if not PodeVerAgenda then
    Exit;
  Filtro := '  DATACOMPROMISSO <= CURRENT_DATE+2 AND  COALESCE(A.FLAGBAIXADO,''N'') = ''N'' ';
  Try
    CdsAgenda.DisableControls;
    SetCds(CdsAgenda,tpcsAgenda,Filtro);
    CdsAgenda.EnableControls;
  Finally

  End;
  GrpAgenda.Visible := CdsAgenda.RecordCount > 0;

  VerificaEstoqueMinimo;
end;

procedure TfrmPrincipal.VerificaEstoqueMinimo;
begin
  if grpEstoque.Visible then
  begin
    Try
      CdsProdutos.DisableControls;
      SetCds(CdsProdutos,tpCSMaterial,' COALESCE(M.ESTOQUETOTAL,0) < COALESCE(M.ESTOQUEMINIMO,0) ');
    Finally
      CdsProdutos.EnableControls;
    End;
    if not GrpAgenda.Visible then
      grpEstoque.Align := alClient
    else
    begin
      grpEstoque.Align := alBottom;
      grpEstoque.Height := 170;
      GrpAgenda.Align := alClient;
    end;
    grpEstoque.Visible := not CdsProdutos.IsEmpty;
  end;
  pnlDados.Visible := grpEstoque.Visible or  GrpAgenda.Visible ;

end;

end.
