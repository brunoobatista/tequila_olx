enum ItemMenus { entrar, cadastrar, meus_anuncios, deslogar }

extension ItemMenusStringExt on String {
  ItemMenus get parse => {
        'Entrar': ItemMenus.entrar,
        'Cadastrar': ItemMenus.cadastrar,
        'Meus anúncios': ItemMenus.meus_anuncios,
        'Deslogar': ItemMenus.deslogar,
      }[this]!;
}

extension ItensMenusExt on ItemMenus {
  String get parse => {
        ItemMenus.entrar: 'Entrar',
        ItemMenus.cadastrar: 'Cadastrar',
        ItemMenus.meus_anuncios: 'Meus anúncios',
        ItemMenus.deslogar: 'Deslogar',
      }[this]!;
}

class HomeService {
  List<String> itensMenuLogOff = [
    ItemMenus.entrar.parse,
    ItemMenus.cadastrar.parse
  ];
  List<String> itensMenuLogOn = [
    ItemMenus.meus_anuncios.parse,
    ItemMenus.deslogar.parse
  ];

  List<String> getMenuItens(bool logged) {
    if (logged) return itensMenuLogOn;
    return itensMenuLogOff;
  }
}
