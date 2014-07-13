inherited frmLst_GrupoEquipamento: TfrmLst_GrupoEquipamento
  Caption = 'Grupo de equipamento'
  ClientHeight = 396
  ClientWidth = 675
  ExplicitWidth = 683
  ExplicitHeight = 430
  PixelsPerInch = 96
  TextHeight = 13
  inherited Status: TStatusBar
    Top = 377
    Width = 675
    ExplicitTop = 377
    ExplicitWidth = 675
  end
  inherited Panel1: TPanel
    Width = 675
    Height = 377
    ExplicitWidth = 675
    ExplicitHeight = 377
    inherited cxSplitter1: TcxSplitter
      Height = 347
      ExplicitHeight = 347
    end
    inherited Panel3: TPanel
      Width = 356
      Height = 347
      ExplicitWidth = 356
      ExplicitHeight = 347
      inherited Panel4: TPanel
        Top = 306
        Width = 356
        ExplicitTop = 306
        ExplicitWidth = 356
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 128
        Width = 356
        Height = 178
        Align = alBottom
        Caption = ' Itens das especifica'#231#245'es '
        TabOrder = 2
        object GridEsp: TDBGrid
          Left = 2
          Top = 15
          Width = 352
          Height = 136
          Align = alClient
          DataSource = DataEspecificacao
          DrawingStyle = gdsGradient
          Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'DESCRICAO'
              Title.Caption = 'Descri'#231#227'o'
              Width = 307
              Visible = True
            end>
        end
        object cxDBNavigator1: TcxDBNavigator
          Left = 2
          Top = 151
          Width = 350
          Height = 25
          Buttons.First.Visible = False
          Buttons.PriorPage.Visible = False
          Buttons.Prior.Visible = False
          Buttons.Next.Visible = False
          Buttons.NextPage.Visible = False
          Buttons.Last.Visible = False
          Buttons.Insert.Visible = False
          Buttons.Append.Hint = 'Novo'
          Buttons.Append.Visible = True
          Buttons.Delete.Hint = 'Deletar'
          Buttons.Edit.Hint = 'Editar'
          Buttons.Post.Hint = 'Gravar'
          Buttons.Cancel.Hint = 'Cancelar'
          Buttons.Refresh.Visible = False
          Buttons.SaveBookmark.Visible = False
          Buttons.GotoBookmark.Visible = False
          Buttons.Filter.Visible = False
          DataSource = DataEspecificacao
          InfoPanel.Font.Charset = DEFAULT_CHARSET
          InfoPanel.Font.Color = clDefault
          InfoPanel.Font.Height = -11
          InfoPanel.Font.Name = 'Tahoma'
          InfoPanel.Font.Style = []
          Align = alBottom
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
      end
    end
    inherited ToolBar1: TToolBar
      Width = 667
      ExplicitWidth = 667
    end
    inherited Panel2: TPanel
      Height = 347
      ExplicitHeight = 347
      inherited PageControl: TcxPageControl
        Height = 345
        ExplicitHeight = 345
        ClientRectBottom = 341
        inherited tsGrid: TcxTabSheet
          ExplicitHeight = 319
          inherited pnlGrid: TPanel
            Height = 319
            ExplicitHeight = 319
            inherited TvCadastro: TcxGrid
              Height = 319
              ExplicitHeight = 319
            end
          end
        end
        inherited tsTree: TcxTabSheet
          ExplicitLeft = 2
          ExplicitTop = 22
          ExplicitWidth = 295
          ExplicitHeight = 319
          inherited pnlTree: TPanel
            Height = 319
            ExplicitHeight = 319
            inherited TvTree: TcxDBTreeList
              Height = 319
              ExplicitHeight = 319
            end
          end
        end
      end
    end
  end
  object DataEspecificacao: TDataSource
    DataSet = CdsEspecificacao
    Left = 32
    Top = 128
  end
  object CdsEspecificacao: TpFIBClientDataSet
    Aggregates = <>
    Filter = 'FLAGEDICAO <>'#39'D'#39
    Filtered = True
    Params = <>
    BeforeEdit = CdsEspecificacaoBeforeEdit
    BeforePost = CdsEspecificacaoBeforePost
    BeforeDelete = CdsEspecificacaoBeforeDelete
    OnNewRecord = CdsEspecificacaoNewRecord
    Left = 136
    Top = 128
  end
end
