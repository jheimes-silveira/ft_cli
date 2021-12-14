import '../../../core/utils/output_utils.dart' as output;

class HelpCommandController {
  void call() {
    output.warn(
      '''
-------------------------- HELPS --------------------------

i, init             Gera os arquivos configuraveis do projeto...
Exemplo: ft_cli init

mf, microfrontend   Seleciona a opção para criação de novos componentes de microfrontend...
Exemplo: ft_cli mf

l, layer            Gera a estrutura de pastas de um modulo...
Exemplo: ft_cli g l lib/app/modules/nome_modulo

p, page             Cria uma nova pagina com um controller...
Exemplo: ft_cli g p lib/app/modules/nome_modulo Nome

c, controller       Cria um novo controller...
Exemplo: ft_cli g c lib/app/modules/nome_modulo Nome

d, datasource       Cria a camada de busca dados de fontes externas...
Exemplo: ft_cli g d lib/app/modules/nome_modulo Nome

r, repository       Cria a camada para tratar os dados...
Exemplo: ft_cli g r lib/app/modules/nome_modulo Nome

u, usecase          Cria a camada para tratar as regras de negócio...
Exemplo: ft_cli g u lib/app/modules/nome_modulo Nome

e, entity           Cria as entidades...
Exemplo: ft_cli g e lib/app/modules/nome_modulo Nome

dto                 Cria os dto para transferência de dados...
Exemplo: ft_cli g dto lib/app/modules/nome_modulo Nome
''',
    );
  }
}
