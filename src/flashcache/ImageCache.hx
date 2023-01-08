package flashcache;
import openfl.display.BitmapData;
import flixel.graphics.FlxGraphic;
using StringTools;

/*
    Pretty simple class to cache FlxGraphics to make game loading speedy fast.
    It uses a hell of a lot of memory if you cache a lot of stuff,
    so it's a good idea to make this optional if you are.
*/

class ImageCache {
	public var cacheFlxGraphic:Map<String, FlxGraphic>;
	public var assetPath:String = "assets/";
	public var extension:String = "png";

	/**
	 * Initializes `FlxCache`
	 */
	public function new(?assetPath:String = "assets/", ?extension:String = "png"):Void {
		this.assetPath = assetPath;
		this.extension = extension;
		cacheFlxGraphic = new Map<String, FlxGraphic>();
	}

	/**
	 * Add an entry to the image cache.
	 * @param path The path to your image.
	 * @param makeOnlyPathName determines whether or not the image key includes assetPath and the file extension.
	 */
	public function cacheGraphic(path:String, ?makeOnlyPathName:Bool = false):FlxGraphic {
		var data:BitmapData;
		var epicPath:String = assetPath + (assetPath == "" ? "" : "/") + path + '.' + extension;

		if (cacheFlxGraphic.exists(makeOnlyPathName ? path : epicPath)) {
			return null; // prevents duplicates
		}

        try (data = BitmapData.fromFile(epicPath))
        catch(e) {
			trace("Error loading image: " + path);
			return null;
        }

		var graphic:FlxGraphic = FlxGraphic.fromBitmapData(data);
		graphic.persist = true;
		graphic.destroyOnNoUse = false;
		cacheFlxGraphic.set((makeOnlyPathName ? path : epicPath), graphic);
		trace("Cached image: " + epicPath);
		return graphic;
	}

	public function getGraphic(path:String):Null<FlxGraphic> {
		if (cacheFlxGraphic.exists(path))
			return cacheFlxGraphic.get(path); // too cool for schoold

		return null;
	}

	public function uncacheAllGraphics():Void {
		cacheFlxGraphic.clear();
	}

	public function uncacheGraphic(tag:String):Bool {
		if (cacheFlxGraphic.exists(tag)) {
			cacheFlxGraphic.get(tag).destroy();
			cacheFlxGraphic.remove(tag);
			trace("Successfully uncached image at " + tag);
			return true;
		}
		trace(tag + " not found in cache");
		return false;
	}

	public function uncacheGraphicGroup(keys:Array<String>):Void {
		for (tag in keys) {
			uncacheGraphic(tag);
		}
	}
}
