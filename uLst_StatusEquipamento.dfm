inherited frmLstStatusEquipamento: TfrmLstStatusEquipamento
  Caption = 'Status do equipamento'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited Panel3: TPanel
      object Label1: TLabel [0]
        Left = 16
        Top = 94
        Width = 17
        Height = 13
        Caption = 'Cor'
      end
      object LabelDBEdit1: TLabelDBEdit
        Left = 16
        Top = 66
        Width = 185
        Height = 21
        DataField = 'NOMESTATUS'
        DataSource = DataCadastro
        TabOrder = 2
        Titulo.Left = 16
        Titulo.Top = 51
        Titulo.Width = 31
        Titulo.Height = 13
        Titulo.Caption = 'Status'
        IsNull = False
        PodeRepetir = False
        CorPrincipal = clWhite
        CorSecundaria = 11592447
        GravaEsteCampo = True
      end
      object cxDBColorComboBox1: TcxDBColorComboBox
        Left = 16
        Top = 110
        DataBinding.DataField = 'COR'
        DataBinding.DataSource = DataCadastro
        Properties.AllowSelectColor = True
        Properties.ColorComboStyle = cxccsComboList
        Properties.ColorValueFormat = cxcvHexadecimal
        Properties.CustomColors = <
          item
            Color = clBlack
            Description = 'Preto'
          end
          item
            Color = clGreen
            Description = 'Verde'
          end
          item
            Color = clRed
            Description = 'Vermelho'
          end
          item
            Color = clYellow
            Description = 'Amarelo'
          end>
        Properties.DefaultColorStyle = cxdcClear
        Properties.DefaultDescription = 'Sem cor definida'
        Properties.ImmediatePost = True
        Properties.ImmediateUpdateText = True
        Properties.NamingConvention = cxncHTML4
        Properties.PrepareList = cxplHTML4
        Properties.ShowDescriptions = False
        Style.BorderStyle = ebs3D
        Style.Shadow = False
        Style.ButtonStyle = bts3D
        Style.ButtonTransparency = ebtAlways
        TabOrder = 3
        Width = 185
      end
    end
    inherited Panel2: TPanel
      inherited PageControl: TcxPageControl
        inherited tsTree: TcxTabSheet
          ExplicitLeft = 2
          ExplicitTop = 22
          ExplicitWidth = 295
          ExplicitHeight = 296
        end
      end
    end
  end
end
