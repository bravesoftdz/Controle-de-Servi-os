inherited frmCad_Cliente: TfrmCad_Cliente
  Caption = 'Cadastro de clientes'
  ClientHeight = 498
  ClientWidth = 773
  ExplicitWidth = 781
  ExplicitHeight = 552
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 773
    inherited SpeedButton4: TSpeedButton
      Width = 142
      Caption = '&Imprimir/Consultar'
      ExplicitWidth = 142
    end
  end
  inherited pnlTree: TPanel
    Height = 468
    ExplicitHeight = 468
    inherited TreeItens: TcxTreeView
      Height = 462
      ExplicitHeight = 462
    end
  end
  inherited Panel3: TPanel
    Width = 588
    Height = 468
    ExplicitHeight = 468
    inherited PageControl: TcxPageControl
      Width = 588
      Height = 468
      ExplicitHeight = 468
      ClientRectBottom = 467
      ClientRectRight = 587
      inherited TsPrincipal: TcxTabSheet
        ExplicitLeft = 1
        ExplicitTop = 21
        ExplicitWidth = 517
        ExplicitHeight = 446
        inherited pnlGeral: TPanel
          Width = 586
          Height = 446
          ExplicitHeight = 446
          object LabelDBEdit1: TLabelDBEdit
            Left = 10
            Top = 24
            Width = 71
            Height = 21
            DataField = 'CODIGO'
            DataSource = DataCadastro
            TabOrder = 0
            Titulo.Left = 10
            Titulo.Top = 9
            Titulo.Width = 33
            Titulo.Height = 13
            Titulo.Caption = 'C'#243'digo'
            IsNull = False
            PodeRepetir = False
            CorPrincipal = clWhite
            CorSecundaria = 11592447
            GravaEsteCampo = True
          end
          object edtNome: TLabelDBEdit
            Left = 87
            Top = 24
            Width = 193
            Height = 21
            DataField = 'NOMECLIENTE'
            DataSource = DataCadastro
            TabOrder = 1
            Titulo.Left = 87
            Titulo.Top = 9
            Titulo.Width = 27
            Titulo.Height = 13
            Titulo.Caption = 'Nome'
            IsNull = False
            PodeRepetir = True
            CorPrincipal = clWhite
            CorSecundaria = 11592447
            GravaEsteCampo = True
          end
          object LabelDBEdit7: TLabelDBEdit
            Left = 427
            Top = 24
            Width = 82
            Height = 21
            TabStop = False
            Color = clSkyBlue
            DataField = 'DATACADASTRO'
            DataSource = DataCadastro
            ReadOnly = True
            TabOrder = 10
            Titulo.Left = 427
            Titulo.Top = 9
            Titulo.Width = 83
            Titulo.Height = 13
            Titulo.Caption = 'Data do cadastro'
            IsNull = False
            PodeRepetir = True
            CorPrincipal = clWhite
            CorSecundaria = 11592447
            GravaEsteCampo = True
          end
          object LabelDBEdit8: TLabelDBEdit
            Left = 300
            Top = 69
            Width = 82
            Height = 21
            DataField = 'DATANASCIMENTO'
            DataSource = DataCadastro
            TabOrder = 5
            Titulo.Left = 300
            Titulo.Top = 54
            Titulo.Width = 55
            Titulo.Height = 13
            Titulo.Caption = 'Nascimento'
            IsNull = True
            PodeRepetir = True
            CorPrincipal = clWhite
            CorSecundaria = 11592447
            GravaEsteCampo = True
          end
          object LabelDBEdit9: TLabelDBEdit
            Left = 10
            Top = 69
            Width = 144
            Height = 21
            DataField = 'Telefone'
            DataSource = DataCadastro
            TabOrder = 3
            Titulo.Left = 10
            Titulo.Top = 54
            Titulo.Width = 42
            Titulo.Height = 13
            Titulo.Caption = 'Telefone'
            IsNull = True
            PodeRepetir = True
            CorPrincipal = clWhite
            CorSecundaria = 11592447
            GravaEsteCampo = True
          end
          object LabelDBEdit10: TLabelDBEdit
            Left = 160
            Top = 69
            Width = 134
            Height = 21
            DataField = 'CELULAR'
            DataSource = DataCadastro
            TabOrder = 4
            Titulo.Left = 160
            Titulo.Top = 54
            Titulo.Width = 33
            Titulo.Height = 13
            Titulo.Caption = 'Celular'
            IsNull = True
            PodeRepetir = True
            CorPrincipal = clWhite
            CorSecundaria = 11592447
            GravaEsteCampo = True
          end
          object GroupBox1: TGroupBox
            Left = 0
            Top = 195
            Width = 586
            Height = 144
            Align = alBottom
            Caption = ' Endere'#231'o '
            TabOrder = 9
            ExplicitWidth = 517
            object edtPesqCEP: TSpeedButton
              Left = 80
              Top = 32
              Width = 23
              Height = 22
              Glyph.Data = {
                36060000424D3606000000000000360000002800000020000000100000000100
                1800000000000006000000000000000000000000000000000000FF00FF4A667C
                BE9596FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FF777777BDBDBDFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6B9CC31E89E8
                4B7AA3C89693FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFABABAB9797978B8B8BC1C1C1FF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4BB4FE51B5FF
                2089E94B7AA2C69592FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFB8B8B8BCBCBC9898988A8A8AC0C0C0FF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF51B7FE
                51B3FF1D87E64E7AA0CA9792FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFBBBBBBBCBCBC9595958B8B8BC2C2C2FF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                51B7FE4EB2FF1F89E64E7BA2B99497FF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFBBBBBBBABABA9696968C8C8CBABABAFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FF52B8FE4BB1FF2787D95F6A76FF00FFB0857FC09F94C09F96BC988EFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBCBCBCB9B9B99494947E7E7EFF
                00FF979797AAAAAAABABABA5A5A5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FFFF00FF55BDFFB5D6EDBF9D92BB9B8CE7DAC2FFFFE3FFFFE5FDFADAD8C3
                B3B58D85FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBEBEBED1D1D1A8A8A8A3
                A3A3D4D4D4F1F1F1F2F2F2EBEBEBC5C5C59D9D9DFF00FFFF00FFFF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFCEA795FDEEBEFFFFD8FFFFDAFFFFDBFFFFE6FFFF
                FBEADDDCAE837FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1B1B1DD
                DDDDEBEBEBECECECEDEDEDF2F2F2FDFDFDE3E3E3969696FF00FFFF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFC1A091FBDCA8FEF7D0FFFFDBFFFFE3FFFFF8FFFF
                FDFFFFFDC6A99CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA9A9A9D1
                D1D1E7E7E7EDEDEDF1F1F1FBFBFBFEFEFEFEFEFEB1B1B1FF00FFFF00FFFF00FF
                FF00FFFF00FFFF00FFC1A091FEE3ACF1C491FCF2CAFFFFDDFFFFE4FFFFF7FFFF
                F7FFFFE9EEE5CBB9948CFF00FFFF00FFFF00FFFF00FFFF00FFA9A9A9D5D5D5C1
                C1C1E3E3E3EEEEEEF1F1F1FBFBFBFBFBFBF4F4F4DCDCDCA2A2A2FF00FFFF00FF
                FF00FFFF00FFFF00FFC2A191FFE6AEEEB581F7DCAEFEFDD8FFFFDFFFFFE3FFFF
                E4FFFFE0F3ECD2BB968EFF00FFFF00FFFF00FFFF00FFFF00FFA9A9A9D6D6D6B7
                B7B7D2D2D2EBEBEBEFEFEFF1F1F1F1F1F1EFEFEFE2E2E2A4A4A4FF00FFFF00FF
                FF00FFFF00FFFF00FFBC978CFBE7B7F4C791F2C994F8E5B9FEFCD8FFFFDDFFFF
                DCFFFFE0E2D2BAB68E86FF00FFFF00FFFF00FFFF00FFFF00FFA4A4A4D9D9D9C2
                C2C2C3C3C3D8D8D8EBEBEBEEEEEEEDEDEDEFEFEFCECECE9E9E9EFF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFD9C3A9FFFEE5F7DCB8F2C994F5D4A5FAE8BDFDF4
                C9FDFBD6B69089FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC1C1C1F2
                F2F2D7D7D7C3C3C3CDCDCDDBDBDBE3E3E3E9E9E99F9F9FFF00FFFF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFB58D85E8DEDDFFFEF2F9D8A3F4C48CF9D49FFDEA
                B8D0B49FB89086FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9D9D9DE2
                E2E2F8F8F8CECECEC0C0C0CCCCCCDADADAB7B7B79F9F9FFF00FFFF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFAD827FC9AA9EEFE0B7EFDFB2E7CEACB890
                86B89086FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF96
                9696B3B3B3D3D3D3D0D0D0C9C9C99F9F9F9F9F9FFF00FFFF00FFFF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBA968ABB988CB79188FF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFA2A2A2A3A3A39F9F9FFF00FFFF00FFFF00FFFF00FF}
              NumGlyphs = 2
              OnClick = edtPesqCEPClick
            end
            object edtBairro: TLabelDBEdit
              Left = 10
              Top = 73
              Width = 221
              Height = 21
              DataField = 'BAIRRO'
              DataSource = DataCadastro
              TabOrder = 2
              Titulo.Left = 10
              Titulo.Top = 58
              Titulo.Width = 28
              Titulo.Height = 13
              Titulo.Caption = 'Bairro'
              IsNull = True
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
            object edtCidade: TLabelDBEdit
              Left = 239
              Top = 73
              Width = 224
              Height = 21
              DataField = 'CIDADE'
              DataSource = DataCadastro
              TabOrder = 3
              Titulo.Left = 239
              Titulo.Top = 58
              Titulo.Width = 33
              Titulo.Height = 13
              Titulo.Caption = 'Cidade'
              IsNull = True
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
            object edtUf: TLabelDBEdit
              Left = 469
              Top = 73
              Width = 32
              Height = 21
              CharCase = ecUpperCase
              DataField = 'UF'
              DataSource = DataCadastro
              TabOrder = 4
              Titulo.Left = 469
              Titulo.Top = 58
              Titulo.Width = 13
              Titulo.Height = 13
              Titulo.Caption = 'UF'
              IsNull = True
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
            object edtNumero: TLabelDBEdit
              Left = 10
              Top = 113
              Width = 57
              Height = 21
              DataField = 'NUMERO'
              DataSource = DataCadastro
              TabOrder = 5
              Titulo.Left = 10
              Titulo.Top = 98
              Titulo.Width = 37
              Titulo.Height = 13
              Titulo.Caption = 'N'#250'mero'
              IsNull = True
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
            object LabelDBEdit12: TLabelDBEdit
              Left = 73
              Top = 113
              Width = 428
              Height = 21
              DataField = 'COMPLEMENTO'
              DataSource = DataCadastro
              TabOrder = 6
              Titulo.Left = 73
              Titulo.Top = 98
              Titulo.Width = 65
              Titulo.Height = 13
              Titulo.Caption = 'Complemento'
              IsNull = True
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
            object edtLogradouro: TLabelDBEdit
              Left = 105
              Top = 32
              Width = 396
              Height = 21
              DataField = 'LOGRADOURO'
              DataSource = DataCadastro
              TabOrder = 1
              Titulo.Left = 105
              Titulo.Top = 17
              Titulo.Width = 55
              Titulo.Height = 13
              Titulo.Caption = 'Logradouro'
              IsNull = True
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
            object edtCEP: TLabelDBEdit
              Left = 10
              Top = 33
              Width = 64
              Height = 21
              DataField = 'CEP'
              DataSource = DataCadastro
              TabOrder = 0
              OnExit = edtCEPExit
              Titulo.Left = 10
              Titulo.Top = 18
              Titulo.Width = 19
              Titulo.Height = 13
              Titulo.Caption = 'CEP'
              IsNull = True
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
          end
          object grpTipoPessoa: TDBRadioGroup
            Left = 388
            Top = 55
            Width = 121
            Height = 44
            Caption = ' Tipo de pessoa '
            Columns = 2
            DataField = 'FLAGTIPOPESSOA'
            DataSource = DataCadastro
            Items.Strings = (
              'F'#237'sica'
              'Jur'#237'dica')
            ParentBackground = True
            TabOrder = 6
            Values.Strings = (
              'F'
              'J')
            OnChange = grpTipoPessoaChange
          end
          object pnlJuridica: TPanel
            Left = 5
            Top = 105
            Width = 499
            Height = 51
            BevelOuter = bvNone
            TabOrder = 7
            Visible = False
            object LabelDBEdit2: TLabelDBEdit
              Left = 5
              Top = 20
              Width = 121
              Height = 21
              DataField = 'CNPJ'
              DataSource = DataCadastro
              TabOrder = 0
              Titulo.Left = 5
              Titulo.Top = 5
              Titulo.Width = 25
              Titulo.Height = 13
              Titulo.Caption = 'CNPJ'
              IsNull = True
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
            object LabelDBEdit13: TLabelDBEdit
              Left = 131
              Top = 20
              Width = 144
              Height = 21
              DataField = 'IE'
              DataSource = DataCadastro
              TabOrder = 1
              Titulo.Left = 131
              Titulo.Top = 5
              Titulo.Width = 87
              Titulo.Height = 13
              Titulo.Caption = 'Inscri'#231#227'o estadual'
              IsNull = True
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
            object LabelDBEdit14: TLabelDBEdit
              Left = 282
              Top = 20
              Width = 89
              Height = 21
              DataField = 'IM'
              DataSource = DataCadastro
              TabOrder = 2
              Titulo.Left = 282
              Titulo.Top = 5
              Titulo.Width = 89
              Titulo.Height = 13
              Titulo.Caption = 'Inscri'#231#227'o Municipal'
              IsNull = True
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
            object LabelDBEdit15: TLabelDBEdit
              Left = 379
              Top = 20
              Width = 89
              Height = 21
              DataField = 'CONTATO'
              DataSource = DataCadastro
              TabOrder = 3
              Titulo.Left = 379
              Titulo.Top = 5
              Titulo.Width = 39
              Titulo.Height = 13
              Titulo.Caption = 'Contato'
              IsNull = True
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
          end
          object pnlFisica: TPanel
            Left = 10
            Top = 105
            Width = 499
            Height = 38
            BevelOuter = bvNone
            TabOrder = 8
            object LabelDBEdit3: TLabelDBEdit
              Left = 2
              Top = 14
              Width = 121
              Height = 21
              DataField = 'CPF'
              DataSource = DataCadastro
              TabOrder = 0
              Titulo.Left = 2
              Titulo.Top = -1
              Titulo.Width = 19
              Titulo.Height = 13
              Titulo.Caption = 'CPF'
              IsNull = True
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
            object LabelDBEdit4: TLabelDBEdit
              Left = 129
              Top = 14
              Width = 144
              Height = 21
              DataField = 'RG'
              DataSource = DataCadastro
              TabOrder = 1
              Titulo.Left = 129
              Titulo.Top = -1
              Titulo.Width = 14
              Titulo.Height = 13
              Titulo.Caption = 'RG'
              IsNull = True
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
            object LabelDBEdit5: TLabelDBEdit
              Left = 279
              Top = 14
              Width = 89
              Height = 21
              DataField = 'ORGAOEMISSOR'
              DataSource = DataCadastro
              TabOrder = 2
              Titulo.Left = 279
              Titulo.Top = -1
              Titulo.Width = 72
              Titulo.Height = 13
              Titulo.Caption = #211'rg'#227'o emissor '
              IsNull = True
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
            object LabelDBEdit6: TLabelDBEdit
              Left = 376
              Top = 14
              Width = 82
              Height = 21
              DataField = 'DATAEMISSAO'
              DataSource = DataCadastro
              TabOrder = 3
              Titulo.Left = 376
              Titulo.Top = -1
              Titulo.Width = 79
              Titulo.Height = 13
              Titulo.Caption = 'Data de emiss'#227'o'
              IsNull = True
              PodeRepetir = True
              CorPrincipal = clWhite
              CorSecundaria = 11592447
              GravaEsteCampo = True
            end
          end
          object LabelDBEdit16: TLabelDBEdit
            Left = 282
            Top = 24
            Width = 142
            Height = 21
            DataField = 'FANTASIA'
            DataSource = DataCadastro
            TabOrder = 2
            Titulo.Left = 282
            Titulo.Top = 9
            Titulo.Width = 41
            Titulo.Height = 13
            Titulo.Caption = 'Fantasia'
            IsNull = True
            PodeRepetir = False
            CorPrincipal = clWhite
            CorSecundaria = 11592447
            GravaEsteCampo = True
          end
          object GroupBox2: TGroupBox
            Left = 0
            Top = 339
            Width = 586
            Height = 107
            Align = alBottom
            Caption = ' Observa'#231#245'es '
            TabOrder = 11
            ExplicitWidth = 517
            object DBMemo1: TDBMemo
              Left = 2
              Top = 15
              Width = 582
              Height = 90
              Align = alClient
              DataField = 'OBS'
              DataSource = DataCadastro
              ScrollBars = ssVertical
              TabOrder = 0
              ExplicitWidth = 513
            end
          end
          object LabelDBEdit11: TLabelDBEdit
            Left = 12
            Top = 169
            Width = 461
            Height = 21
            DataField = 'EMAIL'
            DataSource = DataCadastro
            TabOrder = 12
            Titulo.Left = 12
            Titulo.Top = 154
            Titulo.Width = 28
            Titulo.Height = 13
            Titulo.Caption = 'E-Mail'
            IsNull = True
            PodeRepetir = True
            CorPrincipal = clWhite
            CorSecundaria = 11592447
            GravaEsteCampo = True
          end
        end
      end
    end
  end
  inherited ActionList1: TActionList
    object actIntegracao: TAction
      Caption = 'Integra'#231#227'o'
      OnExecute = actIntegracaoExecute
    end
    object actIntServicos: TAction
      Caption = 'Servi'#231'os desse cliente'
      OnExecute = actIntServicosExecute
    end
  end
  inherited MainMenu1: TMainMenu
    object Integrao1: TMenuItem [0]
      Action = actIntegracao
      object Desseregistro2: TMenuItem
        Action = actIntServicos
      end
    end
  end
end
