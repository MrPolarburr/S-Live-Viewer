Shader "MCRS/Unlit_ValkyrieHQ" {
	Properties {
		_VAL_col ("VAL_col", 2D) = "white" {}
		_VAL_mask ("VAL_mask", 2D) = "white" {}
		_Cube_map ("Cube_map", Cube) = "_Skybox" {}
		_BG_map ("BG_map", Cube) = "_Skybox" {}
		_IBL_color ("IBL_color", Vector) = (0.875,0.9275862,1,1)
		_Frenel ("Frenel", Range(-0.5, 1)) = 0
		_Brightnessmulti ("Brightness(multi)", Range(0, 2)) = 1
		_Saturationpower ("Saturation (power)", Range(0, 2)) = 1
		_BG_roll ("BG_roll", Range(0, 360)) = 0
		_speed ("speed", Float) = 10
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