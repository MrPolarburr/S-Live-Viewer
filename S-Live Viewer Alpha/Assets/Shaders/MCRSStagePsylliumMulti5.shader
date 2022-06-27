Shader "MCRS/Stage/PsylliumMulti5" {
	Properties {
		_MainColorTex ("MainColorTex", 2D) = "white" {}
		_MainAlphaTex ("MainAlphaTex", 2D) = "white" {}
		_PsylliumTex ("PsylliumTex", 2D) = "white" {}
		_PsylliumMaskTex ("PsylliumMaskTex", 2D) = "white" {}
		_PsylliumMaskTex2 ("PsylliumMaskTex2", 2D) = "white" {}
		_Color1 ("Main Color1", Vector) = (1,1,1,1)
		_Color2 ("Main Color2", Vector) = (1,1,1,1)
		_Color3 ("Main Color3", Vector) = (1,1,1,1)
		_Color4 ("Main Color4", Vector) = (1,1,1,1)
		_Color5 ("Main Color5", Vector) = (1,1,1,1)
		_Power ("Power", Float) = 1
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
}