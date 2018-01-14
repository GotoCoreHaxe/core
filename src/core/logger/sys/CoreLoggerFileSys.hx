package core.logger.sys;
import core.logger.base.ILogger;
import core.utils.CoreUtils;
import haxe.PosInfos;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileOutput;
class CoreLoggerFileSys implements ILogger {
    private var stream:FileOutput;

    public function new(path:String) {
        trace(haxe.io.Path.directory(path));
        FileSystem.createDirectory(haxe.io.Path.directory(path));
        stream = File.write(path, false);
    }

    public function addLog(message:Dynamic, pos:PosInfos):Void {
        this.addLogEntry(message, pos);
    }

    public function addLogEntry(message:Dynamic, ?pos:haxe.PosInfos):Void {
        this.stream.writeString(createEntryFrom(pos.className + "." + pos.methodName + "(" + pos.lineNumber + "):" + message) + "\n");
    }

    public function createEntryFrom(message:Dynamic):String {
        return (CoreUtils.timeStamp + " ----> " + message);
    }

}
