precision mediump float;

varying vec2 position;
uniform sampler2D webcam;

vec2 _resolution = vec2(128.0, 96.0);
vec2 _screen = vec2(1024.0, 768.0);
float _opacity = 0.5;

vec2 scale() {
  return gl_FragCoord.xy / _screen.xy;
}

vec2 pixelate(vec2 Position) {
  return floor(Position * _resolution) / _resolution;
}

vec4 vscan(vec2 Position, vec4 Color) {
  if (mod(Position.y * _resolution.y, 2.0) == 0.0) {
    Color.rgb *= (1.0 - _opacity);
  }
  
  return Color;
}

void main() {
  vec2 p = position;
  
  p = scale();
  p = pixelate(p);
  
  vec4 color = texture2D(webcam, p);
  
  //color = scanlines(p, color);
  color = vscan(p, color);
  
  // brightness / contrast stuff?
  //color = color - 4. * (color - 4.0) * color * (color - 0.0);
  
  gl_FragColor = color;
}