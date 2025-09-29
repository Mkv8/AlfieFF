package;
import openfl.filters.ShaderFilter;
import openfl.display.Shader;
import flixel.system.FlxAssets.FlxShader;
import flixel.graphics.tile.FlxGraphicsShader;
import flixel.math.FlxRect;
import openfl.filters.BitmapFilter;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.FlxG;
import openfl.utils.AssetType;
import flixel.graphics.FlxGraphic;
import openfl.utils.Assets as OpenFlAssets;
import openfl.utils.Assets;
import flixel.graphics.FlxGraphic;
import openfl.display.BitmapData;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.FlxBasic;
import flixel.text.FlxText;

typedef ShaderEffect = {
	var shader:Dynamic;
  }

  class FishEye
{
    public var shader:FE = new FE();

    public function new()
    {
    }
}

class FE extends FlxShader
{
    @:glFragmentSource('
    #pragma header

    void main()
    {
        vec2 uv = openfl_TextureCoordv.xy;
        
        float depth = 15.5;

        float dx = distance(uv.x, .5);
        float dy = distance(uv.y, .5);
        
        
        float offset = (dx*.1) * dy;
        
        float dir = 0.;
        if (uv.y <= .5) 
            dir = 1.0;
        else
            dir = -1.;
        
        vec2 coords = vec2(uv.x, uv.y + dx*(offset*depth*dir));
        gl_FragColor = flixel_texture2D(bitmap, coords); 
    }

    ')

    public function new()
        {
            super();
        }
}

  class Mask
  {
      public var shader:Msk = new Msk();
      
      public function new(){
        shader.bfwhite.value = [0.0];
      }

      public function set(c1:Array<Float>,s1:FlxGraphic
        ,c2:Array<Float>,s2:FlxGraphic
        ,c3:Array<Float>,s3:FlxGraphic) {
            shader.mask1.input = s1.bitmap;
            shader.color1.value = [c1[0]/255,c1[1]/255,c1[2]/255];

            shader.mask2.input = s2.bitmap;
            shader.color2.value = [c2[0]/255,c2[1]/255,c2[2]/255];

            shader.mask3.input = s3.bitmap;
            shader.color3.value = [c3[0]/255,c3[1]/255,c3[2]/255];
      }

      public function setWhite(w:Float) {
        shader.bfwhite.value = [w];
      }
      
  }
  
  class Msk extends FlxShader
  {
      @:glFragmentSource('
          #pragma header 

          uniform sampler2D mask1;
          uniform sampler2D mask2;
          uniform sampler2D mask3;
          uniform vec3 color1;   
          uniform vec3 color2;
          uniform vec3 color3;

          uniform float bfwhite;

          void main()
          {
              float colorThreshold = 0.5; 

              vec2 uv = openfl_TextureCoordv;
              vec4 baseColor = texture2D(bitmap, uv);

              vec4 mask1col = texture2D(mask1, uv);
              float diff1 = length(baseColor.rgb - color1);

              vec4 mask2col = texture2D(mask2, uv);
              float diff2 = length(baseColor.rgb - color2);

              vec4 mask3col = texture2D(mask3, uv);
              float diff3 = length(baseColor.rgb - color3);

              vec4 w = vec4(1.0,1.0,1.0,1.0);
              
              if (diff1 < colorThreshold) {
                gl_FragColor = mix(mask1col,w , bfwhite); 
              } 
              else if (diff2 < colorThreshold) {
                gl_FragColor = mix(mask2col, w, bfwhite);
              }
              else if (diff3 < colorThreshold) {
                gl_FragColor = mask3col; 
              }
              else {
                gl_FragColor = baseColor; 
              }
          }
          

  
          ')
          public function new()
              {
                  super();
              }
  }

  class ChromAb
  {
      public var shader:CA = new CA();
      
      public function new(){
      }

      public function set() {
      }
      
  }
  
  class CA extends FlxShader
  {
      @:glFragmentSource('
          #pragma header 

          vec4 Aberrate(vec2 uv, float mult,sampler2D aaa) {
            vec4 col = vec4(0.);
           
            col.x = texture2D(aaa, vec2(uv.x + sin(1.0) * mult, uv.y)).x;
            col.y = texture2D(aaa, vec2(uv.x + cos(1.0) * mult, uv.y)).y;
            col.z = texture2D(aaa, uv).z;
            col.a = texture2D(aaa, uv).a;
            
            return col;
        }
           
        
        void main()
        {
            vec2 uv = openfl_TextureCoordv;
        
            vec4 col = Aberrate(uv, .0045,bitmap);
        
            gl_FragColor = col;
        }
          

  
          ')
          public function new()
              {
                  super();
              }
  }

  class ReplaceCol
  {
      public var shader:Col = new Col();
      
      public function new(){
      }

      public function set(c1:Array<Float>,c2:Array<Float>,a1:Float,c3:Array<Float>,c4:Array<Float>,a2:Float) {
        shader.color1_from.value = [c1[0]/255,c1[1]/255,c1[2]/255];
        shader.color1_to.value = [c2[0]/255,c2[1]/255,c2[2]/255];
        shader.alpha1_to.value = [a1];
        shader.color2_from.value = [c3[0]/255,c3[1]/255,c3[2]/255];
        shader.color2_to.value = [c4[0]/255,c4[1]/255,c4[2]/255];
        shader.alpha2_to.value = [a2];
      }
      
  }
  
  class Col extends FlxShader
  {
      @:glFragmentSource('
          #pragma header 

          uniform vec3 color1_from;   
            uniform vec3 color2_from;  
            uniform vec3 color1_to;  
            uniform vec3 color2_to;   
            uniform float alpha1_to;   
            uniform float alpha2_to;

          void main()
          {
              vec4 texColor = flixel_texture2D(bitmap, openfl_TextureCoordv);

              const float threshold = 0.05; 
              const float softness = 0.3;
              
              float dist1 = distance(texColor.rgb, color1_from);
              float dist2 = distance(texColor.rgb, color2_from);
              
              float factor1 = smoothstep(threshold - softness, threshold + softness, dist1);
              float factor2 = smoothstep(threshold - softness, threshold + softness, dist2);
          
              if (dist1 < threshold) {
                  texColor.rgb = mix(texColor.rgb, color1_to, 1.0 - factor1);
                  if (alpha1_to != -1.0)
                  texColor.a = alpha1_to; 
              }
              
              if (dist2 < threshold) {
                  texColor.rgb = mix(texColor.rgb, color2_to, 1.0 - factor2);
                  if (alpha2_to != -1.0)
                    texColor.a = alpha2_to; 

              }
              
              gl_FragColor = texColor;
          }

  
          ')
          public function new()
              {
                  super();
              }
  }
  

  class SpotLight
  {
      public var shader:SL = new SL();
      
      public function new(){
        shader.iResolution.value = [FlxG.width,FlxG.height];
      }

      public function set(c1:Array<Float>,c2:Array<Float>,c3:Array<Float>,s:Float) {
            shader.pos1.value = [c1[0],c1[1]];
            shader.pos2.value = [c2[0],c2[1]];
            shader.pos3.value = [c3[0],c3[1]];
            shader.size.value = [s];
      }
      
  }
  
  class SL extends FlxShader
  {
      @:glFragmentSource('
          #pragma header 
          uniform vec2 pos1;   
          uniform vec2 pos2;
          uniform vec2 pos3;
          uniform float size;

          uniform vec2 iResolution;

          float sdCircle(vec2 centerPoint, float radius)
            {
                return length(centerPoint) - radius;
            }

            void main()
            {
                vec2 middlePoint = (2.0*gl_FragCoord.xy-iResolution.xy)/iResolution.y;
                vec4 background = flixel_texture2D(bitmap, gl_FragCoord.xy/iResolution.xy);
                
                float largeCircleSDF = sdCircle(middlePoint + pos1, size);
                float midSDF = sdCircle(middlePoint + pos2, size);
                float smallCircleSDF = sdCircle(middlePoint + pos3, size);
                
                float sdfpre = min(midSDF, smallCircleSDF);
                float sdf = min(largeCircleSDF, sdfpre);
                
                float edgeSize = 0.02;
                
                float interpolateEdge = smoothstep(15.0/iResolution.y, 0.0, sdf - edgeSize);    
                vec4 edge = mix(background / 5.0, background / 2.0, interpolateEdge);
                
                float interpolateCenter = smoothstep(15.0/iResolution.y, 0.0, sdf);
                gl_FragColor = mix(edge, background, interpolateCenter);
            }
  
          ')
          public function new()
              {
                  super();
              }
  }