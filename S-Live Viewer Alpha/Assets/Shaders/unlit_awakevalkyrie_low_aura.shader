Shader "MCRS/ValkyrieAwake_Low" {
	Properties {
		_VAL_col ("VAL_col", 2D) = "white" {}
		_Saturationpower ("Saturation (power)", Range(0, 2)) = 1
		_DamageColor ("DamageColor", Vector) = (0,0,0,1)
		_MuzzleColor ("MuzzleColor", Vector) = (0.5,0.5,0.5,1)
		_Multi_value ("Multi_value", Float) = 1
		_color_Value ("color_Value", Float) = 1
		_Aura_color ("Aura_color", Vector) = (1,0,0,1)
		_noise_tex ("noise_tex", 2D) = "white" {}
		_noise_speed ("noise_speed", Float) = 1
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType" = "Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = 1;
		}
		ENDCG
	}
	Fallback "Diffuse"
	//CustomEditor "ShaderForgeMaterialInspector"
}