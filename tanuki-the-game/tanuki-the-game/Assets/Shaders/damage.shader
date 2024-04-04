uniform int isDamaging;


vec3 output = vec3(1.0, 1.0, 1.0);


if (isDamaging != 1) {
    
    _output.color.rgb = _output.color.rgb;
    
} else {

    _output.color.rgb = mix(vec3(1.0, 0.0, 0.0), _output.color.rgb, abs(sin(u_time * 10.0)));

}
