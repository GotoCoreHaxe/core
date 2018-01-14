package core.service;
import haxe.io.Error;
import core.base.interfaces.IExecutable;
//import core.utils.Log;

class CoreServiceContainer {
    private static var instance:CoreServiceContainer;

    public static function getInstance():CoreServiceContainer {
        if (CoreServiceContainer.instance == null)
            CoreServiceContainer.instance = new CoreServiceContainer();
        return CoreServiceContainer.instance;
    }

    public function new():Void{

    }

    private var mapping:Map<String, Dynamic> = new Map();

    public function registerService(name:String, reference:Dynamic):Void {
        this.mapping.set(name, reference);
    }

    public function updateService(name:String, reference:Dynamic):Void {
        if (this.mapping.exists(name))
            this.mapping.set(name, reference);
    }

    public function removeService(name:String):Void {
        this.mapping.remove(name);
    }

    public function getService(name:String):IExecutable {
        if (!this.mapping.exists(name))

            throw ("Nincs ilyen service regisztrálva:  " + name);

        return new CoreService(name, this.mapping.get(name)).addParam(CoreService.CORE_SERVICE_NAME, name);
    }

    public function chainServices(services:Array<IExecutable>):Void {
        services[0].execute();
    }

    public function hasService(name:String):Bool {
        return this.mapping.exists(name);
    }
}



