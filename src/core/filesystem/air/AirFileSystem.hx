package core.filesystem.air;
import core.filesystem.base.IFileSystem;
class AirFileSystem implements IFileSystem{
    public function new() {

    }

    public function desktopDirectory():String {

        return System.desktopDirectory;
    }

    public function documentDirectory():String {
        return System.documentsDirectory;
    }

    public function userDirectory():String {
        return System.userDirectory;
    }

    public function appDirectory():String {
        return System.applicationDirectory;
    }


    public function getSubFolders(path:String):Array<String> {
        return new Array<String>();

    }

    public function getFiles(path:Dynamic, filter:Array<String>):Array<String> {
        var files:Array<String> = FileSystem.readDirectory(cast path);
        if (filter == null)
            return files;
        for (file in files)

            for (f in filter)
                if (file.split('.')[1].indexOf(f) == -1)
                    files.remove(file);
        return files;
    }

    public function fileExists(path:String):Bool {
        return FileSystem.exists(haxe.io.Path.directory(path));
    }

    public function folderExists(path:String):Bool {
        trace(haxe.io.Path.directory(path));
        return FileSystem.exists(haxe.io.Path.directory(path));
    }

    public function createFolder(path:Dynamic):Void {
        FileSystem.createDirectory(path);
    }

    public function copyFile(from:Dynamic, to:Dynamic):Void {
        this.createFolder(haxe.io.Path.directory(to));
        File.copy(cast from, cast to);
    }

    public function copyFolder(from:Dynamic, to:Dynamic):Void {
        this.createFolder(haxe.io.Path.directory(to));
        File.copy(cast from, cast to);
    }

    public function moveFolder(from:Dynamic, to:Dynamic):Void {
        this.createFolder(haxe.io.Path.directory(to));

        FileSystem.rename(from, to);
    }

    public function writeTextFile(path:Dynamic, content:Dynamic, appendable:Bool = false):Void {
        (appendable) ? this.append(path, content, false) : this.write(path, content, false);
    }

    public function writeBinaryFile(path:Dynamic, content:Dynamic, appendable:Bool = false):Void {
        (appendable) ? this.append(path, content, true) : this.write(path, content, true);
    }

    private function write(path:Dynamic, content:Dynamic, isBinary:Bool):Void {
        this.createFolder(haxe.io.Path.directory(path));
        var output:FileOutput = File.write(path, isBinary);
        if (isBinary)
            output.writeBytes(content, 0, content.length);
        else
            output.writeString(content);
        output.close();
    }

    private function append(path:Dynamic, content:Dynamic, isBinary:Bool):Void {
        this.createFolder(haxe.io.Path.directory(path));
        var output:FileOutput = File.append(path, isBinary);
        if (isBinary)
            output.writeBytes(content, 0, content.length);
        else
            output.writeString(content);
        output.close();

    }

    public function readTextFile(path:Dynamic):String {
        return File.getContent(path);
    }

    public function readBinaryFile(path:Dynamic):Dynamic {
        return File.getBytes(path);
    }

    public function deleteFolder(path:Dynamic):Void {
        return FileSystem.deleteDirectory(path);

    }

    public function deleteFile(path:Dynamic):Void {
        return FileSystem.deleteFile(path);
    }
}
