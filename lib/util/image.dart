String getImage({required int amount}) {
  switch (amount) {
    case 200:
      return 'images/fill.png';
    case 300:
      return 'images/mug.png';
    case 500:
      return 'images/water.png';
    case 1000:
      return 'images/gallon.png';
    default:
      return 'images/water-cycle.png';
  }
}
