#version 150
precision highp float;
uniform sampler2D tex;
in vec2 texCoord;
out vec4 fragColor;

const vec2 res = vec2(800., 600.);
const float effectPower = -0.034;
const float center = -0.020;
const float rotate = 0.022;

//Inspired by http://stackoverflow.com/questions/6030814/add-fisheye-effect-to-images-at-runtime-using-opengl-es
void main(void) {

    vec2 p = gl_FragCoord.xy / res.x;  // normalized coords with some cheat (assume 1:1 prop)
    float prop = res.x / res.y;        // screen proroption
    vec2 m = vec2(0.5 - center, 0.5 / prop);    // center coords
    vec2 d = p - m;                    // vector from center to current fragment
    float r = sqrt(dot(d, d));         // distance of pixel from center

    // amount of effect
    float power = (2.0 * 3.141592 / (2.0 * sqrt(dot(m, m)))) * effectPower;

    float bind;                        // radius of 1:1 effect
    if (power > 0.0) {                 // stick to corners
      bind = sqrt(dot(m, m));
    } else {                           // stick to borders
      if (prop < 1.0)
        bind = m.x;
      else
        bind = m.y;
    }

    vec2 uv = p;          // no effect for power = 1.0
    if (power > 0.0)      // fisheye
      uv = m + normalize(d) * tan(r * power) * bind / tan( bind * power);
    else if (power < 0.0) //antifisheye
      uv = m + normalize(d) * atan(r * -power * 10.0) * bind / atan(-power * bind * 10.0);

    vec2 sc = vec2( sin(rotate), cos(rotate) );
    uv -= vec2(0.5, 0.5/prop);
    uv *= mat2(sc.y, -sc.x, sc.xy);
    uv += vec2(0.5, 0.5/prop);

    uv.y -= 1./prop;

    // Second part of cheat for round effect, not elliptical
    vec3 col = texture2D(tex, vec2(uv.x, -uv.y * prop)).xyz;
    fragColor = vec4(col, 1.0);
}
