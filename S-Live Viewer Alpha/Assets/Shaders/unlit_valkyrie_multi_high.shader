Shader "MCRS/ValkyrieMulti_High" {
	Properties {
		_VAL_col ("VAL_col", 2D) = "white" {}
		_Frenel_slider ("Frenel_slider", Range(-0.5, 1)) = 0
		_Cube_map ("Cube_map", Cube) = "_Skybox" {}
		_VAL_mask ("VAL_mask", 2D) = "white" {}
		_Brightnessmulti ("Brightness(multi)", Range(0, 2)) = 1
		_Saturationpower ("Saturation (power)", Range(0, 2)) = 1
		_IBL_color ("IBL_color", Vector) = (0.5,0.5,0.5,1)
		_speed ("speed", Float) = 10
		_DamageColor ("DamageColor", Vector) = (0,0,0,1)
		_MuzzleColor ("MuzzleColor", Vector) = (0.5019608,0.5019608,0.5019608,1)
		_VAL_col2 ("VAL_col2", 2D) = "white" {}
		_VAL_mask2 ("VAL_mask2", 2D) = "white" {}
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