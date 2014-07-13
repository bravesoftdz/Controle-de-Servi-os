inherited frmCad_usuario: TfrmCad_usuario
  Caption = 'Cadastro de usu'#225'rio'
  ClientWidth = 624
  ExplicitWidth = 632
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 624
    ExplicitWidth = 624
  end
  inherited Panel3: TPanel
    Width = 439
    ExplicitWidth = 439
    inherited PageControl: TcxPageControl
      Width = 439
      ExplicitWidth = 439
      ClientRectRight = 438
      inherited TsPrincipal: TcxTabSheet
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 437
        ExplicitHeight = 321
        inherited pnlGeral: TPanel
          Width = 437
          ExplicitWidth = 437
          object GroupBox1: TGroupBox
            Left = 0
            Top = 89
            Width = 437
            Height = 232
            Align = alClient
            Caption = ' Acessos '
            TabOrder = 0
            object Label1: TLabel
              Left = 2
              Top = 217
              Width = 265
              Height = 13
              Align = alBottom
              Caption = 'D'#234' duplo clique no acesso para habilitar/desabilitar [F2]'
            end
            object cxDBTreeList1: TcxDBTreeList
              Tag = 99
              Left = 2
              Top = 15
              Width = 433
              Height = 202
              Align = alClient
              Bands = <
                item
                end>
              DataController.DataSource = DataAcessos
              DataController.ParentField = 'IDPAI'
              DataController.KeyField = 'IDACESSO'
              LookAndFeel.Kind = lfStandard
              RootValue = -1
              TabOrder = 0
              OnDblClick = cxDBTreeList1DblClick
              ExplicitLeft = 53
              ExplicitTop = 103
              object cxDBTreeList1cxDBTreeListColumn1: TcxDBTreeListColumn
                Caption.Text = 'Descri'#231#227'o'
                DataBinding.FieldName = 'DESCRICAO'
                Options.Editing = False
                Width = 307
                Position.ColIndex = 0
                Position.RowIndex = 0
                Position.BandIndex = 0
                Summary.FooterSummaryItems = <>
                Summary.GroupFooterSummaryItems = <>
              end
              object cxDBTreeList1cxDBTreeListColumn2: TcxDBTreeListColumn
                RepositoryItem = cxEditRepository1ImageComboBoxItem1
                Caption.Text = 'Permitido'
                DataBinding.FieldName = 'FLAGPERMITIDO'
                Options.Editing = False
                Width = 100
                Position.ColIndex = 1
                Position.RowIndex = 0
                Position.BandIndex = 0
                Summary.FooterSummaryItems = <>
                Summary.GroupFooterSummaryItems = <>
              end
            end
          end
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 437
            Height = 89
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object LabelDBEdit3: TLabelDBEdit
              Left = 8
              Top = 62
              Width = 353
              Height = 21
              DataField = 'NOMECOMPLETO'
              DataSource = DataCadastro
              TabOrder = 0
              Titulo.Left = 8
              Titulo.Top = 47
              Titulo.Width = 75
              Titulo.Height = 13
              Titulo.Caption = 'Nome Completo'
              IsNull = True
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
            object LabelDBEdit1: TLabelDBEdit
              Left = 8
              Top = 24
              Width = 121
              Height = 21
              DataField = 'LOGIN'
              DataSource = DataCadastro
              TabOrder = 1
              Titulo.Left = 8
              Titulo.Top = 9
              Titulo.Width = 25
              Titulo.Height = 13
              Titulo.Caption = 'Login'
              IsNull = False
              PodeRepetir = False
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
            object LabelDBEdit2: TLabelDBEdit
              Left = 135
              Top = 24
              Width = 121
              Height = 21
              DataField = 'SENHA'
              DataSource = DataCadastro
              PasswordChar = '*'
              TabOrder = 2
              Titulo.Left = 135
              Titulo.Top = 9
              Titulo.Width = 30
              Titulo.Height = 13
              Titulo.Caption = 'Senha'
              IsNull = False
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
            object DBCheckBox1: TDBCheckBox
              Left = 264
              Top = 24
              Width = 97
              Height = 17
              Caption = 'Administrador'
              DataField = 'FLAGADMINISTRADOR'
              DataSource = DataCadastro
              TabOrder = 3
              ValueChecked = 'Y'
              ValueUnchecked = 'N'
            end
          end
        end
      end
    end
  end
  inherited ActionList1: TActionList
    inherited actImprimir: TAction
      Visible = False
    end
    object actMudaAcesso: TAction
      Caption = 'actMudaAcesso'
      ShortCut = 113
      OnExecute = actMudaAcessoExecute
    end
  end
  inherited CdsCadastro: TpFIBClientDataSet
    AfterScroll = CdsCadastroAfterScroll
  end
  object CdsAcessos: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = CdsAcessosAfterOpen
    Left = 40
    Top = 192
  end
  object DataAcessos: TDataSource
    DataSet = CdsAcessos
    Left = 120
    Top = 184
  end
  object cxEditRepository1: TcxEditRepository
    Left = 40
    Top = 248
    object cxEditRepository1ImageComboBoxItem1: TcxEditRepositoryImageComboBoxItem
      Properties.Images = DMConexao.ImageList16_16
      Properties.ImmediatePost = True
      Properties.Items = <
        item
          Description = 'N'#227'o'
          ImageIndex = 9
          Value = 'N'
        end
        item
          Description = 'Sim'
          ImageIndex = 14
          Value = 'Y'
        end>
    end
  end
end
