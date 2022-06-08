# **FlashCache**
## Image cacher for **HaxeFlixel**. Makes games **speedy fast.**
### **Note:** This uses a hell of a lot of memory if you cache a lot of stuff, so it's a good idea to make this optional if you are.

### Somewhat adapted from [**Kade Engine**](http://github.com/KadeDev/Kade-Engine)

## **Functions**

`new()` initializes FlashCache. Should **always** be attached to a public static variable, ideally either in `Main.hx` or your own custom caching state.

`cacheImage(path:String, extension:String)` caches a single image. You **MUST** include `assets/` (or your asset folder name) in `path`.

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
    public static var imageCache:FlashCache = new FlashCache();
    public override function create() {
        initCache();
        super.create();
    }

    public static function initCache() {
        for (i in FileSystem.readFileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images"))
        {
            imageCache.cacheGraphic(path);
        }
        FlxG.switchState(new TitleScreen());
    }
}
```
## **Example of Loading Cached Graphic**

```hx
function getImage(path:String):FlxGraphic {
    var img:FlxGraphic = CachingScreen.imageCache.getGraphic(path);
    if (img != null) return img;
    else {
        // image getting code here
    }
}
```
