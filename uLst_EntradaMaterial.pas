unit uLst_EntradaMaterial;

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
  TfrmLst_EntradaMaterial = class(TfrmListagemPadrao)
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
  frmLst_EntradaMaterial: TfrmLst_EntradaMaterial;

implementation

uses MinhasClasses, uCad_CompraEquipamento;

{$R *.dfm}

procedure TfrmLst_EntradaMaterial.actEditarExecute(Sender: TObject);
begin
  inherited;
  frmCad_CompraEquipamento := TfrmCad_CompraEquipamento.Create(nil);
  Try
    frmCad_CompraEquipamento.TipoPesquisa := Self.TipoPesquisa;
    frmCad_CompraEquipamento.ValorChave := Self.CdsListagem.FieldByName('IDENTRADAMATERIAL').AsString;
    frmCad_CompraEquipamento.EditReg := True;
    frmCad_CompraEquipamento.ShowModal;
    AtuDados;
  Finally
    FreeAndNil(frmCad_CompraEquipamento);
  End;
end;

procedure TfrmLst_EntradaMaterial.actNovoExecute(Sender: TObject);
begin
  inherited;
  frmCad_CompraEquipamento := TfrmCad_CompraEquipamento.Create(nil);
  Try
    frmCad_CompraEquipamento.TipoPesquisa := Self.TipoPesquisa;
    frmCad_CompraEquipamento.NovoReg := True;
    frmCad_CompraEquipamento.ShowModal;
    AtuDados;
  Finally
    FreeAndNil(frmCad_CompraEquipamento);
  End;
end;

procedure TfrmLst_EntradaMaterial.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpCSEntradaMaterial;
  CriaColuna('DATANOTA','Data',80, tcCampoData);
  CriaColuna('DOCUMENTO','Documento',100, tcString);
  CriaColuna('RAZAOSOCIAL','Fornecedor',200, tcString);
  CriaColuna('TOTALNOTA','Total',90, tcMoeda);
end;

procedure TfrmLst_EntradaMaterial.FormShow(Sender: TObject);
begin
  inherited;
  AtuDados;
end;

end.
