package core.logger;
import core.logger.base.ILogger;
import core.utils.CoreUtils;
import haxe.PosInfos;
class CoreLoggerDebug implements ILogger {

    public function addLog(message:Dynamic, pos:PosInfos):Void {
        this.addLogEntry(message, pos);
    }

    public function addLogEntry(message:Dynamic, ?pos:haxe.PosInfos):Void {
        trace(createEntryFrom(pos.className + "." + pos.methodName + "(" + pos.lineNumber + "):" + message));
    }

    public function createEntryFrom(message:Dynamic):String {
        return (CoreUtils.timeStamp + " ----> " + message);
    }

}
