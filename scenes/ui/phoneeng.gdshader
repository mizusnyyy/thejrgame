shader_type canvas_item;

uniform float cut_amount : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    vec2 uv = UV;
    if (uv.y < cut_amount) {
        discard;
    } else {
        COLOR = texture(TEXTURE, uv) * COLOR;
    }
}
