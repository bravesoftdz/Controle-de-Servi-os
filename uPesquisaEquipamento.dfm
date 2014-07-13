inherited frmPesquisaEquipamento: TfrmPesquisaEquipamento
  Caption = ''
  ExplicitTop = -87
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited Panel6: TPanel
      inherited lblTIpoPesquisa: TJvLabel
        Width = 788
      end
    end
  end
  inherited PageControl: TcxPageControl
    inherited tsGrid: TcxTabSheet
      ExplicitLeft = 2
      ExplicitTop = 22
      ExplicitWidth = 786
      ExplicitHeight = 363
      inherited Panel3: TPanel
        inherited cxGrid1: TcxGrid
          Height = 221
          inherited TvPesquisa: TcxGridDBTableView
            Styles.Inactive = nil
            Styles.Group = nil
          end
        end
        object GroupBox3: TGroupBox
          Left = 0
          Top = 254
          Width = 782
          Height = 105
          Align = alBottom
          Caption = ' Especifica'#231#227'o '
          TabOrder = 2
          ExplicitLeft = 88
          ExplicitTop = 240
          ExplicitWidth = 185
          object cxGrid2: TcxGrid
            Left = 2
            Top = 15
            Width = 778
            Height = 88
            Align = alClient
            TabOrder = 0
            ExplicitLeft = 88
            ExplicitTop = 32
            ExplicitWidth = 250
            ExplicitHeight = 200
            object cxGrid2DBCardView1: TcxGridDBCardView
              NavigatorButtons.ConfirmDelete = False
              DataController.DataSource = DataEspecificacao
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsView.CardAutoWidth = True
              OptionsView.CardBorderWidth = 1
              OptionsView.CardExpandButtonAlignment = cebaLeft
              OptionsView.CardWidth = 280
              OptionsView.CategorySeparatorWidth = 1
              OptionsView.SeparatorWidth = 1
              object cxGrid2DBCardView1DESCRICAO: TcxGridDBCardViewRow
                DataBinding.FieldName = 'DESCRICAO'
                Options.Editing = False
                Options.Focusing = False
                Options.Moving = False
                Options.ShowCaption = False
                Position.BeginsLayer = True
                Styles.Content = DMConexao.GroupByBox
              end
              object cxGrid2DBCardView1TEXTO: TcxGridDBCardViewRow
                DataBinding.FieldName = 'TEXTO'
                Options.ShowCaption = False
                Position.BeginsLayer = False
              end
            end
            object cxGrid2Level1: TcxGridLevel
              GridView = cxGrid2DBCardView1
            end
          end
        end
        object cxSplitter1: TcxSplitter
          Left = 0
          Top = 246
          Width = 782
          Height = 8
          HotZoneClassName = 'TcxMediaPlayer9Style'
          AlignSplitter = salBottom
          ExplicitTop = 240
        end
      end
    end
    inherited TsTree: TcxTabSheet
      ExplicitLeft = 2
      ExplicitTop = 22
      ExplicitWidth = 786
      ExplicitHeight = 363
    end
  end
  object CdsEspecificacao: TpFIBClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 168
    Top = 296
  end
  object DataEspecificacao: TDataSource
    DataSet = CdsEspecificacao
    Left = 72
    Top = 296
  end
end
