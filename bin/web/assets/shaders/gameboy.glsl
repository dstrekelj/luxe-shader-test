precision mediump float;

uniform sampler2D tex0;
varying vec2 tcoord;

uniform vec2 _resolution;
uniform vec2 _screen;
uniform int _pixelate;
uniform int _swap;
    
vec3 gb1 = vec3(155.0, 188.0, 15.0) / 256.0;
vec3 gb2 = vec3(139.0, 172.0, 15.0) / 256.0;
vec3 gb3 = vec3( 48.0,  98.0, 48.0) / 256.0;
vec3 gb4 = vec3( 15.0,  56.0, 15.0) / 256.0;

vec2 scale(vec2 Scr) {
    return gl_FragCoord.xy / Scr;
}

vec2 pix(vec2 Pos, vec2 Res) {
    return floor(Pos * Res) / Res;
}

vec3 paletteswap(vec3 Clr) {
    Clr.r = Clr.g = Clr.b;
    
    if (Clr.r >= 0.75) {
        Clr.rgb = gb1;
    } else if (Clr.r >= 0.50 && Clr.r < 0.75) {
        Clr.rgb = gb2;
    } else if (Clr.r >= 0.25 && Clr.r < 0.50) {
        Clr.rgb = gb3;
    } else {
        Clr.rgb = gb4;
    }
    
    return Clr;
}

void main() {
  vec2 p = scale(_screen);
  
  if (_pixelate == 1) {
    p = pix(p, _resolution);
  }
  
  vec4 color = texture2D(tex0, p);
  
  if (_swap == 1) {
    color.rgb = paletteswap(color.rgb);
  }
  
  gl_FragColor = color;
}