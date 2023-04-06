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
  'choix categorie',
  'hommes',
  'femmes',
  'enfants',
  'electroniques',
  'accessoires',
  'maison & jardin',
  'automobiles',
  'sport & loisirs',
  'autres'
];

List<String> hommes = [
  'sous categorie',
  'montre',
  'chaussure',
  /*
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
  'sac',
  'bijoux',
  'ceinture',
  'chapeau',
  'lunette',
  'parfum',*/
];

List<String> femmes = [
  'sous categorie',
  'montre',
  'bijoux',
  'ceinture',
  'chapeau',
  'lunette',
  'sac',
  /*
  'dress',
  'sets',
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
  'sac',
  'montre',
  'bijoux',
  'ceinture',
  'chapeau',
  'lunette',
  'parfum',*/
];

List<String> enfants = [
  'sous categorie',
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

List<String> electroniques = [
  'sous categorie',
  'ordinateur',
  'clavier',
  'souris',
  'cable USB',
  'téléphone',
  'tablette',
  'headphone',
  'camera',
  'smart tv',
  'speaker',
  'smart watch',
  'gaming',
  'accessoires',
];

List<String> accessoires = [
  'sous categorie',
  'cosmetique',
  'accessoires de cheveux',
  'accessoires de voiture',
  'accessoires de maison',
  'accessoires de sport',
  'accessoires de loisir',
];

/*
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
];*/

List<String> maisonetjardin = [
  'sous categorie',
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

List<String> automobiles = [
  'sous categorie',
  'voiture',
  'moto',
  'velo',
  'accessoires',
  /*

  'motorcycle',
  'truck',
  'suv',
  'van',
  'bus',
  'boat',
  'atv',
  'snowmobile',
  'trailer',
  'rv',
  'motorhome',
  'tires',
  'wheels',
  'parts',
  'accessories',
  * */
];

List<String> sportetloisirs = [
  'sous categorie',
  'football',
  'basketball',
  'tennis',
  'golf',
  'volleyball',
  'rugby',
  'handball',
  'athletisme',
  'swimming',
  'boxing',
  'ski',
  'snowboard',
  'hockey',
  'baseball',
  'cricket',
  'badminton',
  'fishing',
  'gym',
  'yoga',
  'pilates',
  'dance',
  'running',
  'cycling',
  'hiking',
  'climbing',
  'surfing',
  'kayaking',
  'skating',
  'skateboarding',
  'scooter',
  'other',
];

List<String> autres = [
  'sous categorie',
  'livre',
  'musique',
  'jeux',
  'jouet',
  'animal',/*
  'fleure',
  'fourniture',
  'materiel',
  'outillage',
  'materiel de bureau',
  'materiel de cuisine',
  'materiel de jardin',
  'materiel de bricolage',
  'materiel de decoration',
  'materiel de peinture',
  'materiel de nettoyage',
  'materiel de couture',
  'materiel de jardinage',
  'materiel de piscine',
  'materiel de bricolage',
  'materiel de decoration',
  'materiel de peinture',
  'materiel de nettoyage',
  'materiel de couture',
  'materiel de jardinage',
  'materiel de piscine',
  'materiel de bricolage',
  'materiel de decoration',
  'materiel de peinture',
  'materiel de nettoyage',
  'materiel de couture',
  'materiel de jardinage',
  'materiel de piscine',
  'materiel de bricolage',
  'materiel de decoration',
  'materiel de peinture',
  'materiel de nettoyage',
  'materiel de couture',
  'materiel de jardinage',
  'materiel de piscine',
  'materiel de bricolage',
  'materiel de decoration',
  'materiel de peinture',
  'materiel de nettoyage',
  'materiel de couture',
  'materiel de jardinage',
  'materiel de piscine',
  'materiel de bricolage',
  'materiel de decoration',
  'materiel de peinture',
  'materiel de nettoyage',
  'materiel de couture',
  'materiel de jardinage',
  'materiel de piscine',
  'materiel de bricolage',
  'materiel de decoration',
  'materiel de peinture',*/
];
