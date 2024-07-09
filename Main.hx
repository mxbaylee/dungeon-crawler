class Main extends hxd.App {
  override private function init():Void {
    super.init();

    var myscene = new h2d.Scene();

    this.setScene(myscene);

    myscene.scaleMode = h2d.Scene.ScaleMode.Stretch(320, 240);

    var rlTiles = roguelikeTiles();

    myscene.addChild(toSprite(rlTiles[DirtPathRL.Top]));
    myscene.addChild(toSprite(rlTiles[DirtPathRL.Middle], 0, 64));
    myscene.addChild(toSprite(rlTiles[DirtPathRL.Bottom], 0, 128));

    var tdTiles = tinydungeonTiles();

    myscene.addChild(toSprite(tdTiles[CharacterTD.Wizard]));
    myscene.addChild(toSprite(tdTiles[CharacterTD.VillagerOne], 75, 150));
  }

  static function main() {
    hxd.Res.initEmbed();
    new Main();
  }
}
