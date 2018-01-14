package core.base;

import core.base.CoreClassFactory.Params;
import core.base.interfaces.IExecutable;

class CoreParameterHolder implements IExecutable {
    @protected var params:Params = new Map();

    public function addParam(name:String, value:Dynamic):IExecutable {
        if (this.params[ name ] == null)
            this.params[ name ] = value;

        return this;
    }

    public function setParam(name:String, value:Dynamic):IExecutable {
        this.params[ name ] = value;

        return this;
    }

    public function addParams(params:Params):IExecutable {

        for (key in params.keys())
            this.addParam(key, params.get(key));

        return this;
    }

    public function setParams(params:Params):IExecutable {
        for (key in params.keys())
            this.setParam(key, params.get(key));
        return this;
    }

    public function has(reference:Dynamic):Bool {
        return false;
    }

    //CoreListener Abstract method

    public function notify():Void {
    }

    //CoreService Abstract method

    public function execute():Dynamic {
        return null;
    }

    //CoreNotification Abstract method

    public function send():Void {
    }
}

