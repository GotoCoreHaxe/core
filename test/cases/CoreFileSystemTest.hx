package cases;
import core.base.CoreTestCase;
import core.filesystem.CoreFileSystem;
import haxe.io.Bytes;

class CoreFileSystemTest extends CoreTestCase {

    private var folder:String;
    private var createFolder:String;
    private var folderCopy:String;
    private var textFile:String;
    private var binaryFile:String;

    private var textContent:String = "test";
    private var byteContent:Bytes = Bytes.ofString("test");

    private var appendTextContent:String = "\nappend";
    private var appendBytesContent:Bytes = Bytes.ofString("\nappend");

    public function new():Void {
        super();
        CoreFileSystem.getInstance();
        this.folder = "test/";
        this.createFolder = folder + "a/b/c/d/e/f/g/h/i/j/k/l/m";
        this.folderCopy = "test2/";
        this.textFile = folder + "text.txt";
        this.binaryFile = folder + "bytes.dat";
    }

    public function testCreateTextFile() {

        this.sc.getService(CoreFileSystem.CREATE_TEXT_FILE)
        .addParam(CoreFileSystem.PATH, this.textFile)
        .addParam(CoreFileSystem.CONTENT, textContent)
        .execute();


        var textFileExists:Bool = this.sc.getService(CoreFileSystem.FILE_EXISTS)
        .addParam(CoreFileSystem.PATH, this.textFile)
        .execute();

        assertTrue(textFileExists);

    }

    public function testTextFileRead() {
        var readTextContent = this.readTextFile(this.textFile);
        assertEquals(textContent, readTextContent);
    }


    public function testTextAppendFile() {
        this.sc.getService(CoreFileSystem.APPEND_TEXT_FILE)
        .addParam(CoreFileSystem.PATH, this.textFile)
        .addParam(CoreFileSystem.CONTENT, appendTextContent)
        .execute();

        var readAppendTextContent:String = this.readTextFile(this.textFile);

        assertEquals(this.textContent + this.appendTextContent, readAppendTextContent);

    }


    public function testCreateBinaryFile() {
        this.sc.getService(CoreFileSystem.CREATE_BINARY_FILE)
        .addParam(CoreFileSystem.PATH, this.binaryFile)
        .addParam(CoreFileSystem.CONTENT, this.byteContent)
        .execute();

        assertTrue(this.fileExists(this.binaryFile));
    }

    public function testAppendBinaryFile() {

        this.sc.getService(CoreFileSystem.APPEND_BINARY_FILE)
        .addParam(CoreFileSystem.PATH, this.binaryFile)
        .addParam(CoreFileSystem.CONTENT, this.appendBytesContent)
        .execute();

        var readAppendByteContent:Dynamic = this.readBinaryFile(this.binaryFile);

        assertEquals(Bytes.ofString(this.textContent + this.appendTextContent).compare(readAppendByteContent), 0);
    }

    public function testCreateFolder() {
        this.sc.getService(CoreFileSystem.CREATE_FOLDER)
        .addParam(CoreFileSystem.PATH, this.createFolder)
        .execute();

        assertTrue(this.folderExists(this.createFolder));
    }

    public function testCopyFolder() {
        this.sc.getService(CoreFileSystem.COPY_FOLDER)
        .addParam(CoreFileSystem.FROM, this.folder)
        .addParam(CoreFileSystem.TO, this.folderCopy)
        .execute();

        assertTrue(this.folderExists(this.folder));
    }


    private function readTextFile(path:String):Dynamic {
        return this.sc.getService(CoreFileSystem.READ_TEXT)
        .addParam(CoreFileSystem.PATH, path)
        .execute();
    }

    private function readBinaryFile(path):Dynamic {
        return this.sc.getService(CoreFileSystem.READ_BYTES)
        .addParam(CoreFileSystem.PATH, path)
        .execute();
    }

    private function fileExists(path:String):Bool {
        return this.sc.getService(CoreFileSystem.FILE_EXISTS)
        .addParam(CoreFileSystem.PATH, path)
        .execute();
    }

    private function folderExists(path:String):Bool {
        return this.sc.getService(CoreFileSystem.FOLDER_EXISTS)
        .addParam(CoreFileSystem.PATH, path)
        .execute();
    }
}
