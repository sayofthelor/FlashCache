package flashcache;
import openfl.display.BitmapData;
import flixel.graphics.FlxGraphic;
import openfl.Assets;
using StringTools;

/*
    Pretty simple class to cache FlxGraphics to make game loading speedy fast.
    It uses a hell of a lot of memory if you cache a lot of stuff,
    so it's a good idea to make this optional if you are.
*/

class FlashCache {
	public static var cacheFlxGraphic:Map<String, FlxGraphic>;

	/**
	 * Initializes `FlxCache`
	 */
	public function new():Void {
		cacheFlxGraphic = new Map<String, FlxGraphic>();
	}

	/**
	 * Add an entry to the image cache.
	 * @param path The path to your image.
	 * @return `FlxGraphic` The graphic you just cached.
	 */
	public function cacheGraphic(path:String, ?extension:String = "png", ?starter:String = ""):FlxGraphic {
		var data:BitmapData;

		if (cacheFlxGraphic.exists(path)) {
			return null; // prevents duplicates
		}
        var epicPath:String = starter + '/' + path + '.' + extension;
        try (data = Assets.getBitmapData(epicPath))
        catch(e) {
			trace("Error loading image: " + path);
			return null;
        }

		var graphic:FlxGraphic = FlxGraphic.fromBitmapData(data);
		graphic.persist = true;
		graphic.destroyOnNoUse = false;
		cacheFlxGraphic.set(path, graphic);
		return graphic;
	}

	public function getGraphic(path:String):Null<FlxGraphic> {
		if (cacheFlxGraphic.exists(path))
			return cacheFlxGraphic.get(path); // too cool for schoold

		trace("Error getting graphic: " + path + " (or not cached)");
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

	public function uncachGraphicGroup(keys:Array<String>):Void {
		for (tag in keys) {
			if (cacheFlxGraphic.exists(tag)) {
				cacheFlxGraphic.get(tag).destroy();
				cacheFlxGraphic.remove(tag);
				trace("Successfully uncached image at " + tag);
			}
			else
				trace(tag + " not found in cache");
		}
	}
}
