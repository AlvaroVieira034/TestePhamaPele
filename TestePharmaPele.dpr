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
  ucadcliente in 'view\ucadcliente.pas' {FrmCadCliente},
  produto.service in 'dao\produto.service.pas',
  produto.repository in 'dao\produto.repository.pas',
  produto.controller in 'controller\produto.controller.pas',
  ucadproduto in 'view\ucadproduto.pas' {FrmCadProduto},
  tipoproduto.service in 'dao\tipoproduto.service.pas',
  tipoproduto.model in 'model\tipoproduto.model.pas',
  tipoproduto.controller in 'controller\tipoproduto.controller.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
