inherited frmRelDespRecEquipamento: TfrmRelDespRecEquipamento
  Caption = 'Relat'#243'rio de receita X despesa por equipamento'
  ClientHeight = 271
  ExplicitHeight = 305
  PixelsPerInch = 96
  TextHeight = 13
  inherited TreeView: TTreeView
    Height = 183
    ExplicitHeight = 183
  end
  inherited Panel1: TPanel
    Top = 230
    ExplicitTop = 230
  end
  inherited Panel2: TPanel
    inherited lblNome: TJvLabel
      Width = 655
      Height = 45
      Caption = 'Relat'#243'rio de receita X despesa por equipamento'
      ExplicitWidth = 655
    end
  end
  inherited PageControlMaster: TcxPageControl
    Height = 183
    ActivePage = tsGeral
    ExplicitHeight = 183
    ClientRectBottom = 183
    inherited tsGeral: TcxTabSheet
      ExplicitTop = 19
      ExplicitWidth = 541
      ExplicitHeight = 164
    end
    inherited tsFiltroPadrao: TcxTabSheet
      ExplicitTop = 19
      ExplicitWidth = 541
      ExplicitHeight = 369
      inherited pnlFiltro: TPanel
        Height = 164
        ExplicitHeight = 164
        inherited cxGrid1: TcxGrid
          Height = 143
          ExplicitHeight = 143
        end
        inherited Panel3: TPanel
          Height = 143
          ExplicitHeight = 143
        end
      end
    end
    inherited tsLayouts: TcxTabSheet
      ExplicitTop = 19
      ExplicitWidth = 541
      ExplicitHeight = 369
      inherited CategoryPanelGroup1: TCategoryPanelGroup
        Height = 164
        ExplicitHeight = 164
        inherited CategoryPanel1: TCategoryPanel
          inherited SpeedButton3: TSpeedButton
            Width = 179
            ExplicitWidth = 179
          end
          inherited btnNovo: TSpeedButton
            Width = 179
            ExplicitWidth = 179
          end
          inherited SpeedButton5: TSpeedButton
            Width = 179
            ExplicitWidth = 179
          end
        end
        inherited CategoryPanel2: TCategoryPanel
          ExplicitWidth = 198
        end
        inherited CategoryPanel3: TCategoryPanel
          ExplicitWidth = 198
          inherited DBRadioGroup2: TDBRadioGroup
            Width = 179
          end
        end
      end
      inherited cxGrid2: TcxGrid
        Height = 164
        ExplicitHeight = 164
      end
    end
  end
  inherited cxImageList1: TcxImageList
    FormatVersion = 1
  end
end
