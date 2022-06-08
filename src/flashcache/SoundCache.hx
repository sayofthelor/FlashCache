package src.flashcache;

import openfl.Assets;
import openfl.media.Sound;
import openfl.utils.AssetType;

/*
    Class to cache sounds into OpenFL's sound cache.
    Cached sounds can be played with FlxG.sound.play(path); or FlxG.sound.playMusic(path);
    Pretty much just FlxG.sound.cache with a few extra features.
*/
class SoundCache {
    public function cacheSound(path:String):Sound {
        if (Assets.exists(path, AssetType.SOUND) || Assets.exists(path, AssetType.MUSIC))
			return Assets.getSound(path, true);
		trace('Sound not found at ' + path);
		return null;
    }
    public function cacheSoundGroup(keys:Array<String>):Void {
        for (i in keys) {
            cacheSound(i);
        }
    }
}