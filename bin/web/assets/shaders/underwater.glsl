precision mediump float;

uniform sampler2D tex0;
uniform float time;

varying vec2 tcoord;

void main() {
    vec2 position = tcoord;
    
    position.x = position.x + sin(position.y + time) * 0.01;
    
    gl_FragColor = texture2D(tex0, position);
}
