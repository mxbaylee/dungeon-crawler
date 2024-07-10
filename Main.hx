import hxd.res.TiledMap;

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

    var mapJson = hxd.Res.dungeon_crawler_v2_tmj.entry.getText();

    // parse Tiled json file
    var mapData: TiledMapData = haxe.Json.parse(mapJson);
    
    // get tile image (tiles.png) from resources
    var tileImage = hxd.Res.tinydungeon.toTile();
    
    // create a TileGroup for fast tile rendering, attach to 2d scene
    var group = new h2d.TileGroup(tileImage, myscene);
    
    var tw = 16;
    var th = 16;

    var mw = mapData.width;
    var mh = mapData.height;

    var margin = 1;

    // make sub tiles from tile
    var tiles = [
      for(y in 0 ... Std.int((tileImage.height + margin) / (th + margin)))
        for(x in 0 ... Std.int((tileImage.width + margin) / (tw + margin)))
          tileImage.sub(x * (tw + margin), y * (th + margin), tw, th)
    ];

    // iterate on all layers
    for(layer in mapData.layers) {
      // iterate on x and y
      for(y in 0 ... mh) for (x in 0 ... mw) {
      if (layer?.data == null) continue;
        // get the tile id at the current position 
        var tid = layer.data[x + y * mw];
        if (tid != 0) { // skip transparent tiles
          // add a tile to the TileGroup
          group.add(x * tw, y * th, tiles[tid - 1]);
        }
      }
    }

/*
    var tdTiles = tinydungeonTiles();

    wizard = toSprite(tdTiles[CharacterTD.Wizard]);

    myscene.addChild(wizard);
    myscene.addChild(toSprite(tdTiles[CharacterTD.VillagerOne], 16, 16));
    */
  }

  override private function update(dt: Float) {
    timer = timer + dt;
    if (timer > 0.1) {
      if (hxd.Key.isDown(hxd.Key.UP))
        wizard.y = wizard.y - 16;
      if (hxd.Key.isDown(hxd.Key.RIGHT))
        wizard.x = wizard.x + 16;
      if (hxd.Key.isDown(hxd.Key.LEFT))
        wizard.x = wizard.x - 16;
      if (hxd.Key.isDown(hxd.Key.DOWN))
        wizard.y = wizard.y + 16;
      timer = 0.0;
    }
  }

  static function main() {
    hxd.Res.initEmbed();
    new Main();
  }
}
