precision mediump float;

uniform sampler2D tex0;

varying vec2 tcoord;
varying vec2 color;

void main() {
  vec4 color = texture2D(tex0, tcoord);
  
  color.rgb = 1. - color.rgb;
  
  gl_FragColor = color;
}
