package ;

import haxe.ui.HaxeUIApp;
import sys.FileSystem;
import sys.io.File;
import haxe.xml.Access;

class Main {

    public static var content:String;

    public static function main() {
        getAppData();
        var app = new HaxeUIApp();
        app.ready(function() {
            app.addComponent(new MainView());
            app.start();
        });
    }

    public static function getAppData() {
        var xml_exists = FileSystem.exists(XML_PATH);
        if(!xml_exists) {
            throw("FATAL: application.xml does not exist!");
            Sys.exit(1);
        }
        var _string = File.getContent(XML_PATH);
        _xml = new Access(Xml.parse(_string).firstElement());
        content = _xml.node.initialWindow.node.content.innerData;
    }

    //Private
    private static var XML_PATH:String = "META-INF/AIR/application.xml";
    private static var _xml:Access;
}
