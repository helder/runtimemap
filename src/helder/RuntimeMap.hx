package helder;

import haxe.ds.StringMap;
import haxe.ds.IntMap;
import haxe.ds.EnumValueMap;
import haxe.ds.ObjectMap;
import haxe.Constraints.IMap;

class RuntimeMap<K, V> implements IMap<K, V> {
  static final EMPTY_ITER: Iterator<Dynamic> = {
    hasNext: () -> false,
    next: null
  }

  var map: IMap<K, V>;

  public inline function new() {}

  function getMap(k: K): IMap<K, V> {
    if (map != null)
      return map;
    if (Std.is(k, String))
      return map = cast new StringMap();
    if (Std.is(k, Int))
      return map = cast new IntMap();
    if (try Type.enumIndex(cast k) >= 0 catch (e:Dynamic) false)
      return map = cast new EnumValueMap();
    if (Reflect.isObject(k))
      return map = cast new ObjectMap();
    throw 'Could not determine map key type';
  }

  public inline function set(k: K, v: V)
    getMap(k).set(k, v);

  public inline function get(k: K)
    return getMap(k).get(k);

  public inline function exists(k: K)
    return getMap(k).exists(k);

  public inline function remove(k: K)
    return getMap(k).remove(k);

  public inline function keys(): Iterator<K>
    return if (map == null) EMPTY_ITER else map.keys();

  public function copy(): IMap<K, V>
    return if (map == null) new RuntimeMap() else map.copy();

  public inline function iterator(): Iterator<V>
    return if (map == null) EMPTY_ITER else map.iterator();

  public inline function keyValueIterator(): KeyValueIterator<K, V>
    return if (map == null) EMPTY_ITER else map.keyValueIterator();

  public inline function clear()
    if (map != null)
      map.clear();

  public function toString()
    return if (map != null) map.toString() else '[]';

  public function toMap(): Map<K, V>
    return cast this;
}
