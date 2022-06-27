Shader "MCRS/Diva/Aura" {
	Properties {
		_MainTex ("MainTex", 2D) = "white" {}
		_TintColor ("Color", Vector) = (0.5,0.5,0.5,1)
		_UScroll ("U Scroll", Float) = 0
		_VScroll ("V Scroll", Float) = 0
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		sampler2D _MainTex;
		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	//CustomEditor "ShaderForgeMaterialInspector"
}