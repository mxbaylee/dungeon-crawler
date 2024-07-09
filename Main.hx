//import js.html.WindowClient;

enum abstract DirtPath (Int) to Int {
  var Top = 153;
  var Bottom = 182;
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

function toSprite(tile, x = 0, y = 0) {
  var sprite = new h2d.Bitmap(tile);

  sprite.x = x;
  sprite.y = y;
  sprite.scaleX = 4;
  sprite.scaleY = 4;

  return sprite;
}

class Main extends hxd.App {
  override private function init():Void {
    super.init();

    var myscene = new h2d.Scene();

    this.setScene(myscene);

    myscene.scaleMode = h2d.Scene.ScaleMode.Stretch(320, 240);

    var rlTiles = roguelikeTiles();

    myscene.addChild(toSprite(rlTiles[DirtPath.Top]));
    myscene.addChild(toSprite(rlTiles[160], 75));
    myscene.addChild(toSprite(rlTiles[DirtPath.Bottom], 0, 150));
    myscene.addChild(toSprite(rlTiles[189], 75, 150));
  }

  static function main() {
    hxd.Res.initEmbed();
    new Main();
  }
}
