program TestePharmaPele;

uses
  Vcl.Forms,
  umain in 'view\umain.pas' {FrmMain},
  cep.service in 'util\cep.service.pas',
  conexao in 'util\conexao.pas',
  connection in 'util\connection.pas',
  untFormat in 'util\untFormat.pas',
  iinterface.repository in 'interface\iinterface.repository.pas',
  iinterface.service in 'interface\iinterface.service.pas',
  cliente.model in 'model\cliente.model.pas',
  cliente.repository in 'dao\cliente.repository.pas',
  cliente.service in 'dao\cliente.service.pas',
  ucadastropadrao in 'view\ucadastropadrao.pas' {FrmCadastroPadrao},
  produto.model in 'model\produto.model.pas',
  cliente.controller in 'controller\cliente.controller.pas',
  ucadcliente in 'view\ucadcliente.pas' {FrmCadCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
