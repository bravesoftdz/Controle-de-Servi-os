unit Cad_CEP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCad_CadastroPaiCS, ComCtrls, DB, DBClient, ActnList, cxPC, cxControls,
  cxContainer, cxTreeView, Buttons, ExtCtrls, StdCtrls, Mask, DBCtrls,
  LabelDBEdit,  pFIBClientDataSet, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxEdit, Cad_CadastroPai;

type
  TfrmCad_CEP = class(TfrmCad_CadastroPaiCS)
    edtCEP: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    LabelDBEdit3: TLabelDBEdit;
    LabelDBEdit4: TLabelDBEdit;
    Label1: TLabel;
    cmbUF: TDBComboBox;
    procedure FormCreate(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
    procedure actNovoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure AtualizaPermissoes;Override;
  end;

var
  frmCad_CEP: TfrmCad_CEP;

implementation

uses Comandos, MinhasClasses, uLibCS;



{$R *.dfm}

procedure TfrmCad_CEP.actGravarExecute(Sender: TObject);
begin
  VerificaEdits := True;
  if cmbUF.Text = '' then
  Begin
    Avisa('Informe a UF');
    cmbUF.SetFocus;
    Exit;
  End;
  inherited;
end;

procedure TfrmCad_CEP.actNovoExecute(Sender: TObject);
begin
  inherited;
  edtCEP.SetFocus;
end;

procedure TfrmCad_CEP.AtualizaPermissoes;
begin
  inherited;
  actNovo.Visible := GetPermissao(IdCadastroCEPNovo);
  actEditar.Visible := GetPermissao(IdCadastroCEPEditar);
  actDeletar.Visible := GetPermissao(IdCadastroCEPExcluir);

end;

procedure TfrmCad_CEP.CdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsCadastro.FieldByName('cep'), tcCEP);
end;

procedure TfrmCad_CEP.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpImoCEP;

  
end;

end.
