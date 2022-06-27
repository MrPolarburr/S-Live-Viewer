Shader "MCRS/Stage/PsylliumMulti" {
	Properties {
		_MainColorTex ("MainColorTex", 2D) = "white" {}
		_MainAlphaTex ("MainAlphaTex", 2D) = "white" {}
		_PsylliumTex ("PsylliumTex", 2D) = "white" {}
		_PsylliumMaskTex ("PsylliumMaskTex", 2D) = "white" {}
		_Color1 ("Main Color1", Vector) = (1,1,1,1)
		_Color2 ("Main Color2", Vector) = (1,1,1,1)
		_Color3 ("Main Color3", Vector) = (1,1,1,1)
		_Power ("Power", Float) = 1
	}
SubShader
	{
		Tags { "Queue"="Transparent" "RenderType"="Geometry" "LightMode" = "Vertex" }
		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite On
		Pass
		{
			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

			sampler2D _MainColorTex;
			sampler2D _MainAlphaTex;
			sampler2D _PsylliumTex;
			sampler2D _PsylliumMaskTex;
			float4 _Color1;
			float4 _Color2;
			float4 _Color3;
			float _Power;
			float4 _MainColorTex_ST;
			float4 _MainAlphaTex_ST;
			float4 _PsylliumTex_ST;
			float4 _PsylliumMaskTex_ST;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				float4 tex = tex2D(_MainColorTex, i.uv);
				float4 tex2 = tex2D(_PsylliumTex, i.uv);
				tex2 *= _Color1 *_Power;
				tex += tex2;
				tex.a = tex2D(_MainAlphaTex, i.uv);

				return tex;
			}
			ENDCG
		}
	}
}