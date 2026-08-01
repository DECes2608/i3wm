#version 330

in vec2 texcoord;
uniform sampler2D tex;
uniform float opacity;
vec4 default_post_processing(vec4 c);

vec4 window_shader() {
    vec2 texsize = textureSize(tex, 0);
    vec4 color = texture2D(tex, texcoord / texsize);

    // 1. Doygunluk (Saturation)
    vec3 grey = vec3(dot(color.rgb, vec3(0.299, 0.587, 0.114)));
    float saturation = 1.6;
    color.rgb = mix(grey, color.rgb, saturation);

    // 2. Siyah Duzeltme (Mavi Kaymasini Engelleme)
    float luma = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    float darkFactor = smoothstep(0.12, 0.0, luma);
    color.b -= color.b * darkFactor * 0.50;
    color.g -= color.g * darkFactor * 0.10;

    color = vec4(color.rgb * opacity, color.a * opacity);
    return default_post_processing(color);
}
