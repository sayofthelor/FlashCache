# **FlashCache**
## Image cacher for **HaxeFlixel**. Makes games **speedy fast.**
### **Note:** This uses a hell of a lot of memory if you cache a lot of stuff, so it's a good idea to make this optional if you are.

### Somewhat adapted from [**Kade Engine**](http://github.com/KadeDev/Kade-Engine)

## **Functions**

`init()` initializes FlashCache. Should **always** be attached to a public non-static variable, ideally either in `Main.hx` or your own custom caching state.

`cacheGraphic(path:String, ?extension:String = "png", ?starter:String = "")` caches a single image, from `starter/path.extension`, with the key `path`. You **MUST** include `assets/` (or your asset folder name) in `path`.

`getGraphic(path:String)` either returns your cached FlxGraphic if it exists or `null` if it doesn't.

`uncacheAllGraphics()` clears the image cache.

`uncacheGraphic(tag:String)` uncaches the image at `tag` if it is cached.

`uncacheGraphicGroup(tag:Array<String>)` uncaches a group of images at the path specified in `tag` if they are cached.

## **Example State**

```hx
import flashcache.FlashCache;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;
import sys.FileSystem;

class CachingScreen extends FlxState {
    public static var imageCache:FlashCache;
    public override function create() {
        initCache();
        super.create();
    }

    public static function initCache() {
        imageCache.init();
        for (i in FileSystem.readFileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images"))
        {
            imageCache.cacheGraphic(path);
        }
        FlxG.switchState(new TitleScreen());
    }
}
```
## **Example of Loading a Cached Graphic**

```hx
function getImage(path:String):FlxGraphic {
    var img:FlxGraphic = CachingScreen.imageCache.getGraphic(path);
    if (img != null) return img;
    else {
        return null;
    }
}
```

## **Example of Caching a Graphic**

```hx
function cacheBackgrounds() {
    CachingScreen.imageCache.cacheGraphic('menuBackground');
    CachingScreen.imageCache.cacheGraphic('optionsBackground');
    CachingScreen.imageCache.cacheGraphic('gameBackground');
}
```

## **Example of Getting a Cached Graphic**

```hx
function cachePlayerGraphic() {
    if (player.skin == "gold") {
        CachingScreen.imageCache.getGraphic('player-gold');
    }
}
```

## **Example of Uncaching a Graphic**

```hx
function uncacheTiles() {
    for (p in tilePaths) {
        CachingScreen.imageCache.uncacheGraphic(p);
    }
}
```

## **Example of Uncaching All Graphics**

```hx
function lowGraphicsCacheManagement() {
    if (someVariableThatStoresMemoryUser > lowGraphicsMemoryLimit) {
        CachingScreen.imageCache.uncacheAllGraphics();
    }
}
```

## **Example of Uncaching a Graphic Group**

```hx
inline function uncacheMenuSprites() {
    CachingScreen.imageCache.uncacheGraphicGroup(menuSpritePaths);
}
```
