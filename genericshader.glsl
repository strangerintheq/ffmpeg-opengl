#version 150
uniform sampler2D tex;
in vec2 texCoord;
out vec4 fragColor;

void main() {
    vec2 uv = texCoord * 0.5 + 0.5;
    uv.y = 1 - uv.y;
    fragColor = texture(tex, uv);
}
