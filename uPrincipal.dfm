inherited frmPrincipal: TfrmPrincipal
  Caption = 'Recibo Fiscal'
  ClientHeight = 564
  ClientWidth = 1088
  Menu = nil
  OnClose = FormClose
  ExplicitWidth = 1104
  ExplicitHeight = 603
  PixelsPerInch = 96
  TextHeight = 13
  inherited Status: TdxRibbonStatusBar
    Top = 541
    Width = 1088
    Images = cxImageList1
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 200
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.ImageIndex = 0
        Text = 'Usu'#225'rio'
        Width = 150
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'Conexao'
        Width = 300
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        BiDiMode = bdRightToLeft
        Fixed = False
        ParentBiDiMode = False
        Text = 'Vers'#227'o'
      end>
    ExplicitTop = 541
    ExplicitWidth = 1088
  end
  object Ribbon: TdxRibbon [1]
    Left = 0
    Top = 0
    Width = 1088
    Height = 126
    BarManager = dxBarManager1
    ColorSchemeName = 'Blue'
    Contexts = <>
    TabOrder = 5
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Acesso r'#225'pido'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
        end
        item
          ToolbarName = 'dxBarManager1Bar2'
        end
        item
          ToolbarName = 'dxBarManager1Bar6'
        end
        item
          ToolbarName = 'dxBarManager1Bar3'
        end>
      Index = 0
    end
    object RibbonTab1: TdxRibbonTab
      Caption = 'Cadastro'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar5'
        end>
      Index = 1
    end
    object RibbonTab2: TdxRibbonTab
      Caption = 'Manuten'#231#227'o'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar4'
        end>
      Index = 2
    end
  end
  object cxSplitter1: TcxSplitter [2]
    Left = 720
    Top = 126
    Width = 8
    Height = 415
    Hint = 'Clique aqui para esconder/mostrar os lembretes'
    HotZoneClassName = 'TcxMediaPlayer9Style'
    HotZone.SizePercent = 34
    AlignSplitter = salRight
    Control = Panel1
    ShowHint = True
    ParentShowHint = False
  end
  object Panel1: TPanel [3]
    Left = 728
    Top = 126
    Width = 360
    Height = 415
    Align = alRight
    TabOrder = 7
    object GrpAgenda: TGroupBox
      Left = 1
      Top = 1
      Width = 358
      Height = 239
      Align = alClient
      Caption = ' Lembretes da agenda '
      TabOrder = 0
      object cxGrid1: TcxGrid
        Left = 2
        Top = 15
        Width = 354
        Height = 222
        Align = alClient
        TabOrder = 0
        object TvAgenda: TcxGridDBTableView
          NavigatorButtons.ConfirmDelete = False
          OnCellDblClick = TvAgendaCellDblClick
          DataController.DataSource = DataAgenda
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          object vAgendaColumn1: TcxGridDBColumn
            Caption = 'Data'
            DataBinding.FieldName = 'DATACOMPROMISSO'
            Visible = False
            GroupIndex = 0
          end
          object vAgendaColumn2: TcxGridDBColumn
            Caption = 'Resumo'
            DataBinding.FieldName = 'CAPTION'
            Width = 45
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = TvAgenda
        end
      end
    end
    object grpEstoque: TGroupBox
      Left = 1
      Top = 248
      Width = 358
      Height = 166
      Align = alBottom
      Caption = ' Produtos abaixo do estoque m'#237'nimo'
      TabOrder = 1
      object cxGrid2: TcxGrid
        Left = 2
        Top = 15
        Width = 354
        Height = 149
        Align = alClient
        TabOrder = 0
        object cxGrid2DBTableView1: TcxGridDBTableView
          NavigatorButtons.ConfirmDelete = False
          DataController.DataSource = DataProdutos
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.GroupByBox = False
          object cxGrid2DBTableView1Column1: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODIGO'
            Width = 48
          end
          object cxGrid2DBTableView1Column2: TcxGridDBColumn
            Caption = 'Material'
            DataBinding.FieldName = 'NOMEMATERIAL'
            Width = 147
          end
          object cxGrid2DBTableView1Column3: TcxGridDBColumn
            Caption = 'Estoque Min.'
            DataBinding.FieldName = 'ESTOQUEMINIMO'
            Width = 70
          end
          object cxGrid2DBTableView1Column4: TcxGridDBColumn
            Caption = 'Estoque Atual'
            DataBinding.FieldName = 'ESTOQUETOTAL'
            Width = 75
          end
        end
        object cxGrid2Level1: TcxGridLevel
          GridView = cxGrid2DBTableView1
        end
      end
    end
    object cxSplitter2: TcxSplitter
      Left = 1
      Top = 240
      Width = 358
      Height = 8
      HotZoneClassName = 'TcxMediaPlayer9Style'
      AlignSplitter = salBottom
      Control = grpEstoque
    end
  end
  inherited dxBarManager1: TdxBarManager
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.LargeImages = cxImageList1
    Left = 200
    Top = 152
    DockControlHeights = (
      0
      0
      0
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Cadastro'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 838
      FloatTop = 8
      FloatClientWidth = 139
      FloatClientHeight = 101
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarButton25'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton24'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Servi'#231'os'
      CaptionButtons = <>
      DockedLeft = 207
      DockedTop = 0
      FloatLeft = 838
      FloatTop = 8
      FloatClientWidth = 174
      FloatClientHeight = 72
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton9'
        end
        item
          Visible = True
          ItemName = 'dxBarButton7'
        end
        item
          Visible = True
          ItemName = 'dxBarButton10'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Supervis'#227'o'
      CaptionButtons = <>
      DockedLeft = 521
      DockedTop = 0
      FloatLeft = 838
      FloatTop = 8
      FloatClientWidth = 141
      FloatClientHeight = 101
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton13'
        end
        item
          Visible = True
          ItemName = 'dxBarButton14'
        end
        item
          Visible = True
          ItemName = 'dxBarButton15'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton16'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar4: TdxBar
      Caption = 'Movimento'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1000
      FloatTop = 8
      FloatClientWidth = 244
      FloatClientHeight = 144
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton26'
        end
        item
          Visible = True
          ItemName = 'dxBarButton28'
        end
        item
          Visible = True
          ItemName = 'dxBarButton29'
        end
        item
          Visible = True
          ItemName = 'dxBarButton30'
        end
        item
          Visible = True
          ItemName = 'dxBarButton31'
        end
        item
          Visible = True
          ItemName = 'dxBarButton32'
        end
        item
          Visible = True
          ItemName = 'dxBarButton33'
        end
        item
          Visible = True
          ItemName = 'dxBarButton34'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar5: TdxBar
      Caption = ' '
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1114
      FloatTop = 8
      FloatClientWidth = 139
      FloatClientHeight = 288
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton35'
        end
        item
          Visible = True
          ItemName = 'dxBarButton36'
        end
        item
          Visible = True
          ItemName = 'dxBarButton37'
        end
        item
          Visible = True
          ItemName = 'dxBarButton38'
        end
        item
          Visible = True
          ItemName = 'dxBarButton39'
        end
        item
          Visible = True
          ItemName = 'dxBarButton40'
        end
        item
          Visible = True
          ItemName = 'dxBarButton42'
        end
        item
          Visible = True
          ItemName = 'dxBarButton43'
        end
        item
          Visible = True
          ItemName = 'dxBarButton44'
        end
        item
          Visible = True
          ItemName = 'dxBarButton45'
        end
        item
          Visible = True
          ItemName = 'dxBarButton46'
        end
        item
          Visible = True
          ItemName = 'dxBarButton47'
        end
        item
          Visible = True
          ItemName = 'dxBarButton48'
        end
        item
          Visible = True
          ItemName = 'dxBarButton49'
        end
        item
          Visible = True
          ItemName = 'dxBarButton50'
        end
        item
          Visible = True
          ItemName = 'dxBarButton51'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar6: TdxBar
      Caption = 'Movimenta'#231'ao'
      CaptionButtons = <>
      DockedLeft = 390
      DockedTop = 0
      FloatLeft = 1114
      FloatTop = 8
      FloatClientWidth = 122
      FloatClientHeight = 48
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton52'
        end
        item
          Visible = True
          ItemName = 'dxBarButton53'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Action = actCadCliente
      Category = 0
    end
    object dxBarButton2: TdxBarButton
      Action = actCadServico
      Category = 0
    end
    object dxBarButton3: TdxBarButton
      Action = actCadCFOP
      Category = 0
    end
    object dxBarButton4: TdxBarButton
      Action = actCEP
      Category = 0
    end
    object dxBarButton5: TdxBarButton
      Action = actEmpresa
      Category = 0
    end
    object dxBarButton6: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
    object dxBarButton7: TdxBarButton
      Action = actListagemServicos
      Category = 0
    end
    object dxBarButton8: TdxBarButton
      Action = actVenda
      Category = 0
    end
    object dxBarButton9: TdxBarButton
      Action = actVenda
      Category = 0
    end
    object dxBarButton10: TdxBarButton
      Action = actServAGenda
      Category = 0
    end
    object dxBarButton11: TdxBarButton
      Action = actCadBanco
      Category = 0
    end
    object dxBarButton12: TdxBarButton
      Action = actCadConta
      Category = 0
    end
    object dxBarButton13: TdxBarButton
      Action = actCadUsuario
      Category = 0
    end
    object dxBarButton14: TdxBarButton
      Action = actLogOut
      Category = 0
    end
    object dxBarButton15: TdxBarButton
      Action = actBloqSistema
      Category = 0
    end
    object dxBarButton16: TdxBarButton
      Action = actAuditoria
      Category = 0
    end
    object dxBarButton17: TdxBarButton
      Action = actCadCombustivel
      Category = 0
    end
    object dxBarButton18: TdxBarButton
      Action = actCadMarca
      Category = 0
    end
    object dxBarButton19: TdxBarButton
      Action = actCadStatusEquipamento
      Category = 0
    end
    object dxBarButton20: TdxBarButton
      Action = actUnidade
      Category = 0
    end
    object dxBarButton21: TdxBarButton
      Action = actCadFornecedor
      Category = 0
    end
    object dxBarButton22: TdxBarButton
      Action = actCadGrupoEquipamento
      Category = 0
    end
    object dxBarButton23: TdxBarButton
      Action = actCadTipoMaterial
      Category = 0
    end
    object dxBarButton24: TdxBarButton
      Action = actCadMaterial
      Category = 0
    end
    object dxBarButton25: TdxBarButton
      Action = actCadEquipamento
      Category = 0
    end
    object dxBarButton26: TdxBarButton
      Action = actCompraEquipamento
      Category = 0
    end
    object dxBarButton27: TdxBarButton
      Action = actCadLocalEstoque
      Category = 0
    end
    object dxBarButton28: TdxBarButton
      Action = actEntradaEquipamento
      Category = 0
    end
    object dxBarButton29: TdxBarButton
      Action = actManutencao
      Category = 0
    end
    object dxBarButton30: TdxBarButton
      Action = actEntradaMaterial
      Category = 0
    end
    object dxBarButton31: TdxBarButton
      Action = actTabelaPreco
      Category = 0
    end
    object dxBarButton32: TdxBarButton
      Action = actRelRecDespEquipamento
      Category = 0
    end
    object dxBarButton33: TdxBarButton
      Action = actRelMovimentacaoEquipamento
      Category = 0
    end
    object dxBarButton34: TdxBarButton
      Action = actRelDivergenciaManutencao
      Category = 0
    end
    object dxBarButton35: TdxBarButton
      Action = actCadCliente
      Category = 0
    end
    object dxBarButton36: TdxBarButton
      Action = actCadServico
      Category = 0
    end
    object dxBarButton37: TdxBarButton
      Action = actCEP
      Category = 0
    end
    object dxBarButton38: TdxBarButton
      Action = actEmpresa
      Category = 0
    end
    object dxBarButton39: TdxBarButton
      Action = actCadBanco
      Category = 0
    end
    object dxBarButton40: TdxBarButton
      Action = actCadConta
      Category = 0
    end
    object dxBarButton41: TdxBarButton
      Action = actCadConta
      Category = 0
    end
    object dxBarButton42: TdxBarButton
      Action = actCadEquipamento
      Category = 0
    end
    object dxBarButton43: TdxBarButton
      Action = actCadMaterial
      Category = 0
    end
    object dxBarButton44: TdxBarButton
      Action = actCadMarca
      Category = 0
    end
    object dxBarButton45: TdxBarButton
      Action = actCadStatusEquipamento
      Category = 0
    end
    object dxBarButton46: TdxBarButton
      Action = actCadFornecedor
      Category = 0
    end
    object dxBarButton47: TdxBarButton
      Action = actCadGrupoEquipamento
      Category = 0
    end
    object dxBarButton48: TdxBarButton
      Action = actCadTipoMaterial
      Category = 0
    end
    object dxBarButton49: TdxBarButton
      Action = actCadCombustivel
      Category = 0
    end
    object dxBarButton50: TdxBarButton
      Action = actUnidade
      Category = 0
    end
    object dxBarButton51: TdxBarButton
      Action = actCadLocalEstoque
      Category = 0
    end
    object dxBarButton52: TdxBarButton
      Action = actEntradaEquipamento
      Category = 0
    end
    object dxBarButton53: TdxBarButton
      Action = actManutencao
      Category = 0
    end
  end
  inherited MainMenu: TMainMenu
    Left = 32
    Top = 152
    object Cadastro1: TMenuItem
      Action = actCadastro
      object Cliente1: TMenuItem
        Action = actCadCliente
      end
      object Servios1: TMenuItem
        Action = actCadServico
      end
      object CEP1: TMenuItem
        Action = actCEP
      end
      object CFOP1: TMenuItem
        Action = actCadCFOP
      end
      object Empresa1: TMenuItem
        Action = actEmpresa
      end
    end
    object Servios2: TMenuItem
      Action = actServicos
      object Checkout1: TMenuItem
        Action = actVenda
      end
      object ListagemdeServios1: TMenuItem
        Action = actListagemServicos
      end
      object Empresa2: TMenuItem
        Action = actImporta
      end
    end
  end
  inherited ActionList1: TActionList
    Left = 120
    Top = 152
    object actCadastro: TAction
      Category = 'Cadastro'
      Caption = 'Cadastro'
      OnExecute = actCadastroExecute
    end
    object actEmpresa: TAction
      Category = 'Cadastro'
      Caption = 'Empresa'
      OnExecute = actEmpresaExecute
    end
    object actCadCliente: TAction
      Category = 'Cadastro'
      Caption = 'Cliente [Ctrl+F3]'
      ImageIndex = 0
      ShortCut = 16498
      OnExecute = actCadClienteExecute
    end
    object actCEP: TAction
      Category = 'Cadastro'
      Caption = 'CEP'
      OnExecute = actCEPExecute
    end
    object actCadServico: TAction
      Category = 'Cadastro'
      Caption = 'Tipo de Servi'#231'o [Ctrl+F6]'
      ShortCut = 16501
      OnExecute = actCadServicoExecute
    end
    object actListagemServicos: TAction
      Category = 'Servicos'
      Caption = 'Listagem de Servi'#231'os [Ctrl+F11]'
      ShortCut = 16506
      OnExecute = actListagemServicosExecute
    end
    object actServicos: TAction
      Category = 'Servicos'
      Caption = 'Servi'#231'os'
      OnExecute = actServicosExecute
    end
    object actVenda: TAction
      Category = 'Servicos'
      Caption = 'Checkout [F10]'
      ShortCut = 121
      OnExecute = actVendaExecute
    end
    object actImporta: TAction
      Category = 'Servicos'
      Caption = 'Importa notas do Empresa f'#225'cil'
    end
    object actCadCFOP: TAction
      Category = 'Cadastro'
      Caption = 'CFOP'
      OnExecute = actCadCFOPExecute
    end
    object actCadMarca: TAction
      Category = 'Cadastro'
      Caption = 'Marca'
      OnExecute = actCadMarcaExecute
    end
    object actServAGenda: TAction
      Category = 'Servicos'
      Caption = 'Agenda'
      OnExecute = actServAGendaExecute
    end
    object actCadBanco: TAction
      Category = 'Cadastro'
      Caption = 'Banco'
      OnExecute = actCadBancoExecute
    end
    object actCadConta: TAction
      Category = 'Cadastro'
      Caption = 'Contas banc'#225'rias'
      OnExecute = actCadContaExecute
    end
    object actCadUsuario: TAction
      Category = 'Supervisao'
      Caption = 'Cadastro de Usu'#225'rio'
      OnExecute = actCadUsuarioExecute
    end
    object actLogOut: TAction
      Category = 'Supervisao'
      Caption = 'Troca de usu'#225'rio [Ctrl+T]'
      ShortCut = 16468
      OnExecute = actLogOutExecute
    end
    object actBloqSistema: TAction
      Category = 'Supervisao'
      Caption = 'Bloquear sistema [F12]'
      ShortCut = 123
      OnExecute = actBloqSistemaExecute
    end
    object actAuditoria: TAction
      Category = 'Supervisao'
      Caption = 'Auditoria'
      OnExecute = actAuditoriaExecute
    end
    object actCadCombustivel: TAction
      Category = 'Cadastro'
      Caption = 'Combust'#237'vel'
      OnExecute = actCadCombustivelExecute
    end
    object actCadStatusEquipamento: TAction
      Category = 'Cadastro'
      Caption = 'Status Equipamento'
      OnExecute = actCadStatusEquipamentoExecute
    end
    object actUnidade: TAction
      Category = 'Cadastro'
      Caption = 'Unidade'
      OnExecute = actUnidadeExecute
    end
    object actCadFornecedor: TAction
      Category = 'Cadastro'
      Caption = 'Fornecedor'
      OnExecute = actCadFornecedorExecute
    end
    object actCadGrupoEquipamento: TAction
      Category = 'Cadastro'
      Caption = 'Grupo de Equipamento'
      OnExecute = actCadGrupoEquipamentoExecute
    end
    object actCadTipoMaterial: TAction
      Category = 'Cadastro'
      Caption = 'Tipo de Material'
      OnExecute = actCadTipoMaterialExecute
    end
    object actCadMaterial: TAction
      Category = 'Cadastro'
      Caption = 'Material'
      OnExecute = actCadMaterialExecute
    end
    object actCadEquipamento: TAction
      Category = 'Cadastro'
      Caption = 'Equipamento [Ctrl+E]'
      ShortCut = 16453
      OnExecute = actCadEquipamentoExecute
    end
    object actCompraEquipamento: TAction
      Category = 'Movimento'
      Caption = 'Compra de equipamentos'
      OnExecute = actCompraEquipamentoExecute
    end
    object actCadLocalEstoque: TAction
      Category = 'Cadastro'
      Caption = 'Local do estoque'
      OnExecute = actCadLocalEstoqueExecute
    end
    object actEntradaEquipamento: TAction
      Category = 'Movimento'
      Caption = 'Entrada Equipamento'
      OnExecute = actEntradaEquipamentoExecute
    end
    object actManutencao: TAction
      Category = 'Movimento'
      Caption = 'Manuten'#231#227'o'
      OnExecute = actManutencaoExecute
    end
    object actEntradaMaterial: TAction
      Category = 'Movimento'
      Caption = 'Entrada de Material'
      OnExecute = actEntradaMaterialExecute
    end
    object actTabelaPreco: TAction
      Category = 'Movimento'
      Caption = 'Tabela Pre'#231'o'
      OnExecute = actTabelaPrecoExecute
    end
    object actRelRecDespEquipamento: TAction
      Category = 'Movimento'
      Caption = 'Receita X Despesa de equipamento'
      OnExecute = actRelRecDespEquipamentoExecute
    end
    object actRelMovimentacaoEquipamento: TAction
      Category = 'Movimento'
      Caption = 'Relat'#243'rio de movimenta'#231#227'o de equipamento'
      OnExecute = actRelMovimentacaoEquipamentoExecute
    end
    object actRelDivergenciaManutencao: TAction
      Category = 'Movimento'
      Caption = 'Relet'#243'rio de Diverg'#234'ncia de Manuten'#231#227'o'
      OnExecute = actRelDivergenciaManutencaoExecute
    end
  end
  object CdsAgenda: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 216
  end
  object DataAgenda: TDataSource
    DataSet = CdsAgenda
    Left = 128
    Top = 216
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 200
    Top = 216
  end
  object cxImageList1: TcxImageList
    FormatVersion = 1
    DesignInfo = 18350136
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A0310300B738
          0D00E6462D00F4483500F34A3500FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A3320400BF3A
          1100EB462F00F6543C00F75F4100F7674F00F4513E00ED412D008B411500FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00AB330700C73C
          1800F3593E00FB6E4A00FB6D4900FCC6BB00F88E7F00E23A2400843F11000076
          00000999180010AF360035BC4A0040B53E00007B000000660000B5350C00D546
          2300FE6F4D00FF6D4400FF977B00FFFFFF00FFBAAA00E94B2E007F3C0D00078E
          13001DC753001EC2430099F299009EEF9F000893110000680000FF00FF00D546
          2300FF724900B6554100968B8F00B2BBBF00E68A7300FE5D3C00914A16000CA1
          210014B03C002C8A390092B48F0068BA660015AD300002740700FF00FF00FF00
          FF00414665001E4F97001255AB00134E9300734C5200FF00FF00FF00FF000222
          0400021C0700091C4C000C1E66000A2C3D0012913200FF00FF00FF00FF001066
          A4000C69D1001C88FF001E86FF00187AF3001A67C200FF00FF0000040A000000
          000003092F00082A9C0006289900061F890007297600FF00FF001D688C002882
          C6002C97FF002D99FF002D99FC002D9AFF002897FE00146DC400000407000002
          07000B3492000F46C4000E41B4000F42B7000C36B00002158A001D688C002D8E
          D70032A0FF00319DFC002E98F6002E98F70033A3FF00237ECF00010405000106
          1000114EBD001357D700114BC0001152CB00114EC6000D36A0001D688C001D68
          8C002D8BC6002F95E100319DFB00319AF80034A3FF001F73C200010407000102
          0400104FA7001C7FFF001B74F2001C78F700165ED40010439A001D688C001D68
          8C001D688C002F90D30035A3FE0035A4FF00309CF300114F8800020508001410
          0C0013273D000F4E9A001564BF00196BC7000C34700010439A00FF00FF001D68
          8C001D688C001D688C001D688C001D688C001D688C00FF00FF00FF00FF001716
          14004F4B46004545440010161E000208110001030A00FF00FF00FF00FF00FF00
          FF001D688C001D688C001D688C001D688C00FF00FF00FF00FF00FF00FF00FF00
          FF003839390041403E00110F0C0000000000FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
        MaskColor = clFuchsia
      end>
  end
  object DataProdutos: TDataSource
    DataSet = CdsProdutos
    Left = 72
    Top = 376
  end
  object CdsProdutos: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 368
  end
end
