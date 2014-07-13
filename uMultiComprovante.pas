unit uMultiComprovante;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormPadrao, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, StdCtrls, Mask,
  EditPesquisa, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, ExtCtrls,
  Buttons, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, DBClient, pFIBClientDataSet, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid,strutils, cxEditRepositoryItems;

type
  TfrmMultiComprovante = class(TfrmPadrao)
    bit: TGroupBox;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edtDataInicial: TcxDateEdit;
    edtDataFinal: TcxDateEdit;
    Label3: TLabel;
    edtNumeroFinal: TLabeledEdit;
    edtNumeroINicial: TLabeledEdit;
    edtExecuta: TBitBtn;
    Label4: TLabel;
    TvRecibos: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataRecibos: TDataSource;
    CdsRecibos: TpFIBClientDataSet;
    cxEditRepository1: TcxEditRepository;
    CmbSimNao: TcxEditRepositoryImageComboBoxItem;
    vRecibosColumn1: TcxGridDBColumn;
    vRecibosColumn2: TcxGridDBColumn;
    vRecibosColumn3: TcxGridDBColumn;
    vRecibosColumn4: TcxGridDBColumn;
    vRecibosColumn5: TcxGridDBColumn;
    vRecibosColumn6: TcxGridDBColumn;
    vRecibosColumn7: TcxGridDBColumn;
    edtCliente: TEditPesquisa;
    Panel2: TPanel;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure edtExecutaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TvRecibosDblClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMultiComprovante: TfrmMultiComprovante;

implementation

uses uSQL, uSQLCS, MinhasClasses, Comandos, UDmConexao, uLibCS;

{$R *.dfm}

procedure TfrmMultiComprovante.BitBtn1Click(Sender: TObject);
var
  IdServico: String;
begin
  inherited;
  CdsRecibos.DisableControls;
  Try
    CdsRecibos.First;
    while not CdsRecibos.Eof do
    begin
      if CdsRecibos.FieldByName('FLAGMARCADO').AsString = 'Y' Then
        IdServico := IdServico+ CdsRecibos.FieldByName('IDSERVICO').AsString+',';
      CdsRecibos.Next;
    end;

  Finally
    CdsRecibos.EnableControls;
  End;
  if IdServico = ''  then
  begin
    Avisa('Selecione pelo menos um recibo');
    Exit;
  end;
  IdServico := StringReplace(IdServico+'$',',$','',[]);
  Imp_Recibo(CdsRecibos.FieldByName('idempresa').AsInteger,IdServico,tlTela);

end;

procedure TfrmMultiComprovante.BitBtn2Click(Sender: TObject);
begin
  inherited;
  if CdsRecibos.IsEmpty then
  begin
    Avisa('Não existe recibos para imprimir');
    Exit;
  end;
  CdsRecibos.DisableControls;
  Try
    CdsRecibos.First;
    while not CdsRecibos.Eof do
    begin
      CdsRecibos.Edit;
      CdsRecibos.FieldByName('FLAGMARCADO').AsString := 'Y';
      CdsRecibos.Post;
      CdsRecibos.Next;
    end;

  Finally
    CdsRecibos.EnableControls;
  End;
end;

procedure TfrmMultiComprovante.edtExecutaClick(Sender: TObject);
var
  StrSQL,Data : String;
begin
  inherited;
  StrSQL := '1=1';
  GetPeriodo(edtDataInicial.Text,edtDataFinal.Text,Data,'S.DATA',True,True);
  StrSQL := StrSQL+Data+IfThen(not edtCliente.IsNull, ' and s.idcliente = '+edtCliente.ValorChaveString)+
            IfThen(edtNumeroINicial.Text <> '', ' and S.NUMSERVICO>= '+QuotedStr(edtNumeroINicial.Text))+
            IfThen(edtNumeroFinal.Text <> '', ' and S.NUMSERVICO<= '+QuotedStr(edtNumeroFinal.Text));
  StrSQL := GetSelect(tpCsServicos,StrSQL,'NUMSERVICO DESC');
  StrSQL := StringReplace(StrSQL,'SELECT ','SELECT ''N'' FLAGMARCADO, ',[]);
  SetCds(CdsRecibos,StrSQL);

end;

procedure TfrmMultiComprovante.FormCreate(Sender: TObject);
begin
  inherited;
  ConfiguraEditPesquisa(edtCliente,nil,tpCsCliente);
end;

procedure TfrmMultiComprovante.TvRecibosDblClick(Sender: TObject);
begin
  inherited;
  CdsRecibos.Edit;
  IF CdsRecibos.FieldByName('FLAGMARCADO').AsString = 'N' THEN
    CdsRecibos.FieldByName('FLAGMARCADO').AsString := 'Y'
  ELSE
    CdsRecibos.FieldByName('FLAGMARCADO').AsString := 'N';
  CdsRecibos.Post;
end;

end.
