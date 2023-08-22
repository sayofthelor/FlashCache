package flashcache;

import flixel.graphics.FlxGraphic;
import openfl.utils.Assets;

class TypedCache<T>
{
	private var cache:Map<String, T>;
	private var thingName:String = "TypedCache";

	public var length(get, never):Int;
	public function get_length():Int {
		var l:Int = 0;
		for (item in cache) l++;
		return l;
	}

	/**
	 * Automatically called when traced, added to a string, etc.
	 * @return String
	 */

	public inline function toString():String {
		return thingName + " instance";
	}

	/**
	 * Cache an entry of data type `T`
	 * Defined when you create the variable, like an Array
	 * Example: var cache:TypedCache<BitmapData> = new TypedCache<BitmapData>();
	 * @param path The path to your file
	 * @param cachingFunction A function to run to retrieve the data from whatever you are using.
	 */

	public function new()
	{
		cache = new Map<String, T>();
		thingName = (Type.getClassName(T) == "Dynamic" || Type.getClassName(T) == "Any") ? "DynamicCache" : "TypedCache<" + Type.getClassName(T) + ">";
	}

	public function cacheItem(key:String, item:T, ?cachingFunction:T->Void)
	{
		if (cache.exists(key))
			return;

		if (cachingFunction != null)
			cachingFunction(item);
		cache.set(key, item);
	}

	public function cacheItemGroup(keys:Array<String>, items:Array<T>, cachingFunction:T->Void)
	{
		for (p in 0...keys.length)
		{
			if (!cache.exists(keys[p]))
			{
				if (cachingFunction != null)
					cachingFunction(items[p]);
				cache.set(keys[p], items[p]);
			}
		}
	}

	/**
	 * Uncaches an item
	 * @param path Path to the item
	 * @param uncacheFunction A function to run to properly close an item before uncaching (This runs before the function uncaches the item!)
	 */

	public function uncacheItem(key:String, uncacheFunction:T->Void)
	{
		if (cache.exists(key))
		{
			if (uncacheFunction != null)
				uncacheFunction(cache.get(key));
			cache.remove(key);
		}
	}

	/**
	 * Uncaches an item group
	 * @param paths A list of the paths of items
	 * @param uncacheFunction A function to run to properly close items before uncaching (This runs before the function uncaches the items!)
	 */ 

	public function uncacheItemGroup(keys:Array<String>, uncacheFunction:T->Void)
	{
		for (p in 0...keys.length)
		{
			if (uncacheFunction != null)
			        uncacheFunction(cache.get(keys[p]));
			cache.exists(keys[p]) ? cache.remove(keys[p]) : null;
		}
	}

	/**
	 * Uncaches everything in this cache
	 * @param uncacheFunction A function to properly close all the items before uncaching (This runs before the function uncaches the items!)
	 */    

	public inline function uncacheAll(uncacheFunction:T->Void)
	{
		for (item in cache)
			if (uncacheFunction != null)
			        uncacheFunction(item);
		cache.clear();
	}

	/**
	 * Check if an item exists
	 * @param path The path to the item
	 * @return Bool
	 */

	public inline function exists(key:String):Bool
		return cache.exists(key);

	/**
	* Get an item from the cache
	@param key The key paired to the item you want to retrieve
	@return `T`
	*/
	
	public inline function get(key:String)
		return cache.get(key);
}
