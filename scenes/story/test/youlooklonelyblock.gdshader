shader_type canvas_item;

void fragment() {
    vec4 base_color = texture(TEXTURE, UV)*0.1; 
	if (UV.y>0.35){  // pobiera kolor z tekstury
    vec3 end_color = vec3(0.12, 0.0, 0.15);     // czerwony
    
    float fade = smoothstep(0.35, 0.6, UV.y);  // płynne przejście

    COLOR.rgb = mix(base_color.rgb, end_color, fade); // zachowaj oryginalną przezroczystość
	}else{
		COLOR = base_color;
	}
	if (COLOR.a != 0.0){
    COLOR.a = 1.0;
	}
}
