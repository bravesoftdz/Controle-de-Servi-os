unit uRelServicos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UdlgRelatorioPadrao, cxStyles, cxCustomData, cxFilter, cxData,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxDataStorage,
  cxEdit, DB, cxDBData, cxContainer, cxDropDownEdit, cxCalendar, StdCtrls,
  DBClient, pFIBClientDataSet, ActnList, ImgList, cxTextEdit, cxMaskEdit,
  cxDBEdit, ExtCtrls, DBCtrls, JvGradient, Buttons, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxPC, JvExControls, JvLabel, dxGDIPlusClasses,
  ComCtrls,uRelPadraoCS;

type
  TfrmRelServicos = class(TfrmRelPadraoCS)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtDataIni: TcxDateEdit;
    edtDataFin: TcxDateEdit;
    CdsParametrosTexto: TStringField;
    grpTipoRel: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelServicos: TfrmRelServicos;

implementation

uses MinhasClasses, Comandos, uSQL, uLibCS;

{$R *.dfm}

procedure TfrmRelServicos.btnNovoClick(Sender: TObject);
var
  StrWr,Str2,Str3,StrData: String;
  CdsEquipamento: TpFIBClientDataSet;
begin
  GetPeriodo(edtDataIni.Text,edtDataFin.Text,StrData,'DATA');
  StrWr :=' 1=1 '+StrData;
  StrWr := StrWr+ GetFiltro(tpCsCliente,'C.IDCLIENTE');
  case grpTipoRel.ItemIndex of
    1:
     StrWr := StrWr+' AND COALESCE(S.FLAGCANCELADO,''N'') = ''N'' ';
    2:
     StrWr := StrWr+' AND COALESCE(S.FLAGCANCELADO,''N'') = ''S'' ';
  end;





  Str2 :=' AND EXISTS(SELECT 1 '+
         '              FROM SERVICO S  '+
         '             WHERE SD.IDSERVICO = S.IDSERVICO  '+StrData+
                          GetFiltro(tpCsCliente,'IDCLIENTE')+' )'+ GetFiltro(tpCSProdutos,'IDTIPOSERVICO')+
        { ' AND EXISTS(SELECT 1 '+
         '              FROM SERVICODETALHE SD  '+
         '             WHERE SF.IDSERVICO = SD.IDSERVICO  '+
                                   GetFiltro(tpCSProdutos,'IDTIPOSERVICO')+') '+}
         ' AND VALOR IS NOT NULL ';

  //Str3 := Str3+ ' ORDER BY S.IDSERVICO ';
  //Str3 := StringReplace(Str3,'SELECT','SELECT S.DATA,',[rfIgnoreCase]);

  Str3 :=' AND EXISTS(SELECT 1 '+
         '              FROM SERVICO S  '+
         '             WHERE SE.IDSERVICO = S.IDSERVICO  '+StrData+ GetFiltro(tpCsCliente,'IDCLIENTE')+' )'+
         ' AND EXISTS(SELECT 1 '+
         '              FROM SERVICODETALHE SD  '+
         '             WHERE SE.IDSERVICO = SD.IDSERVICO  '+
                                   GetFiltro(tpCSProdutos,'IDTIPOSERVICO')+')';

  SetCds(CdsMaster,tpCsServicos,StrWr+ ' ORDER BY S.IDSERVICO ');
  SetCds(CdsDetalhes,tpCsServicosDetalhe,' 1=1 '+Str2+ ' ORDER BY IDSERVICO ');
  Try
    CdsEquipamento := TpFIBClientDataSet.Create(nil);
    CdsEquipamento.Name := 'Equipamento';

    SetCds(CdsEquipamento,tpCSSaidaEquipamento,' 1=1 '+Str3+ ' ORDER BY IDSERVICO ');
    SetLength(DataSetExtras,1);



    DataSetExtras[0] := CdsEquipamento;

  //  SetCds(CdsEmpresa,tpCSEmpresa,'' );
    CdsParametros.Append;
    CdsParametrosTexto.AsString:=
         GetParametrosData(edtDataIni.Text, edtDataFin.Text)+
         GetParametros(tpCsCliente)+
         GetParametros(tpCSProdutos);
    inherited;
  Finally
    FreeAndNil(CdsEquipamento);
  End;
 
end;

procedure TfrmRelServicos.FormCreate(Sender: TObject);
begin
  inherited;
  IdRelatorio := IdRelServicosCS;
  CamposFiltro.Add(tpCsCliente);
end;

end.
