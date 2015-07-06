precision mediump float;

uniform sampler2D tex0;
varying vec2 tcoord;

uniform vec2 _resolution;
uniform vec2 _screen;
uniform float _opacity;
uniform float _time;
uniform int _curve;
uniform int _pixelate;
uniform int _swap;
uniform int _vignette;
uniform int _vscan;
    
vec3 gb1 = vec3(155.0, 188.0, 15.0) / 256.0;
vec3 gb2 = vec3(139.0, 172.0, 15.0) / 256.0;
vec3 gb3 = vec3( 48.0,  98.0, 48.0) / 256.0;
vec3 gb4 = vec3( 15.0,  56.0, 15.0) / 256.0;

vec2 scale() {
    return gl_FragCoord.xy / _screen;
}

vec2 pixelate(vec2 Pos) {
    return floor(Pos * _resolution) / _resolution;
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

vec3 vscan(vec2 Pos, vec3 Clr) {
  //Clr -= sin(Pos.y * _screen.y) * _opacity;
  // Scanlines
  Clr -= sin(_time * 10.0 + Pos.y * _screen.y * 1.5) * _opacity;
  // Big 'refresh rate' bar thing
  Clr *= sin(_time * 1.5 + Pos.y * _screen.y / 100.0) * 0.2 + 0.8;
  // Flicker
  Clr *= 0.998 + 0.02 * sin(60.0 * _time);
  
  return Clr;
}

vec2 curve(vec2 Pos) {
  Pos = (Pos - 0.5) * 2.0;
  Pos.xy *= 1.0 + pow(Pos.yx / 4.0, vec2(2.0));
  Pos = (Pos / 2.0) + 0.5;
  
  return Pos;
}

vec3 vignette(vec2 Pos, vec3 Clr) {
    float v = (10.0 * (1.0 - Pos.x) * Pos.x * (1.0 - Pos.y) * Pos.y);
    Clr *= vec3(pow(v, 0.25));
    
    return Clr;
}

void main() {
  vec2 p = scale();
  
  if (_curve == 1) {
    p = curve(p);
  }
  
  if (_pixelate == 1) {
    p = pixelate(p);
  }
  
  vec3 color = texture2D(tex0, p).rgb;
  
  if (_swap == 1) {
    color = paletteswap(color);
  }
  
  if (_vscan == 1) {
    color = vscan(p, color);
  }
  
  if (_vignette == 1) {
    color = vignette(p, color);
  }
  
  gl_FragColor = vec4(color, 1.0);
}