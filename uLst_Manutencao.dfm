inherited frmLst_Manutencao: TfrmLst_Manutencao
  Caption = 'Listagem de  Manuten'#231#227'o'
  ClientHeight = 534
  ClientWidth = 874
  ExplicitWidth = 890
  ExplicitHeight = 573
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFiltros: TPanel
    Width = 874
    ExplicitWidth = 874
  end
  inherited Panel2: TPanel
    Width = 874
    ExplicitWidth = 874
  end
  inherited Status: TdxStatusBar
    Top = 514
    Width = 874
    ExplicitTop = 514
    ExplicitWidth = 874
  end
  inherited pnlCaption: TPanel
    Width = 874
    ExplicitWidth = 874
    inherited Panel4: TPanel
      Left = 523
      ExplicitLeft = 523
    end
  end
  inherited PageControl: TcxPageControl
    Width = 874
    Height = 426
    ExplicitWidth = 874
    ExplicitHeight = 426
    ClientRectBottom = 426
    ClientRectRight = 874
    inherited tsListagem: TcxTabSheet
      ExplicitTop = 20
      ExplicitWidth = 874
      ExplicitHeight = 406
      inherited cxGrid1: TcxGrid
        Width = 874
        Height = 406
        ExplicitWidth = 874
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
