inherited frmLst_Unidade: TfrmLst_Unidade
  Caption = 'Cadastro de unidade'
  ExplicitWidth = 650
  ExplicitHeight = 407
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited Panel3: TPanel
      object DBCheckBox1: TDBCheckBox
        Left = 16
        Top = 104
        Width = 193
        Height = 17
        Caption = 'Permitir francionado?'
        DataField = 'FLAGFRACIONADO'
        DataSource = DataCadastro
        TabOrder = 2
        ValueChecked = 'Y'
        ValueUnchecked = 'N'
      end
      object TDBCheckBox
        Left = 16
        Top = 136
        Width = 193
        Height = 17
        Caption = 'Usar em equipamento'
        DataField = 'FLAUNIDADEDEEQUIPAMENTO'
        DataSource = DataCadastro
        TabOrder = 3
        ValueChecked = 'Y'
        ValueUnchecked = 'N'
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
