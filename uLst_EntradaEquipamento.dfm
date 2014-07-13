inherited frmLst_EntradaEquipamento: TfrmLst_EntradaEquipamento
  Caption = 'Entrada de Equipamento'
  ClientHeight = 536
  ClientWidth = 880
  ExplicitWidth = 888
  ExplicitHeight = 570
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFiltros: TPanel
    Width = 880
    ExplicitWidth = 880
  end
  inherited Panel2: TPanel
    Width = 880
    ExplicitWidth = 880
  end
  inherited Status: TdxStatusBar
    Top = 516
    Width = 880
    ExplicitTop = 516
    ExplicitWidth = 880
  end
  inherited pnlCaption: TPanel
    Width = 880
    ExplicitWidth = 880
    inherited Panel4: TPanel
      Left = 529
      ExplicitLeft = 529
    end
  end
  inherited PageControl: TcxPageControl
    Width = 880
    Height = 428
    ExplicitWidth = 880
    ExplicitHeight = 428
    ClientRectBottom = 428
    ClientRectRight = 880
    inherited tsListagem: TcxTabSheet
      ExplicitTop = 20
      ExplicitWidth = 880
      ExplicitHeight = 408
      inherited cxGrid1: TcxGrid
        Width = 880
        Height = 408
        ExplicitWidth = 880
        ExplicitHeight = 408
        inherited TvListagem: TcxGridDBTableView
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Group = nil
        end
      end
    end
  end
end
