/**
 * CoreFileSystem
 *
 * @dependencies:
 * CoreNotificationContainer
 */
package core.filesystem;

import core.filesystem.CoreFileSystem;
import core.base.CoreClassFactory.Params;
import core.base.CoreClass;
import core.filesystem.base.IFileSystem;
import core.notification.CoreNotificationContainer;

class CoreFileSystem extends CoreClass {
    public static var instance:CoreFileSystem;

    /*PROPERTIES*/
    public static inline var PATH:String = 'core.filesystem.path';
    public static inline var FILTER:String = 'core.filesystem.filter';
    public static inline var FROM:String = 'core.filesystem.from';
    public static inline var TO:String = 'core.filesystem.to';
    public static inline var CONTENT:String = 'core.filesystem.content';
    public static inline var FILE:String = 'core.filesystem.file';


    /*SERVICES*/
    public static inline var GET_SUB_FOLDERS:String = 'core.filesystem.get.sub.folders';
    public static inline var GET_FILES:String = 'core.filesystem.get.files';
    public static inline var FILE_EXISTS:String = 'core.filesystem.file.exists';
    public static inline var FOLDER_EXISTS:String = 'core.filesystem.folder.exists';
    public static inline var CREATE_FOLDER:String = 'core.filesystem.create.folder';
    public static inline var COPY_FILE:String = 'core.filesystem.copy.file';
    public static inline var COPY_FOLDER:String = 'core.filesystem.copy.folder';
    public static inline var MOVE_FOLDER:String = 'core.filesystem.move.folder';
    public static inline var CREATE_BINARY_FILE:String = 'core.filesystem.create.binary.file';
    public static inline var CREATE_TEXT_FILE:String = 'core.filesystem.create.text.file';
    public static inline var CREATE_XML_FILE:String = 'core.filesystem.create.xml.file';
    public static inline var APPEND_TEXT_FILE:String = 'core.filesystem.append.text.file';
    public static inline var APPEND_XML_FILE:String = 'core.filesystem.append.xml.file';
    public static inline var APPEND_BINARY_FILE:String = 'core.filesystem.append.binary.file';
    public static inline var READ_TEXT:String = 'core.filesystem.read.text';
    public static inline var READ_XML_FILE:String = 'core.filesystem.read.xml.file';
    public static inline var READ_BYTES:String = 'core.filesystem.read.bytes';
    public static inline var DELETE_FILE:String = 'core.filesystem.delete.file';
    public static inline var DELETE_FOLDER:String = 'core.filesystem.delete.folder';


    public static function getInstance(filesystem:IFileSystem):CoreFileSystem {
        if (CoreFileSystem.instance == null) {
            CoreFileSystem.instance = new CoreFileSystem(filesystem);
        }
        return CoreFileSystem.instance;
    }

    public static var filesystem(default,null):IFileSystem;


    public function new(filesystem:IFileSystem):Void {
        super();
        CoreFileSystem.filesystem = filesystem;
        this.sc.registerService(GET_SUB_FOLDERS, this.serviceGetSubFolders);
        this.sc.registerService(GET_FILES, this.serviceGetFiles);
        this.sc.registerService(FILE_EXISTS, this.serviceFileExists);
        this.sc.registerService(FOLDER_EXISTS, this.serviceFolderExists);
        this.sc.registerService(CREATE_FOLDER, this.serviceCreateFolder);
        this.sc.registerService(COPY_FILE, this.serviceCopyFile);
        this.sc.registerService(COPY_FOLDER, this.serviceCopyFolder);
        this.sc.registerService(MOVE_FOLDER, this.serviceMoveFolder);
        this.sc.registerService(CREATE_TEXT_FILE, this.serviceCreateTextFile);
        this.sc.registerService(CREATE_BINARY_FILE, this.serviceCreateBinaryFile);
        this.sc.registerService(CREATE_XML_FILE, this.serviceCreateXMLFile);
        this.sc.registerService(APPEND_TEXT_FILE, this.serviceAppendTextFile);
        this.sc.registerService(APPEND_XML_FILE, this.serviceAppendXMLFile);
        this.sc.registerService(APPEND_BINARY_FILE, this.serviceAppendBinaryFile);
        this.sc.registerService(READ_TEXT, this.serviceReadText);
        this.sc.registerService(READ_XML_FILE, this.serviceReadXMLFile);
        this.sc.registerService(READ_BYTES, this.serviceReadBytes);
        this.sc.registerService(DELETE_FILE, this.serviceDeleteFile);
        this.sc.registerService(DELETE_FOLDER, this.serviceDeleteFolder);

        this.initDependModules();
    }

    public function get_filesystem():IFileSystem{
        return CoreFileSystem.filesystem;
    }


    private function initDependModules():Void {
        CoreNotificationContainer.getInstance();
    }

    private function serviceGetSubFolders(params:Params):Dynamic {
        return CoreFileSystem.filesystem.getSubFolders(params[PATH]);
    }


    private function serviceGetFiles(params:Params):Dynamic {
        return CoreFileSystem.filesystem.getFiles(params[PATH], params[FILTER]);
    }

    private function serviceFileExists(params:Params):Bool {
        return CoreFileSystem.filesystem.fileExists(params[PATH]);
    }

    private function serviceFolderExists(params:Params):Bool{
        return CoreFileSystem.filesystem.folderExists(params[PATH]);
    }

    private function serviceCreateFolder(params:Params):Void {
        CoreFileSystem.filesystem.createFolder(params[PATH]);
    }

    private function serviceCopyFile(params:Params):Void {
        CoreFileSystem.filesystem.copyFile(params[FROM], params[TO]);
    }

    private function serviceCopyFolder(params:Params):Void {
        CoreFileSystem.filesystem.copyFolder(params[FROM], params[TO]);
    }
    private function serviceMoveFolder(params:Params):Void {
        CoreFileSystem.filesystem.moveFolder(params[FROM], params[TO]);
    }

    private function serviceCreateTextFile(params:Params):Void {

        return CoreFileSystem.filesystem.writeTextFile(params[PATH], params[CONTENT]);
    }
    private function serviceCreateBinaryFile(params:Params):Void {

        return CoreFileSystem.filesystem.writeBinaryFile(params[PATH], params[CONTENT]);
    }

    private function serviceAppendTextFile(params:Params):Void {
        return CoreFileSystem.filesystem.writeTextFile(params[PATH], params[CONTENT], true);
    }

    private function serviceAppendXMLFile(params:Params):Void {

        var xml:Xml;
        var xmlString:String = filesystem.readTextFile(params[PATH]);
        xml = Xml.parse(xmlString);
        xml.addChild(params[CONTENT]);
        CoreFileSystem.filesystem.writeTextFile(params[PATH],xml.toString());
    }

    private function serviceAppendBinaryFile(params:Params):Void {
        return CoreFileSystem.filesystem.writeBinaryFile(params[PATH], params[CONTENT], true);
    }

    private function serviceReadText(params:Params):String {
        return CoreFileSystem.filesystem.readTextFile(params[PATH]);
    }

    private function serviceReadBytes(params:Params):Dynamic{
        return CoreFileSystem.filesystem.readBinaryFile(params[PATH]);
    }


    private function serviceDeleteFile(params:Params):Void {
        return CoreFileSystem.filesystem.deleteFile(params[PATH]);
    }

    private function serviceDeleteFolder(params:Params):Void {
        return CoreFileSystem.filesystem.deleteFolder(params[PATH]);
    }

    private function serviceReadXMLFile(params:Params):Void {

//        return CoreFileSystemSysTest XML(filesystem.readTextFile(params[PATH]));
    }

    private function serviceCreateXMLFile(params:Params):Void {

        return CoreFileSystem.filesystem.writeTextFile(params[PATH], params[CONTENT].toXMLString(), false);
    }

}



