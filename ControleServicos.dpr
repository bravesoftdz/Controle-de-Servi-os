program ControleServicos;

uses
  ExceptionLog,
  Forms,
  SysUtils,
  MidasLib,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uSQL in '..\Global\uSQL.pas',
  Comandos in '..\Global\Comandos.pas',
  MinhasClasses in '..\Global\MinhasClasses.pas',
  UDmConexao in '..\Global\UDmConexao.pas' {DMConexao: TDataModule},
  uDmRelatorio in '..\Global\uDmRelatorio.pas' {DmRelatorio: TDataModule},
  uFormPadrao in '..\Global\uFormPadrao.pas' {frmPadrao},
  uMetodosRB in '..\Global\uMetodosRB.pas',
  uPrincipalPadrao in '..\Global\uPrincipalPadrao.pas' {frmPrincipalPadrao},
  Cad_CadastroPai in '..\Global\Cad_CadastroPai.pas' {frmCad_CadastroPai},
  Dlg_Cadastro in '..\Global\Dlg_Cadastro.pas' {frmDlg_Cadastro},
  Lst_CadastroSimples in '..\Global\Lst_CadastroSimples.pas' {frmLstCadastroSimples},
  uAguarde in '..\Global\uAguarde.pas' {frmAguarde},
  UdlgRelatorioPadrao in '..\Global\UdlgRelatorioPadrao.pas' {frmdlgRelatorioPadrao},
  uLista_Layouts in '..\Global\uLista_Layouts.pas' {frmLista_Layouts},
  uPesquisa_kimera in '..\Global\uPesquisa_kimera.pas' {frmPesquisa},
  uSQLCS in 'uSQLCS.pas',
  uExtenso in '..\Global\uExtenso.pas',
  uRelServicos in 'uRelServicos.pas' {frmRelServicos},
  uListagemPadrao in '..\Global\uListagemPadrao.pas' {frmListagemPadrao},
  Lst_Empresa in 'Lst_Empresa.pas' {frmLst_Empresa},
  Cad_Servico in 'Cad_Servico.pas' {frmCad_Servico},
  Cad_Cliente in 'Cad_Cliente.pas' {frmCad_Cliente},
  Cad_CEP in 'Cad_CEP.pas' {frmCad_CEP},
  uVenda in 'uVenda.pas' {frmVenda},
  uFechamento in 'uFechamento.pas' {frmFechamento},
  Lst_Produtos in 'Lst_Produtos.pas' {frmLstProdutos},
  uLst_Servicos in 'uLst_Servicos.pas' {frmLst_Servicos},
  Cad_Item in 'Cad_Item.pas' {frmCad_Itens},
  uLibCS in 'uLibCS.pas',
  uAgenda in 'uAgenda.pas' {frmAgenda},
  Cad_Agenda in 'Cad_Agenda.pas' {frmCad_Agenda},
  uLst_Conta in 'uLst_Conta.pas' {frmLst_Conta},
  uLibLicenca in '..\Global\uLibLicenca.pas',
  uCad_CadastroPaiCS in 'uCad_CadastroPaiCS.pas' {frmCad_CadastroPaiCS},
  Cad_usuario in 'Cad_usuario.pas' {frmCad_usuario},
  uLogin in 'uLogin.pas' {frmLogin},
  uLstCadastroSimplesCS in 'uLstCadastroSimplesCS.pas' {frmLstCadastroSimplesCS},
  uAuditoria in 'uAuditoria.pas' {frmAuditoria},
  uLst_StatusEquipamento in 'uLst_StatusEquipamento.pas' {frmLstStatusEquipamento},
  uLst_Unidade in 'uLst_Unidade.pas' {frmLst_Unidade},
  uCad_Fornecedor in 'uCad_Fornecedor.pas' {frmCad_Fornecedor},
  uCad_Material in 'uCad_Material.pas' {Cad_material},
  uCad_Equipamento in 'uCad_Equipamento.pas' {frmCad_Equipamento},
  uRelEquipamento in 'uRelEquipamento.pas' {frmRelEquipamento},
  uRelClientes in 'uRelClientes.pas' {frmRelClientes},
  uDlg_ArvorePeca in 'uDlg_ArvorePeca.pas' {frmDlg_ArvorePeca},
  uLst_GrupoEquipamento in 'uLst_GrupoEquipamento.pas' {frmLst_GrupoEquipamento},
  uPesquisaEquipamento in 'uPesquisaEquipamento.pas' {frmPesquisaEquipamento},
  uRelPadraoCS in 'uRelPadraoCS.pas' {frmRelPadraoCS},
  uLst_CompraEquipamento in 'uLst_CompraEquipamento.pas' {frmLst_CompraEquipamentos},
  uCad_CompraEquipamento in 'uCad_CompraEquipamento.pas' {frmCad_CompraEquipamento},
  udlg_CompraEquipamentosItens in 'udlg_CompraEquipamentosItens.pas' {frmDlg_CompraEquipamentoItens},
  uDlg_SaidaEquipamento in 'uDlg_SaidaEquipamento.pas' {frmDlg_SaidaEquipamento},
  uLst_EntradaEquipamento in 'uLst_EntradaEquipamento.pas' {frmLst_EntradaEquipamento},
  uCad_EntradaEquipamento in 'uCad_EntradaEquipamento.pas' {frmCad_EntradaEquipamento},
  uDlg_EntradaEquipamento in 'uDlg_EntradaEquipamento.pas' {frmDlg_EntradaEquipamento},
  uLst_Manutencao in 'uLst_Manutencao.pas' {frmLst_Manutencao},
  uCad_Manutencao in 'uCad_Manutencao.pas' {frmCad_manutencao},
  uLst_EntradaMaterial in 'uLst_EntradaMaterial.pas' {frmLst_EntradaMaterial},
  uCad_TabelaPreco in 'uCad_TabelaPreco.pas' {frmCad_TabelaPreco},
  uRelDespRecEquipamento in 'uRelDespRecEquipamento.pas' {frmRelDespRecEquipamento},
  uRelMovimentacaoEquipamento in 'uRelMovimentacaoEquipamento.pas' {frmRelMovimentacaoEquipamento},
  uRelDivergenciaManutencao in 'uRelDivergenciaManutencao.pas' {frmRelDivergenciaManutencao},
  uRelManutencao in 'uRelManutencao.pas' {frmRelManutencao},
  uRelMateriais in 'uRelMateriais.pas' {frmRelMateriais},
  uMultiComprovante in 'uMultiComprovante.pas' {frmMultiComprovante};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  InfoSistema.LocalBancoDados := 'D:\Meus Projetos\Bancos\ControleServico.fdb';
  if not FileExists(InfoSistema.LocalBancoDados) then
    InfoSistema.LocalBancoDados := ExtractFilePath(Application.ExeName)+'ControleServico.fdb';
  InfoSistema.NomeBanco :='ControleServico.fdb';
  InfoSistema.Host := '127.0.0.1';
  InfoSistema.UsaBancoDados := True;
  InfoSistema.Sistema := sControleServico;
  InfoSistema.VerificaLicenca := False;
  InfoSistema.SQLs := TSQLCS.Create;

  Application.Title := 'Controle de Serviços';

  if Entra then
  Begin
//    ClassePadrao.vOnException := Application.OnException;
//    Application.OnException := ClassePadrao.OnExcept;
    Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
  End else
  Begin
    Application.ProcessMessages;
    DMConexao.Free;
    DMConexao := nil;
    Application.Terminate;
  End;

end.
