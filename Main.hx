class Main extends hxd.App {
  var wizard: h2d.Object;
  var timer: Float = 0.0;

  override private function init():Void {
    super.init();

    var myscene = new h2d.Scene();

    this.setScene(myscene);

    myscene.scaleMode = h2d.Scene.ScaleMode.Stretch(300, 200);

    var rlTiles = roguelikeTiles();

    myscene.addChild(toSprite(rlTiles[DirtPathRL.Top]));
    myscene.addChild(toSprite(rlTiles[DirtPathRL.Middle], 0, 16));
    myscene.addChild(toSprite(rlTiles[DirtPathRL.Bottom], 0, 32));

    var tdTiles = tinydungeonTiles();

    wizard = toSprite(tdTiles[CharacterTD.Wizard]);

    myscene.addChild(wizard);
    myscene.addChild(toSprite(tdTiles[CharacterTD.VillagerOne], 16, 16));
  }

  override private function update(dt: Float) {
    timer = timer + dt;

    if (hxd.Key.isDown(hxd.Key.UP) && timer > 0.15) {
      wizard.y = wizard.y - 16;
      timer = 0.0;
    }
    if (hxd.Key.isDown(hxd.Key.RIGHT) && timer > 0.15) {
      wizard.x = wizard.x + 16;
      timer = 0.0;
    }
    if (hxd.Key.isDown(hxd.Key.LEFT) && timer > 0.15) {
      wizard.x = wizard.x - 16;
      timer = 0.0;
    }
    if (hxd.Key.isDown(hxd.Key.DOWN) && timer > 0.15) {
      wizard.y = wizard.y + 16;
      timer = 0.0;
    }
  }

  static function main() {
    hxd.Res.initEmbed();
    new Main();
  }
}
