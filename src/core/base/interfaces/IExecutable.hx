package core.base.interfaces;


interface IExecutable {
    function addParam(name:String, value:Dynamic):IExecutable;

    function addParams(params:Map<String,Dynamic>):IExecutable;

    function setParam(name:String, value:Dynamic):IExecutable;

    function setParams(params:Map<String,Dynamic>):IExecutable;

    function has(reference:Dynamic):Bool;

    function execute():Dynamic;

    function notify():Void;

    function send():Void;
}

