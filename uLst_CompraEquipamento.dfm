inherited frmLst_CompraEquipamentos: TfrmLst_CompraEquipamentos
  Caption = 'Listagem de Compra de equipamentos'
  ClientHeight = 531
  ClientWidth = 877
  ExplicitWidth = 885
  ExplicitHeight = 565
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFiltros: TPanel
    Width = 877
    ExplicitWidth = 877
  end
  inherited Panel2: TPanel
    Width = 877
    ExplicitWidth = 877
  end
  inherited Status: TdxStatusBar
    Top = 511
    Width = 877
    ExplicitTop = 511
    ExplicitWidth = 877
  end
  inherited pnlCaption: TPanel
    Width = 877
    ExplicitWidth = 877
    inherited Panel4: TPanel
      Left = 526
      ExplicitLeft = 526
    end
  end
  inherited PageControl: TcxPageControl
    Width = 877
    Height = 423
    ExplicitWidth = 877
    ExplicitHeight = 423
    ClientRectBottom = 423
    ClientRectRight = 877
    inherited tsListagem: TcxTabSheet
      ExplicitTop = 20
      ExplicitWidth = 877
      ExplicitHeight = 403
      inherited cxGrid1: TcxGrid
        Width = 877
        Height = 403
        ExplicitWidth = 877
        ExplicitHeight = 403
        inherited TvListagem: TcxGridDBTableView
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Group = nil
        end
      end
    end
  end
end
