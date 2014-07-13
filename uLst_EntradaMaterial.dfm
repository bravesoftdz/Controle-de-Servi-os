inherited frmLst_EntradaMaterial: TfrmLst_EntradaMaterial
  Caption = 'Entrada de material'
  ClientHeight = 458
  ClientWidth = 644
  ExplicitWidth = 652
  ExplicitHeight = 492
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFiltros: TPanel
    Width = 644
    ExplicitWidth = 875
  end
  inherited Panel2: TPanel
    Width = 644
    ExplicitWidth = 875
  end
  inherited Status: TdxStatusBar
    Top = 438
    Width = 644
    ExplicitTop = 514
    ExplicitWidth = 875
  end
  inherited pnlCaption: TPanel
    Width = 644
    ExplicitWidth = 875
    inherited Panel4: TPanel
      Left = 293
      ExplicitLeft = 524
    end
  end
  inherited PageControl: TcxPageControl
    Width = 644
    Height = 350
    ExplicitWidth = 875
    ExplicitHeight = 426
    ClientRectBottom = 350
    ClientRectRight = 644
    inherited tsListagem: TcxTabSheet
      ExplicitTop = 20
      ExplicitWidth = 875
      ExplicitHeight = 406
      inherited cxGrid1: TcxGrid
        Width = 644
        Height = 330
        ExplicitWidth = 875
        ExplicitHeight = 406
        inherited TvListagem: TcxGridDBTableView
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Group = nil
        end
      end
    end
  end
end
