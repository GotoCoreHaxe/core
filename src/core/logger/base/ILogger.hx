package core.logger.base;
import haxe.PosInfos;
interface ILogger {

    function addLog(message:Dynamic,pos:PosInfos):Void;
    function addLogEntry(message:Dynamic,?pos:haxe.PosInfos):Void;
    function createEntryFrom(message:Dynamic):String;
}
