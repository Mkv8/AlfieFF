package utils;

import lime.utils.Assets;
import lime.system.CFFI;

class NdllUtil {

    public static function getFunction(ndll:String, funcName:String, args:Int):Dynamic {
        #if cpp
        var path:String = "assets/songs/external/" + ndll + ".ndll"; 
        if (!Assets.exists(path)) {
            trace('NDLL not found at ' + path);
            return noop;
        }
    
        var func = CFFI.load(Assets.getPath(path), funcName, args); 
        if (func == null) {
            trace('Function ' + funcName + ' in ' + path + ' not found');
            return noop;
        }
    
        return func;
        #else
        trace("NDLLs not supported on this platform");
        return noop;
        #end
    }
    

    public static function noop(...args):Dynamic {
        return null;
    }
}
