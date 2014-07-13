unit uLst_CompraEquipamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uListagemPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, pFIBClientDataSet, ActnList,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxPC, StdCtrls, Buttons,
  dxStatusBar, ExtCtrls;

type
  TfrmLst_CompraEquipamentos = class(TfrmListagemPadrao)
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLst_CompraEquipamentos: TfrmLst_CompraEquipamentos;

implementation

uses MinhasClasses, uCad_CompraEquipamento;

{$R *.dfm}

procedure TfrmLst_CompraEquipamentos.actEditarExecute(Sender: TObject);
begin
  inherited;
  frmCad_CompraEquipamento := TfrmCad_CompraEquipamento.Create(nil);
  Try
    frmCad_CompraEquipamento.EditReg := True;
    frmCad_CompraEquipamento.ValorChave := Self.CdsListagem.FieldByName('IDCOMPRAEQUIPAMENTO').AsString;
    frmCad_CompraEquipamento.ShowModal;
    AtuDados;
  Finally
    FreeAndNil(frmCad_CompraEquipamento );
  End;
end;

procedure TfrmLst_CompraEquipamentos.actNovoExecute(Sender: TObject);
begin
  inherited;
  frmCad_CompraEquipamento := TfrmCad_CompraEquipamento.Create(nil);
  Try
    frmCad_CompraEquipamento.NovoReg := True;
    frmCad_CompraEquipamento.ShowModal;
    AtuDados;
  Finally
    FreeAndNil(frmCad_CompraEquipamento );
  End;
end;

procedure TfrmLst_CompraEquipamentos.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpCSCompraEquipamento;
  CriaColuna('DATA','Data',80, tcCampoData);
  CriaColuna('HORA','Hora',80, tcHora);
  CriaColuna('RAZAOSOCIAL','Fornecedor',150, tcString);
  CriaColuna('DOCUMENTO','Documento',100, tcString);
  CriaColuna('TOTALNOTA','Total',100, tcMoeda);
  CriaColuna('LOGIN','Usuaário',100, tcString);




end;

procedure TfrmLst_CompraEquipamentos.FormShow(Sender: TObject);
begin
  inherited;
  AtuDados;
end;

end.
