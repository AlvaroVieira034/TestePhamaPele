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
  tipoproduto.controller in 'controller\tipoproduto.controller.pas',
  ucadpedido in 'view\ucadpedido.pas' {FrmCadPedido},
  pedido.model in 'model\pedido.model.pas',
  pedidoitens.model in 'model\pedidoitens.model.pas',
  upesqpedidos in 'view\upesqpedidos.pas' {FrmPesquisaPedidos},
  pedido.controller in 'controller\pedido.controller.pas',
  pedidoitens.controller in 'controller\pedidoitens.controller.pas',
  ipedido.repository in 'interface\ipedido.repository.pas',
  ipedido.service in 'interface\ipedido.service.pas',
  ipedidoitens.repository in 'interface\ipedidoitens.repository.pas',
  pedido.repository in 'dao\pedido.repository.pas',
  pedido.service in 'dao\pedido.service.pas',
  pedidoitens.repository in 'dao\pedidoitens.repository.pas',
  entregador.model in 'model\entregador.model.pas',
  entregador.repository in 'dao\entregador.repository.pas',
  entregador.service in 'dao\entregador.service.pas',
  entregador.controller in 'controller\entregador.controller.pas',
  ucadentregador in 'view\ucadentregador.pas' {FrmCadEntregador},
  entregas.repository in 'dao\entregas.repository.pas',
  entregas.service in 'dao\entregas.service.pas',
  entregas.model in 'model\entregas.model.pas',
  entregas.controller in 'controller\entregas.controller.pas',
  ientregas.repository in 'interface\ientregas.repository.pas',
  ientregas.service in 'interface\ientregas.service.pas',
  ucadentrega in 'view\ucadentrega.pas' {FrmCadEntrega},
  uposicaopedidos in 'view\uposicaopedidos.pas' {FrmPosicaoPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
