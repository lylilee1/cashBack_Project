import 'dart:ui';

class CbCategory {
  // -- App default category
  CbCategory._(this.categoryName, this.productCount, this.thumbnailImage);

  final String categoryName;
  final String productCount;
  final String thumbnailImage;

  final categories = [
    CbCategory._("t-shirt", "240",
        "https://images.unsplash.com/photo-1576871337622-98d48d1cf531?ix"),
    CbCategory._("t-shirt", "240",
        "https://images.unsplash.com/photo-1576871337622-98d48d1cf531?ix"),
    CbCategory._("shoes", "240",
        "https://images.unsplash.com/photo-1576871337622-98d48d1cf531?ix"),
    CbCategory._("hoddies", "240",
        "https://images.unsplash.com/photo-1576871337622-98d48d1cf531?ix"),
  ];

// list of all categories
}


List<String> maincateg = [
  "men",
  "women",
  "electronics",
  "shoes",
  "accessories",
  "kids",
  "home & garden",
  "sports",
  "beauty",
  "health",
  "automobile",
  "bags",
];

List<String> men = [
  'shoes',
  't-shirt',
  'hoddies',
  'sweater',
  'sweatshirt',
  'jeans',
  'shorts',
  'jacket',
  'pants',
  'socks',
  'suit',
  'underwear',
];

List<String> women = [
  'dress',
  'sets'
  't-shirt',
  'top',
  'skirt',
  'jeans',
  'pants',
  'coat',
  'jacket',
  'sweater',
  'sweatshirt',
  'shorts',
  'socks',
  'suit',
  'underwear',
];

List<String> kids = [
  'hoodies',
  't-shirt',
  'jeans',
  'pants',
  'jacket',
  'shorts',
  'socks',
  'suit',
  'underwear',
  'dress',
  'sets',
  'top',
  'skirt',
  'coat',
  'sweater',
  'sweatshirt',
  'shoes',
];

List<String> electronics = [
  'laptop',
  'mobile',
  'tablet',
  'headphone',
  'camera',
  'tv',
  'speaker',
  'watch',
  'gaming',
  'accessories',
];

List<String> shoes = [
  'men slippers'
  'men classic'
  'men casual',
  'men boots',
  'men boots',
  'men canvas',
  'men sport',
  'women slippers',
  'women classic',
  'women boots',
  'women heels',
  'women sport',
];

List<String> homeandgarden = [
  'bedding',
  'bath',
  'kitchen',
  'furniture',
  'decor',
  'lighting',
  'storage',
  'outdoor',
  'tools',
  'appliances',
];
