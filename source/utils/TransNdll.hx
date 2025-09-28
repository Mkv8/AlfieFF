package utils;

import lime.utils.Assets;
import lime.system.CFFI;
import flixel.FlxCamera;
import flixel.FlxG;
import openfl.Lib;

class TransNdll {
    private static var _enable_window_transparency:Void->Void = null;
    private static var _disable_window_transparency:Void->Void = null;

    public static function cacheFunctions():Void {
        if (_enable_window_transparency == null)
            _enable_window_transparency = NdllUtil.getFunction("TP", "win32_enable_window_transparent", 0);

        if (_disable_window_transparency == null)
            _disable_window_transparency = NdllUtil.getFunction("TP", "win32_disable_window_transparent", 0);

        trace("cached window transparency functions");
    }

    private static function enable_window_transparency():Void {
        trace("made window transparent");
        if (_enable_window_transparency == null) {
            _enable_window_transparency = NdllUtil.getFunction("TP", "win32_enable_window_transparent", 0);
            trace("..... but wasnt cached!");
        }
        _enable_window_transparency();
    }

    private static function disable_window_transparency():Void {
        trace("made window non transparent");
        if (_disable_window_transparency == null) {
            _disable_window_transparency = NdllUtil.getFunction("TP", "win32_disable_window_transparent", 0);
            trace("..... but wasnt cached!");
        }
        _disable_window_transparency();
    }

    public static function setWindowTransparent(transparent:Bool) {
        if (transparent) {
            enable_window_transparency(); 
            FlxG.cameras.cameraAdded.add(transparentFlxCamera);
            for (camera in FlxG.cameras.list) transparentFlxCamera(camera);
            Lib.application.window.stage.color = null;
        } else {
            disable_window_transparency(); 
            FlxG.cameras.cameraAdded.remove(transparentFlxCamera);
        }
    }

    public static function transparentFlxCamera(camera:FlxCamera) {
        if (camera != null) camera.bgColor = 0x00000000;
    }
}
