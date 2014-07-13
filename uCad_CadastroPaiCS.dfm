inherited frmCad_CadastroPaiCS: TfrmCad_CadastroPaiCS
  Caption = 'frmCad_CadastroPaiCS'
  ClientHeight = 313
  Menu = MainMenu1
  ExplicitWidth = 320
  ExplicitHeight = 387
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlTree: TPanel
    Height = 283
    ExplicitHeight = 283
    inherited TreeItens: TcxTreeView
      Height = 277
      ExplicitHeight = 277
    end
  end
  inherited Panel3: TPanel
    Height = 283
    ExplicitHeight = 303
    inherited PageControl: TcxPageControl
      Height = 283
      ExplicitHeight = 303
      ClientRectBottom = 282
      inherited TsPrincipal: TcxTabSheet
        ExplicitLeft = 1
        ExplicitTop = 21
        ExplicitWidth = 517
        ExplicitHeight = 281
        inherited pnlGeral: TPanel
          Height = 281
          ExplicitHeight = 281
        end
      end
    end
  end
  inherited ActionList1: TActionList
    object actAuditoria: TAction
      Category = 'Auditoria'
      Caption = 'Auditoria'
      OnExecute = actAuditoriaExecute
    end
    object actAudDesteRegistro: TAction
      Category = 'Auditoria'
      Caption = 'Desse registro'
      OnExecute = actAudDesteRegistroExecute
    end
    object actDessaTabela: TAction
      Category = 'Auditoria'
      Caption = 'Dessa tabela'
      OnExecute = actDessaTabelaExecute
    end
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 160
    object Auditoria1: TMenuItem
      Action = actAuditoria
      object Desseregistro1: TMenuItem
        Action = actAudDesteRegistro
      end
      object Dessatabela1: TMenuItem
        Action = actDessaTabela
      end
    end
  end
end
