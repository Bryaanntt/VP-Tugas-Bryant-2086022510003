class MenuItem {
  final String name;
  final double price;
  final double? discountPercent;

  MenuItem({required this.name, required this.price, this.discountPercent});

  double finalprice() {
    final discount = discountPercent ?? 0;
    return price - (price * discount / 100);
  }
}

  void main() {
    // Bikin List<MenuItem>
    final menu = <MenuItem>[
      MenuItem(name: 'Nasi Ayam Limau', price: 15000, discountPercent: 35),
      MenuItem(name: 'Martabak Manis', price: 29999, discountPercent: 1),
      MenuItem(name: 'Ayam Tanpa Tulang', price: 25000),
      MenuItem(name: 'Kangkung Tumis Pete', price: 20000, discountPercent: 10),
      MenuItem(name: 'Es Teh Tawar Hangat Dingin Manis', price: 40000),
    ];

    final allnames = menu.map((item) => item.name).toList();
    print('All names: $allnames');

    final itemsunder15k = menu
        .where((item) => item.finalprice() < 15000)
        .toList();
    print(
      'Items under 15k: ${itemsunder15k.map((item) => item.name).toList()}',
    );

    final totalprice = menu.fold(0.0, (sum, item) => sum + item.finalprice());
    print('Total price: $totalprice');
  }

