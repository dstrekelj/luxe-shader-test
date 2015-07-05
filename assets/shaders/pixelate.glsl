precision mediump float;

uniform sampler2D tex0;
uniform float resolution;

varying vec4 color;
varying vec2 tcoord;

void main() {
    vec2 position = tcoord;
    
    position = floor(position * resolution) / resolution;
    
    gl_FragColor = texture2D(tex0, position);
}
