unit uLst_EntradaEquipamento;

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
  TfrmLst_EntradaEquipamento = class(TfrmListagemPadrao)
    procedure FormCreate(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLst_EntradaEquipamento: TfrmLst_EntradaEquipamento;

implementation

uses MinhasClasses, uCad_EntradaEquipamento;

{$R *.dfm}

procedure TfrmLst_EntradaEquipamento.actEditarExecute(Sender: TObject);
begin
  inherited;
  frmCad_EntradaEquipamento := TfrmCad_EntradaEquipamento.Create(nil);
  Try
    frmCad_EntradaEquipamento.TipoPesquisa := Self.TipoPesquisa;
    frmCad_EntradaEquipamento.ValorChave := Self.CdsListagem.FieldByName('IDENTRADAEQUIPAMENTO').AsString;
    frmCad_EntradaEquipamento.EditReg := True;
    frmCad_EntradaEquipamento.ShowModal;
    AtuDados;
  Finally
    FreeAndNil(frmCad_EntradaEquipamento);
  End;
end;

procedure TfrmLst_EntradaEquipamento.actNovoExecute(Sender: TObject);
begin
  inherited;
  frmCad_EntradaEquipamento := TfrmCad_EntradaEquipamento.Create(nil);
  Try
    frmCad_EntradaEquipamento.TipoPesquisa := Self.TipoPesquisa;
    frmCad_EntradaEquipamento.ValorChave := Self.CdsListagem.FieldByName('IDENTRADAEQUIPAMENTO').AsString;
    frmCad_EntradaEquipamento.NovoReg := True;
    frmCad_EntradaEquipamento.ShowModal;
    AtuDados;
  Finally
    FreeAndNil(frmCad_EntradaEquipamento);
  End;
end;

procedure TfrmLst_EntradaEquipamento.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPesquisa := tpCSEntradaEquipamento;
  CriaColuna('DATAENTRADA','Data', 80, tcCampoData);
  CriaColuna('DOCUMENTO','Docuemtno', 80, tcString);
  CriaColuna('NOMECLIENTE','Cliente', 300, tcString);
  CriaColuna('NOMELOCALESTOQUE','Local do estoque', 200, tcString);
  CriaColuna('LOGIN','Usuario', 80, tcString);


end;

procedure TfrmLst_EntradaEquipamento.FormShow(Sender: TObject);
begin
  inherited;
  AtuDados;
end;

end.
