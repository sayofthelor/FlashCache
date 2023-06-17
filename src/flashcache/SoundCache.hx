package flashcache;

import openfl.Assets;
import openfl.media.Sound;
import openfl.utils.AssetType;
import lime.media.vorbis.VorbisFile;
import lime.media.AudioBuffer;

/*
    DO NOT USE THIS IT'S STUPID
    Class to cache sounds into OpenFL's sound cache.
    Cached sounds can be played with FlxG.sound.play(path); or FlxG.sound.playMusic(path);
    Pretty much just FlxG.sound.cache with a few extra features.
*/
class SoundCache {
    public function new() {}
    public function cacheSound(path:String, ?stream:Bool = false):Sound {
        if (Assets.exists(path, AssetType.SOUND) || Assets.exists(path, AssetType.MUSIC))
		var sound:Sound = null;
	        #if lime_vorbis
		if (stream)
                        return sound = Sound.fromAudioBuffer(AudioBuffer.fromVorbisFile(VorbisFile.fromFile(path));
		else
		#end
		        return sound = Assets.getSound(path, true);
		trace('Sound not found at ' + path);
		return null;
    }
    public function cacheSoundGroup(keys:Array<String>):Void {
        for (i in keys) {
            cacheSound(i);
        }
    }
}
