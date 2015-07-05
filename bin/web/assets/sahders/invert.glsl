precision mediump float;

uniform sampler2D tex0;
varying vec2 tcoord;
varying vec4 color;

void main() {
    vec4 color = texture2D(tex0, tcoord);
    color.rgb = 1.0 - color.rgb;
    gl_FragColor = color;
}
