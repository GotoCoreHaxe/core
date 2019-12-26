package core.base;

import core.base.interfaces.IExecutable;
class CoreSender extends CoreParameterHolder {
    @protected var name:String;

    @protected var collection:Array<IExecutable>;

    public function new(name:String, collection:Array<IExecutable>):Void {
        this.name = name;
        this.collection = collection;
    }
}
