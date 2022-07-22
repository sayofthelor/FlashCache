# **FlashCache**
## Work-in-progress general-purpose cacher for **HaxeFlixel**. Makes games **speedy fast.**
### **Note:** This uses a hell of a lot of memory if you cache a lot of stuff, so it's a good idea to make this optional if you are.

### ImageCache adapted from [**Kade Engine**](http://github.com/KadeDev/Kade-Engine)

### Currently functional: ImageCache, SoundCache (partially)
## **KEEP IN MIND, FUNCTIONS MAY CHANGE! WE AREN'T RESPONSIBLE IF THIS BREAKS YOUR CODE.**
## **ANOTHER NOTE:** Psych Engine and any derivative mods of it contain a lot of existing things relating to image loading that are required to be changed in order for this to not be woefully inefficient.

## **Functions (ImageCache)**

`new()` initializes ImageCache. Should **always** be attached to a public static variable, ideally either in `Main.hx` or your own custom caching state.

`cacheGraphic(path:String, extension:String = "png", ?starter:String = "")` caches a single image, from `starter/path.extension`, with the key `path`. You **MUST NOT** include the file extension, and you **MUST** include `assets/` (or your asset folder name) in either `path` or `starter`. Feel free to include more of the path, depending on what you want to type into `getGraphic` to get your graphic.

`getGraphic(path:String)` either returns your cached FlxGraphic if it exists or `null` if it doesn't. To retrieve the graphic, type what you typed into `path` when you cached the graphic.

`uncacheAllGraphics()` clears the image cache.

`uncacheGraphic(tag:String)` uncaches the image at `tag` if it is cached.

`uncacheGraphicGroup(tag:Array<String>)` uncaches a group of images at the path specified in `tag` if they are cached.

### **Another Note:** Don't clear memory when this is active or else there is literally no point.

## **Example State**

```hx
import flashcache.ImageCache;
import flashcache.SoundCache;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxColor;
import sys.FileSystem;

/*
    Example caching state for FlashCache.
    Will be updated over time.
*/

class CachingScreen extends FlxState {
    // Both ImageCache and SoundCache have constructors that *must* be used before doing anything with them.
    public static var imageCache:ImageCache = new ImageCache("assets/shared/images", "png");
    public static var soundCache:SoundCache = new SoundCache();
    public override function create() {
        add(new FlxText(20, 20, 0, "Caching..." 32).setFormat('assets/fonts/segoe.ttf', FlxColor.WHITE, LEFT));
        initCache();
        super.create();
    }

    public static function initCache() {
        for (i in FileSystem.readFileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images"))
            imageCache.cacheGraphic(i, true);
        var sounds:String = FileSystem.readFileSystem.readDirectory(FileSystem.absolutePath("assets/shared/sounds");
        soundCache.cacheSoundGroup(sounds);
        FlxG.switchState(new TitleScreen());
    }
}
```
## **Example of Loading a Cached Graphic**

```hx
function getImage(path:String):FlxGraphic {
    var foo:FlxGraphic = CachingScreen.imageCache.getGraphic(path);
    if (foo != null) return foo;
    else {
        return null;
    }
}
```

## **Example of Caching a Graphic**

```hx
function cacheBackgrounds() {
    CachingScreen.imageCache.cacheGraphic('bg/menuBackground', 'png'');
    CachingScreen.imageCache.cacheGraphic('bg/optionsBackground', 'png');
    CachingScreen.imageCache.cacheGraphic('bg/gameBackground', 'png');
}
```

## **Example of Getting a Cached Graphic**

```hx
function cachePlayerGraphic() {
    if (foo.skin == "bar") {
        CachingScreen.imageCache.getGraphic('bar');
    }
}
```

## **Example of Uncaching a Graphic**

```hx
function uncacheTiles() {
    for (p in foo) {
        CachingScreen.imageCache.uncacheGraphic(p);
    }
}
```

## **Example of Uncaching All Graphics**

```hx
function lowGraphicsCacheManagement() {
    if (storeMemVarOrSomething > memLimit) {
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
