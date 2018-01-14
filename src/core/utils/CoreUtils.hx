package core.utils;
import core.base.CoreClass;
class CoreUtils extends CoreClass {

    public static var timeStamp(get, null):String;

    public function new() {
        super();
    }

    static function get_timeStamp():String {
        var date:Date = Date.now();
        var timestamp:String = "";
        timestamp += date.getFullYear() + "-";
        timestamp += date.getMonth() + 1 + "-";
        timestamp += date.getDate() + " ";
        timestamp += date.getHours() + "_";
        timestamp += date.getMinutes() + "_";
        timestamp += date.getSeconds();
        return timestamp;
    }

    public static function stringReplace(str:String, search:Dynamic, replace:String):String {
        trace(Type.getClass(search));
        if (Type.getClass(search) == Array) {
            for (field in Reflect.fields(search))
                str = str.split(Reflect.field(search,field)).join(replace);
            return str;
        }
        else
            return str.split(search).join(replace);

    }

    public static macro function getDefine(key:String):haxe.macro.Expr {
        return macro $v{haxe.macro.Context.definedValue(key)};
    }

    public static macro function setDefine(key:String, value:String):haxe.macro.Expr {
        haxe.macro.Compiler.define(key, value);
        return macro null;
    }

    public static macro function isDefined(key:String):haxe.macro.Expr {
        return macro $v{haxe.macro.Context.defined(key)};
    }

    public static macro function getDefines():haxe.macro.Expr {
        var defines:Map<String, String> = haxe.macro.Context.getDefines();
        var map:Array<haxe.macro.Expr> = [];
        for (key in defines.keys()) {
            map.push(macro $v{key} => $v{Std.string(defines.get(key))});
        }
        return macro $a{map};
    }


}
