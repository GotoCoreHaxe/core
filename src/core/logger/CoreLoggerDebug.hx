package core.logger;
import core.logger.base.ILogger;
import core.utils.CoreUtils;
import haxe.PosInfos;
class CoreLoggerDebug implements ILogger {

    public function new(){}

    public function addLog(message:Dynamic, pos:PosInfos):Void {
        this.addLogEntry(message, pos);
    }

    public function addLogEntry(message:Dynamic, ?pos:haxe.PosInfos):Void {

        #if js
        js.Browser.console.log(pos.className + "." + pos.methodName + "(" + pos.lineNumber + "):" + message);
        #else
        trace(createEntryFrom(pos.className + "." + pos.methodName + "(" + pos.lineNumber + "):" + message));
        #end
    }

    public function createEntryFrom(message:Dynamic):String {
        return (CoreUtils.timeStamp + " ----> " + message);
    }

}
