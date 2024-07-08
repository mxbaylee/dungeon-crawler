import js.html.WindowClient;

class Main extends hxd.App {
  override private function init():Void {
    super.init();
    var myscene = new h2d.Scene();
    this.setScene(myscene);

    var tileImage = hxd.Res.roguelikeDungeon_transparent.toTile();
    var tw: Int = 16;
    var th: Int = 16;
    var margin: Int = 1;
    var tiles = [
        for (y in 0 ... Std.int((tileImage.height + margin) / (th + margin)))
        for (x in 0 ... Std.int((tileImage.width + margin) / (tw + margin)))
        tileImage.sub(x * (tw + margin), y * (th + margin), tw, th)
    ];
    var tileMap = {
      bottom: 153,
      right: 154,
      rightLeft: 155,
      left: 155,
    }
    /*
        153-160
        182-189
    */
    var sprite = new h2d.Bitmap(tiles[153]);
    sprite.x = 0;
    sprite.y = 0;
    sprite.scaleX = 4;
    sprite.scaleY = 4;
    myscene.addChild(sprite);


    var sprite = new h2d.Bitmap(tiles[160]);
    sprite.x = 75;
    sprite.y = 0;
    sprite.scaleX = 4;
    sprite.scaleY = 4;
    myscene.addChild(sprite);

    var sprite = new h2d.Bitmap(tiles[182]);
    sprite.x = 0;
    sprite.y = 150;
    sprite.scaleX = 4;
    sprite.scaleY = 4;
    myscene.addChild(sprite);

    var sprite = new h2d.Bitmap(tiles[189]);
    sprite.x = 75;
    sprite.y = 150;
    sprite.scaleX = 4;
    sprite.scaleY = 4;
    myscene.addChild(sprite);
  }

  static function main() {
    hxd.Res.initEmbed();
    new Main();
  }
}