shader_type canvas_item;

void fragment() {
	vec4 base_color = vec4(0.0, 0.0, 0.0, 1.0);

	// Im bliżej środka (0.5, 0.5), tym większa alfa.
	float fade_x = smoothstep(0.0, 0.5, abs(UV.x - 0.5)); // 0.3 = szerokość przejścia
	float fade_y = smoothstep(0.0, 0.5, abs(UV.y - 0.5));

	// Wygaszamy tylko po bokach
	float fade = max(fade_x, fade_y); // lub fade = fade_x, jeśli tylko w poziomie
	float alpha = 1.0 - fade;

	COLOR = base_color;
	COLOR.a *= alpha;
}
