Shader "MCRS/ValkyrieMulti_Low" {
	Properties {
		_VAL_col ("VAL_col", 2D) = "white" {}
		_Saturationpower ("Saturation (power)", Range(0, 2)) = 1
		_DamageColor ("DamageColor", Vector) = (0,0,0,1)
		_MuzzleColor ("MuzzleColor", Vector) = (0.5,0.5,0.5,1)
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