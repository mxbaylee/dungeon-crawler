import hxd.res.TiledMap;

typedef Bound = { x: Int, y : Int, height: Int, width : Int, name : String, type : String };

class Main extends hxd.App {
  var wizard: h2d.Object;
  var timer: Float = 0.0;
  var currentScene: h2d.Scene;
  var boundaries: Array<Bound>;

  override private function init():Void {
    super.init();

    var myScene = new h2d.Scene();
    currentScene = myScene;

    this.setScene(myScene);

    myScene.scaleMode = h2d.Scene.ScaleMode.Stretch(300, 200);

    var rlTiles = roguelikeTiles();

    myScene.addChild(toSprite(rlTiles[DirtPathRL.Top]));
    myScene.addChild(toSprite(rlTiles[DirtPathRL.Middle], 0, 16));
    myScene.addChild(toSprite(rlTiles[DirtPathRL.Bottom], 0, 32));

    var mapJson = hxd.Res.dungeon_crawler_v2_tmj.entry.getText();

    // parse Tiled json file
    var mapData: TiledMapData = haxe.Json.parse(mapJson);
    
    // get tile image (tiles.png) from resources
    var tileImage = hxd.Res.tinydungeon.toTile();
    
    // create a TileGroup for fast tile rendering, attach to 2d scene
    var group = new h2d.TileGroup(tileImage, myScene);
    
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
        if (layer?.objects != null) {
          this.boundaries = layer.objects;
        } else if (layer?.data != null) {
          // get the tile id at the current position 
          var tid = layer.data[x + y * mw];
          if (tid != 0) { // skip transparent tiles
            // add a tile to the TileGroup
            group.add(x * tw, y * th, tiles[tid - 1]);
          }
        }
      }
    }

    var tdTiles = tinydungeonTiles();
    wizard = toSprite(tdTiles[CharacterTD.Wizard]);
    myScene.addChild(wizard);
  }

  public function move(object: h2d.Object, x: Float, y: Float): Void {
    // knows where object is, and is going
    // can make accurate prediction on collision detection
    var hit: Bool = false;
    for (boundary in this.boundaries) {
      if (detectCollision(object, boundary, x, y)) {
        hit = true;
        break; // Exit the loop early if a collision is detected
      }
    }
    if (!hit) {
      object.x = x;
      object.y = y;
    }
  }

  public function detectCollision(obj: h2d.Object, boundary: Bound, x: Float, y: Float): Bool {
    // New position of the object
    var newX = x;
    var newY = y;
  
    // Check for collision with the boundary
    if (newX < boundary.x + boundary.width &&
        newX + obj.width > boundary.x &&
        newY < boundary.y + boundary.height &&
        newY + obj.height > boundary.y) {
      return true;
    }
  
    return false;
  }

  override private function update(dt: Float) {
    timer = timer + dt;
    if (timer > 0.1) {
      if (hxd.Key.isDown(hxd.Key.UP))
        this.move(wizard, wizard.x, wizard.y - 16);
      if (hxd.Key.isDown(hxd.Key.DOWN))
        this.move(wizard, wizard.x, wizard.y + 16);
      if (hxd.Key.isDown(hxd.Key.RIGHT))
        this.move(wizard, wizard.x + 16, wizard.y);
      if (hxd.Key.isDown(hxd.Key.LEFT))
        this.move(wizard, wizard.x - 16, wizard.y);
      timer = 0.0;
    }
  }

  static function main() {
    hxd.Res.initEmbed();
    new Main();
  }
}
