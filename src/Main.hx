package ;

import haxe.ui.HaxeUIApp;
import sys.FileSystem;
import sys.io.File;
import haxe.xml.Access;

typedef Mod = {
    var name:String;
    var description:String;
    var content:String;
}

class Main {

    public static var content:String;
    public static var modlist:Array<Mod>;

    private static var _xml:Access;
    private static inline var XML_PATH:String = "META-INF/AIR/application.xml";

    public static function main() {
        getAppData();
        getModList();
        var app = new HaxeUIApp();
        app.ready(function() {
            app.addComponent(new MainView());
            app.start();
        });
    }

    public static function getAppData() {
        if(!FileSystem.exists(XML_PATH)) {
            throw("FATAL: application.xml does not exist!");
            Sys.exit(1);
        }
        var _string = File.getContent(XML_PATH);
        _xml = new Access(Xml.parse(_string).firstElement());
        content = _xml.node.initialWindow.node.content.innerData;
    }

    public static function getModList() {
        modlist = new Array<Mod>();
        if(!FileSystem.exists("mods")) {
            trace("Mod folder does not exist");
            return;
        }
        var dir = FileSystem.readDirectory("mods");
        for(i in 0...dir.length) {
            var _path = "mods/" + dir[i];
            if(!FileSystem.isDirectory(_path)) continue;
            var _configpath = _path + "/mod.json";
            if(!FileSystem.exists(_configpath)) continue;
            var _string = File.getContent(_configpath);
            var _mod:Mod = haxe.Json.parse(_string);
            _mod.content = _path + "/" + _mod.content;
            modlist.push(_mod);
        }
    }

}
