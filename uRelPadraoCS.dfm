inherited frmRelPadraoCS: TfrmRelPadraoCS
  Caption = 'frmRelPadraoCS'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControlMaster: TcxPageControl
    inherited tsGeral: TcxTabSheet
      ExplicitTop = 19
      ExplicitWidth = 541
      ExplicitHeight = 369
    end
    inherited tsFiltroPadrao: TcxTabSheet
      ExplicitTop = 19
      ExplicitWidth = 541
      ExplicitHeight = 369
    end
    inherited tsLayouts: TcxTabSheet
      ExplicitTop = 19
      ExplicitWidth = 541
      ExplicitHeight = 369
      inherited CategoryPanelGroup1: TCategoryPanelGroup
        inherited CategoryPanel2: TCategoryPanel
          ExplicitWidth = 198
        end
        inherited CategoryPanel3: TCategoryPanel
          ExplicitWidth = 198
        end
      end
    end
  end
  inherited cxImageList1: TcxImageList
    FormatVersion = 1
  end
  object CdsEmpresa: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    Left = 216
    Top = 120
  end
  object DataEmpresa: TDataSource
    DataSet = CdsEmpresa
    Left = 304
    Top = 112
  end
end
