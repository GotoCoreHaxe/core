package core.filesystem.base;

interface IFileSystem {

//    DIRECTORIES
    function desktopDirectory():String;

    function documentDirectory():String;

    function userDirectory():String;

    function appDirectory():String;
//    DIRECTORIES

    function getSubFolders(path:String):Dynamic;

    function getFiles(path:String,filter:Array<String>):Dynamic;


    function fileExists(path:String):Dynamic;

    function folderExists(path:String):Dynamic;

    function createFolder(path:Dynamic):Void;

    function copyFile(from:Dynamic, to:Dynamic):Void;

    function copyFolder(from:Dynamic, to:Dynamic):Void;

    function moveFolder(from:Dynamic, to:Dynamic):Void;

    function writeTextFile(path:Dynamic, content:Dynamic, appendable:Bool = false):Void;

    function writeBinaryFile(path:Dynamic, content:Dynamic, appendable:Bool = false):Void;

    function readTextFile(path:Dynamic):Dynamic;

    function readBinaryFile(path:Dynamic):Dynamic;

    function deleteFolder(path:Dynamic):Void;

    function deleteFile(path:Dynamic):Void;
}
