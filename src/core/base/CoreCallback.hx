package core.base;

import core.base.interfaces.IExecutable;
import core.service.CoreServiceContainer;

class CoreCallback extends CoreSender {
    public static inline var GROUP:String = 'group';
    public static inline var CALLBACK:String = 'callback';
    public static inline var CALLBACKS:String = 'callbacks';

    public static inline var ADD_CALLBACK:String = ".add.callback";
    public static inline var ADD_CALLBACKS:String = ".add.callbacks";

    public function new(name:String, collection:Array<IExecutable>) {
        super(name, collection);
    }

    public override function send():Void {
        for (callback in this.collection)
            callback.setParams(this.params).execute();
    }

    public static function addCallback(target:Dynamic, group:String, callback:IExecutable):Void {
        CoreServiceContainer.getInstance().getService(target.name + ADD_CALLBACK)
        .addParam(GROUP, group)
        .addParam(CALLBACK, callback)
        .execute();
    }

    public static function addCallbacks(target:Dynamic, group:String, callbacks:Array<IExecutable>):Void {
        CoreServiceContainer.getInstance().getService(target.name + ADD_CALLBACK)
        .addParam(GROUP, group)
        .addParam(CALLBACKS, callbacks)
        .execute();
    }
}

