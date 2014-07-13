unit uCad_TabelaPreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, DB, DBClient, pFIBClientDataSet, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid,MinhasClasses, StdCtrls, Buttons, ExtCtrls;

type
  TfrmCad_TabelaPreco = class(TfrmPadrao)
    DataTabelaPreco: TDataSource;
    CdsTabelaPreco: TpFIBClientDataSet;
    TvItem: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGrid;
    TvItemEQUIPAMENTO: TcxGridDBColumn;
    TvItemPRECO: TcxGridDBColumn;
    TvItemUNIDADE: TcxGridDBColumn;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure CdsTabelaPrecoAfterOpen(DataSet: TDataSet);
    procedure CdsTabelaPrecoAfterPost(DataSet: TDataSet);
    procedure CdsTabelaPrecoBeforePost(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    Ta : TTipoAlteracao;
  public
    { Public declarations }

  end;

var
  frmCad_TabelaPreco: TfrmCad_TabelaPreco;

implementation

uses Comandos, UDmConexao, uPesquisaEquipamento;

{$R *.dfm}

procedure TfrmCad_TabelaPreco.BitBtn1Click(Sender: TObject);
begin
  inherited;
  frmPesquisaEquipamento := TfrmPesquisaEquipamento.Create(Self);
  Try
    with frmPesquisaEquipamento  do
    Begin
      frmPesquisaEquipamento.TipoPesquisa := tpCSEquipamento;
      if ShowModal = mrOk then
        CdsTabelaPreco.Locate('IDEQUIPAMENTO', CdsPesquisa.FieldByName('IDEQUIPAMENTO').Value, []) ;
      Self.cxGrid.SetFocus;
    End;
  Finally
    FreeAndNil(frmPesquisaEquipamento );
  End;
end;

procedure TfrmCad_TabelaPreco.CdsTabelaPrecoAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsTabelaPreco.FieldByName('PRECO'),tcReal);

  CdsTabelaPreco.FieldByName('EQUIPAMENTO').ProviderFlags := [];
  CdsTabelaPreco.FieldByName('UNIDADE').ProviderFlags := [];
  
end;

procedure TfrmCad_TabelaPreco.CdsTabelaPrecoAfterPost(DataSet: TDataSet);

begin
  inherited;
  Try
    StartTrans;
    AlteraBanco(ta, CdsTabelaPreco,'TABELAPRECOEQUIPAMENTO','IDTABELAPRECOEQUIPAMENTO');
    Commit;
  Except
    on e: Exception do
    begin
      RollBack;
      Raise;
    end;

  End;

end;

procedure TfrmCad_TabelaPreco.CdsTabelaPrecoBeforePost(DataSet: TDataSet);
begin
  inherited;
  if CdsTabelaPreco.FieldByName('IDTABELAPRECOEQUIPAMENTO').IsNull then
  Begin
    CdsTabelaPreco.FieldByName('IDTABELAPRECOEQUIPAMENTO').AsString := GetCodigo(tpCSTabelaPrecoEquipamento);
    ta := taInsere;
  End else
    ta := taModifica;
end;

Procedure TfrmCad_TabelaPreco.FormShow(Sender: TObject);
begin
  inherited;
  SetCds(CdsTabelaPreco,tpCSTabelaPrecoEquipamento,'');
  TvItem.ViewData.Expand(True);
end;

end.
