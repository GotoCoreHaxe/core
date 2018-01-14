package core.logger;
#if nodejs
import core.logger.node.CoreLoggerFileNode;
#elseif sys
import core.logger.sys.CoreLoggerFileSys;
#end

import core.logger.base.ILogger;
import haxe.PosInfos;
class CoreLoggerFile implements ILogger {
    private var filelogger:ILogger;

    public function new(path:String) {
        #if nodejs

        filelogger = new CoreLoggerFileNode(path);
        #elseif sys
        filelogger = new CoreLoggerFileSys(path);
        #else
        throw "CoreLoggerFile is not supported on this platform!";
        #end
    }

    public function addLog(message:Dynamic, pos:PosInfos):Void {
        this.filelogger.addLogEntry(message, pos);
    }

    public function addLogEntry(message:Dynamic, ?pos:haxe.PosInfos):Void {
    }

    public function createEntryFrom(message:Dynamic):String {
        return "";
    }
}
