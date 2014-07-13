unit uCad_Material;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCad_CadastroPaiCS, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, ComCtrls, StdCtrls, Mask, DBCtrls, LabelDBEdit, Menus,
  DB, DBClient, pFIBClientDataSet, ActnList, cxPC, cxContainer, cxEdit,
  cxTreeView, Buttons, ExtCtrls, EditPesquisa, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter;

type
  TCad_material = class(TfrmCad_CadastroPaiCS)
    edtCodigo: TLabelDBEdit;
    LabelDBEdit2: TLabelDBEdit;
    edtTipoMaterial: TEditPesquisa;
    LabelDBEdit3: TLabelDBEdit;
    DBCheckBox1: TDBCheckBox;
    edtFornecedor: TEditPesquisa;
    LabelDBEdit4: TLabelDBEdit;
    edtUnidade: TEditPesquisa;
    LabelDBEdit5: TLabelDBEdit;
    GroupBox1: TGroupBox;
    DBMemo1: TDBMemo;
    LabelDBEdit1: TLabelDBEdit;
    GroupBox2: TGroupBox;
    LabelDBEdit6: TLabelDBEdit;
    LabelDBEdit7: TLabelDBEdit;
    LabelDBEdit8: TLabelDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure CdsCadastroNewRecord(DataSet: TDataSet);
    procedure actNovoExecute(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure CdsCadastroAfterOpen(DataSet: TDataSet);
    procedure actImprimirExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Cad_material: TCad_material;

implementation

uses MinhasClasses, Comandos, uRelMateriais;

{$R *.dfm}

procedure TCad_material.actGravarExecute(Sender: TObject);
begin
  VerificaEdit(edtTipoMaterial,'Informe o tipo de material');
  inherited;

end;

procedure TCad_material.actImprimirExecute(Sender: TObject);
begin
  inherited;
  frmRelMateriais := TfrmRelMateriais.Create(nil);
  Try
    frmRelMateriais.ShowModal;
  Finally
    FreeAndNil(frmRelMateriais);
  End;
end;

procedure TCad_material.actNovoExecute(Sender: TObject);
begin
  inherited;
  edtCodigo.SetFocus;
end;

procedure TCad_material.CdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
  FormataMascara(CdsCadastro.FieldByName('PERCALERTA'),tcPercent);
end;

procedure TCad_material.CdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
  CdsCadastro.FieldByName('DATACADASTRO').AsString := GetDataServidor;
  CdsCadastro.FieldByName('FLAGCONTROLASERIAL').AsString := 'N';
end;

procedure TCad_material.FormCreate(Sender: TObject);
begin
  inherited;
  VerificaEdits := True;
  TipoPesquisa := tpCSMaterial;
  ConfiguraEditPesquisa(edtTipoMaterial,CdsCadastro,tpCSTipoMaterial,True);
  ConfiguraEditPesquisa(edtFornecedor,CdsCadastro,tpCSFornecedor);
  ConfiguraEditPesquisa(edtUnidade,CdsCadastro,tpCSUnidade);
end;

end.
