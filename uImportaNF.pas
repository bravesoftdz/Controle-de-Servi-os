unit uImportaNF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Dlg_Cadastro, uFormPadrao, StdCtrls, Buttons, ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Mask, EditPesquisa, DB,
  adsdata, adsfunc, adstable, adscnnct,StrUtils,IniFiles, adsset;

type
  TfrmImportaDados = class(TfrmDlg_Cadastro)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edtDataIni: TcxDateEdit;
    edtDataFin: TcxDateEdit;
    edtLoja: TEditPesquisa;
    edtSerie: TLabeledEdit;
    edtCodMov: TLabeledEdit;
    ConexaoAds: TAdsConnection;
    Qry: TAdsQuery;
    QryItens: TAdsQuery;
    AdsSettings1: TAdsSettings;
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Function GeDataAds(pData: TDateTime): String;
  public
    { Public declarations }
    Procedure AbreQuery(StrSQL: String;var pQry: TAdsQuery);
  end;

var
  frmImportaDados: TfrmImportaDados;

implementation

uses Comandos, MinhasClasses, uAguarde;

{$R *.dfm}

procedure TfrmImportaDados.AbreQuery(StrSQL: String;var pQry: TAdsQuery);
begin
  pQry.Close;
  pQry.SQL.Text := StrSQL;
  pQry.Open;
end;

procedure TfrmImportaDados.btnOkClick(Sender: TObject);
var
  StrSQL,IdServico: String;
 procedure CadastraCliente;
 var
   SQL: String;
 Begin
   SQL :=
    'UPDATE OR INSERT INTO CLIENTE (IDCLIENTE, CODIGO, NOMECLIENTE, NUMERO, COMPLEMENTO, CPF, CNPJ, ORGAOEMISSOR,'+
    '                     DATAEMISSAO, DATANASCIMENTO, DATACADASTRO, TELEFONE, OBS, RG, IDCEP, CELULAR, CONTATO, IE, IM,'+
    '                     FLAGTIPOPESSOA)'+
    ' VALUES (GEN_ID(SEQ_IDCLIENTE,1), '+
             QuotedStr(Qry.FieldByName('NM_CLIENTE').AsString)+','+//:CODIGO,
             QuotedStr(Qry.FieldByName('DS_CLIENTE').AsString)+','+//:NOMECLIENTE, :
             QuotedStr(Qry.FieldByName('NR_ENDEREC').AsString)+','+//NUMERO,
             QuotedStr(Qry.FieldByName('DS_COMPENT').AsString)+','+//:COMPLEMENTO,
             QuotedStr(Qry.FieldByName('NR_CPF').AsString)+','+//:CPF,
             QuotedStr(Qry.FieldByName('NR_CGC').AsString)+','+//:CNPJ,
             'NULL,'+//:ORGAOEMISSOR,
             'NULL,'+//:DATAEMISSAO,'+
             GetData(Qry.FieldByName('DT_NASCTO').AsDateTime)+','+//:DATANASCIMENTO,
             GetData(Qry.FieldByName('DT_CADASTR').AsDateTime)+','+//:DATACADASTRO,
             QuotedStr(Qry.FieldByName('NR_TEL').AsString)+','+//:TELEFONE,
             QuotedStr(Qry.FieldByName('TX_DOSSIE').AsString)+','+//:OBS,
             QuotedStr(Qry.FieldByName('NR_IDENTID').AsString)+','+//: :RG,
             '(SELECT  FIRST 1 IDCEP '+
             '   FROM CEP '+
             '  WHERE CEP = '+QuotedStr(Qry.FieldByName('NR_CEP').AsString)+'),'+
             ' NULL, '+//  :CELULAR,
             QuotedStr(Qry.FieldByName('NM_CONTATO').AsString)+','+
             QuotedStr(Qry.FieldByName('NR_INSCEST').AsString)+','+// :IE,
             QuotedStr(Qry.FieldByName('NR_INSCMUN').AsString)+','+//:IM,
             QuotedStr(IfThen( Qry.FieldByName('NR_CPF').AsString = '','J', 'F'))+')'+
    ' MATCHING(CODIGO) ';
   Exec_SQL(SQL);
 End;

 Procedure CadastraProduto;
 Begin
   StrSQL:=
     'UPDATE OR INSERT INTO PRODUTOS (IDPRODUTOS, CODIGO, NOME, VALORVENDA)'+
     '              VALUES (GEN_ID(SEQ_IDPRODUTOS,1),'+
                            QuotedStr(QryItens.FieldByName('CD_PRODUTO').AsString)+','+//:CODIGO,
                            QuotedStr(QryItens.FieldByName('DS_PRODUTO').AsString)+','+//:NOME,
                            GetNumber(QryItens.FieldByName('VL_PRODUTO').AsCurrency)+')'+//:VALORVENDA)'+
     ' MATCHING(CODIGO) ';
   Exec_SQL(StrSQL);
 End;

begin
  Try
    StartTrans;
    frmAguarde.Ativar;
    frmAguarde.ProgressBar.Position := 0;
    StrSQL:=
      'SELECT N.CD_LOJA,N.CD_MOVEST,N.CD_NATOP,N.CD_SERIENF,N.DT_DOCTO,N.NM_CLIENTE,N.NR_NF,N.TX_OBSNF, C.*, CF.DS_NATOP '+
      '  FROM NFSAIDA N '+
      ' INNER JOIN CLIENTE C '+
      '    ON (C.NM_CLIENTE = N.NM_CLIENTE) '+
      ' INNER JOIN NATOP CF '+
      '    ON (N.CD_NATOP = CF.CD_NATOP) '+
      ' WHERE DT_DOCTO >= '+GeDataAds(edtDataIni.Date)+' AND DT_DOCTO <= '+GeDataAds(edtDataFin.Date)+
      '   AND N.CD_LOJA = '+QuotedStr(edtLoja.Text)+
      '   AND N.CD_MOVEST = '+QuotedStr(edtCodMov.Text)+
      '   AND N.CD_SERIENF = '+QuotedStr(edtSerie.Text);
    AbreQuery(StrSQL,Qry);
    Qry.First;
    frmAguarde.ProgressBar.Properties.Max :=Qry.RecordCount;
    while not Qry.Eof do
    begin
      frmAguarde.ProgressBar.Position := frmAguarde.ProgressBar.Position +1;
      Application.ProcessMessages;
      CadastraCliente;
      IdServico := IntToStr(GetValSeq('SEQ_IDSERVICO'));

      StrSQL:=
        'INSERT INTO SERVICO (IDSERVICO, DATA, IDEMPRESA, VALORTOTAL, OBS, IDCLIENTE, NUMSERVICO, VALORTOTALLIQUIDO, '+
        '                     NUMNOTA, SERIENF, CFOP, NATUREZA)'+
        'VALUES ( '+IdServico+','+
                 GetData(Qry.FieldByName('DT_DOCTO').AsDateTime)+','+ //:DATA
                 '(SELECT IDEMPRESA FROM EMPRESA WHERE CODIGO = '+QuotedStr(Qry.FieldByName('CD_LOJA').AsString)+'),'+//IDEMPRESA
                 '0,'+//:VALORTOTAL,
                 QuotedStr(Qry.FieldByName('TX_OBSNF').AsString)+','+//:OBS,
                 '(SELECT IDCLIENTE  FROM CLIENTE WHERE CODIGO = '+QuotedStr(Qry.FieldByName('NM_CLIENTE').AsString)+'),'+//:IDCLIENTE,
                 '(SELECT NUMSERVICO FROM EMPRESA WHERE CODIGO = '+QuotedStr(Qry.FieldByName('CD_LOJA').AsString)+'),'+//:NUMSERVICO,
                 '0,'+ //:VALORTOTALLIQUIDO,
                 QuotedStr(Qry.FieldByName('NR_NF').AsString)+','+//:NUMNOTA,
                 QuotedStr(Qry.FieldByName('CD_SERIENF').AsString)+','+//:SERIENF,
                 QuotedStr(Qry.FieldByName('CD_NATOP').AsString)+','+//:CFOP,
                 QuotedStr(Qry.FieldByName('DS_NATOP').AsString)+')';//:NATUREZA)';
      Exec_SQL(StrSQL);
      StrSQL:=
        'UPDATE EMPRESA '+
        '   SET NUMSERVICO = LPAD(CAST(NUMSERVICO AS INTEGER)+1,6,''0'') '+
        ' WHERE codigo = '+QuotedStr(Qry.FieldByName('CD_LOJA').AsString);
      Exec_SQL(StrSQL);

      StrSQL:=
        'SELECT P.CD_PRODUTO, N.VL_PRODUTO,QT_PRODUTO, VL_TABNEG, (N.VL_PRODUTO*QT_PRODUTO)-COALESCE(VL_DESCONT,0) TOTAL, P.DS_PRODUTO '+
        '  FROM MOVITEM N '+
        ' INNER JOIN PRODUTO P '+
        '    ON (P.CD_PRODUTO = N.CD_PRODUTO )'+
        ' WHERE DT_MOVIM >= '+GeDataAds(edtDataIni.Date)+' AND DT_MOVIM <= '+GeDataAds(edtDataFin.Date)+
        '   AND CD_LOJA = '+QuotedStr(edtLoja.Text)+
        '   AND CD_MOVEST = '+QuotedStr(edtCodMov.Text)+
        '   AND CD_SERIENF = '+QuotedStr(edtSerie.Text)+
        '   AND NR_NF = '+QuotedStr(Qry.FieldByName('NR_NF').AsString);
      AbreQuery(StrSQL,QryItens);
      QryItens.First;
      while not QryItens.Eof  do
      Begin
        CadastraProduto;
        StrSQL:=
          'INSERT INTO SERVICODETALHE (IDSERVICODETALHE, IDSERVICO, IDPRODUTOS, VALOR, VALORORIGINAL, QUANTIDADE, TOTAL)'+
          '                    VALUES (GEN_ID(SEQ_IDSERVICODETALHE,1), '+IdServico+', '+
                                      ' (SELECT IDPRODUTOS FROM PRODUTOS WHERE CODIGO = '+QuotedStr(QryItens.FieldByName('CD_PRODUTO').AsString)+'),'+//:IDPRODUTOS
                                      GetNumber(QryItens.FieldByName('VL_PRODUTO').AsCurrency)+','+// :VALOR,
                                      GetNumber(QryItens.FieldByName('VL_TABNEG').AsCurrency)+','+//:VALORORIGINAL,
                                      GetNumber(QryItens.FieldByName('QT_PRODUTO').AsCurrency)+','+//:QUANTIDADE,
                                      GetNumber(QryItens.FieldByName('TOTAL').AsCurrency)+')';//:TOTAL)'+
        Exec_SQL(StrSQL);
        QryItens.Next;
      end;
      StrSQL:=
        'UPDATE SERVICO '+
        '   SET VALORTOTALLIQUIDO = (SELECT SUM(TOTAL) FROM SERVICODETALHE WHERE IDSERVICO = '+IdServico+')'+
        ' WHERE IDSERVICO = '+IdServico;
      Exec_SQL(StrSQL);

      Qry.Next;

    end;

    Commit;
    Avisa('Concluído com sucesso');
    frmAguarde.Desativar;
  Except
    on E: Exception do
    Begin
      RollBack;
      frmAguarde.Desativar;
      Raise;
    End;
  End;

  inherited;

end;

procedure TfrmImportaDados.FormCreate(Sender: TObject);
var
  Ini : TIniFile;
  Local,vFile: String;
begin
  Try
    vFile := ExtractFilePath(ParamStr(0))+'Conexao.ini';
    Ini := TIniFile.Create(vFile);
    Local := Ini.ReadString('Geral','Local',ExtractFilePath(ParamStr(0))) ;
  Finally
    FreeAndNil(INi);
  End;
  ConexaoAds.ConnectPath := Local; //ExtractFilePath(ParamStr(0));
  ConexaoAds.Connect;
  inherited;

end;

procedure TfrmImportaDados.FormShow(Sender: TObject);
begin
  inherited;
  pDataSet := nil;
  ConfiguraEditPesquisa(edtLoja,nil,tpCSEmpresa);
end;

Function TfrmImportaDados.GeDataAds(pData: TDateTime): String;
begin
  Result := QuotedStr(FormatDateTime('yyyy-mm-dd',pData));
end;

end.
