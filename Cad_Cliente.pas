unit Cad_Cliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCad_CadastroPaiCS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ComCtrls, DB, DBClient, pFIBClientDataSet, ActnList,
  cxPC, cxContainer, cxTreeView, Buttons, ExtCtrls, StdCtrls, Mask, DBCtrls,
  LabelDBEdit, EditPesquisa, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,MinhasClasses,
  Cad_CadastroPai, Menus;

type
  TfrmCad_Cliente = class(TfrmCad_CadastroPaiCS)
    LabelDBEdit1: TLabelDBEdit;
    edtNome: TLabelDBEdit;
    LabelDBEdit7: TLabelDBEdit;
    LabelDBEdit8: TLabelDBEdit;
    LabelDBEdit9: TLabelDBEdit;
    LabelDBEdit10: TLabelDBEdit;
    GroupBox1: TGroupBox;
    edtBairro: TLabelDBEdit;
    edtCidade: TLabelDBEdit;
    edtUf: TLabelDBEdit;
    edtNumero: TLabelDBEdit;
    LabelDBEdit12: TLabelDBEdit;
    grpTipoPessoa: TDBRadioGroup;
    pnlJuridica: TPanel;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit13: TLabelDBEdit;
    LabelDBEdit14: TLabelDBEdit;
    LabelDBEdit15: TLabelDBEdit;
    pnlFisica: TPanel;
    LabelDBEdit3: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    LabelDBEdit5: TLabelDBEdit;
    LabelDBEdit6: TLabelDBEdit;
    LabelDBEdit16: TLabelDBEdit;
    edtLogradouro: TLabelDBEdit;
    edtPesqCEP: TSpeedButton;
    edtCEP: TLabelDBEdit;
    actIntegracao: TAction;
    actIntServicos: TAction;
    Integrao1: TMenuItem;
    Desseregistro2: TMenuItem;
    GroupBox2: TGroupBox;
    DBMemo1: TDBMemo;
    LabelDBEdit11: TLabelDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
    procedure actNovoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grpTipoPessoaChange(Sender: TObject);
    procedure edtPesqCEPClick(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
    procedure actIntegracaoExecute(Sender: TObject);
    procedure actIntServicosExecute(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    Procedure ABrePesquisaCep(pCep: String = '');
    Procedure AtualizaPermissoes;Override;
  end;

var
  frmCad_Cliente: TfrmCad_Cliente;

implementation

uses  Comandos, UDmConexao, uPesquisa_kimera, uLibCS, uLst_Servicos,
  uRelClientes;

{$R *.dfm}

procedure TfrmCad_Cliente.ABrePesquisaCep(pCep: String);
begin
  MudaEstado;
  Try
    frmPesquisa:= TfrmPesquisa.Create(nil);
    frmPesquisa.TipoPesquisa := tpImoCEP;
    frmPesquisa.edtPesquisa.Text := pCep;
    if frmPesquisa.ShowModal = mrOk Then
    Begin
      CdsCadastro.FieldByName('CEP').AsString :=     frmPesquisa.cdsPesquisa.FieldByName('CEP').AsString;
      CdsCadastro.FieldByName('LOGRADOURO').AsString :=     frmPesquisa.cdsPesquisa.FieldByName('LOGRADOURO').AsString;
      CdsCadastro.FieldByName('BAIRRO').AsString := frmPesquisa.cdsPesquisa.FieldByName('BAIRRO').AsString;
      CdsCadastro.FieldByName('CIDADE').AsString := frmPesquisa.cdsPesquisa.FieldByName('CIDADE').AsString;
      CdsCadastro.FieldByName('UF').AsString :=     frmPesquisa.cdsPesquisa.FieldByName('UF').AsString;

    End;
  Finally
    FreeAndNil(frmPesquisa);
  End;

end;

procedure TfrmCad_Cliente.actImprimirExecute(Sender: TObject);
begin
  inherited;
  frmRelClientes := TfrmRelClientes.Create(nil);
  Try
    frmRelClientes.ShowModal;
  Finally
    FreeAndNil(frmRelClientes);
  End;
end;

procedure TfrmCad_Cliente.actIntegracaoExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmCad_Cliente.actIntServicosExecute(Sender: TObject);
begin
  inherited;
  Try
    if frmLst_Servicos = nil then
      frmLst_Servicos := TfrmLst_Servicos.Create(nil);
    if frmLst_Servicos.Showing then
      frmLst_Servicos.Close;

    frmLst_Servicos.Wr :=' and S.IDCLIENTE = '+ValorChave;
    frmLst_Servicos.ShowModal;
  Finally
    FreeAndNil(frmLst_Servicos);
  End;

end;

procedure TfrmCad_Cliente.actNovoExecute(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
end;

procedure TfrmCad_Cliente.AtualizaPermissoes;
begin
  inherited;
  actNovo.Visible := GetPermissao(IdCadastroClienteNovo);
  actEditar.Visible := GetPermissao(IdCadastroClienteEditar);
  actDeletar.Visible := GetPermissao(IdCadastroClienteExcluir);
  actIntegracao.Visible := GetPermissao(IdListagemServico)
end;

procedure TfrmCad_Cliente.CdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
//  CdsCadastro.FieldByName('BAIRRO').ProviderFlags := [];
//  CdsCadastro.FieldByName('CEP').ProviderFlags := [];
//  CdsCadastro.FieldByName('CIDADE').ProviderFlags := [];
//  CdsCadastro.FieldByName('UF').ProviderFlags := [];
//  CdsCadastro.FieldByName('LOGRADOURO').ProviderFlags := [];
//  CdsCadastro.FieldByName('CPF_CNPJ').ProviderFlags := [];
  FormataMascara(CdsCadastro.FieldByName('CPF'),tcCPF);
  FormataMascara(CdsCadastro.FieldByName('CNPJ'),tcCNPJ);
  FormataMascara(CdsCadastro.FieldByName('DATANASCIMENTO'),tcCampoData);
  FormataMascara(CdsCadastro.FieldByName('DATAEMISSAO'),tcCampoData);
  FormataMascara(CdsCadastro.FieldByName('CEP'),tcCEP);
end;

procedure TfrmCad_Cliente.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('FLAGTIPOPESSOA').AsString := 'J';
  //CdsCadastro.FieldByName('CODIGO').AsString := PadL(CdsCadastro.FieldByName('CODIGO').AsString,6,'0');
  CdsCadastro.FieldByName('DATACADASTRO').AsString := GetDataServidor;
end;

procedure TfrmCad_Cliente.grpTipoPessoaChange(Sender: TObject);
begin
  inherited;
  pnlJuridica.Visible := grpTipoPessoa.ItemIndex = 1; //CdsCadastro.FieldByName('FLAGTIPOPESSOA').AsString = 'J';
  pnlFisica.Visible := not pnlJuridica.Visible ;
end;

procedure TfrmCad_Cliente.edtCEPExit(Sender: TObject);
begin
  inherited;
  if Pergunta('Deseja pesquisar o CEP?') then
    AbrePesquisaCep(edtCEP.Text);
end;

procedure TfrmCad_Cliente.edtPesqCEPClick(Sender: TObject);
begin
  inherited;
  AbrePesquisaCep;

end;

procedure TfrmCad_Cliente.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpCsCliente;
  VerificaEdits := True;

end;

procedure TfrmCad_Cliente.FormShow(Sender: TObject);
begin
  inherited;
  if NovoReg or EditReg then
    edtNome.SetFocus;
end;

end.
