inherited frmRelClientes: TfrmRelClientes
  Caption = 'Listagem de clientes'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited lblNome: TJvLabel
      Caption = 'Listagem de clientes'
      ExplicitWidth = 261
    end
  end
  inherited PageControlMaster: TcxPageControl
    ActivePage = tsGeral
    inherited tsGeral: TcxTabSheet
      object grpTipoPessoa: TRadioGroup
        Left = 16
        Top = 24
        Width = 185
        Height = 73
        Caption = ' Tipo de pessoa '
        ItemIndex = 0
        Items.Strings = (
          'Todas'
          'F'#237'sicas'
          'Jur'#237'dicas')
        TabOrder = 0
      end
      object edtBairro: TLabeledEdit
        Left = 16
        Top = 128
        Width = 233
        Height = 21
        Hint = 
          'Voc'#234' pode usar % antes e/ou depois do digitado para localizar qu' +
          'alquer caracter'
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Bairro'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object edtCidade: TLabeledEdit
        Left = 16
        Top = 168
        Width = 233
        Height = 21
        Hint = 
          'Voc'#234' pode usar % antes e/ou depois do digitado para localizar qu' +
          'alquer caracter'
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Cidade'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object GroupBox1: TGroupBox
        Left = 207
        Top = 24
        Width = 203
        Height = 70
        Caption = ' Per'#237'odo de cadastro '
        TabOrder = 3
        object Label2: TLabel
          Left = 8
          Top = 16
          Width = 51
          Height = 13
          Caption = 'Data inicial'
        end
        object Label3: TLabel
          Left = 96
          Top = 16
          Width = 46
          Height = 13
          Caption = 'Data final'
        end
        object edtDataIni: TcxDateEdit
          Left = 8
          Top = 32
          TabOrder = 0
          Width = 78
        end
        object edtDataFin: TcxDateEdit
          Left = 96
          Top = 32
          TabOrder = 1
          Width = 78
        end
      end
    end
    inherited tsFiltroPadrao: TcxTabSheet
      inherited pnlFiltro: TPanel
        inherited Panel4: TPanel
          inherited lblTituloFiltro: TLabel
            Width = 81
            Height = 16
          end
        end
      end
    end
  end
  inherited cxImageList1: TcxImageList
    FormatVersion = 1
  end
end
