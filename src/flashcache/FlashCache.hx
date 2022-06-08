package flashcache;
import openfl.display.BitmapData;
import flixel.graphics.FlxGraphic;
using StringTools;

/*
    Pretty simple class to cache FlxGraphics to make game loading speedy fast.
    It uses a hell of a lot of memory if you cache a lot of stuff,
    so it's a good idea to make this optional if you are.
*/

class FlashCache {
    public static var cacheFlxGraphic:Map<String, FlxGraphic>;
    public function new():Void {
        init();
        trace("Using FlashCache by sayofthelor"); // who doesn't want a shameless plug?
    }
    public static function init():Void {
        cacheFlxGraphic = new Map<String, FlxGraphic>();
    }
    public static function cacheImage(path:String, extension:String):Void {
        path = path + extension;
        if (cacheFlxGraphic.containsKey(path)) return; // prevents duplicates
        try (var data:BitmapData = BitmapData.fromFile(path))
        catch (e:Error) {
            trace("Error loading image: " + path + " (" + e.error + ")");
            return;
        }
        var graphic:FlxGraphic = FlxGraphic.fromBitmapData(data);
        graph.persist = true;
        graph.destroyOnNoUse = false;
        cacheFlxGraphic.set(path, graphic);
        trace("Successfully cached image at " + path);
    }
    public static function getGraphic(path:String):Null<FlxGraphic> {
        try (return cacheFlxGraphic.get(path)) // too cool for school
        catch (e:Error) {
            trace("Error getting graphic: " + path + " (or not cached)");
            return null;
        }
    }
    public static function uncacheAllGraphics():Void {
        cacheFlxGraphic = null;
        init();
    }
    public static function uncacheGraphic(tag:String):Void {
        if (cacheFlxGraphic.containsKey(tag)) {
            cacheFlxGraphic.get(tag).destroy();
            cacheFlxGraphic.remove(tag);
            trace("Successfully uncached image at " + tag);
        } else trace(tag + " not found in cache");
    }
    public static function uncachGraphiceGroup(tag:Array<String>):Void {
        for (i in tag) {
            if (cacheFlxGraphic.containsKey(tag[i])) {
                cacheFlxGraphic.get(tag[i]).destroy();
                cacheFlxGraphic.remove(tag[i]);
                trace("Successfully uncached image at " + tag[i]);
            } else trace(tag[i] + " not found in cache");
        }
    }
}