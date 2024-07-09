//import js.html.WindowClient;

// roguelike
enum abstract DirtPathRL (Int) to Int {
  var Top = 153;
  var Bottom = 182;
}

// tinydungeon
enum abstract CharacterTD (Int) to Int {
  var Wizard = 84;
  var VillagerOne = 85;
  var VillagerTwo = 86;
}

/*
  var tileMap = {
    bottom: 153,
    right: 154,
    rightLeft: 155,
    left: 155,
  }
  153-160
  182-189
*/

function roguelikeTiles() {
  var tileImage = hxd.Res.roguelikeDungeon_transparent.toTile();

  var tw: Int = 16;
  var th: Int = 16;

  var margin: Int = 1;

  return [
    for (y in 0 ... Std.int((tileImage.height + margin) / (th + margin)))
    for (x in 0 ... Std.int((tileImage.width + margin) / (tw + margin)))
    tileImage.sub(x * (tw + margin), y * (th + margin), tw, th)
  ];
}

function tinydungeonTiles() {
  var tileImage = hxd.Res.tinydungeon.toTile();

  var tw: Int = 16;
  var th: Int = 16;

  var margin: Int = 1;

  return [
    for (y in 0 ... Std.int((tileImage.height + margin) / (th + margin)))
    for (x in 0 ... Std.int((tileImage.width + margin) / (tw + margin)))
    tileImage.sub(x * (tw + margin), y * (th + margin), tw, th)
  ];
}

function toSprite(tile, x = 0, y = 0) {
  var sprite = new h2d.Bitmap(tile);

  sprite.x = x;
  sprite.y = y;
  sprite.scaleX = 4;
  sprite.scaleY = 4;

  return sprite;
}

